Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B210C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 23:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCFXeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 18:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCFXeY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 18:34:24 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBE34A1C7
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 15:34:23 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bbaa701aso117295457b3.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 15:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678145662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdbWk9/gURd+n6KiHecov5G/SMF9tZCeQTA8MGdBGkA=;
        b=A1lRyLQl3e87DaQqQn2xdhUKL6RNljLpJ/phOLzfWQCQ2NsGG+poWXUFXmDX8xMAB5
         6F9c9z49EKYFMrzJk+l08z1BWJU6PWm7EwZ3USbL1kNri7otvakwh13rHTJTNl8VoUsB
         a+0geJYCPWPwVNjQUV1Y4qLZq98VDzyoxkUxGg2FX6lECe7FjPrKbBIxXr+9TR91uZex
         zEXmCayYqQCrf+1zR5ISKqNHYRSk6/yZ3UcOx18vHyp6LrwWStJVY2Ym1ewC7uYlD4u1
         blxn2j2YWva9v5LdnFEy2QuU2iJcrRSXkTzL22QxaNGO72qyJwRA0fb1IgjY0zn+Xt8/
         rspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678145662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdbWk9/gURd+n6KiHecov5G/SMF9tZCeQTA8MGdBGkA=;
        b=PysFN9mwPTNgwNkLaqQ2EB08XXL7Q7AT3Jw/9kDqzaLA5+Cawiay7UHMr4pKFGh2aY
         69eS1vHwevt3bBNvzKAF9tRZPEJBhejD357BItcGl4EbW7r2/cB/6W0bFnP3Mwo6GV5K
         2BcX7FthGXSPp217dbTs0RBtWgdSOVJ2U2X6GzcJKt40phXJXcMNkB0lHCuBBCKadANA
         pX7IdP2Gn5mWPvZjAUD6S9bKCM9INV3PFZVCN6Gd/YR29k4nXeH2PsjgrZ+18ZXr+fu/
         hQqdd75qZKZIlL1wvJDlGvsbb2UY3pCwwBFGFwmnwrzfRlDRY75R90jeftY3NdbUtSCA
         +nfQ==
X-Gm-Message-State: AO0yUKXr+1Q5T0O+gi1lzvHvDu2RgKm/uvMidhj7NV/HrHi3HuorO8hP
        rakIlAwMh26TF+c1Ibnd2FNx6sYOOJmOWg==
X-Google-Smtp-Source: AK7set/dB438f1u5PUmGJfkW2Y5Ru29Duj9wMfuj6tvzKeEULuUDuvcnpRkV1W1VSIDn7wGtV10T/xbq3dKNxg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:109:b0:917:51c8:97c1 with SMTP
 id o9-20020a056902010900b0091751c897c1mr6ybh.660.1678145662226; Mon, 06 Mar
 2023 15:34:22 -0800 (PST)
Date:   Mon, 06 Mar 2023 15:34:20 -0800
In-Reply-To: <20230228185642.2357806-3-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com> <20230228185642.2357806-3-calvinwan@google.com>
Message-ID: <kl6lsfehihdv.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 3/6] tests: use `git submodule add` and fix expected diffs
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, peff@peff.net,
        gitster@pobox.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> This commit continues the previous work of updating the test suite to
> use `git submodule add` to create submodules instead of using `git add`
> to include embedded repositories. Specifically, in this commit we update
> test cases where expected diffs must change due to the presence of a
> .gitmodules file.

Adjusting the diff makes sense when the .gitmodules file is relevant to
the diff being tested.

> diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
> index 61da7e3b94..a0f14db3d2 100755
> --- a/t/t3040-subprojects-basic.sh
> +++ b/t/t3040-subprojects-basic.sh
> @@ -19,11 +19,12 @@ test_expect_success 'setup: create subprojects' '
>  	( cd sub2 && git init && : >Makefile && git add * &&
>  	git commit -q -m "subproject 2" ) &&
>  	git update-index --add sub1 &&
> -	git add sub2 &&
> +	git submodule add ./sub2 &&
>  	git commit -q -m "subprojects added" &&
>  	GIT_PRINT_SHA1_ELLIPSIS="yes" git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
>  	git branch save HEAD &&
>  	cat >expected <<-\EOF &&
> +	:000000 100644 00000... A	.gitmodules
>  	:000000 160000 00000... A	sub1
>  	:000000 160000 00000... A	sub2
>  	EOF

e.g. this change makes sense

> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index 2aa12243bd..f5074071a4 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -50,9 +50,19 @@ test_expect_success 'setup' '
>  '
>  
>  test_expect_success 'added submodule' '
> -	git add sm1 &&
> +	git submodule add ./sm1 &&
> +	gitmodules_hash1=$(git rev-parse --short $(git hash-object .gitmodules)) &&
>  	git diff-index -p --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
> +	diff --git a/.gitmodules b/.gitmodules
> +	new file mode 100644
> +	index 0000000..$gitmodules_hash1
> +	--- /dev/null
> +	+++ b/.gitmodules
> +	@@ -0,0 +1,3 @@
> +	+[submodule "sm1"]
> +	+	path = sm1
> +	+	url = ./sm1
>  	Submodule sm1 0000000...$head1 (new submodule)
>  	EOF
>  	test_cmp expected actual

But in this file and the next (t4041 and t4060), we are checking
submodule diffing behavior, so wouldn't it make sense to ignore
non-submodule changes in the diff?

E.g. we could have ignored .gitmodules during the diff like so

  test_expect_success 'added submodule' '
          git submodule add ./sm1 &&
          gitmodules_hash1=$(git rev-parse --short $(git hash-object .gitmodules)) &&
  -       git diff-index -p --submodule=log HEAD >actual &&
  +       git diff-index -p --submodule=log HEAD -- :!.gitmodules >actual &&

and then we wouldn't have to adjust the diff. That would be my preferred
approach, since it keeps the irrelevant details out of the test.

To play devil's advocate, there's a small integration test-style benefit
to testing both a regular file diff and a submodule diff together. I
haven't checked if these are the only files that are testing this, but
even if not, checking .gitmodules repeatedly seems like a suboptimal way
to do this.

> @@ -243,7 +244,7 @@ test_expect_success 'status -a clean (empty submodule dir)' '
>  '
>  
>  cat >status_expect <<\EOF
> -AA .gitmodules
> +UU .gitmodules
>  A  sub1
>  EOF

_Maybe_ this is worth modernizing too as a 'while we're at it' kind of
change, though it's far less important than the earlier patch (where the
setup actually touches the Git repo and submodules). Idk.
