From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4 v2] Allow detached form (e.g. "-S foo" instead of
	"-Sfoo") for diff options
Date: Wed, 28 Jul 2010 21:00:31 -0500
Message-ID: <20100729020031.GI29156@dert.cs.uchicago.edu>
References: <vpqr5ioukca.fsf@bauges.imag.fr> <1280310062-16793-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 29 04:00:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeIQI-0001LH-Ab
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 04:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256Ab0G2CAd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 22:00:33 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:49218 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0G2CAd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 22:00:33 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 50913A1B8;
	Wed, 28 Jul 2010 21:00:32 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 1ACD220DBC; Wed, 28 Jul 2010 21:00:31 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1280310062-16793-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152146>

Matthieu Moy wrote:

>  5 files changed, 90 insertions(+), 16 deletions(-)
>  create mode 100644 t/t4013/diff.log_-S_F_master

Well, I like it, though I=E2=80=99m obviously biased.

> --- /dev/null
> +++ b/t/t4013/diff.log_-S_F_master
> @@ -0,0 +1,7 @@
> +$ git log -S F master
> +commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0

Note to self: a nice mini-series might be to blur these out.

> +++ b/t/t4202-log.sh
> @@ -101,11 +101,16 @@ test_expect_success 'oneline' '
>  test_expect_success 'diff-filter=3DA' '
> =20
>  	actual=3D$(git log --pretty=3D"format:%s" --diff-filter=3DA HEAD) &=
&
> +	actual_detached=3D$(git log --pretty=3D"format:%s" --diff-filter A =
HEAD) &&
>  	expect=3D$(echo fifth ; echo fourth ; echo third ; echo initial) &&
>  	test "$actual" =3D "$expect" || {
>  		echo Oops
>  		echo "Actual: $actual"
>  		false
> +	} &&
> +	test "$actual" =3D "$actual_detached" || {
> +		echo Oops. Detached form broken
> +		echo "Actual_detached: $actual_detached"
>  	}

You left out the crucial "false"! :)

Below is an add-on patch to use a more readable style.  With
or without that change:

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 3352935..36870c5 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -100,18 +100,11 @@ test_expect_success 'oneline' '
=20
 test_expect_success 'diff-filter=3DA' '
=20
-	actual=3D$(git log --pretty=3D"format:%s" --diff-filter=3DA HEAD) &&
-	actual_detached=3D$(git log --pretty=3D"format:%s" --diff-filter A HE=
AD) &&
-	expect=3D$(echo fifth ; echo fourth ; echo third ; echo initial) &&
-	test "$actual" =3D "$expect" || {
-		echo Oops
-		echo "Actual: $actual"
-		false
-	} &&
-	test "$actual" =3D "$actual_detached" || {
-		echo Oops. Detached form broken
-		echo "Actual_detached: $actual_detached"
-	}
+	git log --pretty=3D"format:%s" --diff-filter=3DA HEAD > actual &&
+	git log --pretty=3D"format:%s" --diff-filter A HEAD > actual-detached=
 &&
+	printf "fifth\nfourth\nthird\ninitial" > expect &&
+	test_cmp expect actual &&
+	test_cmp expect actual-detached
=20
 '
=20
--=20
