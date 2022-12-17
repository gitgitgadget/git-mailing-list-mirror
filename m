Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DBBC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 12:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLQMpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 07:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLQMpw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 07:45:52 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6229595
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 04:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671281143; bh=UOdYK4aHrg8d6eN8/VSbaZJwg/FLuqUhU+l/8Eid8Jg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BeoOBKzHCRiacQQSt9QWUdK8TLAtSiH3XuQuhPoHJjqFf+TfBEYbGROzX+MzNCG+M
         n5+0XEdS3WkU/z+sFJRWX5BDBIWsTFls5Ryu/ogVadBqY9B1VOSvxp+WKL53epQvwQ
         e2OKfK/HBmqXw5Bdl0DBaNvx3z4iYdZgx6ScpqSwsa8J306RUtJZ/pWHup+NZu5Kfl
         QSv8vMGEoSvx0yICDVbhrMlFEgjTblkAFppK2wdnyf3A4OS232pX1qAFHQXh8mZUAa
         ECy1gtQcgzkIroNHBuZHeLk9ftWJt2JfrcrKhxmAoi3kehenLVwddPsXWD9ufQv4uO
         Dj3CzYzqCV05g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBSB3-1pCGG83FGh-00CsQx; Sat, 17
 Dec 2022 13:45:43 +0100
Message-ID: <0036020f-5fe7-4ad1-a66e-26db9d851035@web.de>
Date:   Sat, 17 Dec 2022 13:45:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 5/5] strvec API users: fix more leaks by using
 "STRVEC_INIT_NODUP"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
 <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
 <RFC-patch-5.5-81742a8a6ed-20221215T090226Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-5.5-81742a8a6ed-20221215T090226Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qn8BzTqQTXxxOnTBcnXb99XMSfhZagY7nJj+Ns07MAGas5J0Lm3
 71+fyquv31d2xsUB2pg/G1/VpQk79iZgNrqB4L0CgGVKx5XASvZMFAvE+0aoBs/9yWe3UCy
 Fm3aJrOFRuzrBpFEIz8AzbZAFSk8YAUo+Spd3uPQSLL4CNnWctOyBn3WYj1gde6+CEEt3Dp
 crtdjNSWr9l8uZrHfiupg==
UI-OutboundReport: notjunk:1;M01:P0:wGOCJZaJ4ho=;zokjPEU+/warFitisKsDViStzFk
 Yv7ihP9wMUGHaM1ZLmR3IcjQfTJLJHFuNIkPBTtFd2wezduDanhi4P+MfcibwO6DQtr8zwrui
 gc0PVWaHDhUiQ36YcQYD0v08blk2noW7A6XZU/jPiw18L+6TMwzeb7osKwn2xii3etDyNSGrv
 dKXj7o1Hh2ztEauJpJ4kJJ6va6ve/FE8GoUSUbgRhttMChWpiebckbM9Cf5bfx5xpPGQRZ4cP
 rxoUNb8btuLDFFpuXHNI2kk+9K+2/dspFxq8P005PwptbfoGpFTS77KQOHC10n2b9v5egmhbl
 c5ViM8nm2XJLWn29l6gopw3EOcuBOpnn69Sl0WK9TkbJQl7KF/Vm5w2OTzfw59Ql0+fRUDlPG
 XDoZmQefaTHLOzoOjGBazBPr+W7BNcX81xO6GExcFzcpL8WwxRt9NeL3WDblwSVeG345b7l9N
 eDh/WWfsmcWw4GsO6vjUWb+KwkHwmk3sGSn/e5ibHePK00qtwzw/EpSUOjkqwK88+iVMhGDOW
 E7AI9otz7gQb16AFfTeWB4kLWddnn2RG8HhZVFsVqOjGuNtLb+bC3AnF9pxMuP/BkTwoHdN+c
 zOZEedtFS1XxIccCYZ9f1DOVrNTZh4lJbDXEp8WJZmHswtuXdag96yShJjn8VbEeDe7PFCwVd
 rG2YWUysgS2lNyON/Pl6AsTEba8O09MF8wmZ9r2jTCJ667n4UUV8e8D+OOOgAMbgsiRRo3mpd
 oPdInXWydLpIz5mihrcsKzbKzZZCnu1w/jBDqDrZYeyfNJXa423hfXet1wF43tjSdKTIipj3T
 YjnR63I/Lx5BTb7zyhg1RdXupM0bsGMFfKGkV0gGgQjC6JDRiTtKCEY+ntEiERLP2WXCdiBdH
 sQchKH7Pi7O5Ir9rFm/zTXj3c0M3wYDx/IH7gyieQEZ0GN63p3eZM2wb2NPdh7mqGYjseXpRR
 IPGvFQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.12.22 um 10:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> For these cases where most of the the strings we were pushing to the
> "struct strvec" were fixed strings, but others are dynamically
> allocated. For the latter we keep around a "to_free" list of them.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/describe.c       | 22 +++++++++++++++++-----
>  builtin/upload-archive.c |  9 +++++++--
>  t/t5003-archive-zip.sh   |  1 +
>  3 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index cb205f6b561..eda59ebb19a 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -596,8 +596,10 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
>  		die(_("options '%s' and '%s' cannot be used together"), "--long", "--=
abbrev=3D0");
>
>  	if (contains) {
> +		struct string_list to_free =3D STRING_LIST_INIT_DUP;
>  		struct string_list_item *item;
> -		struct strvec args =3D STRVEC_INIT;
> +		struct strvec args =3D STRVEC_INIT_NODUP;
> +
>  		int ret;
>
>  		strvec_pushl(&args, "name-rev",
> @@ -607,10 +609,19 @@ int cmd_describe(int argc, const char **argv, cons=
t char *prefix)
>  			strvec_push(&args, "--always");
>  		if (!all) {
>  			strvec_push(&args, "--tags");
> -			for_each_string_list_item(item, &patterns)
> -				strvec_pushf(&args, "--refs=3Drefs/tags/%s", item->string);
> -			for_each_string_list_item(item, &exclude_patterns)
> -				strvec_pushf(&args, "--exclude=3Drefs/tags/%s", item->string);
> +			for_each_string_list_item(item, &patterns) {
> +				char *str =3D xstrfmt("--refs=3Drefs/tags/%s", item->string);
> +				const char *item =3D string_list_append_nodup(&to_free, str)->strin=
g;
> +
> +				strvec_push(&args, item);
> +			}
> +			for_each_string_list_item(item, &exclude_patterns) {
> +				char *str =3D xstrfmt("--exclude=3Drefs/tags/%s", item->string);
> +
> +				const char *item =3D string_list_append_nodup(&to_free, str)->strin=
g;
> +
> +				strvec_push(&args, item);
> +			}

Having to track allocations separately for each option is tedious, as
we see here.

>  		}
>  		if (argc)
>  			strvec_pushv(&args, argv);
> @@ -618,6 +629,7 @@ int cmd_describe(int argc, const char **argv, const =
char *prefix)
>  			strvec_push(&args, "HEAD");
>  		ret =3D cmd_name_rev(args.nr, args.v, prefix);
>  		strvec_clear(&args);
> +		string_list_clear(&to_free, 0);
>  		return ret;
>  	}
>
> diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> index 6ef0d06ee8b..95c6cdc4be0 100644
> --- a/builtin/upload-archive.c
> +++ b/builtin/upload-archive.c
> @@ -19,7 +19,8 @@ static const char deadchild[] =3D
>
>  int cmd_upload_archive_writer(int argc, const char **argv, const char *=
prefix)
>  {
> -	struct strvec sent_argv =3D STRVEC_INIT;
> +	struct string_list to_free =3D STRING_LIST_INIT_DUP;
> +	struct strvec sent_argv =3D STRVEC_INIT_NODUP;
>  	const char *arg_cmd =3D "argument ";
>  	int ret;
>
> @@ -34,6 +35,7 @@ int cmd_upload_archive_writer(int argc, const char **a=
rgv, const char *prefix)
>  	/* put received options in sent_argv[] */
>  	strvec_push(&sent_argv, "git-upload-archive");
>  	for (;;) {
> +		struct string_list_item *item;
>  		char *buf =3D packet_read_line(0, NULL);
>  		if (!buf)
>  			break;	/* got a flush */
> @@ -42,13 +44,16 @@ int cmd_upload_archive_writer(int argc, const char *=
*argv, const char *prefix)
>
>  		if (!starts_with(buf, arg_cmd))
>  			die("'argument' token or flush expected");
> -		strvec_push(&sent_argv, buf + strlen(arg_cmd));
> +
> +		item =3D string_list_append(&to_free, buf + strlen(arg_cmd));
> +		strvec_push(&sent_argv, item->string);
>  	}
>
>  	/* parse all options sent by the client */
>  	ret =3D write_archive(sent_argv.nr, sent_argv.v, prefix,
>  			    the_repository, NULL, 1);
>  	strvec_clear(&sent_argv);
> +	string_list_clear(&to_free, 0);
>  	return ret;
>  }
>
> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> index fc499cdff01..cc1ce060558 100755
> --- a/t/t5003-archive-zip.sh
> +++ b/t/t5003-archive-zip.sh
> @@ -2,6 +2,7 @@
>
>  test_description=3D'git archive --format=3Dzip test'
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  TEST_CREATE_REPO_NO_TEMPLATE=3D1
>  . ./test-lib.sh
>
