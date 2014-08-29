From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] fsck: check tag objects' headers
Date: Fri, 29 Aug 2014 19:46:41 -0400
Message-ID: <20140829234641.GG24834@peff.net>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
 <xmqqlhq88fyb.fsf@gitster.dls.corp.google.com>
 <xmqqegw08fft.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 01:46:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNVsV-0004LR-Gr
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 01:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbaH2Xqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 19:46:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:33506 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750888AbaH2Xqn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 19:46:43 -0400
Received: (qmail 13607 invoked by uid 102); 29 Aug 2014 23:46:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 18:46:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 19:46:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqqegw08fft.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256205>

On Thu, Aug 28, 2014 at 02:36:22PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +	if (check_refname_format(buffer, REFNAME_ALLOW_ONELEVEL))
> >> +		ret = error_func(&tag->object, FSCK_ERROR, "invalid 'tag' name: %s", buffer);
> >> +	*eol = '\n';
> >
> > I actually think this check is harmful.
> 
> Let me take this one back; we do a moral equivalent when we create a
> tag, like this:
> 
> 	strbuf_addf(sb, "refs/tags/%s", name);
>         return check_refname_format(sb->buf, 0);

Hmm. But that is because "git tag" always makes one type of tag: one in
which the "tag" field is the same as the refname in which we store it.
So the name must be a valid refname there to meet the ref storage
requirement, and therefore the tag name must, too.

But is that something we necessarily need or want to enforce? Is it OK
for me to have refs/tags/foo pointing to a tag object that is not
related to "foo" (either semantically or syntactically)?

I dunno. I cannot think of a reason you would want to do such a thing,
but this seems like outlawing it because git does not generate it, not
because it is necessarily a problematic thing to be doing.

-Peff
