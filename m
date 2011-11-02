From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Wed, 2 Nov 2011 14:03:27 -0400
Message-ID: <20111102180327.GA30668@sigill.intra.peff.net>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
 <4EAEAE13.50101@atlas-elektronik.com>
 <4EAFC18A.1070502@atlas-elektronik.com>
 <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
 <loom.20111101T205618-231@post.gmane.org>
 <loom.20111101T211624-511@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 19:03:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLf9z-0003eh-O6
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 19:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437Ab1KBSDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 14:03:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60276
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932240Ab1KBSDa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 14:03:30 -0400
Received: (qmail 14986 invoked by uid 107); 2 Nov 2011 18:09:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 14:09:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 14:03:27 -0400
Content-Disposition: inline
In-Reply-To: <loom.20111101T211624-511@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184651>

On Tue, Nov 01, 2011 at 08:18:47PM +0000, Stefan Naewe wrote:

> Stefan Naewe <stefan.naewe <at> gmail.com> writes:
> 
> > Push with https works, if the URL looks e.g. like this:
> > 
> >   https://github.com/user/repo.git
> > 
> > rather than this
> > 
> >   https://user <at> github.com/user/repo.git
> > 
> > and having a ~/.netrc like this
> > 
> >   machine github.com login user password YouDontWantToKnow
> > 
> > If the URL contains 'user@' I get the 'need ENTER' behaviour.
> > 
> 
> Another update:
> 
> If I revert deba493 the 'need ENTER' is gone and everything works as above.

I think this is a false positive. The problem that deba493 fixes is that
"git push" was not properly looking at the push URL, but rather pulling
the initial auth information from the fetch URL. So I suspect your
finding the bug there or not may have to do with it actually respecting
your config properly.

I think the bug is much older than this, and we are just exposing it by
finally using the correct URL.

Without using a configured remote, try this (with .netrc configured):

  git push https://github.com/user/repo.git :refs/heads/nothing

which should work, and then this:

  git push https://user@github.com/user/repo.git :refs/heads/nothing

which will do the "must hit enter to accept password" thing.

That fails even with v1.7.7. I didn't bisect, but it has been there
quite a while (v1.6.6 has it, but v1.6.5 has a weird error, so I didn't
bisect further).

-Peff
