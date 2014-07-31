From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 3/7] change `git_config()` return value to void
Date: Thu, 31 Jul 2014 13:22:29 +0200
Message-ID: <vpqoaw5epsa.fsf@anie.imag.fr>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
	<1406799857-28048-4-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:23:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCoSN-0004Nm-DU
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 13:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbaGaLXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 07:23:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50704 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466AbaGaLWc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 07:22:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBMR2W001714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 13:22:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBMTPp024816;
	Thu, 31 Jul 2014 13:22:29 +0200
In-Reply-To: <1406799857-28048-4-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 31 Jul 2014 02:44:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 Jul 2014 13:22:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VBMR2W001714
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407410548.31902@/ymOvwlud/RLYWM1T/Przg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254551>

Tanay Abhra <tanayabh@gmail.com> writes:

> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>

I think I deserve a bit of credit here ;-).

>  {
> -	return git_config_with_options(fn, data, NULL, 1);
> +	if (git_config_with_options(fn, data, NULL, 1) < 0)
> +		/*
> +		 * git_config_with_options() normally returns only
> +		 * positive values, as most errors are fatal, and
> +		 * non-fatal potential errors are guarded by "if"
> +		 * statements that are entered only when no error is
> +		 * possible.
> +		 *
> +		 * If we ever encounter a non-fatal error, it means
> +		 * something went really wrong and we should stop
> +		 * immediately.
> +		 */
> +		die("Unknown error occured while reading the configuration files");
>  }

My bad, but this should be die(_("..."));, so that the message can be
translated. Not really serious since it's not really meant to be seen by
the user, though.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
