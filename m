From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH/WIP v2 08/14] read-cache: add GIT_TEST_FORCE_WATCHER for testing
Date: Sun, 19 Jan 2014 18:04:51 +0100
Message-ID: <87lhybewcs.fsf@thomasrast.ch>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
	<1389952060-12297-1-git-send-email-pclouds@gmail.com>
	<1389952060-12297-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 18:05:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4voZ-0003fe-BI
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 18:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbaASRF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jan 2014 12:05:29 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:53159 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbaASRFG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jan 2014 12:05:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 5B3614D6572;
	Sun, 19 Jan 2014 18:05:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id J16OOLIhxvht; Sun, 19 Jan 2014 18:04:52 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (unknown [213.55.184.196])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 3B3C64D64BD;
	Sun, 19 Jan 2014 18:04:52 +0100 (CET)
In-Reply-To: <1389952060-12297-9-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 17
 Jan 2014 16:47:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240694>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> This can be used to force watcher on when running the test
> suite.
>
> git-file-watcher processes are not automatically cleaned up after eac=
h
> test. So after running the test suite you'll be left with plenty
> git-file-watcher processes that should all end after about a minute.

Probably not a very good idea, especially in noninteractive use?  E.g.,
a bisection through the test suite or parallel test runs on different
commits may exhaust the available processes and/or memory.

Each test should make an effort to clean up all watchers before
terminating.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  read-cache.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 5dae9eb..a1245d4 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1544,7 +1544,12 @@ static void validate_watcher(struct index_stat=
e *istate, const char *path)
>  	}
> =20
>  	if (autorun_watcher =3D=3D -1) {
> -		git_config(watcher_config, NULL);
> +		if (getenv("GIT_TEST_FORCE_WATCHER")) {
> +			watch_lowerlimit =3D 0;
> +			recent_limit =3D 0;
> +			autorun_watcher =3D 1;
> +		} else
> +			git_config(watcher_config, NULL);
>  		if (autorun_watcher =3D=3D -1)
>  			autorun_watcher =3D 0;
>  	}

--=20
Thomas Rast
tr@thomasrast.ch
