Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7F6C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 14:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiBXOhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 09:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBXOhO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 09:37:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E8965BD
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645713395;
        bh=uBw4ir8cS7PfREdxSjdH8nRNvkf8YkoaAH0WcyirP+Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ouyx62OLbtDETr0VRaxTyVfSCmC4QeOFZcDqL3g8FZ5UeqClPH6xfUrVuDaCWUmjo
         WPI8VqTgziRDEAzWjQ/ZnMjLOR5z4vJtnj2oBsjulXUa47W/a/eziX/+yAKsmI8alP
         CCCnD1Ccz1JYrLD86pKOoatR5S6NIar+uRJEHqUg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mulm5-1oD8xk2qnb-00rrNY; Thu, 24
 Feb 2022 15:36:35 +0100
Date:   Thu, 24 Feb 2022 15:36:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 12/30] fsmonitor--daemon: add pathname
 classification
In-Reply-To: <21c099c5197168ffba5861d2b7a992fce84a7252.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202241532560.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <21c099c5197168ffba5861d2b7a992fce84a7252.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:r3Ta8yRXehgeaQdJtPUOwEx+YnY7kBtdu6JWY87KSfLl5CMYAG5
 0zG+yAm5IcT9ou+D0oHNJkLuiU2BU8jNGiSqtOOyPFDfRTiO6YFCcGdwUTeusckcDUCR/Kp
 xxxHe+VAOh54Bd7SfcLUGVRRrRLssvBXURjhLzuBsZw4mdnYUArPhr0ghHTKzVxXYcER90a
 XafP5cjCRG5hI3cWAX6NA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v8QquPdUgk8=:3qJmjpA+yU02Ky5iuX/JFA
 QmtBejZ/GcrkvI+0Fe1R+AXEwnizIo/uMEwmeGhTBATP3R+OjseyDIrifELCkKa2AHJutauuN
 Dy1EO5d7Bc7J1I8U2tlGgBD43N56lAbt0gl8EJvCf+irEKSFpKm80ANmB3ax1DjOD7N2vaU2q
 GK9rYFIlT1go4gKuMLGa8m35Ro1OpE5pako9E+ps/fNZkjGBKmk8rPfVG2k1XHxoNsaGGK9iH
 EYmdXZf3EUoQpyD8cR0DlACRLXWxUJ/8j9iu8/C/b5KCIrJgALIoxzt+YCy1xQQiuPFwfiE4q
 6p9VoKVJOPmzjf/KMu/nEqLJs0avV55rZ4t0ZV6v0Ho2/BCqcFT33Z3wyNG21pAqe7QqUuI3m
 2vtz0XqBRH7XrA4rcaoxCOJLA79iHsUv6t0jvn33iSeZT7heCjC1/RSTOMmccymS6elCFo7Wy
 vojCgFdlJsZa//20PsAtq50ZONwAnAXefxtFl44mz5ZY57XiIq3BViVSYlQEdRiAE8b0+wlqh
 67T603Zq0OXIT2rE8+5OCgVrq6m36dyBMpzJAuTVGNh4i9ubMNwVyKui0ZUYeWNp3Wrydc0cq
 OwcUPg1DlPyLKMegsG1N5ZSRATasfaU5dTPYG4e8PS/+6YculN902ECk5+wzV9C3y6lCIk7Da
 fCaDx9owJJFaRGwXotI9/Bxifacs6VoIligwPhzxOrbHHi6Ma+gN/HN3Uv4gbiPVpa+Nzbg2S
 ZQsl36s8Tg0sKk4N/YR2h6lFRcC0cZTHljBqjUz1nnZHKfiaXftir87oQMqPGTpZvvm44kTaU
 4fv7/mGCgO4AQtDq5QtFL+E53AYTKiAWh6hJixtSKkKIftPIN6SnfQUkZdoP8SYXtmeA5dMnQ
 1JXWUpOmflRJQevl/XVg/z6zxCkBHrTz5CrcRGH1kAUG52Z8LL9gkjTVvhGovStEH35FfPkJW
 lYtjr5WIC9ksemKpE437q3+Qjd3rNcW23IHdBCydRbp2Taw0HSiRdLtx9Js97bTaAL3hq80Ox
 bxYNzLUZsI/Vez461El9AuETAbuqwnLivRj1pejfny9N12gOjw+zhLavHghc/+25eC7SYILa9
 MAMS7xy00OJDfg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> +enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
> +	const char *rel)
> +{
> +	if (fspathncmp(rel, ".git", 4))
> +		return IS_WORKDIR_PATH;
> +	rel +=3D 4;
> +
> +	if (!*rel)
> +		return IS_DOT_GIT;
> +	if (*rel !=3D '/')
> +		return IS_WORKDIR_PATH; /* e.g. .gitignore */
> +	rel++;
> +
> +	if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
> +			strlen(FSMONITOR_COOKIE_PREFIX)))
> +		return IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX;
> +
> +	return IS_INSIDE_DOT_GIT;
> +}
> +
> +enum fsmonitor_path_type fsmonitor_classify_path_gitdir_relative(
> +	const char *rel)
> +{
> +	if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
> +			strlen(FSMONITOR_COOKIE_PREFIX)))
> +		return IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX;
> +
> +	return IS_INSIDE_GITDIR;

At first, I was puzzled why this is not `IS_INSIDE_DOT_GIT` as above, but
then...

> [...]
> diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
> index 3009c1a83de..7bbb3a27a1c 100644
> --- a/fsmonitor--daemon.h
> +++ b/fsmonitor--daemon.h
> @@ -30,5 +30,66 @@ struct fsmonitor_daemon_state {
>  	struct ipc_server_data *ipc_server_data;
>  };
>
> +/*
> + * Pathname classifications.
> + *
> + * The daemon classifies the pathnames that it receives from file
> + * system notification events into the following categories and uses
> + * that to decide whether clients are told about them.  (And to watch
> + * for file system synchronization events.)
> + *
> + * The client should only care about paths within the working
> + * directory proper (inside the working directory and not ".git" nor
> + * inside of ".git/").  That is, the client has read the index and is
> + * asking for a list of any paths in the working directory that have
> + * been modified since the last token.  The client does not care about
> + * file system changes within the .git directory (such as new loose
> + * objects or packfiles).  So the client will only receive paths that
> + * are classified as IS_WORKDIR_PATH.
> + *
> + * The daemon uses the IS_DOT_GIT and IS_GITDIR internally to mean the
> + * exact ".git" directory or GITDIR.  If the daemon receives a delete

... I read this, and it started to click.

However, may I suggest to point out that ".git" can also be a _file_, not
only a directory? Otherwise it would not make sense to distinguish between
the `.git` directory/file and `GITDIR`, I'd say.

The rest of the patch looks good to me.

Thanks!
Dscho
