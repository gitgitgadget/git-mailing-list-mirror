From: Jeff King <peff@peff.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 07:23:35 -0500
Message-ID: <20110228122335.GB5197@sigill.intra.peff.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
 <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
 <4D6A6291.8050206@drmicha.warpmail.net>
 <7v7hclulz0.fsf@alter.siamese.dyndns.org>
 <7v39n9uldp.fsf@alter.siamese.dyndns.org>
 <4D6B4F6B.1040209@drmicha.warpmail.net>
 <20110228121726.GA5197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Mart =?utf-8?B?U8O1bWVybWFh?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 13:23:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu28c-0002Jn-Ov
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 13:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab1B1MXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 07:23:37 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41329 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799Ab1B1MXh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 07:23:37 -0500
Received: (qmail 22711 invoked by uid 111); 28 Feb 2011 12:23:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 28 Feb 2011 12:23:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Feb 2011 07:23:35 -0500
Content-Disposition: inline
In-Reply-To: <20110228121726.GA5197@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168102>

On Mon, Feb 28, 2011 at 07:17:26AM -0500, Jeff King wrote:

> > That aspect is similar to -M and -C, though - unless we check the sha1
> > of the blobs before applying the patch (which would be possible for -D
> > also) - do we?
> 
> Yes, I think we do check the sha1s for a "-M" patch. And we should do so
> for a "-D" patch, too. Which would make it just as likely to conflict as
> a version with the actual patch content, _except_ that it relies on the
> recipient having that sha1.
> 
> I don't see how "-D" is any less reversible than -M or -C, though. If I
> get your -D patch, I use the index line to see that the blob went from
> 1234abcd to 0000000, check that we are at 1234abcd, and then delete the
> file. To reverse it, I reinstate 1234abcd from nothing (and conflict if
> the file exists). _Neither_ case works without the sha1.
> 
> So I think the problem is not about "this cannot be reversed" but about
> "the recipient must have your sha1 to make sense of it, in either
> direction". Which is the same case as with "-M" and "-C", and why we
> have long cautioned about their use on mailing lists. But the right rule
> is not "do not use on mailing lists" but rather "do not use on mailing
> lists for projects where the recipients will not be using git to apply".

Actually, thinking on this a bit more, I guess "-M" and "-C" are usable
without the sha1. In fact, we don't even provide it for a strict 100%
rename, and for a rename-with-patch, you can apply the patch, assuming
you have the original file in any form. So they are really about "is
your recipient using git", not "is your recipient using git _and_ will
he/she have the right sha1".

I do still think that in practice among git users that "-D" patches will
be able to be applied. You won't typically be sending a patch to delete
something that other people don't have. I would expect most uses of
"apply -R" to be reverting an existing delete, which means you will have
the sha1.

-Peff
