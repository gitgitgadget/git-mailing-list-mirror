From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Mon, 25 Jan 2016 05:01:41 -0500
Message-ID: <20160125100141.GC24452@sigill.intra.peff.net>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
 <20160124071234.GA24084@sigill.intra.peff.net>
 <20160124071815.GB24084@sigill.intra.peff.net>
 <xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
 <20160124222736.GA29115@sigill.intra.peff.net>
 <xmqqsi1m9yxh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 11:01:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNdy4-0001VK-MZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 11:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbcAYKBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 05:01:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:59830 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756465AbcAYKBn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 05:01:43 -0500
Received: (qmail 17563 invoked by uid 102); 25 Jan 2016 10:01:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jan 2016 05:01:44 -0500
Received: (qmail 16927 invoked by uid 107); 25 Jan 2016 10:02:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jan 2016 05:02:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jan 2016 05:01:41 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsi1m9yxh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284731>

On Sun, Jan 24, 2016 at 06:26:50PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, "strip=2" would also get the job done, and extends more naturally
> > to the branch case.
> >
> > To be honest, I cannot imagine anybody using anything _but_ strip=2...
> 
> I 100% agree, and I do consider this to be internal implementation
> detail for the listing modes of "tag" (and "branch"), which may be
> exposed to the user (by documenting that %(refname:X) is used by
> default), so perhaps even the flexibility of strip=2 is unwanted.
> 
> I know what "remove-standard-prefix" is way too long for the value
> of X above, but then we can say "the command will error out if you
> allow your for-each-ref invocation to step outside of the area that
> has standard prefix to be removed." without having to worry about
> "what is the sensible thing to do when the prefixes are not what we
> expect (too short for strip=2 or no match for short=refs/tags/)".

I'm not sure "remove-standard-prefix" doesn't open its own questions.
Like "what are the standard prefixes?".

If we are going to go with "remove a prefix", I really don't think
"remove if present" is too complicated a set of semantics (as opposed to
"error out" you mentioned above).

I do like "strip=<n>" for its simplicity (it's easy to explain), and the
fact that it will probably handle the git-branch case for us. The only
open question is what to do if there are fewer components, but I really
think any of the 4 behaviors I gave earlier would be fine.

Eric' globbing suggestion is simpler for the error case (as a prefix, it
can be "remove if present"), but I think introducing globbing in general
opens up too many corner cases (e.g., does "*" match "/", is "**"
supported, etc).

-Peff
