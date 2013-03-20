From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-am: fix "Applying" message when applypatch-hook was run
Date: Thu, 21 Mar 2013 00:36:00 +0100
Message-ID: <vpqli9hmyov.fsf@grenoble-inp.fr>
References: <b978a77f8a37c47b2d6c2201d1f7cfffa01f8443.1363820289.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Thu Mar 21 00:36:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UISYd-0005yJ-B6
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 00:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab3CTXgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 19:36:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49245 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab3CTXgG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 19:36:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r2KNZvsk022492
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 21 Mar 2013 00:35:57 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UISY4-0007cE-Tb; Thu, 21 Mar 2013 00:36:00 +0100
In-Reply-To: <b978a77f8a37c47b2d6c2201d1f7cfffa01f8443.1363820289.git.simon@ruderich.org>
	(Simon Ruderich's message of "Thu, 21 Mar 2013 00:18:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 21 Mar 2013 00:35:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2KNZvsk022492
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1364427358.42461@S99+PDrecTKRceC4cR4Hfw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218688>

Simon Ruderich <simon@ruderich.org> writes:

> ---
> Hello,
>
> This patch fixes a minor issue with git-am. When the
> applypatch-hook modifies the commit message, git-am displays the
> original message. This patch updates the message to use the
> modified version.

Please, read SubmittingPatches in the Documentation directory of Git's
source tree. Your text above should be a commit message (hence, no
hello), and should not be below the --- line.

Also, read about signed-off-by in the same document.

> diff --git a/git-am.sh b/git-am.sh
> index 202130f..0997077 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -795,6 +795,14 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
>  	then
>  		"$GIT_DIR"/hooks/applypatch-msg "$dotest/final-commit" ||
>  		stop_here $this
> +
> +		# applypatch-msg can update the commit message.
> +		if test -f "$dotest/final-commit"
> +		then
> +			FIRSTLINE=$(sed 1q "$dotest/final-commit")
> +		else
> +			FIRSTLINE=""
> +		fi
>  	fi

This copy/paste a piece of code that is already a few lines above. Is
there any reason not to _move_ the assignment to FIRSTLINE after the "if
test -x "$GIT_DIR"/hooks/applypatch-msg", to avoid duplicating?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
