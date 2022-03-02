Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC1C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 18:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244683AbiCBSym (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbiCBSyk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 13:54:40 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C60C6205
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 10:53:56 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gb39so5721503ejc.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 10:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=e4pgzqv4RDk9oJv12Sr+WJ/8nNH4ZK850XB39idIab8=;
        b=MEbMRUamxM9ARJoKreWhsMlpCPP/lhyFCcxoOKSAjpPrFpp+C3vLD9J2Q/i2ud9w5t
         EYc4KrKF4kStJGwOVGAt3OJzILEr/xVxCa/SMQ22cH/wYW7mdxyqT6EIGLZtaKoC76jB
         0wTyjQouelCpAOsFCNOn2rlQiC1QwZZUhQq0xxY+DZnKVWVhlG7c01wZGqVdHpzK65Ax
         rPkDo9u2J1KTjPaejsuCg4WmkvNWwB2V23TpqKx0/X1713m53r1rcqlxEZFWazxkY8xd
         FIJ8hYEmLwlSjlHV1ptnX4eHvAQyZVoo99tCCHldmhoCpdcRuhBLdTBZ6yvEw6CxCYyt
         klcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=e4pgzqv4RDk9oJv12Sr+WJ/8nNH4ZK850XB39idIab8=;
        b=qzflYCNdBLKGQl9bbhKnCPlP5rHrGsDeoHE8vMo8IWdhWNa0M3YtbZWUZkt7NoBBhC
         olGIMklY5nFeUlYZmmwdMfYfQxQ0lAE5ZMDJSevmPGwNFLw4SDbJk6ryVrz1Sw67Srqv
         1uQPCWo2vkmvz+cTk4gK1Q/XfikqgxrYKIYjSc/kvjO8Jh6hMdmpwwvCeHveiPfzoETg
         oylb994EgbfEf8yWjr0X9kInmwp4o/WKaCRYB2/lZcVaC4D1GBGsPuolCY9h/1cwHBru
         IpGgdcQH1e3/YZ10ZxslXAZzPu6CHWwSuoG5rle0gHki2olUA2I44VUU2PgVbG2l9o2J
         lV3g==
X-Gm-Message-State: AOAM531EfHWGjp8aHdTml1k92N+v1sQ4lm5oNOQOn3n5DMLTqjIanuPe
        xTc8eys0QTmCEACwq33Zw9aoEBiypUTkew==
X-Google-Smtp-Source: ABdhPJzgFw5xG4aQv4aTdPMuC/7Rlea9r5sBeDLpsl9l/FVOMQNH1wY9Vwm2n//CSGYipEVIK7z4Zg==
X-Received: by 2002:a17:906:6693:b0:6cf:3cb:89c9 with SMTP id z19-20020a170906669300b006cf03cb89c9mr24320795ejo.23.1646247234553;
        Wed, 02 Mar 2022 10:53:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b0040f826f09fdsm8891670edt.81.2022.03.02.10.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:53:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPU6j-000Ibe-Cq;
        Wed, 02 Mar 2022 19:53:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 1/3] stash: add tests to ensure reflog --rewrite
 --updatref behavior
Date:   Wed, 02 Mar 2022 19:52:25 +0100
References: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
 <33299825fc47fb0e2bc54e1f125282e7825e1924.1645817452.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <33299825fc47fb0e2bc54e1f125282e7825e1924.1645817452.git.gitgitgadget@gmail.com>
Message-ID: <220302.86ee3k6v9a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 25 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> There is missing test coverage to ensure that the resulting reflogs
> after a git stash drop has had its old oid rewritten if applicable, and
> if the refs/stash has been updated if applicable.
>
> Add two tests that verify both of these happen.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/t3903-stash.sh | 65 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 54 insertions(+), 11 deletions(-)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index b149e2af441..73785cf862f 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -41,20 +41,29 @@ diff_cmp () {
>  	rm -f "$1.compare" "$2.compare"
>  }
>=20=20
> -test_expect_success 'stash some dirty working directory' '
> -	echo 1 >file &&
> -	git add file &&
> -	echo unrelated >other-file &&
> -	git add other-file &&
> +setup_stash() {
> +	repo_dir=3D$1
> +	if test -z $repo_dir; then
> +		repo_dir=3D"."
> +	fi
> +
> +	echo 1 >$repo_dir/file &&
> +	git -C $repo_dir add file &&
> +	echo unrelated >$repo_dir/other-file &&
> +	git -C $repo_dir add other-file &&
>  	test_tick &&
> -	git commit -m initial &&
> -	echo 2 >file &&
> +	git -C $repo_dir commit -m initial &&
> +	echo 2 >$repo_dir/file &&
>  	git add file &&
> -	echo 3 >file &&
> +	echo 3 >$repo_dir/file &&
>  	test_tick &&
> -	git stash &&
> -	git diff-files --quiet &&
> -	git diff-index --cached --quiet HEAD
> +	git -C $repo_dir stash &&
> +	git -C $repo_dir diff-files --quiet &&
> +	git -C $repo_dir diff-index --cached --quiet HEAD
> +}
> +
> +test_expect_success 'stash some dirty working directory' '
> +	setup_stash
>  '
>=20=20
>  cat >expect <<EOF
> @@ -185,6 +194,40 @@ test_expect_success 'drop middle stash by index' '
>  	test 1 =3D $(git show HEAD:file)
>  '
>=20=20
> +test_expect_success 'drop stash reflog updates refs/stash' '
> +	git reset --hard &&
> +	git rev-parse refs/stash >expect &&
> +	echo 9 >file &&
> +	git stash &&
> +	git stash drop stash@{0} &&
> +	git rev-parse refs/stash >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success REFFILES 'drop stash reflog updates refs/stash with =
rewrite' '
> +	git init repo &&
> +	setup_stash repo &&
> +	echo 9 >repo/file &&
> +
> +	old_oid=3D"$(git -C repo rev-parse stash@{0})" &&
> +	git -C repo stash &&
> +	new_oid=3D"$(git -C repo rev-parse stash@{0})" &&
> +
> +	cat >expect <<-EOF &&
> +	$(test_oid zero) $old_oid
> +	$old_oid $new_oid
> +	EOF
> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
> +	test_cmp expect actual &&
> +
> +	git -C repo stash drop stash@{1} &&
> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
> +	cat >expect <<-EOF &&
> +	$(test_oid zero) $new_oid
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'stash pop' '
>  	git reset --hard &&
>  	git stash pop &&

I just looked at the post-image of this and didn't notice it was altered
existing code at first, so I was going to suggest just this:
=09
	diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
	index 73785cf862f..422d1f7a306 100755
	--- a/t/t3903-stash.sh
	+++ b/t/t3903-stash.sh
	@@ -42,24 +42,14 @@ diff_cmp () {
	 }
=09=20
	 setup_stash() {
	-	repo_dir=3D$1
	-	if test -z $repo_dir; then
	-		repo_dir=3D"."
	-	fi
	-
	-	echo 1 >$repo_dir/file &&
	-	git -C $repo_dir add file &&
	-	echo unrelated >$repo_dir/other-file &&
	-	git -C $repo_dir add other-file &&
	-	test_tick &&
	-	git -C $repo_dir commit -m initial &&
	-	echo 2 >$repo_dir/file &&
	+	test_commit initial file 1 &&
	+	test_commit second other-file unrelated &&
	+	echo 2 >file &&
	 	git add file &&
	-	echo 3 >$repo_dir/file &&
	-	test_tick &&
	-	git -C $repo_dir stash &&
	-	git -C $repo_dir diff-files --quiet &&
	-	git -C $repo_dir diff-index --cached --quiet HEAD
	+	echo 3 >file &&
	+	git stash &&
	+	git diff-files --quiet &&
	+	git diff-index --cached --quiet HEAD
	 }
=09=20
	 test_expect_success 'stash some dirty working directory' '
	@@ -206,7 +196,10 @@ test_expect_success 'drop stash reflog updates refs/s=
tash' '
=09=20
	 test_expect_success REFFILES 'drop stash reflog updates refs/stash with r=
ewrite' '
	 	git init repo &&
	-	setup_stash repo &&
	+	(
	+		cd repo &&
	+		setup_stash repo
	+	) &&
	 	echo 9 >repo/file &&
=09=20
	 	old_oid=3D"$(git -C repo rev-parse stash@{0})" &&

But I think much better as a replacement is:
=09
	diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
	index b149e2af441..9dd05a497bc 100755
	--- a/t/t3903-stash.sh
	+++ b/t/t3903-stash.sh
	@@ -41,7 +41,7 @@ diff_cmp () {
	 	rm -f "$1.compare" "$2.compare"
	 }
=09=20
	-test_expect_success 'stash some dirty working directory' '
	+setup_stash() {
	 	echo 1 >file &&
	 	git add file &&
	 	echo unrelated >other-file &&
	@@ -55,6 +55,10 @@ test_expect_success 'stash some dirty working directory=
' '
	 	git stash &&
	 	git diff-files --quiet &&
	 	git diff-index --cached --quiet HEAD
	+}
	+
	+test_expect_success 'stash some dirty working directory' '
	+	setup_stash
	 '
=09=20
	 cat >expect <<EOF
	@@ -185,6 +189,43 @@ test_expect_success 'drop middle stash by index' '
	 	test 1 =3D $(git show HEAD:file)
	 '
=09=20
	+test_expect_success 'drop stash reflog updates refs/stash' '
	+	git reset --hard &&
	+	git rev-parse refs/stash >expect &&
	+	echo 9 >file &&
	+	git stash &&
	+	git stash drop stash@{0} &&
	+	git rev-parse refs/stash >actual &&
	+	test_cmp expect actual
	+'
	+
	+test_expect_success REFFILES 'drop stash reflog updates refs/stash with r=
ewrite' '
	+	git init repo &&
	+	(
	+		cd repo &&
	+		setup_stash repo
	+	) &&
	+	echo 9 >repo/file &&
	+
	+	old_oid=3D"$(git -C repo rev-parse stash@{0})" &&
	+	git -C repo stash &&
	+	new_oid=3D"$(git -C repo rev-parse stash@{0})" &&
	+
	+	cat >expect <<-EOF &&
	+	$(test_oid zero) $old_oid
	+	$old_oid $new_oid
	+	EOF
	+	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
	+	test_cmp expect actual &&
	+
	+	git -C repo stash drop stash@{1} &&
	+	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
	+	cat >expect <<-EOF &&
	+	$(test_oid zero) $new_oid
	+	EOF
	+	test_cmp expect actual
	+'
	+
	 test_expect_success 'stash pop' '
	 	git reset --hard &&
	 	git stash pop &&

I>e. the only reason you need to add that -C etc. is because you'd like
to set it up in a subdirectory. Easier to just add the tiny bity of
logic to make that a sub-shell instead.

