From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 2/2] send-email: add tests for refactored prompting
Date: Tue, 31 Mar 2009 16:19:37 +0200
Message-ID: <20090331141937.GC14611@atjola.homenet>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com> <1238290751-57461-2-git-send-email-jaysoffian@gmail.com> <20090331103303.GD3307@atjola.homenet> <76718490903310707s75e24e39l63f0d396f60a0583@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 16:21:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loeqi-0003xU-NC
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 16:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914AbZCaOTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 10:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755565AbZCaOTo
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 10:19:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:34992 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751293AbZCaOTo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 10:19:44 -0400
Received: (qmail invoked by alias); 31 Mar 2009 14:19:40 -0000
Received: from i59F54235.versanet.de (EHLO atjola.local) [89.245.66.53]
  by mail.gmx.net (mp014) with SMTP; 31 Mar 2009 16:19:40 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19os8Jhi21o942VT3Xs50pqJWcIk/Tk4QmhKQm49S
	vKaMmT5zXHo247
Content-Disposition: inline
In-Reply-To: <76718490903310707s75e24e39l63f0d396f60a0583@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115263>

On 2009.03.31 10:07:25 -0400, Jay Soffian wrote:
> 2009/3/31 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> > These two cause interactive prompts for me.
>=20
> Ah, it's because of going through test_must_fail. Grrr, a test farm
> for git would be nice. :-)
>=20
> This should fix it up:
>=20
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index b4de98c..cd34525 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -476,7 +476,8 @@ test_expect_success 'confirm detects EOF (inform
> assumes y)' '
>  test_expect_success 'confirm detects EOF (auto causes failure)' '
>         CONFIRM=3D$(git config --get sendemail.confirm) &&
>         git config sendemail.confirm auto &&
> -       GIT_SEND_EMAIL_NOTTY=3D1 \
> +       GIT_SEND_EMAIL_NOTTY=3D1 &&
> +       export GIT_SEND_EMAIL_NOTTY &&
>                 test_must_fail git send-email \
>                         --from=3D"Example <nobody@example.com>" \
>                         --to=3Dnobody@example.com \
> @@ -490,8 +491,9 @@ test_expect_success 'confirm detects EOF (auto
> causes failure)' '
>  test_expect_success 'confirm doesnt loop forever' '
>         CONFIRM=3D$(git config --get sendemail.confirm) &&
>         git config sendemail.confirm auto &&
> -       yes "bogus" | GIT_SEND_EMAIL_NOTTY=3D1 \
> -               test_must_fail git send-email \
> +       GIT_SEND_EMAIL_NOTTY=3D1 &&
> +       export GIT_SEND_EMAIL_NOTTY &&
> +               yes "bogus" | test_must_fail git send-email \
>                         --from=3D"Example <nobody@example.com>" \
>                         --to=3Dnobody@example.com \
>                         --smtp-server=3D"$(pwd)/fake.sendmail" \

Yep, after fixing the linewrapping and restoring the tabs, this works.

> What's your OS and test shell btw?

Debian sid, kernel 2.6.29, dash as /bin/sh

Thanks,
Bj=F6rn
