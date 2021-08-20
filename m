Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4D5C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F2C61056
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhHTARR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhHTARQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:17:16 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F36C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:16:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i21so7070386pfd.8
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=btYqWc7DSycpQDUZ7pcSaeldd8NvQvSaBCEHw5iudTw=;
        b=elSIi3EjWyR7Slsmpyvr/HYhxgA2oEuVYAuL4lKHgAkb4R1ZXp3t3eV9pjs9Sg/sXa
         6YncUnWuW+8vpAVCRgs4TV91kkY3oCp+cLCGjBi9kcdukyyddQyqe8ltTeoBcltRbqVi
         MHr5YqPJAQyA5lNx5gbG8Lh8Bs3kWMOLK/4uEvBP7dxZr/k6CAe3lEnYmHxMkBgwfR8u
         FW3qvHvReNbNsr8OXTA2QuP6YweinKHwUhPdP+biZt2pZ+Kz1nfTy0O99RmyTJaYkOxy
         IO6ZV/oR91pSPduiFx2y/AW/x1/TbC5y39cqrp//azwI9tqoNnv/tqmeFO6Yb5b8HFqA
         /pQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=btYqWc7DSycpQDUZ7pcSaeldd8NvQvSaBCEHw5iudTw=;
        b=SY7Y2gVH/oN4y0wqh0EUE/94ndd1Acd7XNnZDhuESS/7BZFADflKSJT1uKIPFjPCBE
         vTVOYBCBugCbcSX5Sd2UI4yiMxCz4fYQ6nNpl7Q/+1YCY9XwE61W7JGPyQNe5T2SfyDV
         koGBLjzr2CkxfKN9tJbWVNoYjshXeWqYfpNrMk0CeXoYSTPs4ng0MVDAd0NmLaIn13Qu
         QZv6yMty5SV3C1ulszJy3Slu61UFN1TOa2C0lgl9avrPbRyb3KosJHKuvFNTBwRcjBUK
         jcyJCzmHmKNx4/qE2R0/giaUffYEOzH0HtwRglmi40NmDtrpx6YkGid2NPh+QuNdkFEF
         QSpg==
X-Gm-Message-State: AOAM532z9L1axdOk4iFcYobiSC/LWRLEuSSuYNcPR/Yx9fkr6we1qIsS
        IV55cwi/22qQMBcPLXjoEA3QFzzJ7ptXc2ooy691Yw==
X-Google-Smtp-Source: ABdhPJyTo6N377q5YzKBXRoiyyC6+u7doegW6hdajgcX60T7ai2zPGKq67veE8e3s4Bot2UjDE7E0A==
X-Received: by 2002:a63:3d0e:: with SMTP id k14mr16161556pga.351.1629418599141;
        Thu, 19 Aug 2021 17:16:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
        by smtp.gmail.com with ESMTPSA id c26sm5682350pgl.10.2021.08.19.17.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:16:38 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:16:30 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 28/36] hook tests: test for exact "pre-push" hook input
Message-ID: <YR70XmoSUE3D1ZS6@google.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <patch-v4-28.36-ecf75f33233-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-28.36-ecf75f33233-20210803T191505Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 09:38:54PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Extend the tests added in ec55559f937 (push: Add support for pre-push
> hooks, 2013-01-13) to exhaustively test for the exact input we're
> expecting. This helps a parallel series that's refactoring how the
> hook is called, to e.g. make sure that we don't miss a trailing
> newline

The reference to "a parallel series" I think didn't belong in the
commit-msg in the first place, and doesn't make sense now (because this
is in said series, right?).

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t5571-pre-push-hook.sh | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
> index ad8d5804f7b..d2857a6fbc0 100755
> --- a/t/t5571-pre-push-hook.sh
> +++ b/t/t5571-pre-push-hook.sh
> @@ -11,7 +11,7 @@ HOOKDIR="$(git rev-parse --git-dir)/hooks"
>  HOOK="$HOOKDIR/pre-push"
>  mkdir -p "$HOOKDIR"
>  write_script "$HOOK" <<EOF
> -cat >/dev/null
> +cat >actual
>  exit 0
>  EOF
>  
> @@ -20,10 +20,16 @@ test_expect_success 'setup' '
>  	git init --bare repo1 &&
>  	git remote add parent1 repo1 &&
>  	test_commit one &&
> -	git push parent1 HEAD:foreign
> +	cat >expect <<-EOF &&
> +	HEAD $(git rev-parse HEAD) refs/heads/foreign $(test_oid zero)
> +	EOF
> +
> +	test_when_finished "rm actual" &&
> +	git push parent1 HEAD:foreign &&
> +	test_cmp expect actual
>  '
>  write_script "$HOOK" <<EOF
> -cat >/dev/null
> +cat >actual

Hm, I am not sure I like this. It upsets the usual convention of what
'actual' means ("output I captured from a 'git' command"). It is
nitpicky, but I would be happier to see it cat to some other filename,
like 'received-input'.

>  exit 1
>  EOF
>  
> @@ -32,11 +38,18 @@ export COMMIT1
>  
>  test_expect_success 'push with failing hook' '
>  	test_commit two &&
> -	test_must_fail git push parent1 HEAD
> +	cat >expect <<-EOF &&
> +	HEAD $(git rev-parse HEAD) refs/heads/main $(test_oid zero)
> +	EOF
> +
> +	test_when_finished "rm actual" &&
> +	test_must_fail git push parent1 HEAD &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success '--no-verify bypasses hook' '
> -	git push --no-verify parent1 HEAD
> +	git push --no-verify parent1 HEAD &&
> +	test_path_is_missing actual

Other than the naming nit, though, the test changes look reasonable to
me to ensure we don't goof up the stdin support in hook.c. Thanks.

With (or, I guess, without) changes,
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

>  '
>  
>  COMMIT2="$(git rev-parse HEAD)"
> -- 
> 2.33.0.rc0.595.ge31e012651d
> 
