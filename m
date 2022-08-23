Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76900C38145
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 10:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355837AbiHWKxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356802AbiHWKwK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 06:52:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A463EAB4DE
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661245943;
        bh=nYxK6izUDo6ucYNXqubwcQXW6FT5Mr5KGuAGAXj41+I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IOynUN1T2rAP4cSANSYYI1Ih/3TZb7lgwsF2rrX6F4SWQJGxLTTbZIVzj6OoZrolO
         a8jiDJfSiKnMVQWF86hA+q3SI6RO0JY57DlkSPD52/N+5SOYLnXs6kpNSpv8hmXcsc
         KnXN09PtwDdpgO7XX76O04gcQyBIgsNSjBhKvpAY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHns-1pJt7t3IZW-00tihL; Tue, 23
 Aug 2022 11:12:23 +0200
Date:   Tue, 23 Aug 2022 11:12:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Renato Botelho <garga@FreeBSD.org>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] gc: use temporary file for editing crontab
In-Reply-To: <20220823010120.25388-1-sandals@crustytoothpaste.net>
Message-ID: <6428252p-ssrn-7qs7-9p26-5so10r96s3os@tzk.qr>
References: <1dd29f43-1a8e-eb69-3320-7f5140a0e18e@github.com> <20220823010120.25388-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NPnexBwcwht+xqeAqh0ZIR0szkl0rxCMQrePudUylJCoJKK/jkx
 +BmilHf0x42cioJ5HS+R/Yv8mGDT0gjKstC5DU9Q3cjJhUdeMZXyddPD1fJ1g/Kjnfb8qQK
 8zTV8CJ+uImvjIltZCo7jvk+xf0muC334R+V6UPj8pf10Zcufd8P6VlnykSbLHV3GoWJK/s
 2PXH/vTDJUis/BsOuZBMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DloDKEIfcjw=:SMEkNa5e5TgaLe0KyQNbuq
 P4VE0UBG141qgwKe2kMHmfcj7TkfFRGO6LCJ0rsoh9dGEmoS+Bya2hK5QzElNGt5aP8+bg9wU
 BubYmMJe08fRKDoKQKRBhcsjqMv0XFOcpu627vWrkzJyPF8wH/oYYxkMsfpyLW5pqZFnoG69e
 +bslgG84tklOBxh1UDXKfimT0v7NnxobnEHIbFNmko+fVy9i074ZBt84N2y7tsNjwFXRPDnli
 3mGDnehnYzJbfG4mCtcTBPjEK5DoH8ZJk7xg1IMZZIpbSyCjlQQ/qBXDa/oq04YtHEr0S5dpZ
 1ltVfcY9QFTr1Du48W4wo3IClNqTggPryfwD6Egc8TypkPIXOWUkTkn4wUxCE4zMZi/B2rKC7
 1zyDBTmpBvXRBPJ7lK3Bv+aVPb78LkICa8aew/wYqjA3huy166G/985mU2XyQ+53+C2X8F8iq
 NN05HWcKiTJtgDtKO1kLlvYKpXDM86r8euGVLBfSRmxBFxvSJeAClKEPUKWYdcSLADDuGqvF2
 PN/PLHoS9SzAlBCFney7mA5Znh3uidVNIcFqiE8oMNnAVhfzcTl1QKkihW8/ji7IXdDM5wI4C
 YAmhdZ8qQbgU5rqqmV6SWLNKvTFuVpfk0z8eW0IzaoLcIdrMsZhMreyXC88spiZ9d+tBWF2Cl
 3IsKNACQNusegNCFwdGOo68NI4T+bKXjdxLB/CbasdC7Zsd0RQj/k08F8YV4NSJrmRRcRV326
 8jD5JCTdpnOw5AoZsNIjHD7GB8MwXqC4MUl9nyrDNrAw4bY2nRrnw4qI6vgDBh58VMTkuwpqz
 QQQz5+p2fGWy1OLMSx7wL7Na5ItNzekOapvxBoJD/oKjR+kpM1c4tCNtkSAaca1uZK9vMpw+m
 4DnXjV9beeEbSQh/UgNCovHUjYqhW0QA6jaT+3OeuvRCn4IJCHzziOsgn/DtzJFfCvXDs6Rdf
 6edTdReO4ZSlObGHaMTuJGXoqHzyIuORNFLZeM/YyHkV8OV0cbo14zPqj4/mI//CDC7Poupbi
 vHgZ7EL6eDriQe5hr+CD3mJitHXvRdNVAl9Lo0tR0CeGzygAMQnLWb8gFPS413jhcBbLaT7g8
 By7h45nL4RCxPibCuriCyT5R29weIQKlodd8vDNd6csHa4SLJtRupSVbQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Tue, 23 Aug 2022, brian m. carlson wrote:

> While cron is specified by POSIX, there are a wide variety of
> implementations in use.  On FreeBSD, the cron implementation requires a
> file name argument: if the user wants to edit standard input, they must
> specify "-".  However, this notation is not specified by POSIX, allowing
> the possibility that making such a change may break other, less common
> implementations.
>
> Since POSIX tells us that cron must accept a file name argument, let's
> solve this problem by specifying a temporary file instead.  This will
> ensure that we work with the vast majority of implementations.
>
> Reported-by: Renato Botelho <garga@FreeBSD.org>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Beautiful commit message. Thank you!

> diff --git a/builtin/gc.c b/builtin/gc.c
> index eeff2b760e..168dbdb5d9 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2065,6 +2065,7 @@ static int crontab_update_schedule(int run_mainten=
ance, int fd)
>  	struct child_process crontab_edit =3D CHILD_PROCESS_INIT;
>  	FILE *cron_list, *cron_in;
>  	struct strbuf line =3D STRBUF_INIT;
> +	struct tempfile *tmpedit;
>
>  	get_schedule_cmd(&cmd, NULL);
>  	strvec_split(&crontab_list.args, cmd);
> @@ -2079,6 +2080,15 @@ static int crontab_update_schedule(int run_mainte=
nance, int fd)
>  	/* Ignore exit code, as an empty crontab will return error. */
>  	finish_command(&crontab_list);
>
> +	tmpedit =3D mks_tempfile_t(".git_cron_edit_tmpXXXXXX");
> +	if (!tmpedit)
> +		return error(_("failed to create crontab temporary file"));

It might make sense to use the same `goto out;` pattern here, to make it
easier to reason about the early exit even six years from now.

We do not even have to guard the `close_tempfile_gently()` behind an `if
(tempfile)` conditional because that function handles `NULL` parameters
gently.

> +	cron_in =3D fdopen_tempfile(tmpedit, "w");
> +	if (!cron_in) {
> +		result =3D error(_("failed to open temporary file"));
> +		goto out;
> +	}
> +
>  	/*
>  	 * Read from the .lock file, filtering out the old
>  	 * schedule while appending the new schedule.
> @@ -2086,19 +2096,6 @@ static int crontab_update_schedule(int run_mainte=
nance, int fd)
>  	cron_list =3D fdopen(fd, "r");
>  	rewind(cron_list);
>
> -	strvec_split(&crontab_edit.args, cmd);
> -	crontab_edit.in =3D -1;
> -	crontab_edit.git_cmd =3D 0;
> -
> -	if (start_command(&crontab_edit))
> -		return error(_("failed to run 'crontab'; your system might not suppor=
t 'cron'"));
> -
> -	cron_in =3D fdopen(crontab_edit.in, "w");
> -	if (!cron_in) {
> -		result =3D error(_("failed to open stdin of 'crontab'"));
> -		goto done_editing;
> -	}
> -
>  	while (!strbuf_getline_lf(&line, cron_list)) {
>  		if (!in_old_region && !strcmp(line.buf, BEGIN_LINE))
>  			in_old_region =3D 1;
> @@ -2132,14 +2129,22 @@ static int crontab_update_schedule(int run_maint=
enance, int fd)
>  	}
>
>  	fflush(cron_in);
> -	fclose(cron_in);
> -	close(crontab_edit.in);

This worries me a bit. I could imagine that keeping the file open and then
expecting a spawned process to read its stdin from that file won't work on
Windows.

In any case, I would consider it the correct thing to do to close
the temp file here. In other words, I would like to move the
`close_tempfile_gently()` call to this location.

>
> -done_editing:
> +	strvec_split(&crontab_edit.args, cmd);
> +	strvec_push(&crontab_edit.args, get_tempfile_path(tmpedit));
> +	crontab_edit.git_cmd =3D 0;
> +
> +	if (start_command(&crontab_edit)) {
> +		result =3D error(_("failed to run 'crontab'; your system might not su=
pport 'cron'"));
> +		goto out;
> +	}
> +
>  	if (finish_command(&crontab_edit))
>  		result =3D error(_("'crontab' died"));
>  	else
>  		fclose(cron_list);
> +out:
> +	close_tempfile_gently(tmpedit);

Here, I would like to call `delete_tempfile(&tmpedit);` instead. That way,
the memory is released correctly, the temporary file is deleted, and
everything is neatly cleaned up.

The way I read the code, `delete_tempfile(&tmpedit)` would return early if
`tmpedit =3D=3D NULL`, and otherwise clean everything up and release the
memory, so there is no need to guard this call behind an `if (tmpedit)`
conditional.

Side note: I do notice that `delete_tempfile(&tmpedit)` seems to _not_
release memory when `tmpedit` is non-NULL when `tmpedit->active =3D=3D 0`.
I consider this a bug in the `delete_tempfile()` code (in its `if
(!is_tempfile_active(tempfile))` clause, it should call
`deactivate_tempfile()` for non-NULL `tempfile`s and set `*tempfile_p =3D
NULL;`), but it is outside the scope of your patch to address that.

What do you think about my suggestions?

Thanks,
Dscho

>  	return result;
>  }
>
>
