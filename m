From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] A handful of "branch description" patches
Date: Fri, 23 Sep 2011 16:18:24 -0400
Message-ID: <20110923201824.GA27999@sigill.intra.peff.net>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
 <4E7C49CF.60508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 23 22:18:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7CCm-0000F2-No
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 22:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab1IWUSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 16:18:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41808
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784Ab1IWUS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 16:18:27 -0400
Received: (qmail 20330 invoked by uid 107); 23 Sep 2011 20:23:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Sep 2011 16:23:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2011 16:18:24 -0400
Content-Disposition: inline
In-Reply-To: <4E7C49CF.60508@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181999>

On Fri, Sep 23, 2011 at 10:56:47AM +0200, Michael J Gruber wrote:

>   mjg/vob/refrev-pretend [mjg/vob/virtual-objects: ahead 1]
>     Pseudo revs for refnames
>     
>     An alternative implementation using pretend_sha1...
>     Currently unused.
> 
>   mjg/vob/virtual-objects [origin/next: ahead 2, behind 10]
>     Virtual refname objects
>     
>     For each existing refname, introduce virtual objects corresponding to a blob
>     with the refname as the content. "virtual" refers to the fact that these
>     objects are not written out but exist for all other purposes, such as
>     attaching notes and keeping them from being pruned.

Eww. :)

This seems like a clever solution to making git-notes store a ref as a
key instead of an arbitrary sha1. But I wonder if the end result is
really waht the user wants. The resulting notes tree is good for doing
lookups, but the entries are completely obfuscated. So I can't easily do
something like "list all of the refs which have descriptions". I can
only list the _hashes_ of the refs which have descriptions. And if I am
lucky, I can hash the refs I have and correlate them. But unknown ones
will simply be a mystery.

Wouldn't it be much more friendly to have a separate tree of refnames
that stores:

  refs/heads/foo -> (some blob with the "foo" description)
  refs/heads/bar -> (some blob with the "bar" description)

Yeah, you have to build another git-notes-like interface around it. But
the data structure is pleasant and flexible. You could even "git
checkout" the whole tree and edit the notes with your editor, without
having to deal with some obfuscated name.

-Peff
