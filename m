Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B3EC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 21:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiATVh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 16:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377967AbiATVhX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 16:37:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2FFC061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 13:37:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m4so34246395edb.10
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 13:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GmTm1Qd70azDs1X0d5psDZWo5tylzKQPFukuOJJAY54=;
        b=WUsV0QinFBoxu8ijefQcKvUYKTtQ25C7xPVGeX4GxXhKKs2v8NMvzlT0uYCh2uNhxs
         PYN2aWt+ujwPJRQStCvrR8n3HO3XO+9Ps0thP3pMRnwClNaXE2Ke2qItyRplpH7tSrTT
         b1PK1iUloYHraO5yTiXCdqBaq+eqPrdYymkrVmS4RoI3SQdeSpOeBSqGuzqC6elqNSyz
         dL6YBlZQWYrWK4K7BfmANXZ9RpOQZZiYKpzGFmGDLTaxF65+T6x6SOfWWfkmAi18htI9
         HHEXPGUlQZayL9pmaQNoM7ln6npblrVJ7VQb2MzZttrr3x7S8I762mGf4Pp9LhbM5cYo
         gsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GmTm1Qd70azDs1X0d5psDZWo5tylzKQPFukuOJJAY54=;
        b=vYDOa7Hp8DSAHnnT9O73k67Gi/0mqDoZUscb6dXRp0BK4CButi9MfkXAzutyFx7fKb
         jOhk8NGNCgt+dGnpq0DPfeVbKMeuZCcznYGiO3VHJYDRLkktMjiF/jwt7TuWZtPctf3F
         +MB3AoDTBEAgi/NxyWhnO99Qt0x7E8fFKNSSuGt/gmiER8BS8SCFLlRUX7OakPrSH3uC
         RGMw3D/JmQG1uvKA1BVQVuZibjcwCl3CCWGageAvdVN3x1yJ6rj9GzwGZRWRqOT7Gjh0
         M+j19/QahasXHnJqOr4LfM55ZGrNtFJjX+th4OEhsacmvuP6D4zIG6mcc0s3WK/+GAZd
         FbIw==
X-Gm-Message-State: AOAM532oJH56rBEH6sZsaL1jzqw5dSXK4dUiOu3EDeCm8S4JEUYGTLGR
        pikmgasbEgZvyGO9EBeq98k=
X-Google-Smtp-Source: ABdhPJx7Lj3fxw1tekxFjPIKhvaKM5kOtKQmn3pmCKXWPUqKcJKZ6cOtwSa6O7+7MdKZGzYR7030dw==
X-Received: by 2002:a17:907:1c1f:: with SMTP id nc31mr768596ejc.624.1642714641376;
        Thu, 20 Jan 2022 13:37:21 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s14sm1833667edx.37.2022.01.20.13.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:37:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAf7Q-0025u3-C9;
        Thu, 20 Jan 2022 22:37:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH] sparse-checkout: create leading directory
Date:   Thu, 20 Jan 2022 22:30:03 +0100
References: <20220120185548.3648549-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220120185548.3648549-1-jonathantanmy@google.com>
Message-ID: <220120.86mtjqks1b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Jonathan Tan wrote:

> When creating the sparse-checkout file, Git does not create the leading
> directory, "$GIT_DIR/info", if it does not exist. This causes problems
> if the repository does not have that directory. Therefore, ensure that
> the leading directory is created.
>
> This is the only "open" in builtin/sparse-checkout.c that does not have
> a leading directory check. (The other one in write_patterns_and_update()
> does.)
>
> Note that the test needs to explicitly specify a template when running
> "git init" because the default template used in the tests has the
> "info/" directory included.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This problem is being discussed in [1], and we also noticed this problem
> internally at $DAYJOB. Here's a fix.
>
> [1] https://lore.kernel.org/git/db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com/

Thanks. This fix looks good to me.

Looking at my [1] my preliminary analysis there wasn't correct,
i.e. there are other cases where we get the "sparse_filename" that you
don't cover here, but e.g. if you do:

    <your test> &&
    rm -rf .git/info &&
    git sparse-checkout add foo

It looks like it will fail either way, so for those other codepaths we
didn't need to ensure the .git/info.

Still, it would be nice to have the fix test for those cases too,
i.e. how various operations are expected to behave if the user were to
rm -rf .git/info. That'll obviously yield a broken repo, but we should
still try to handle it gracefully.

1. https://lore.kernel.org/git/211220.86zgovt9bi.gmgdl@evledraar.gmail.com/

> ---
>  builtin/sparse-checkout.c          | 3 +++
>  t/t1091-sparse-checkout-builtin.sh | 7 +++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 679c107036..2b0e1db2d2 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -471,6 +471,9 @@ static int sparse_checkout_init(int argc, const char **argv)
>  		FILE *fp;
>  
>  		/* assume we are in a fresh repo, but update the sparse-checkout file */
> +		if (safe_create_leading_directories(sparse_filename))
> +			die(_("unable to create leading directories of %s"),
> +			    sparse_filename);
>  		fp = xfopen(sparse_filename, "w");
>  		if (!fp)
>  			die(_("failed to open '%s'"), sparse_filename);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 42776984fe..dba0737599 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -79,6 +79,13 @@ test_expect_success 'git sparse-checkout init' '
>  	check_files repo a
>  '
>  
> +test_expect_success 'git sparse-checkout init in empty repo' '
> +	test_when_finished rm -rf empty-repo blank-template &&
> +	mkdir blank-template &&
> +	git init --template=blank-template empty-repo &&
> +	git -C empty-repo sparse-checkout init
> +'
> +
>  test_expect_success 'git sparse-checkout list after init' '
>  	git -C repo sparse-checkout list >actual &&
>  	cat >expect <<-\EOF &&

You're using an overly verbose way to say "no templates, please". You
can squash this in, i.e. --template= is an explicitly supported way to
do that.

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index dba07375993..1fe741d9cd5 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -80,9 +80,8 @@ test_expect_success 'git sparse-checkout init' '
 '
 
 test_expect_success 'git sparse-checkout init in empty repo' '
-	test_when_finished rm -rf empty-repo blank-template &&
-	mkdir blank-template &&
-	git init --template=blank-template empty-repo &&
+	test_when_finished rm -rf empty-repo &&
+	git init --template= empty-repo &&
 	git -C empty-repo sparse-checkout init
 '
 
