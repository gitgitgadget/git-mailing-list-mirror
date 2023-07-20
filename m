Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEB7EB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 18:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGTSnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 14:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGTSni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 14:43:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8912712
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 11:43:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8b2b60731so6751795ad.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1689878614; x=1690483414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGeEJ+XA8zDpJi9ZWGlZMRfq44uwQjSu5bo8AVHWdMQ=;
        b=jGvptv0Mh9V7f8rOu2h2Rb5G3Gz25jK3h9f6i2hcPXihrcPqjRAFsZyiLpBtaGmQ1F
         eF93471lkbu+yFNg4uVADZG4BMBLO2gWmua105AzmA4jr52ZiYZMRW6HWrSVQqq0Gmyd
         1kr4eFdTSzhvwnms6KKJE27URz1qFX0cm1YJW0/j8Dp8rSCg7th5XrPUzUr1A5ARSiqV
         j8e/BZCWRpOx3JV9SCAVG46BmLQWhpQj2vXQq/J18kS/v0dnG3bicr3o6jqXRh71iUDz
         A2DouTRgPbd2e26mMWs9JgZ186jW8us3eXEEOcYx4MG0Tgz9Z6E8jQasqmmqhDagvXJd
         hYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689878614; x=1690483414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGeEJ+XA8zDpJi9ZWGlZMRfq44uwQjSu5bo8AVHWdMQ=;
        b=iSHfJeBp9q57vDd/dnG+D6HAJLATIFMShgMqFFiegpxKJ3ESo1Zce7+JLRToHXWL4v
         x1B3XkNAuoaYt1b1M4KZ4yGUZnCGPL1NiIsCUrWeo8A/JbpKlQ/lyt+FQoXcTIV1IEPU
         G3FMrxB8uM15eU9x7YrUp4cNdVRQ/toQspMgNBWfjNLDA4pLz4jILFBC95W6xMueZZtl
         Mez1PPc2ZvF0p2wb7o0t/PvDGQXyaIQrXCT6fmzzQ2BXtKVq+8qjj3ji5D87P2ZoWLBp
         YqV4IWRbVtS7biQMfhJ5PBUuQaRzB46lhLOlop/q1W8brtO8cl8+r5by3ZuvFsbPRpFr
         5UVA==
X-Gm-Message-State: ABy/qLZLkpPnmlmeWryZcS7VvCNIgm6RV6A8DW8dUdNR1mDsrz5t+dk7
        OMyUmcxJom1Jix/RgzxE0S+S77E9B3nwN37upw==
X-Google-Smtp-Source: APBJJlEkVZcKwxx0iBMtDl+vIKr8aOM7VRe8r5P6O+Zw4IOilmO4lfq8B2IhR+l8+SewCYzAI986NA==
X-Received: by 2002:a17:902:ee82:b0:1b8:c1f:fd2c with SMTP id a2-20020a170902ee8200b001b80c1ffd2cmr67539pld.33.1689878613628;
        Thu, 20 Jul 2023 11:43:33 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902ba8600b001ae5d21f760sm1733237pls.146.2023.07.20.11.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 11:43:33 -0700 (PDT)
Message-ID: <c3ebe3b4-88b9-8ca2-2ee3-39a3e0d82201@github.com>
Date:   Thu, 20 Jul 2023 11:43:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/3] t1092: add tests for 'git check-attr'
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20230711133035.16916-1-cheskaqiqi@gmail.com>
 <20230718232916.31660-1-cheskaqiqi@gmail.com>
 <20230718232916.31660-2-cheskaqiqi@gmail.com>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230718232916.31660-2-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Add tests for `git check-attr`, make sure attribute file does get read
> from index when path is either inside or outside of sparse-checkout
> definition.
> 
> Add a test named 'diff --check with pathspec outside sparse definition'.
> It starts by disabling the trailing whitespace and space-before-tab
> checks using the core.whitespace configuration option. Then, it
> specifically re-enables the trailing whitespace check for a file located
> in a sparse directory. This is accomplished by adding a
> whitespace=trailing-space rule to the .gitattributes file within that
> directory. To ensure that only the .gitattributes file in the index is
> being read, and not any .gitattributes files in the working tree, the
> test removes the .gitattributes file from the working tree after adding
> it to the index. The final part of the test uses 'git diff --check' to
> verify the correct application of the attribute rules. This ensures that
> the .gitattributes file is correctly read from index and applied, even
> when the file's path falls outside of the sparse-checkout definition.

Thanks for the thorough explanation! This presents a compelling case for why
.gitattributes should be read from sparse directories (if it isn't, the
behavior in sparse-index vs. full-checkout and sparse-checkout doesn't
match).

> 
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 48 ++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 8a95adf4b5..90633f383a 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2259,4 +2259,52 @@ test_expect_success 'worktree is not expanded' '
>  	ensure_not_expanded worktree remove .worktrees/hotfix
>  '
>  
> +test_expect_success 'check-attr with pathspec inside sparse definition' '
> +	init_repos &&
> +
> +	echo "a -crlf myAttr" >>.gitattributes &&
> +	run_on_all cp ../.gitattributes ./deep &&
> +
> +	test_all_match git check-attr -a -- deep/a &&
> +
> +	test_all_match git add deep/.gitattributes &&
> +	test_all_match git check-attr -a --cached -- deep/a
> +'
> +
> +test_expect_failure 'check-attr with pathspec outside sparse definition' '

Could you explain (either in a "NEEDSWORK" comment here or in the commit
message) why this is 'test_expect_failure'? 

> +	init_repos &&
> +
> +	echo "a -crlf myAttr" >>.gitattributes &&
> +	run_on_sparse mkdir folder1 &&
> +	run_on_all cp ../.gitattributes ./folder1 &&
> +	run_on_all cp a folder1/a &&
> +
> +	test_all_match git check-attr -a -- folder1/a &&
> +
> +	git -C full-checkout add folder1/.gitattributes &&
> +	run_on_sparse git add --sparse folder1/.gitattributes &&
> +	run_on_all git commit -m "add .gitattributes" &&
> +	test_sparse_match git sparse-checkout reapply &&
> +	test_all_match git check-attr  -a --cached -- folder1/a
> +'
> +
> +test_expect_failure 'diff --check with pathspec outside sparse definition' '

Same here.

However, when I apply this patch locally and run this test, I get:

	ok 94 - diff --check with pathspec outside sparse definition # TODO known breakage vanished
	# 1 known breakage(s) vanished; please update test(s)

Looking at 'sparse-checkout-out', I see:

	folder1/a:1: trailing whitespace.
	+a 

This test _should_ fail (as your 'test_expect_failure' indicates), but it
passes because the outside-of-cone '.gitattributes' is somehow being applied
to 'folder1/a'. After some debugging, I traced the issue to...

> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo "a " >"$1"
> +	EOF
> +
> +	git config core.whitespace -trailing-space,-space-before-tab &&

...here. This 'git config' doesn't actually apply the configuration to any
of the test repositories, it applies the config to the parent directory. To
apply the config to the test repos, use:

	test_all_match git config core.whitespace -trailing-space,-space-before-tab &&

> +
> +	echo "a whitespace=trailing-space,space-before-tab" >>.gitattributes &&
> +	run_on_all mkdir -p folder1 &&
> +	run_on_all cp ../.gitattributes ./folder1 &&
> +	git -C full-checkout add folder1/.gitattributes &&
> +	run_on_sparse git add --sparse folder1/.gitattributes &&

nit: 'git add --sparse' will work in 'full-checkout' - there's no need to
have separate calls for 'full-checkout' and the sparse checkouts. 

Also, please use 'test_(all|sparse)_match' when running Git commands in
these tests, even if they're not the command explicitly being tested. It
adds an extra level of verification to the test essentially "for free".
Conversely, using 'run_on_(all|sparse)' could conceal subtle issues in the
test or mask bugs in the implementation.

> +	run_on_all rm folder1/.gitattributes &&
> +	run_on_all  ../edit-contents folder1/a &&

nit: extra space between 'run_on_all' and '../edit-contents'.

> +	test_all_match test_must_fail git diff --check -- folder1/a

Because '.gitattributes' was added and 'folder1/a' exists on disk, the
'folder1/' sparse directory is "unsparsified" by the time of this check. As
a result, there's essentially no difference in how 'sparse-index' is handled
vs. 'sparse-checkout'. It would be nice to have this verify the attribute
parsing in a sparse directory; one way to do that would be something like:

----- 8< ----- 8< ----- 8< ----- 8< ----- 8< ----- 8< ----- 8< ----- 8< -----
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 125b205b0d..183fce8531 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2300,11 +2300,12 @@ test_expect_success 'diff --check with pathspec outside sparse definition' '
        echo "a whitespace=trailing-space,space-before-tab" >>.gitattributes &&
        run_on_all mkdir -p folder1 &&
        run_on_all cp ../.gitattributes ./folder1 &&
-       git -C full-checkout add folder1/.gitattributes &&
-       run_on_sparse git add --sparse folder1/.gitattributes &&
-       run_on_all rm folder1/.gitattributes &&
-       run_on_all  ../edit-contents folder1/a &&
-       test_all_match test_must_fail git diff --check -- folder1/a
+       test_all_match git add --sparse folder1/.gitattributes &&
+       run_on_all ../edit-contents folder1/a &&
+       test_all_match git add --sparse folder1/a &&
+
+       test_sparse_match git sparse-checkout reapply &&
+       test_all_match test_must_fail git diff --check --cached -- folder1/a
 '
 
 test_expect_success 'sparse-index is not expanded: check-attr' '
----- >8 ----- >8 ----- >8 ----- >8 ----- >8 ----- >8 ----- >8 ----- >8 -----

The main differences from the current patch are:

1. adding 'folder1/a' to the index then "re-sparsifying" 'folder1/' with
   'git sparse-checkout reapply'.
2. using the '--cached' option to 'git diff' to compare "index vs. HEAD"
   rather than "working tree vs. index".

Finally, as a general point of feedback - all of the version of this series
so far have included some minor whitespace/stylistic issues (missing spaces
in expressions, double spaces, trailing whitespace, etc.). Please check your
patches carefully before submitting them to avoid excess re-rolls & get your
changes merged faster.

[1] https://lore.kernel.org/git/20230718232916.31660-3-cheskaqiqi@gmail.com/

> +'
> +
>  test_done

