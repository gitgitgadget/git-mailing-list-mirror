Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6599C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 00:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbiKWAnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 19:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiKWAnK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 19:43:10 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E66E13E3A
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:43:09 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x8-20020aa79568000000b0056dd717e051so10186352pfq.11
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvL0o1DrYowWmAzbOuMfXp0wtu09lmhi3YWxFF8uIo4=;
        b=UTEyDtaek+8ktLL6Ewx9p6bukv4e9teKyZjJhoJ7GaXR/pghJRwyDAJP/H7jpwXJSL
         IaZ3RRjVbCOGGfsLINQX0n2hdvnGuubUFClgmmoI8C1S2DzB+S6QZ7Dxo+FXRZzLQHom
         44gQLPeVdFf7gM81T2NAfV2ZCMPcfPeheatvwuhm8+y4lqeAI8l8S/l0CDd94PSAcuM5
         4R7I4XUyD/a28EAUVAu5lk2E8NKf9pFdBlmoVFEFEDObCQL/4Kz/dEuAdl5NPgY75+bd
         uj2vRtcsAkuRKmC3THZjK5Z4LRqoPRwJtpZSpmdhi/S8CNJV/1flRX+GElTc9rsjjGK9
         exZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AvL0o1DrYowWmAzbOuMfXp0wtu09lmhi3YWxFF8uIo4=;
        b=d4pcxCBgVt6SRjNQY27b9W6aRziob1H7Pj0/Y9v1B41jYeU9IusxcNgCQd0jM1Fa1a
         UxaytQtZ57rak+Cns3nMNZPGjvjbZraX1X0g9y+GQv1irfLLXCgoPlR5s/uyqlBsa9ik
         yBxcGcSZSy+K5LY69d3L0apKzO2CEqL9vT+0rmu5i4YVYhp4C3xWDncUhLOU0hgH+fVH
         SlLVzgFqIEYWHYZ/W/VAw5mw9Nwi3cQlrX4wE9/rmkzjsORnWIA/pFIqZA+Lvuqu7RAQ
         dHT9OJIDadd3xAUFvWUrKB6rkiUgiGzPjH8ZZNaYkNmp6691TTkfrWM+zfRCagfs8VNV
         XbQw==
X-Gm-Message-State: ANoB5pn3mnH2ybuBjRagV5MAILnL+Xdf7QV85EdZ4Dwi5iTSrgaTz62Y
        QuH8nbG/1AWx3dfZpaXFOB9StHq5FoGSEw==
X-Google-Smtp-Source: AA0mqf55VSBZghgtMXfIW5RQpMx8kbOxtCFyuW8cvlpClkOn7Tbn6YnkfIWVFIOuzI5pApfbucQJ99imtpE/ig==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:6083:0:b0:56d:3180:c7fc with SMTP id
 u125-20020a626083000000b0056d3180c7fcmr9326391pfb.41.1669164188503; Tue, 22
 Nov 2022 16:43:08 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:43:07 -0800
In-Reply-To: <patch-1.1-065be1da895-20221122T224306Z-avarab@gmail.com>
Mime-Version: 1.0
References: <kl6ltu2sdk1r.fsf@chooglen-macbookpro.roam.corp.google.com> <patch-1.1-065be1da895-20221122T224306Z-avarab@gmail.com>
Message-ID: <kl6l7czmec10.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] submodule absorbgitdirs: use relative <from> and <to> paths
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think we might be better off reverting a79e56cb0a6 than trying to fix
forward. But before getting into that, thanks for reading the report and
sending a fix :)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

Rearranging the thread slightly,

>> - If "absorbgitdirs" becomes consistent with other "git submodule"
>>   subcommands and prints relative paths to submodules, then this
>>   produces the wrong result.
> It's harder to narrowly fix that problem than to just have
> relocate_single_git_dir_into_superproject() display the same sorts of
> paths we do for most other "submodule" commands. I.e. the "<to>"
> should be relative to the "<from>" path, rather than relative to the
> eventual superproject.

As I noted here and in the initial report [1], the relative path is from
the original CWD to the submodule, not from 'old submodule gitdir' to
'new submodule gitdir', so I wouldn't really consider this consistent
with other "submodule" commands.

Besides that, I also don't find the output intuitive..

[1] https://lore.kernel.org/git/kl6lmt8qv9gc.fsf@chooglen-macbookpro.roam.c=
orp.google.com/

> diff --git a/submodule.c b/submodule.c
> index c47358097fd..a464c99a27f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2271,9 +2271,12 @@ int validate_submodule_git_dir(char *git_dir, cons=
t char *submodule_name)
>  static void relocate_single_git_dir_into_superproject(const char *path)
>  {
>  	char *old_git_dir =3D NULL, *real_old_git_dir =3D NULL, *real_new_git_d=
ir =3D NULL;
> +	char *rel_old_git_dir;
> +	const char *rel_new_git_dir;
>  	struct strbuf new_gitdir =3D STRBUF_INIT;
>  	const struct submodule *sub;
> -	size_t off =3D 0;
> +	const char *super_prefix =3D get_super_prefix();
> +	const char *sp =3D super_prefix ? super_prefix : "";
> =20
>  	if (submodule_uses_worktrees(path))
>  		die(_("relocate_gitdir for submodule '%s' with "
> @@ -2285,6 +2288,7 @@ static void relocate_single_git_dir_into_superproje=
ct(const char *path)
>  		return;
> =20
>  	real_old_git_dir =3D real_pathdup(old_git_dir, 1);
> +	rel_old_git_dir =3D xstrfmt("%s%s", sp, old_git_dir);

rel_old_git_dir is relative to the root of the superproject's worktree.

> @@ -2293,23 +2297,23 @@ static void relocate_single_git_dir_into_superpro=
ject(const char *path)
>  	submodule_name_to_gitdir(&new_gitdir, the_repository, sub->name);
>  	if (validate_submodule_git_dir(new_gitdir.buf, sub->name) < 0)
>  		die(_("refusing to move '%s' into an existing git dir"),
> -		    real_old_git_dir);
> +		    rel_old_git_dir);
>  	if (safe_create_leading_directories_const(new_gitdir.buf) < 0)
>  		die(_("could not create directory '%s'"), new_gitdir.buf);
> +
>  	real_new_git_dir =3D real_pathdup(new_gitdir.buf, 1);
> +	rel_new_git_dir =3D relative_path(real_new_git_dir, real_old_git_dir,
> +					&new_gitdir);

rel_new_git_dir is relative to rel_old_git_dir

> =20
> -	while (real_old_git_dir[off] && real_new_git_dir[off] &&
> -	       real_old_git_dir[off] =3D=3D real_new_git_dir[off])
> -		off++;
>  	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\=
n"),
> -		get_super_prefix_or_empty(), path,
> -		real_old_git_dir + off, real_new_git_dir + off);
> +		sp, path, rel_old_git_dir, rel_new_git_dir);

and the submodule is also relative to the root of the superproject's
worktree...

> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absor=
bgitdirs.sh
> index a5cd6db7ac2..0afa0fe3a83 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -27,7 +27,7 @@ test_expect_success 'absorb the git dir' '
>  	git status >expect.1 &&
>  	git -C sub1 rev-parse HEAD >expect.2 &&
>  	cat >expect <<-\EOF &&
> -	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''.=
git/modules/sub1'\''
> +	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''.=
./../.git/modules/sub1'\''
>  	EOF
>  	git submodule absorbgitdirs 2>actual &&
>  	test_cmp expect actual &&

So when we print the 3 relative paths here, they don't all share the
same base, which I find quite unintuitive to parse.

The 'obvious' solution to make this relative to the original CWD is to
plumb the relative path in --super-prefix (like the other "git
submodule" commands), but that won't give the right result in all cases
either, since we found a call site that gets --super-prefix from "git
read-tree" [2], in which case, --super-prefix is relative to the root of
the worktree and not the original CWD. I don't think we should pursue
this.

A more workable fix (and a possible future direction for removing
--super-prefix) would be to pass "--original-cwd" instead of
"--super-prefix", which would let the child process resolve the relative
path correctly. That's a big change though, and I don't think it's worth
doing right now, especially with 'remove --super-prefix' underway.

So for now, I'd strongly prefer we either eject or revert a79e56cb0a6.

[2] https://lore.kernel.org/git/cover-v3-0.9-00000000000-20221119T122853Z-a=
varab@gmail.com
