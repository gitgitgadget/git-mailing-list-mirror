Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C4AC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 15:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34250207DE
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 15:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VBGI92km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgHUPTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:19:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:49033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbgHUPRv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 11:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598023064;
        bh=vb5KXUJrDgzOoysmKQEPcKYu/wnPoFbu6+pWHUPCVVo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VBGI92kmJfuYUkPp2RSj4r0SfD9x5wkfTBNAwd2iMjHRJBpQl1gYret2N2wcm9rf2
         AwS/srzj+laEompOQKcbZiUxY3Y6VyTptdJ7QEANPE6iZbSI+Roln9UP9A96HNrGX+
         7+FQOMZngLycG99OL+scLeHd1NVGWPPcvXdLtr44=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.213.219]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYux-1kwiRf0qGR-00u4vp; Fri, 21
 Aug 2020 17:17:44 +0200
Date:   Fri, 21 Aug 2020 17:17:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary'
 from shell to C
In-Reply-To: <20200812194404.17028-5-shouryashukla.oo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008211708280.56@tvgsbejvaqbjf.bet>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com> <20200812194404.17028-1-shouryashukla.oo@gmail.com> <20200812194404.17028-5-shouryashukla.oo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Lw6c976jMZiwGUjhdY3Y0i2/9aDWJ1QK6J1OWcy+ttGH3Vngl34
 wkRk+iRwpA4kg18KlkH63YLNNfg2k5grohXrhG0NAaIsLQ22SMyKMFajxPcWmygonW7baMv
 J42tyZHMIZXN5xQTt7rqdhzgWkRvLHSakBXOgX1LG5J7NU97UN7LGq85i+nl7hBO0SEXHZ8
 9mEThZ6EI+ZcJGoqjxrrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TNyTD6NTEwo=:Vws10hrFnECb5WI1VRFHy7
 6Fe/Au9bkEwX2mbmuSuUdqVFqZk3c2N2p0+XV2p1vx/s1UHoBuMUtZAbXTzmO2zFxZXIYLAKP
 zXZpRG+S/ce9K4cTY7evQYJuzN2CVIcxBgNypp0Yvzn7bG4iBBmEgCgcUbJmpIyhiLCPVEtll
 DqSIjmP6BPyUC2GN4vnsqAWNqE6CWHfQ7Wq7Viy6baSsRzT8rwTlDLp/e5l4CQkGeeak35gPf
 JV1vy8g46oxjthFKbYEP8PP+JSWOFuZRq31XDwEa6elryjgUTxb9Bl1iRtw0rFt0P1MzFopCR
 OrP64PmGpW8o/wyJR7pVZ/iA/HyDwF7mF0lnLhSSR73uyywVmNk4xjLCJIf0SuaRvmlLL603L
 ISajt2WLOFa5V9Y2gM3f4vKo+U2H0VPpe+2rRQ1CujZQpUE9V8H+Jxanp+qL8WyDweShxb8gi
 8H+3e3oG5MXpkP+irrNhJ6egaqHUKLl21tiDevW2WCpi0iGM2hQIove96IVWMTiKEgmAKQJxT
 25bv/88ek9+ZX6HcfZKmSADKgRbDm+u3ZSBE3N7Wo1jYLmHbZ4A0WI9B2Zaj1tsseT4KmekJ1
 7YQJsNzJp8iaYGBDRcmU8I3bvQYuyVsVDLN5kUKwjizchLYGcvl4MjrcQjLi117rGhRIn40FO
 oHvizwiCKHh9mypauc9sc9NFQyIZYsWHgcdCKwZEJvTfWpv2rArWKaZKFSxCQqgabCneH2GQI
 H++FMEgAToOjNEDdAFZtgYaohD/Y1FMlNS4nGQCPdkXYu9oWnhqKjR9EL/Zf4udgvdgaCAMVk
 uKO9321T6x8ZPSJMqsX9HbavODQjLZpJ/WG6SRGH8JPuW2kqxjb8I68aS4WQ9cKkk2sp/ffUC
 E9wRFoqmZ5Sa1cf+FlpEQ8DLyAvEBQp00IqRFS+YYjxW11wqHVlva0k3SU6VR/wIy0dPhuXm/
 k1Gs4BsUWXR/j3uRxo6BpI1pVNiLb7G5UuHP6fJR14pQulbgglDk8fzokYGDmH2N+gNy/xb59
 hZ4ekoBahDV6nbxBhuXxzqUJJ6pUw/deed8E49jt0WqwlXUyZ0sgT2j9Z8dYT3ivTTBFX3Jej
 Y9316WPUP/4klqTHmpBl4dmgIgyY0G93s4AKT5zNtvfynNY8Kq5g8p+r68tah3t2JUxPqwhE2
 VkpSTArg7qHd91hgI+3xw6INgiPxViBn51bUsI6KlmTx+fb7HAhPdr99wxjndlX9cJZ6vMZxC
 0RxOxl0+N4027oVCZ3PUts+tsXMj6G5FKHSSZiQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Thu, 13 Aug 2020, Shourya Shukla wrote:

> [...]
> diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summar=
y-add.sh
> index 829fe26d6d..59a9b00467 100755
> --- a/t/t7421-submodule-summary-add.sh
> +++ b/t/t7421-submodule-summary-add.sh
> @@ -58,7 +58,7 @@ test_expect_success 'submodule summary output for subm=
odules with changed paths'
>  	git commit -m "change submodule path" &&
>  	rev=3D$(git -C sm rev-parse --short HEAD^) &&
>  	git submodule summary HEAD^^ -- my-subm >actual 2>err &&
> -	test_i18ngrep "fatal:.*my-subm" err &&
> +	grep "fatal:.*my-subm" err &&

Sadly, this breaks on Windows: on Linux (and before this patch, also on
Windows), the error message reads somewhat like this:

	fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or director=
y

However, with the built-in `git submodule summary`, on Windows the error
message reads like this:

	error: cannot spawn git: No such file or directory

Now, this is of course not the best way to present this error message, but
please note that even providing a better error message does not fix the
erroneous expectation of the `fatal:` prefix (Git typically produces this
when `die()`ing, which can be done in the POSIX version that uses `fork()`
and `exec()` but not in the Windows version that needs to use
`CreateProcessW()` instead).

Therefore, I propose this patch on top:

=2D- snipsnap --
[PATCH] mingw: mention if `mingw_spawnve()` failed due to a missing direct=
ory

When we recently converted the `summary` subcommand of `git submodule`
to be mostly built-in, a bug was uncovered where a very unhelpful error
message was produced when a process could not be spawned because the
directory in which it was supposed to be run does not exist.

Even so, we _still_ have to adjust the `git submodule summary` test, to
accommodate for the fact that the `mingw_spawnve()` function will return
with an error instead of `die()`ing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 compat/mingw.c                   | 4 ++++
 t/t7421-submodule-summary-add.sh | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 1a64d4efb26b..3c30d0cab589 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1850,6 +1850,10 @@ static pid_t mingw_spawnve_fd(const char *cmd, cons=
t char **argv, char **deltaen
 	/* Make sure to override previous errors, if any */
 	errno =3D 0;

+	if (dir && !is_directory(dir))
+		return error_errno(_("could not exec '%s' in '%s'"),
+				   argv[0], dir);
+
 	if (restrict_handle_inheritance < 0)
 		restrict_handle_inheritance =3D core_restrict_inherited_handles;
 	/*
diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summary-=
add.sh
index 59a9b00467dc..f00d69ca29ea 100755
=2D-- a/t/t7421-submodule-summary-add.sh
+++ b/t/t7421-submodule-summary-add.sh
@@ -58,7 +58,7 @@ test_expect_success 'submodule summary output for submod=
ules with changed paths'
 	git commit -m "change submodule path" &&
 	rev=3D$(git -C sm rev-parse --short HEAD^) &&
 	git submodule summary HEAD^^ -- my-subm >actual 2>err &&
-	grep "fatal:.*my-subm" err &&
+	grep "my-subm" err &&
 	cat >expected <<-EOF &&
 	* my-subm ${rev}...0000000:

=2D-
2.28.0.windows.1

