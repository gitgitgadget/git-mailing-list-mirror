From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] credentials helpers+remote helpers
Date: Thu, 07 Jun 2012 19:13:06 +0200
Message-ID: <vpqvcj32ggt.fsf@bauges.imag.fr>
References: <1339079743-31068-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Thu Jun 07 19:13:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScgGu-0006U4-1B
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394Ab2FGRNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:13:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60187 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932308Ab2FGRNP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:13:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q57H4G1h002042
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Jun 2012 19:04:16 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ScgGh-0005Qb-DQ; Thu, 07 Jun 2012 19:13:07 +0200
In-Reply-To: <1339079743-31068-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
	(Javier Roucher-Iglesias's message of "Thu, 7 Jun 2012 16:35:43
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Jun 2012 19:04:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q57H4G1h002042
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339693459.35813@9SJho92ni0K8XkXVC8SVhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199422>

> Subject: Re: [PATCH/RFC] credentials helpers+remote helpers

This is not a good title. The one you have below (which I suggested
off-list) should be the first line of the patch.

Javier.Roucher-Iglesias@ensimag.imag.fr writes:

> Add "git credential" plumbing command

(I mean this one)

>  .gitignore                       |  1 +
>  Documentation/git-credential.txt | 70 ++++++++++++++++++++++++++++++++++++++++
>  Makefile                         |  1 +
>  builtin.h                        |  1 +
>  builtin/credential.c             | 40 +++++++++++++++++++++++
>  git.c                            |  1 +

No tests?

Since this new command is essentially a copy-paste of test-credential.c,
it would indeed make sense to replace test-credential calls in the
scripts by calls to this "git credential" command.

> index 0000000..a6e1d0a
> --- /dev/null
> +++ b/Documentation/git-credential.txt

This file is not valid asciidoc. Please, run "make doc" and see if the
generated HTML is right. Currently, it says

    SUBDIR ../
make[1]: `GIT-VERSION-FILE' is up to date.
    ASCIIDOC git-credential.html
asciidoc: ERROR: git-credential.txt: line 69: [blockdef-listing] missing closing delimiter
make: *** [git-credential.html] Error 1

(didn't I already mention it off-list?)
> +------------------
> +git credential [fill|approve|reject]
> +
> +------------------
[...]
> +static const char usage_msg[] =
> +"credential <fill|approve|reject> [helper...]";

Which one is right?

I already suggested several times that you get rid of this "helper"
argument (inherited from test-credential), or that you give it a better
API (e.g. --helper HELPER, but not positional argument). If this
argument is usefull, then keep it but it should be documented properly.

> +Git-credential permits to save username, password, host, path and protocol.
> +When you invoke git-credential, you can ask for a password, using the command
> +'git credential fill'.

Who is "you" here? This "you" is the developer writing a script using
"git credential", while this one :

> +-If it is not stored, git-credential will ask you to enter 
> +the password:
> +		
> +		> Password for '[http|https]admin@localhost':

... is the user of the script. Please be more precise, e.g. "a script
can ask ...", "the user will be prompted for a password".

> +Then if password is correct, you can store using command

if _the_ password ... you can store _it_ using ...

> +If the password is refused, you can delete using command

delete _it_

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
