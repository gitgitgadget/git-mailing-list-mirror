Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC840C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 12:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CE061139
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 12:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbhHYMYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 08:24:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:54747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240593AbhHYMYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 08:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629894193;
        bh=Ey9TXQxYzG2FXdD6tUju230tIgq76X3WWiB4YP9btOM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lY64hwSTk9n1Rq493w1HWafaekmCqyC8PswrpvEj7M5S9aoYMRYMETvpMbnXHunXZ
         R2SOfmks1xRcGk/vq8tIpB6c00eXPWZtI0kmU/bvMHB8B6U+/+QwFi3lPnWdt7duyS
         2GgTuzHRhtgt313GqJoyqmSl3P5XFHF0W+FctFmk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0FxV-1nCsIY1dPr-00xNp8; Wed, 25
 Aug 2021 14:23:13 +0200
Date:   Wed, 25 Aug 2021 14:23:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] macos: safeguard git maintenance against highly
 concurrent operations
In-Reply-To: <xmqqwnoajql1.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2108251420541.55@tvgsbejvaqbjf.bet>
References: <pull.1024.git.1629819840.gitgitgadget@gmail.com> <xmqqwnoajql1.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uWiUN0NAa5V1fW5tUHejXUl+UtkP+SLgxQirWhZ3mtjLaLfBfKO
 tEKBoLmH9v8g/8J7mt5Z8IHzeASDLj79FfvzaSj2XFD5VnRpRcz6gzlUhXtjs1esdx5eB3W
 kkhqQcdeLZshpfjKehmVovcjhA+nJ9qMBuquHRnkSF0X8fimKsVjRhu4FTyYUICTVfmTMQc
 WRDqjOUV4r7OMSYWOiEsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qRJl7kYxLvg=:JiKsU6jMks6+i1djkF5gl+
 5fDSnlPBAbu0GvsZHQ5utRU6j5IYw9Oa7SgyIJTkfKeI4mlGZAzkYr5HWu/vf4c8Z/3CUHMym
 PVSlUVxz/kcrdIaIRtHC5ZRrpE0M7M3CqUSQ0dSHMA+OOXZgHtEKCS8djvD+zdGvJLJOW+xqk
 RHAhrTporA7OtdSGMoBERaw+0XRe88AnZwN0PPITt1ReH62i+qjTlispDcQJms0+GwegWV41D
 vZuY66Kkgck8IGH0X8Oy3MP6OTO1hQx96lwYDhupu2U7tqxH3YUTcsAmahXT/3qc2VYE/RVKP
 r5cx6ElC/y7ymz0Sl0tt7moC+uilaYEnQUHO8eikHwwokmIc8ymltKT5C8DuLAnHt/18LwqLr
 Fmarghsh8ysgkDjBQ4oU9tMa9iGRrpwCY+S9WZ+3JTnfoQLDcZs8aMpjWfo/h+tJLKV+RdhnA
 JvBFBFKnfy6cP2ypELCxNP8ZzdwIhWM/Y8wyrqJAcFIM3Nt7N5/yyHIyO6CJtjl63jRFs7/mA
 l8JqbE6zx+B54XMfLaUWNC5Sz4drU8DyyMa6b2V2XMHR6Kj9FJO2VwIwDWBW/G5A8xfWtu+RG
 wBg4Zn7zXck7RiGlj6OpPa4hLQcfKA1VVWPFM5pql4ggvaJvFmmMTs2apZHKHKi66XYwKRSI/
 qFBgM+7zOGA5q5ko2QPPaXk02AqxKk7shOT1eW1Qw58FQGOfcPi3WTRb2dukItpNYYVsTWBsw
 8MyaH8Cp8TBtXrdZ0ByXfdG0nSuBc9YZu0r0KJhJSDE4EHoFMDfbz7ubuP1G/iL5cxKToK2Np
 r3rxBVCx69rhbNKSuUMasJpFGj2GuaWO0JIEcwbWAFcSXh+k4Ps5YpU1d+xPET5qlEbv91azs
 fimZ8+fe3dRUqG+Mqo+NjWeIDaO7KtBFuVTvLJyHQCFeOlCnjGcfv1WtiXuhDZbRj6Hl98wbY
 Oo++C5prPX0+utV628psO/1RMU7eUkXCcf26SyX69wGTWn8xeilc8AZ1AsPTsAPa0lTAsjO+V
 Cc/VS5AJcCP/boynSzajNijFPNJZWmaPHDjfj/Sz9kFRPkflyfHA0IAu2hUQsbNeedkN2D/gU
 cy1Qs7tNXfkIdcXqBYLidrjNgmFLo+GyCZiJrxrlYGYF6rqeJyoUxCITA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 Aug 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Please note that this patch series conflicts with lh/systemd-timers,
> > although in a trivial way: the latter changes the signature of
> > launchctl_schedule_plist() to lose its cmd parameter. The resolution i=
s to
> > adjust the conflicting code to lose the cmd parameter, and also drop i=
t from
> > launchctl_list_contains_plist() (and define it in the same way as
> > launchctl_boot_plist() does). I assume that lh/systemd-timers will adv=
ance
> > to next pretty soon; I plan on rebasing this patch series on top of it=
 at
> > that stage.
>
> Sounds like a plan.
>
> Here is my attempt to merge lh/systemd-timers into the result of
> applying these two to 'master', with focus on the top part of the
> launchctl_schedule_plist().  Sanity-checking is appreciated.

My local version (hence `git reset -hard`'ed away) looked almost precisely
like yours, I only added the definition of `cmd` to the top of
`launchctl_list_contains_plist()` and removed its `cmd` parameter (and
adjusted the callers). But that's the only difference I can spot.

Thanks,
Dscho

>
> diff --cc builtin/gc.c
> index 22e670b508,6a57d0fde5..0000000000
> --- i/builtin/gc.c
> +++ w/builtin/gc.c
> @@@ -1593,48 -1678,26 +1678,50 @@@ static int launchctl_remove_plist(enu=
m
>   	return result;
>   }
>
> - static int launchctl_remove_plists(const char *cmd)
> + static int launchctl_remove_plists(void)
>   {
> - 	return launchctl_remove_plist(SCHEDULE_HOURLY, cmd) ||
> - 		launchctl_remove_plist(SCHEDULE_DAILY, cmd) ||
> - 		launchctl_remove_plist(SCHEDULE_WEEKLY, cmd);
> + 	return launchctl_remove_plist(SCHEDULE_HOURLY) ||
> + 	       launchctl_remove_plist(SCHEDULE_DAILY) ||
> + 	       launchctl_remove_plist(SCHEDULE_WEEKLY);
>   }
>
>  +static int launchctl_list_contains_plist(const char *name, const char =
*cmd)
>  +{
>  +	int result;
>  +	struct child_process child =3D CHILD_PROCESS_INIT;
>  +	char *uid =3D launchctl_get_uid();
>  +
>  +	strvec_split(&child.args, cmd);
>  +	strvec_pushl(&child.args, "list", name, NULL);
>  +
>  +	child.no_stderr =3D 1;
>  +	child.no_stdout =3D 1;
>  +
>  +	if (start_command(&child))
>  +		die(_("failed to start launchctl"));
>  +
>  +	result =3D finish_command(&child);
>  +
>  +	free(uid);
>  +
>  +	/* Returns failure if 'name' doesn't exist. */
>  +	return !result;
>  +}
>  +
> - static int launchctl_schedule_plist(const char *exec_path, enum schedu=
le_priority schedule, const char *cmd)
> + static int launchctl_schedule_plist(const char *exec_path, enum schedu=
le_priority schedule)
>   {
>  -	FILE *plist;
>  -	int i;
>  +	int i, fd;
>   	const char *preamble, *repeat;
>   	const char *frequency =3D get_frequency(schedule);
>   	char *name =3D launchctl_service_name(frequency);
>   	char *filename =3D launchctl_service_filename(name);
>  +	struct lock_file lk =3D LOCK_INIT;
>  +	static unsigned long lock_file_timeout_ms =3D ULONG_MAX;
>  +	struct strbuf plist =3D STRBUF_INIT, plist2 =3D STRBUF_INIT;
>  +	struct stat st;
> ++	const char *cmd =3D "launchctl";
>
>  -	if (safe_create_leading_directories(filename))
>  -		die(_("failed to create directories for '%s'"), filename);
>  -	plist =3D xfopen(filename, "w");
>  -
> ++	get_schedule_cmd(&cmd, NULL);
>   	preamble =3D "<?xml version=3D\"1.0\"?>\n"
>   		   "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://=
www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
>   		   "<plist version=3D\"1.0\">"
> @@@ -1687,38 -1750,13 +1774,38 @@@
>   		/* unreachable */
>   		break;
>   	}
>  -	fprintf(plist, "</array>\n</dict>\n</plist>\n");
>  -	fclose(plist);
>  +	strbuf_addstr(&plist, "</array>\n</dict>\n</plist>\n");
>
>  -	/* bootout might fail if not already running, so ignore */
>  -	launchctl_boot_plist(0, filename);
>  -	if (launchctl_boot_plist(1, filename))
>  -		die(_("failed to bootstrap service %s"), filename);
>  +	if (safe_create_leading_directories(filename))
>  +		die(_("failed to create directories for '%s'"), filename);
>  +
>  +	if ((long)lock_file_timeout_ms < 0 &&
>  +	    git_config_get_ulong("gc.launchctlplistlocktimeoutms",
>  +				 &lock_file_timeout_ms))
>  +		lock_file_timeout_ms =3D 150;
>  +
>  +	fd =3D hold_lock_file_for_update_timeout(&lk, filename, LOCK_DIE_ON_E=
RROR,
>  +					       lock_file_timeout_ms);
>  +
>  +	/*
>  +	 * Does this file already exist? With the intended contents? Is it
>  +	 * registered already? Then it does not need to be re-registered.
>  +	 */
>  +	if (!stat(filename, &st) && st.st_size =3D=3D plist.len &&
>  +	    strbuf_read_file(&plist2, filename, plist.len) =3D=3D plist.len &=
&
>  +	    !strbuf_cmp(&plist, &plist2) &&
>  +	    launchctl_list_contains_plist(name, cmd))
>  +		rollback_lock_file(&lk);
>  +	else {
>  +		if (write_in_full(fd, plist.buf, plist.len) < 0 ||
>  +		    commit_lock_file(&lk))
>  +			die_errno(_("could not write '%s'"), filename);
>  +
>  +		/* bootout might fail if not already running, so ignore */
> - 		launchctl_boot_plist(0, filename, cmd);
> - 		if (launchctl_boot_plist(1, filename, cmd))
> ++		launchctl_boot_plist(0, filename);
> ++		if (launchctl_boot_plist(1, filename))
>  +			die(_("failed to bootstrap service %s"), filename);
>  +	}
>
>   	free(filename);
>   	free(name);
>
