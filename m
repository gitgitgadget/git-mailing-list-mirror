From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] t0005: work around strange $? in ksh when program terminated
 by a signal
Date: Fri, 09 Jul 2010 10:45:06 -0500
Message-ID: <iOZX7rvipLDwT5DTYGPE0q9TlJfav09nJWqaRsyiefjNds9DpaDw1A@cipher.nrlssc.navy.mil>
References: <20100709030812.GA16877@dert.cs.uchicago.edu> <4C36CA2C.5050305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 09 17:45:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXFlS-00048D-Gn
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 17:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495Ab0GIPpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 11:45:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59493 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757131Ab0GIPpO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 11:45:14 -0400
Received: by mail.nrlssc.navy.mil id o69Fj8YE025296; Fri, 9 Jul 2010 10:45:08 -0500
In-Reply-To: <4C36CA2C.5050305@viscovery.net>
X-OriginalArrivalTime: 09 Jul 2010 15:45:08.0023 (UTC) FILETIME=[B51E5C70:01CB1F7D]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150675>

On 07/09/2010 02:05 AM, Johannes Sixt wrote:
> From: Johannes Sixt <j6t@kdbg.org>
> 
> ksh is known to report $? of programs that terminated by a signal as
> 256 + signal number instead of 128 + signal number like other POSIX
> compliant shells. (ksh's behavior is still POSIX compliant in this regard.)

This may only be true for Ksh93.  The Ksh88 man page says that
the exit status is 128+signum.  The Public domain Korn shell, and
ksh on IRIX 6.5, Solaris 7, 9, and 10 all exit with the standard
behavior of 128+signum.  So, it may be appropriate to change the
commit message and comment in t0005 to reflect this fact.

-Brandon


>  t/t0005-signals.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
> index 09f855a..93e58c0 100755
> --- a/t/t0005-signals.sh
> +++ b/t/t0005-signals.sh
> @@ -13,6 +13,7 @@ test_expect_success 'sigchain works' '
>  	test-sigchain >actual
>  	case "$?" in
>  	143) true ;; # POSIX w/ SIGTERM=15
> +	271) true ;; # ksh w/ SIGTERM=15
>  	  3) true ;; # Windows
>  	  *) false ;;
>  	esac &&
