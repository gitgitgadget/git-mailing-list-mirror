From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] specifying ranges: we did not mean to make ".." an empty
 set
Date: Thu, 23 Aug 2012 18:14:27 -0400
Message-ID: <20120823221427.GA9337@sigill.intra.peff.net>
References: <7vd32i5y8w.fsf@alter.siamese.dyndns.org>
 <20120823082916.GA6963@sigill.intra.peff.net>
 <7vhart2sos.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 00:14:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4ffh-0005Gc-8n
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 00:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847Ab2HWWOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 18:14:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46618 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab2HWWOa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 18:14:30 -0400
Received: (qmail 26545 invoked by uid 107); 23 Aug 2012 22:14:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Aug 2012 18:14:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2012 18:14:27 -0400
Content-Disposition: inline
In-Reply-To: <7vhart2sos.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204177>

On Thu, Aug 23, 2012 at 02:40:19PM -0700, Junio C Hamano wrote:

> > This last sentence confuses me. Now we are documenting that "yes, ..
> > really means HEAD..HEAD, which is the empty range". But isn't the point
> > of this patch to say "sure, it would be the empty range, but because
> > that is stupid and pointless, we do not consider it valid and treat ..
> > as a pathspec"?
> 
> No, we still allow ".." as a short-hand for HEAD..HEAD when it is
> understood as a rev.  We also allow ".." as a pathspec to match the
> parent directory when it is understood as a pathspec.
> 
> The only thing the topic wanted to change was the disambiguation
> logic.  When a string S can name both rev and path, we ask the user
> to disambiguate, but when S is "..", we do not have to (as one
> interpretation is meaningless).

Ah, right. OK, that makes more sense. I wasn't thinking that you could
still do:

  git log .. --

if you really wanted to. So yeah, it doesn't belong here...

> I think that documentation belongs to the section of disambiguation
> without "--".  Usually you need to use "--", but ".." is taken as
> path even without "--".

...but I agree it would be worth mentioning there. But I am not sure
where "there" is in the current documentation.

> An interesting side effect is that
> 
> 	git log .. pu
> 
> used to error out for ".." being both rev and path, but it will
> error out for "pu" not being a path in the working tree.  This is
> because on a command line without "--" disambiguation, once you
> start listing paths, you have to have nothing but paths after that
> point.

Hmm. Yeah, that's a slightly surprising emergent behavior. But I think
it is not a big deal since both cases led to errors anyway.

-Peff
