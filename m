Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FADC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 22:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiKPWIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiKPWIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 17:08:47 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC6F6869A
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 14:08:45 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-38e82825a64so859347b3.20
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 14:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XK1KAoSy7nh6S9PBlaILRcUjRiMAy53TWmTPOPvq2Lk=;
        b=n14fVJLaSAc4OgqRy9NTeLkiwsQ2I/uBOcQWWJ3FwBeZrLojo+gLsXv5U5qqn9fT+7
         gDBmJMcyHqoSlA9eqjw5Ek/HeK7NtIQX1O2jxAHJqepyLO9GV9I2cW/bA3GfA7lZhfRY
         FbqEQkzeklAdwvkcR2g7DHS2niNFWt5W2G9CMujlpeoLMNcDPO+bYf2CY+HQYuTzT49b
         SFB6vdjEgwGED30KWumpnvXhf+BStm0NX9Q2vmWxdaXWk64k0N7yow2s3mWXkJnr5eIZ
         u3cDvymd605OfZDvbYaXIJTzmLJTcuQlWK5OmCMtHgUe7GFQyBBoRS5EhJIXtbqDc51v
         gryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XK1KAoSy7nh6S9PBlaILRcUjRiMAy53TWmTPOPvq2Lk=;
        b=SIgnxbSRX8XZJm91fTBaUJkYyEixBDCslKcR5VxvXHZhbj7vZ8RNGx27OrH/UHv2aL
         vhuIhOp3B2pnmMHKTIV1HsTtM7ngcI7DipFg9MBsqf0nawCtEtaZrfzoRVHEJFVaB5/j
         vgLn2lK9xw+74QkUhiM620dFXKgJV34rXPb7Rid9P1ulLLJAiaMuPdGe1xv4381rvUsa
         RRyh9eEpo+PbeaDY69m4jy+ngA4Q38SMvNBOTDfkRiPnSDmp8uFsdrek0UcNseUYXcr4
         LtJY+8VGj2DB93lf4il+xv90wwhabq6jnq345ySzetX49ENPpxEP9eUJ1SlM1STLYNTQ
         JpsQ==
X-Gm-Message-State: ACrzQf3fkAv/Gv2HCJbCzFK5NRCS6arInxaxyYd3STN1M3Nw6Rtprcw4
        79mGdsEmZwtLql8kYrI5+F6XYCQt1TJocQ==
X-Google-Smtp-Source: AMsMyM5hI2wuxvZe3+jTMbFl7zapcENHzC1tU03pJJJUHAvyx6a020A5bomsNL9v+W4liLFAoxaFtIUmItkm+w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:5fd4:0:b0:370:28c2:1142 with SMTP id
 t203-20020a815fd4000000b0037028c21142mr62506347ywb.254.1668636524322; Wed, 16
 Nov 2022 14:08:44 -0800 (PST)
Date:   Wed, 16 Nov 2022 14:08:35 -0800
In-Reply-To: <patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com>
Mime-Version: 1.0
References: <patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com>
Message-ID: <kl6lmt8qv9gc.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] submodule--helper absorbgitdirs: no abspaths in
 "Migrating git..."
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Change the "Migrating git directory" messages to avoid emitting
> absolute paths. We could use "old_git_dir" and "new_gitdir.buf" here
> sometimes, but not in all the cases covered by these tests,
> i.e. sometimes the latter will be an absolute path with a different
> prefix.

I'm not sure I follow this bit. Couldn't we use $PWD to make sure we get
the correct path?

> Something I hacked up a while ago, but which I'm prompted to send in
> by [1] which added a test for this output, but did so with:
>
> 	+  cat >expect.err <<-EOF &&
> 	+  Migrating git directory of ${SQ}sub1/nested${SQ} from
> 	+  ${SQ}/Users/chooglen/Code/git/t/trash directory.t7412-submodule-absor=
bgitdirs/sub1/nested/.git${SQ} to
> 	+  ${SQ}/Users/chooglen/Code/git/t/trash directory.t7412-submodule-absor=
bgitdirs/.git/modules/sub1/modules/nested${SQ}
>
> :)

Bleh :( It was even more of a rush job than I realized.

> diff --git a/submodule.c b/submodule.c
> index b958162d286..1f0032d183a 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2274,6 +2274,7 @@ static void relocate_single_git_dir_into_superproje=
ct(const char *path)
>  	char *old_git_dir =3D NULL, *real_old_git_dir =3D NULL, *real_new_git_d=
ir =3D NULL;
>  	struct strbuf new_gitdir =3D STRBUF_INIT;
>  	const struct submodule *sub;
> +	size_t off =3D 0;
> =20
>  	if (submodule_uses_worktrees(path))
>  		die(_("relocate_gitdir for submodule '%s' with "
> @@ -2298,9 +2299,12 @@ static void relocate_single_git_dir_into_superproj=
ect(const char *path)
>  		die(_("could not create directory '%s'"), new_gitdir.buf);
>  	real_new_git_dir =3D real_pathdup(new_gitdir.buf, 1);
> =20
> -	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s=
'\n"),
> +	while (real_old_git_dir[off] && real_new_git_dir[off] &&
> +	       real_old_git_dir[off] =3D=3D real_new_git_dir[off])
> +		off++;
> +	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\=
n"),
>  		get_super_prefix_or_empty(), path,
> -		real_old_git_dir, real_new_git_dir);
> +		real_old_git_dir + off, real_new_git_dir + off);

Doesn't this assume that the top level superproject's gitdir and the
worktree share the same parent directory? IOW I think this produces a
wrong result if the user is using a different worktree. Maybe this isn't
a big problem now because worktrees don't interact well with submodules,
so I doubt many users use them, but that's something that we should
improve upon.

Separately, I think the super-prefixed path printed by "git submodule
absorbgitdirs" is just wrong, or at the very least, inconsistent with
every other "git submodule" subcommand. Like I mentioned elsewhere,
subcommands implemented primarily in "git submodule--helper" use
get_submodule_displaypath() which results in the path to the submodule
being relative to the original CWD, but "absorbgitdirs" never passes the
relative path from CWD, which results in a path rooted at the
superproject's tree instead (probably a historical accident because
absorbgitdirs was never implemented in sh). If "absorbgitdirs" did print
the relative path from the CWD (which I think it should at some point),
we can't take this patch since it produces paths relative to the
superproject tree, e.g. the result would be something like:

  git init my-repo
  git init my-repo/submodule
  cd my-repo
  mkdir some-dir
  cd some-dir
  # This would say
  #   "Migrating ../submodule from 'submodule' to '.git/modules/submodule'"
  # instead of
  #   "Migrating ../submodule from '../submodule' to '../.git/modules/submo=
dule'"
  git submodule absorbgitdirs

>  	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
> =20
> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absor=
bgitdirs.sh
> index 2859695c6d2..a5cd6db7ac2 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -18,13 +18,19 @@ test_expect_success 'setup a real submodule' '
>  '
> =20
>  test_expect_success 'absorb the git dir' '
> +	>expect &&
> +	>actual &&
>  	>expect.1 &&
>  	>expect.2 &&
>  	>actual.1 &&
>  	>actual.2 &&
>  	git status >expect.1 &&
>  	git -C sub1 rev-parse HEAD >expect.2 &&
> -	git submodule absorbgitdirs &&
> +	cat >expect <<-\EOF &&
> +	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''.=
git/modules/sub1'\''
> +	EOF
> +	git submodule absorbgitdirs 2>actual &&
> +	test_cmp expect actual &&
>  	git fsck &&
>  	test -f sub1/.git &&
>  	test -d .git/modules/sub1 &&
> @@ -37,7 +43,8 @@ test_expect_success 'absorb the git dir' '
>  test_expect_success 'absorbing does not fail for deinitialized submodule=
s' '
>  	test_when_finished "git submodule update --init" &&
>  	git submodule deinit --all &&
> -	git submodule absorbgitdirs &&
> +	git submodule absorbgitdirs 2>err &&
> +	test_must_be_empty err &&
>  	test -d .git/modules/sub1 &&
>  	test -d sub1 &&
>  	! test -e sub1/.git
> @@ -56,7 +63,11 @@ test_expect_success 'setup nested submodule' '
>  test_expect_success 'absorb the git dir in a nested submodule' '
>  	git status >expect.1 &&
>  	git -C sub1/nested rev-parse HEAD >expect.2 &&
> -	git submodule absorbgitdirs &&
> +	cat >expect <<-\EOF &&
> +	Migrating git directory of '\''sub1/nested'\'' from '\''sub1/nested/.gi=
t'\'' to '\''.git/modules/sub1/modules/nested'\''
> +	EOF
> +	git submodule absorbgitdirs 2>actual &&
> +	test_cmp expect actual &&
>  	test -f sub1/nested/.git &&
>  	test -d .git/modules/sub1/modules/nested &&
>  	git status >actual.1 &&
> @@ -87,7 +98,11 @@ test_expect_success 're-setup nested submodule' '
>  test_expect_success 'absorb the git dir in a nested submodule' '
>  	git status >expect.1 &&
>  	git -C sub1/nested rev-parse HEAD >expect.2 &&
> -	git submodule absorbgitdirs &&
> +	cat >expect <<-\EOF &&
> +	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''.=
git/modules/sub1'\''
> +	EOF
> +	git submodule absorbgitdirs 2>actual &&
> +	test_cmp expect actual &&
>  	test -f sub1/.git &&
>  	test -f sub1/nested/.git &&
>  	test -d .git/modules/sub1/modules/nested &&
> @@ -107,7 +122,11 @@ test_expect_success 'setup a gitlink with missing .g=
itmodules entry' '
>  test_expect_success 'absorbing the git dir fails for incomplete submodul=
es' '
>  	git status >expect.1 &&
>  	git -C sub2 rev-parse HEAD >expect.2 &&
> -	test_must_fail git submodule absorbgitdirs &&
> +	cat >expect <<-\EOF &&
> +	fatal: could not lookup name for submodule '\''sub2'\''
> +	EOF
> +	test_must_fail git submodule absorbgitdirs 2>actual &&
> +	test_cmp expect actual &&
>  	git -C sub2 fsck &&
>  	test -d sub2/.git &&
>  	git status >actual &&
> @@ -127,8 +146,11 @@ test_expect_success 'setup a submodule with multiple=
 worktrees' '
>  '
> =20
>  test_expect_success 'absorbing fails for a submodule with multiple workt=
rees' '
> -	test_must_fail git submodule absorbgitdirs sub3 2>error &&
> -	test_i18ngrep "not supported" error
> +	cat >expect <<-\EOF &&
> +	fatal: could not lookup name for submodule '\''sub2'\''
> +	EOF
> +	test_must_fail git submodule absorbgitdirs 2>actual &&
> +	test_cmp expect actual
>  '

I think these tests are good-to-have, even if only to check that we're
treating the "--super-prefix" correctly. Maybe we could move them to
before [1].

[1] https://lore.kernel.org/git/patch-v2-02.10-5a35f7b75b3-20221114T100803Z=
-avarab@gmail.com
> =20
>  test_done
> --=20
> 2.38.0.1467.g709fbdff1a9
