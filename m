From: Jeff King <peff@peff.net>
Subject: Re: commit a1f6baa5 (wrap long header lines) breaks my habit
Date: Thu, 26 May 2011 16:36:25 -0400
Message-ID: <20110526203625.GA31018@sigill.intra.peff.net>
References: <20110524160253.GA7723@scotty.home>
 <7vboys83nh.fsf@alter.siamese.dyndns.org>
 <20110524164616.GB7723@scotty.home>
 <20110524200716.GF584@sigill.intra.peff.net>
 <20110525154046.GC7723@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Thu May 26 22:36:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhIJ-0001wq-7p
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 22:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148Ab1EZUg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 16:36:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51260
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758238Ab1EZUg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 16:36:28 -0400
Received: (qmail 16904 invoked by uid 107); 26 May 2011 20:36:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 16:36:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 16:36:25 -0400
Content-Disposition: inline
In-Reply-To: <20110525154046.GC7723@scotty.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174561>

On Wed, May 25, 2011 at 05:40:46PM +0200, Stefan-W. Hahn wrote:

> > With "am -k", it does keep the fold. This is an artifact of the original
> > behavior, where the folds were literally included from a multi-line
> 
> Correct, I checked this, so with
> 
>    git format-patch -k --stdout a..b | git am -3
> (no second -k)
> 
> all is as before. 
> 
> Thanks for your clarification, sorry for the noise.

Actually, I don't think it's noise. Look at the documentation patch you
suggest:

> index d13c9b2..4e62248 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -468,6 +468,16 @@ the current branch using 'git am' to cherry-pick them:
>  ------------
>  $ git format-patch -k --stdout R1..R2 | git am -3 -k
>  ------------
> ++
> +In this example the subject lines of the commits will be folded after
> +78 characters and 'git am' will keep this folding.

You are using "format-patch -k | am -k". Surely that should preserve
your subject, no matter the length, and the fact that we need to
document it is a sign that the behavior is simply wrong.

So I think we should do the following series instead.

  [1/3]: t: test subject handling in format-patch / am pipeline
  [2/3]: mailinfo: always clean up rfc822 header folding
  [3/3]: format-patch: preserve subject newlines with -k

-Peff
