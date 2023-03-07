Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9107C64EC4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 02:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCGCEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 21:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCGCEW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 21:04:22 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343A443463
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 18:04:10 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id fa3-20020a17090af0c300b002377eefb6acso4355888pjb.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 18:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678154649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2fq2FxPJhQR2BMXOUnuYrnVNNEYzcCtt3c4V29QSrSM=;
        b=DnsQwkGd541lIf/R5uGGztt6WdQ/Dd0m1eWPor6N/NebI3UdecsmR2M92fS4LTNjM2
         ulT2HRCGGYw1vsSpnIMtUJD3DRD5/7wnge/FTOHmttOMe5eBqQigYl+RtWvme42ZmcDs
         El49NH4DczhEQc6l3twt3oVuf0LR0of/4srGO2hBNzM5rCdy4Ph726Q2oIE93dNBzvTd
         AeAePBHX/yL1y5TC1la3sMHjxdoefmf5DJMfRNixTnV+/lszJtolwWnS5crgnUSamvLF
         DjxFzH+rZSQt3m6r4J0NRytoM8uSO7EsF4uBAR09eeZ/8OkR7b8B7s6tynnoethgU4tl
         3rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678154649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fq2FxPJhQR2BMXOUnuYrnVNNEYzcCtt3c4V29QSrSM=;
        b=NJbMoXwQPwfCJPMZ/QnVl7upMF+Fc/yniENdUjuTw5//uRkjqQqWbUzfalN7Yd7K3z
         idvK2zJXojVOEzdTgJDO1HShtRQpUdhIpneGHT1kRQdpJ3K0Rk6oXmQ01laCR1nMGPGz
         04M9IfHJlKBogR81XXHrfTMgpBZxfkV197m6WcK6/+nZDy7yAB19zHb3yKkTWs40x/kx
         5iL9KjmaDoqtQlIkxxw5AKazo5394BRvz51CJZKM95r0gIzuVAppSvF7CCgdCGGoItIl
         3Vcw00RbSSb/E+/+oIWgpLK4UWegMH2AOkUOHJIhOZYbRWllYEKwFCI86sszyXMi6zKP
         3AdQ==
X-Gm-Message-State: AO0yUKWvIFxt0BugrGLpTf8xk5ZY31xg4XsvRlwTU1YKyQzwlIxG+4RW
        Dl9Uo4B3DH14WLhAknJZxNmqdwD3izLxMg==
X-Google-Smtp-Source: AK7set8c092FYBZL6Ehz/dKSMrM/2o7Xmz5YMPMrJTDrK4nR7j5hvMDCo7bJXReVkyVmK6k58+jjf8RGPP1yWw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a62:db86:0:b0:5a8:e8f3:bf8e with SMTP id
 f128-20020a62db86000000b005a8e8f3bf8emr5525400pfg.2.1678154649462; Mon, 06
 Mar 2023 18:04:09 -0800 (PST)
Date:   Mon, 06 Mar 2023 18:04:08 -0800
In-Reply-To: <20230228185642.2357806-6-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com> <20230228185642.2357806-6-calvinwan@google.com>
Message-ID: <kl6lilfdiag7.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 6/6] add: reject nested repositories
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, peff@peff.net,
        gitster@pobox.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> At $dayjob, we have found that even this advice is insufficient to stop
> users from committing unclonable embedded repos in shared projects.
> This causes toil for the owners of the top-level project repository as
> they must clean up the resulting gitlinks. Additionally, these mistakes
> are often made by partners outside of $dayjob, which means that a simple
> organization-wide change to the default Git config would be insufficient
> to prevent these mistakes.
>
> Due to this experience, we believe that Git's default behavior should be
> changed to disallow adding embedded repositories. This commit changes
> the existing warning into a fatal error, rewrites the advice given, and
> deprecates `--no-warn-embedded-repo` in favor of `--allow-embedded-repo`
> to bypass the fatal error.

Sounds good, thanks.

> ---no-warn-embedded-repo::
> -	By default, `git add` will warn when adding an embedded
> +--allow-embedded-repo::
> +	By default, `git add` will error out when adding an embedded
>  	repository to the index without using `git submodule add` to
> -	create an entry in `.gitmodules`. This option will suppress the
> -	warning (e.g., if you are manually performing operations on
> -	submodules).
> +	create an entry in `.gitmodules`. This option will allow the
> +	embedded repository to be added. (e.g., if you are manually
> +	performing operations on submodules).

Okay.

> +--no-warn-embedded-repo::
> +	This option is deprecated in favor of '--add-embedded-repo'.
> +	Passing this option still suppresses advice but does not bypass
> +	the error.

Hm, why would a user want to suppress the warning but still have "git
add" fail?

If this is for backwards compatibility, i.e. users get the same behavior
if they pass "--no-warn-embedded-repo" before and after this patch, then
shouldn't this also allow the embedded repo to be added (i.e. it is an
alias of --allow-embedded-repo)?

> @@ -409,48 +412,53 @@ static int add_config(const char *var, const char *value, void *cb)
>  }
>  
>  static const char embedded_advice[] = N_(
> -"You've added another git repository inside your current repository.\n"
> +"You attempted to add another git repository inside your current repository.\n"
>  "Clones of the outer repository will not contain the contents of\n"
>  "the embedded repository and will not know how to obtain it.\n"
>  "If you meant to add a submodule, use:\n"
>  "\n"
>  "	git submodule add <url> %s\n"
>  "\n"
> -"If you added this path by mistake, you can remove it from the\n"
> -"index with:\n"
> +"See \"git help submodule\" for more information.\n"
>  "\n"
> -"	git rm --cached %s\n"
> +"If you cannot use submodules, you may bypass this check with:\n"
>  "\n"
> -"See \"git help submodule\" for more information."
> +"	git add --allow-embedded-repo %s\n"
>  );

Is there a particular reason you reordered the

  "See \"git help submodule\" for more information.\n"

line? I personally like it at the end, and if a user is already used to
looking for it at the end, they can keep looking there.

> -static void check_embedded_repo(const char *path)
> +static int check_embedded_repo(const char *path)
>  {
> +	int ret = 0;
>  	struct strbuf name = STRBUF_INIT;
>  	static int adviced_on_embedded_repo = 0;
>  
> -	if (!warn_on_embedded_repo)
> -		return;
> +	if (allow_embedded_repo)
> +		goto cleanup;
>  	if (!ends_with(path, "/"))
> -		return;
> +		goto cleanup;
> +
> +	ret = 1;
>  
>  	/* Drop trailing slash for aesthetics */
>  	strbuf_addstr(&name, path);
>  	strbuf_strip_suffix(&name, "/");
>  
> -	warning(_("adding embedded git repository: %s"), name.buf);
> +	error(_("cannot add embedded git repository: %s"), name.buf);
>  	if (!adviced_on_embedded_repo &&
> -	    advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
> +		warn_on_embedded_repo &&
> +		advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
>  		advise(embedded_advice, name.buf, name.buf);
>  		adviced_on_embedded_repo = 1;
>  	}
>  
> +cleanup:
>  	strbuf_release(&name);
> +	return ret;
>  }

So we give an error message when we first encounter the embedded repo,
okay...

>  static int add_files(struct dir_struct *dir, int flags)
>  {
> -	int i, exit_status = 0;
> +	int i, exit_status = 0, embedded_repo = 0;
>  	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
>  
>  	if (dir->ignored_nr) {
> @@ -476,10 +484,13 @@ static int add_files(struct dir_struct *dir, int flags)
>  				die(_("adding files failed"));
>  			exit_status = 1;
>  		} else {
> -			check_embedded_repo(dir->entries[i]->name);
> +			embedded_repo |= check_embedded_repo(dir->entries[i]->name);
>  		}
>  	}
>  
> +	if (embedded_repo)
> +		die(_("refusing to add embedded git repositories"));
> +

And then we die(), giving a similar message again. That feels like
overkill, but I'm not sure if it's unidiomatic.

Is there a reason why we shouldn't just die() the first time we
encounter the embedded repo? The difference is that in this patch, we
actually add all of the non-submodule files before die()-ing, but I'm
not sure if that's what users would expect. Personally at least, I'd
expect "git add" to abort the moment it encountered something wrong.

> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index c70d11bc91..a53dac5931 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -191,7 +191,7 @@ test_expect_success 'setup' '
>  		git add a &&
>  		git commit -m"commit in submodule"
>  	) &&
> -	git add a/submodule &&
> +	git add --allow-embedded-repo a/submodule &&
>  	cat <<-\EOF >.gitignore &&
>  		one
>  		ignored-*

Given that --allow-embedded-repo is meant to be an escape hatch, and
we've already adjusted so many tests to avoid using it, I'd imagine that
any uses of it in the test suite have to be quite well-justified. It
would have been helpful to see such a justification in the comments on
each of the changes or some general principles in the commit message.

I've tried testing most of these with "git submodule add". This one
works around a test failure in test 346 "submodule", which checks that
ignores should fail if the path is in the submodule, like

	test_check_ignore "a/submodule/one" 128 &&
	test_stderr "fatal: Pathspec '\''a/submodule/one'\'' is in submodule '\''a/submodule'\''"

I don't understand why git-check-ignore should succeed on submodules but
not an embedded repo. I'll investigate more later.

> diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
> index 11bc136f6e..1ce4fc49fa 100755
> --- a/t/t2103-update-index-ignore-missing.sh
> +++ b/t/t2103-update-index-ignore-missing.sh
> @@ -36,7 +36,7 @@ test_expect_success basics '
>  		git add file &&
>  		git commit -m "sub initial"
>  	) &&
> -	git add ./xyzzy &&
> +	git add --allow-embedded-repo ./xyzzy &&
>  
>  	test_tick &&
>  	git commit -m initial &&

This seems to pass with "git submodule add", but maybe we don't want to
introduce .gitmodules into a low level test.

> diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
> index 76f8034c60..bfd87891f4 100755
> --- a/t/t4035-diff-quiet.sh
> +++ b/t/t4035-diff-quiet.sh
> @@ -66,7 +66,7 @@ test_expect_success 'git diff-index --cached HEAD^' '
>  test_expect_success 'git diff-index --cached HEAD^' '
>  	echo text >>b &&
>  	echo 3 >c &&
> -	git add . &&
> +	git add --allow-embedded-repo . &&
>  	test_expect_code 1 git diff-index --quiet --cached HEAD^ >cnt &&
>  	test_line_count = 0 cnt
>  '

This is also a low-level test for gitlinks in the index, so eliminating
noise from .gitmodules also seems okay I think.

> diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
> index 07067bb347..ae435fa492 100755
> --- a/t/t6430-merge-recursive.sh
> +++ b/t/t6430-merge-recursive.sh
> @@ -677,7 +677,7 @@ test_expect_success 'merging with triple rename across D/F conflict' '
>  	echo content3 >sub2/file3 &&
>  	mkdir simple &&
>  	echo base >simple/bar &&
> -	git add -A &&
> +	git add -A --allow-embedded-repo &&
>  	test_tick &&
>  	git commit -m base &&
>  

Similarly, this tests low-level gitlink merging, so eliminating
.gitmodules sounds okay.

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index eae6a46ef3..18ef9141b7 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -118,7 +118,7 @@ test_expect_success 'setup - repository in init subdirectory' '
>  test_expect_success 'setup - commit with gitlink' '
>  	echo a >a &&
>  	echo z >z &&
> -	git add a init z &&
> +	git add --allow-embedded-repo a init z &&
>  	git commit -m "super commit 1"
>  '
>  

This is needed because test 38

  test_expect_success 'status should fail for unmapped paths' '
    test_must_fail git submodule status
  '

presumably requires the submodule to not be in .gitmodules. This needs a
comment, I think.

> @@ -771,7 +771,7 @@ test_expect_success 'set up for relative path tests' '
>  			git init &&
>  			test_commit foo
>  		) &&
> -		git add sub &&
> +		git add --allow-embedded-repo sub &&
>  		git config -f .gitmodules submodule.sub.path sub &&
>  		git config -f .gitmodules submodule.sub.url ../subrepo &&
>  		cp .git/config pristine-.git-config &&

In the next test, we're checking that "git submodule init" fixes a
gitlink without .gitmodules. Okay. Might benefit from a comment.

> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index 2859695c6d..d1662aa23c 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -100,7 +100,7 @@ test_expect_success 'absorb the git dir in a nested submodule' '
>  test_expect_success 'setup a gitlink with missing .gitmodules entry' '
>  	git init sub2 &&
>  	test_commit -C sub2 first &&
> -	git add sub2 &&
> +	git add --allow-embedded-repo sub2 &&
>  	git commit -m superproject
>  '

The test is literally called 'setup a gitlink with missing .gitmodules
entry', so okay.

> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> index ba1f569bcb..4b3010c9e2 100755
> --- a/t/t7450-bad-git-dotfiles.sh
> +++ b/t/t7450-bad-git-dotfiles.sh
> @@ -307,7 +307,7 @@ test_expect_success 'git dirs of sibling submodules must not be nested' '
>  		EOF
>  		git clone . thing1 &&
>  		git clone . thing2 &&
> -		git add .gitmodules thing1 thing2 &&
> +		git add --allow-embedded-repo .gitmodules thing1 thing2 &&
>  		test_tick &&
>  		git commit -m nested
>  	) &&

This one can be adjusted. The important thing is that .gitmodules is bad
_after_ we have "git submodule add"-ed the submodules, so this works:

	git init nested &&
	test_commit -C nested nested &&
	(
		cd nested &&
		git clone . thing1 &&
		git clone . thing2 &&
		git submodule add ./thing1 &&
		git submodule add ./thing2 &&
		cat >.gitmodules <<-EOF &&
		[submodule "hippo"]
			url = .
			path = thing1
		[submodule "hippo/hooks"]
			url = .
			path = thing2
		EOF
		git add .gitmodules &&
		test_tick &&
		git commit -m nested
	) &&
	test_must_fail git clone --recurse-submodules nested clone 2>err &&
	test_i18ngrep "is inside git dir" err

> -- 
> 2.39.2.722.g9855ee24e9-goog
