From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [RFC/PATCH 1/2] log: add "log.showsignature" configuration
 variable
Date: Thu, 26 May 2016 15:42:11 +0200 (CEST)
Message-ID: <156149583.51074.1464270131166.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com> <20160526130647.27001-2-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Austin English <austinenglish@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 15:32:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5vOI-0000XA-QW
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 15:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbcEZNbt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2016 09:31:49 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:53678 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753499AbcEZNbs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 09:31:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id AD78E24A7;
	Thu, 26 May 2016 15:31:45 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cV67rRApIHHY; Thu, 26 May 2016 15:31:45 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 9B74F2533;
	Thu, 26 May 2016 15:31:45 +0200 (CEST)
In-Reply-To: <20160526130647.27001-2-mehul.jain2029@gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: add "log.showsignature" configuration variable
Thread-Index: huxeBb4wTQ3/1WcIhEwBTYy4ufxp9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295654>

Hi Mehul,

Mehul Jain <mehul.jain2029@gmail.com> writes:
> People may want to always use "--show-signature" while using "git log=
"
> or "git show".
>=20
> When log.showsignature set true, "git log" and "git show" will behave

'When log.showsignature is set to true' ?

> as "--show-signature" was given to them.

s/as/as if

> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
>  Documentation/git-log.txt |  4 ++++
>  builtin/log.c             |  6 ++++++
>  t/t4202-log.sh            | 19 +++++++++++++++++++
>  t/t7510-signed-commit.sh  |  7 +++++++
>  4 files changed, 36 insertions(+)
> [...]
> [...]
> +test_expect_success GPG 'log.showsignature=3Dtrue behaves like --sho=
w-signature' '
> +        git checkout -b test_sign master &&
> +        echo foo >foo &&
> +        git add foo &&
> +        git commit -S -m signed_commit &&
> +        test_config log.showsignature true &&
> +        git log -1 signed >actual &&
> +        test_i18ngrep "gpg: Signature made" actual &&
> +        test_i18ngrep "gpg: Good signature" actual
> +'
> +
> +test_expect_success GPG '--show-signature overrides log.showsignatur=
e=3Dfalse' '
> +        test_when_finished "git reset --hard && git checkout master"=
 &&
> +        git config log.showsignature false &&

Any specific reason as to why you don't use test_config like in the
first test?

> +        git log -1 --show-signature signed >actual &&
> +        test_i18ngrep "gpg: Signature made" actual &&
> +        test_i18ngrep "gpg: Good signature" actual
> +'
> +
>  test_expect_success 'log --graph --no-walk is forbidden' '
>          test_must_fail git log --graph --no-walk
>  '
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 4177a86..326dcc8 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -210,4 +210,11 @@ test_expect_success GPG 'show lack of signature =
with custom format' '
>          test_cmp expect actual
>  '
> =20
> +test_expect_success GPG 'log.showsignature behaves like --show-signa=
ture' '
> +        git config log.showsignature true &&

Same here.

> +        git show initial > actual &&

Style: no space after redirection.

Thanks,
R=C3=A9mi
