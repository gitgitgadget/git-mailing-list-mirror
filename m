From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] am: invoke perl's strftime in C locale
Date: Tue, 15 Jan 2013 07:59:53 -0800
Message-ID: <20130115155953.GB21815@sigill.intra.peff.net>
References: <20130114205933.GA25947@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:00:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv8vz-00081b-Uh
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 17:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303Ab3AOP75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 10:59:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34101 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933Ab3AOP74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 10:59:56 -0500
Received: (qmail 30376 invoked by uid 107); 15 Jan 2013 16:01:12 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Jan 2013 11:01:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2013 07:59:53 -0800
Content-Disposition: inline
In-Reply-To: <20130114205933.GA25947@altlinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213642>

On Tue, Jan 15, 2013 at 12:59:33AM +0400, Dmitry V. Levin wrote:

> diff --git a/git-am.sh b/git-am.sh
> index c682d34..64b88e4 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -334,7 +334,7 @@ split_patches () {
>  			# Since we cannot guarantee that the commit message is in
>  			# git-friendly format, we put no Subject: line and just consume
>  			# all of the message as the body
> -			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
> +			LC_ALL=C perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
>  				if ($subject) { print ; }
>  				elsif (/^\# User /) { s/\# User/From:/ ; print ; }
>  				elsif (/^\# Date /) {

This puts all of perl into the C locale, which would mean error messages
from perl would be in English rather than the user's language. It
probably isn't a big deal, because that snippet of perl is short and not
likely to produce problems, but I wonder how hard it would be to set the
locale just for the strftime call.

-Peff
