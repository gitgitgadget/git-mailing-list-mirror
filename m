Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B8FC43460
	for <git@archiver.kernel.org>; Fri, 21 May 2021 11:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8937613DA
	for <git@archiver.kernel.org>; Fri, 21 May 2021 11:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhEULtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhEULs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 07:48:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FC4C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:47:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 6so14006148pgk.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WSQn+pjI0RLpZYO7YYGmzpaojwv2heoHqbHm1XNIVFY=;
        b=FUF/WerthEogKw1+0k97M3KXtS73WIjKdpEWRtQ+F/+jY8FlTOdFkqGHzenbkbDVvE
         f3Z2hQnPndns3n7q5qg0SJWbLiniIfFTmIMhRf9Hb2Tz2cAWvPOrnkHrth5lLO+vmJOk
         1mmI4gEBsoiZjD1C8RpWxDtEJuzE+wgVptbViLIbQD5m5zXIpA0R0QkXejq9tzofdqT1
         o0BPBcnVbHjGIU4k/3Wywj7O41OWuWHtLIIz6Oe/fUw4gMM/q8kot20QDhY89Ps8YW30
         v+2a3K/ESOpTyXyzV8TqOoOck0qesFwpNh0DAYvbsbo6tekdx2KvzlDVFwfvhpM5o/Oa
         /kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WSQn+pjI0RLpZYO7YYGmzpaojwv2heoHqbHm1XNIVFY=;
        b=kguZnMEPx0KtrGliF2M2gJNZlXH1iDAxtxNwCHMRhnZGz6BmXjocBDEnNz+qspRo6F
         E/90nxybCh4tA4I66VyCJt38OuzVAsy3guzH5wUMxtlxcvAp4Eo9EaTQWCxnhBh4gFwd
         sSEI3JrUpj1HzEGz4TxJrIr+/bjT8jvfAr0/xwgZzPB+CoR/xBA6vafPShp6OloBrVRF
         mzKDUr/CB+fXXmL5riAiA1iCn5MZHA69y3oAjbmxvLAaOh4d4cKQngPQ3rHJonb5mUee
         LARZDaQYPm3BqsIzOxoQk5xrYqb81B38Llp+qc9Ig4lRTwvu6DYycEzwAEzkRttizHNX
         9zGA==
X-Gm-Message-State: AOAM532YxfeVCzhU1VxRB4Arp6F9RTLiFN84y5TYY26HDaPSKSsaOgJG
        Hi9vuLyjVU8QJfzE74wSL0g=
X-Google-Smtp-Source: ABdhPJwYwD7CuKD/Zvwyc5j+Eoh2VPYzvOp5MTl2btSaoUvJlFIdhUp4PPv+2ZCV00LSOkKmoqzP8w==
X-Received: by 2002:a62:5288:0:b029:2e3:fd7d:267a with SMTP id g130-20020a6252880000b02902e3fd7d267amr5647929pfb.21.1621597654653;
        Fri, 21 May 2021 04:47:34 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.70])
        by smtp.gmail.com with ESMTPSA id v12sm4312997pgi.44.2021.05.21.04.47.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 May 2021 04:47:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: Bug in git submodule update --remote
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <a727c1af-4993-684d-d299-00bf1a47cfc7@riscosopen.org>
Date:   Fri, 21 May 2021 17:17:30 +0530
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FCF5A210-4042-4C1B-87A5-83D916F02FCE@gmail.com>
References: <c4b27662-1228-a1ff-26fc-637897ffc8e7@riscosopen.org>
 <EB55447C-538F-44DE-BFC0-A3BD1A970E99@gmail.com>
 <a727c1af-4993-684d-d299-00bf1a47cfc7@riscosopen.org>
To:     Ben Avison <bavison@riscosopen.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19-May-2021, at 20:11, Ben Avison <bavison@riscosopen.org> wrote:
>=20
> On 19/05/2021 11:49, Atharva Raykar wrote:
>> If I understood you correctly, you'd prefer that the updating of the
>> submodule should be independent of the ref that is checked out in the
>> submodule's directory.
>>=20
>> While I am not sure of the reason why the design of 'update
>> --remote' uses the remote-tracking branch of the submodule, I can
>> imagine adding a switch like 'submodule.<name>.remote' that defaults
>> to 'origin'. Then the behaviour could be changed such that it always=20=

>> pulls from the remote specified in that option.
>>=20
>> This would help make the behaviour consistent in all the cases you=20
>> mentioned, while also giving the option for a user to update the=20
>> submodule from the remote of their choice (which may not be origin).
>=20
> I like that solution. Although, I should note that if the user has set
> submodule.<name>.remote to something other than 'origin', they will =
need
> to ensure that submodule.<name>.branch is also set, or they will still
> hit the "Unable to find current <remote>/HEAD revision in submodule"
> error that I initially stumbled on.
>=20
> How about an implementation like the following? I introduced a new =
"git
> submodule--helper" command rather than modify "print-default-remote" =
for
> a couple of reasons:
>=20
> 1) "print-default-remote" is also used for "git submodule sync" (I'm =
not
> sure if we should change its behaviour too)
>=20
> 2) "print-default-remote" needs to be executed from within the
> submodule, and takes no arguments, whereas I need to parse the
> superproject's .git/config so need to be executed from the =
superproject
> and take the submodule path as an argument
>=20
> The two functions I added are heavily based on "git submodule--helper
> remote-branch". However:
>=20
> * Unlike with the branch name, I don't fall back to using the name for
> the remote cached from when we read the .gitmodules file, if it isn't
> found in .git/config. It doesn't make sense to me for the .gitmodules
> file to include this information, as any new clones will only contain
> "origin" remotes anyway.
>=20
> * I removed "struct strbuf sb" since I don't think it's used.
>=20
> Ben

Thanks for this. I am quite new around here, and I will be working
on porting the whole of 'submodule update' to C in the coming months.

Since this would modify the behaviour of the update subcommand, I
have decided to CC my mentors (Christian and Shourya) who are more
qualified than me to comment on this proposal.

I personally feel that the current behaviour where the remote used
depends on how the submodule is checked out is odd, and I don't
mind addressing it while doing the conversion of this functionality.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 9d505a6329..25ce3c8a1d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2444,6 +2444,41 @@ static int resolve_remote_submodule_branch(int =
argc, const char **argv,
> 	return 0;
> }
>=20
> +static const char *remote_submodule_remote(const char *path)
> +{
> +	const struct submodule *sub;
> +	const char *remote =3D NULL;
> +	char *key;
> +
> +	sub =3D submodule_from_path(the_repository, &null_oid, path);
> +	if (!sub)
> +		return NULL;
> +
> +	key =3D xstrfmt("submodule.%s.remote", sub->name);
> +	repo_config_get_string_tmp(the_repository, key, &remote);
> +	free(key);
> +
> +	if (!remote)
> +		return "origin";
> +
> +	return remote;
> +}
> +
> +static int resolve_remote_submodule_remote(int argc, const char =
**argv,
> +		const char *prefix)
> +{
> +	const char *ret;
> +	if (argc !=3D 2)
> +		die("submodule--helper remote-remote takes exactly one =
arguments, got %d", argc);
> +
> +	ret =3D remote_submodule_remote(argv[1]);
> +	if (!ret)
> +		die("submodule %s doesn't exist", argv[1]);
> +
> +	printf("%s", ret);
> +	return 0;
> +}
> +
> static int push_check(int argc, const char **argv, const char *prefix)
> {
> 	struct remote *remote;
> @@ -2770,6 +2805,7 @@ static struct cmd_struct commands[] =3D {
> 	{"deinit", module_deinit, 0},
> 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
> 	{"remote-branch", resolve_remote_submodule_branch, 0},
> +	{"remote-remote", resolve_remote_submodule_remote, 0},
> 	{"push-check", push_check, 0},
> 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
> 	{"is-active", is_active, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index eb90f18229..4d0df1cf5a 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -577,7 +577,7 @@ cmd_update()
> 				fetch_in_submodule "$sm_path" $depth ||
> 				die "$(eval_gettext "Unable to fetch in =
submodule path '\$sm_path'")"
> 			fi
> -			remote_name=3D$(sanitize_submodule_env; cd =
"$sm_path" && git submodule--helper print-default-remote)
> +			remote_name=3D$(git submodule--helper =
remote-remote "$sm_path")
> 			sha1=3D$(sanitize_submodule_env; cd "$sm_path" =
&&
> 				git rev-parse --verify =
"${remote_name}/${branch}") ||
> 			die "$(eval_gettext "Unable to find current =
\${remote_name}/\${branch} revision in submodule path '\$sm_path'")"

