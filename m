Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069CFC00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 19:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiGZTOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 15:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiGZTOE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 15:14:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733D30F4D
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 12:14:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ez10so27719210ejc.13
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=ToxFK2HitwuuZXGXyVYGYTV1Rx3qUct1H5COoYK6D2E=;
        b=lbWZbV7bM8mDsZ17XFzegqAvBoyH1ghNL8Y34fjA0/I9CDuCHky6UnLjGmA8fzUl/s
         B7C2EdcUQL4pEIRA73WsrXKa22ufl40RGI24CjpH1lljt0gPbpaB2SV4YY/PGxqd/o+N
         RYHufxdpNh6VqvTSfLGxfNmR90J2wom1qqaswtDnZ52QmoiwggQ0npoB/p2I7UbeMbXp
         8y3Ql9XRd4joUqdoMwhAlGUsUkI4uFXq4fB1YX7robhlyX/Vz1KEZkE4AAeADADUHfcJ
         lL3mefiJS6uCbfD2qYkt6XLlMNYBFleQOWJcF2GyRvg5l9tcFjgjAfbdVZmszTiwADJh
         ZzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=ToxFK2HitwuuZXGXyVYGYTV1Rx3qUct1H5COoYK6D2E=;
        b=xcnkDtBhcHVYHW1QUYHweFDGrEb6gJY+LehC0JVgT4Zwr/3hVeKrNwD9GXLm838uUG
         wXaNMjoCfnkIIhK/msu4y8CiZEQIj3mZgKzjRo7/JTU/6ur8T9qVrMoG6/3x4o0wODoS
         O7WfgY5s3NDiJojFype070yOoT53JFO/Ujk2nc2AY2USEH8li+zZHKrtGz7VS1WSETpV
         gMcmQ1X2lGqjWxUnXBIBi0WZDw/VRxKtlNur9HmWH0aSDJdMxtVdQPM7RvuyKIXEPnX3
         B4vyCaONjW4Q0TMri38fBlIu3mhSbUOyBSND7h3v1PCA/58/cjCe0Rr2h84vyAOs58Ox
         074Q==
X-Gm-Message-State: AJIora/24RfKxWoCz7pFbQ5NVKtOl2T/zfsFPDRz0zQCUECj5mHUscO0
        b7eYiQ+7tbiUaXWSCGWWXgU=
X-Google-Smtp-Source: AGRyM1uot1vTUM0KB3P0gPWgAnKEvjjec3r/IineDa5DUVBwKal6U+8Hccv2zEFTfj9c34R3IlyZlg==
X-Received: by 2002:a17:906:9bef:b0:72b:40d1:4276 with SMTP id de47-20020a1709069bef00b0072b40d14276mr14876597ejc.360.1658862841662;
        Tue, 26 Jul 2022 12:14:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i8-20020a056402054800b0043bb71edd36sm8973492edx.44.2022.07.26.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 12:14:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGQ0G-006F70-5M;
        Tue, 26 Jul 2022 21:14:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] config.c: NULL check when reading protected config
Date:   Tue, 26 Jul 2022 21:03:00 +0200
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
Message-ID: <220726.864jz3n0uf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> In read_protected_config(), check whether each file name is NULL before
> attempting to read it. This mirrors do_git_config_sequence() (which
> read_protected_config() is modelled after).
>
> Without these NULL checks,
>
>  make SANITIZE=3Daddress test T=3Dt0410*.sh
>
> fails because xdg_config is NULL, causing us to call fopen(NULL).

FWIW a lot more than that fails, that's just the test I focused on for
the bug report, the others ones (I didn't check out all of them) all
variants of that.

See https://github.com/avar/git/runs/7519070124?check_suite_focus=3Dtrue
for the current failing run with that "[2]" patch you quoted. We fail a
total of 14 test files (and many more tests within those files).

> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>     config.c: NULL check when reading protected config
>=20=20=20=20=20
>     This fixes the SANITIZE=3Daddress failure on master, That was introdu=
ced
>     by gc/bare-repo-discovery. Thanks again to =C3=86var for the original=
 report
>     [1] and for proposing a way to catch this in CI [2].
>=20=20=20=20=20
>     [1]
>     https://lore.kernel.org/git/220725.861qu9oxl4.gmgdl@evledraar.gmail.c=
om
>     [2]
>     https://lore.kernel.org/git/patch-1.1-e48b6853dd5-20220726T110716Z-av=
arab@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-129=
9%2Fchooglen%2Fconfig%2Ffix-sanitize-address-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1299/c=
hooglen/config/fix-sanitize-address-v1
> Pull-Request: https://github.com/git/git/pull/1299
>
>  config.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/config.c b/config.c
> index 015bec360f5..b0ba7f439a4 100644
> --- a/config.c
> +++ b/config.c
> @@ -2645,9 +2645,12 @@ static void read_protected_config(void)
>  	system_config =3D git_system_config();
>  	git_global_config(&user_config, &xdg_config);
>=20=20
> -	git_configset_add_file(&protected_config, system_config);
> -	git_configset_add_file(&protected_config, xdg_config);
> -	git_configset_add_file(&protected_config, user_config);
> +	if (system_config)
> +		git_configset_add_file(&protected_config, system_config);
> +	if (xdg_config)
> +		git_configset_add_file(&protected_config, xdg_config);
> +	if (user_config)
> +		git_configset_add_file(&protected_config, user_config);
>  	git_configset_add_parameters(&protected_config);
>=20=20
>  	free(system_config);
>
> base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25

Re your claim in
https://lore.kernel.org/git/kl6lzggwsyh1.fsf@chooglen-macbookpro.roam.corp.=
google.com/
I tried testing this, and came up with the below.

I wonder if we should work in here for general paranoia, but I'm not too
familiar with the this part of the config reading, maybe we're confident
enough that these are invariants within the process.

This will BUG() out if these variables change within the process, which
would mean that our caching assumptions are no longer true, which would
cause you to return the wrong data here.

Of course you'd have segfaulted or similar before, but this should
demonstrate that not only are these sometimes NULL, but that they stay
that way.

diff --git a/config.c b/config.c
index 015bec360f5..cdd665c1cc8 100644
--- a/config.c
+++ b/config.c
@@ -2102,6 +2102,30 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
=20
+static char *last_system_config;
+static char *last_xdg_config;
+static char *last_user_config;
+
+static void sanity_check_config_1(const char *name, char **last,
+				  const char *now)
+{
+	if (*last && now && strcmp(*last, now))
+		BUG("%s_config: had '%s', now '%s'", name, *last, now);
+	else if (*last && !now)
+		BUG("%s_config: had '%s', now NULL", name, *last);
+	free(*last);
+	*last =3D xstrdup_or_null(now);
+}
+
+static void sanity_check_config(const char *system_config,
+				const char *xdg_config,
+				const char *user_config)
+{
+	sanity_check_config_1("system", &last_system_config, system_config);
+	sanity_check_config_1("xdg", &last_xdg_config, xdg_config);
+	sanity_check_config_1("user", &last_user_config, user_config);
+}
+
 static int do_git_config_sequence(const struct config_options *opts,
 				  config_fn_t fn, void *data)
 {
@@ -2134,6 +2158,8 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
 		ret +=3D git_config_from_file(fn, user_config, data);
=20
+	sanity_check_config(system_config, xdg_config, user_config);
+
 	current_parsing_scope =3D CONFIG_SCOPE_LOCAL;
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
@@ -2645,6 +2671,8 @@ static void read_protected_config(void)
 	system_config =3D git_system_config();
 	git_global_config(&user_config, &xdg_config);
=20
+	sanity_check_config(system_config, xdg_config, user_config);
+
 	git_configset_add_file(&protected_config, system_config);
 	git_configset_add_file(&protected_config, xdg_config);
 	git_configset_add_file(&protected_config, user_config);
