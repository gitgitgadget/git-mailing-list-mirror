Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837DAC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6AF61019
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhHKVzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhHKVzk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 17:55:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C15C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:55:16 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d1so4566484pll.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UxkxE4Q6f6H8mjRA18wsvBZcgvSbMMaNJnWOWeLqK20=;
        b=Xgwi2nP6xYr0V9OBrl4jSMUzy5znAwz0fp0sX+F3usW7b/79Mn2VVFb/E/1WD4zRhL
         rzJZgN0xtpvJvlqmteWVxsQbBihlszqdoC5XRUlHpniM/0n6zhOcEzBAVZ6ayCViWIH2
         kXNpNve5kho4Lnec2k4SMaBWNEJgdFc45VwbfD6+qP6MIyLc4fadhq2Yot+mgJSmx2jV
         rLoR61Ebpe0o4ajIc7YdkYpdOmEzBq6eI1RC0X0Xq+/tGO63wWbq8FT3FmOZaW1STbIA
         Obi5sO2NNtMT4iydCL0aDVRx2vt/7Q9RSsRNncre/clRRrb+GG0bRIxke1IYjZhcTeH/
         yFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UxkxE4Q6f6H8mjRA18wsvBZcgvSbMMaNJnWOWeLqK20=;
        b=AP1MrPkYycXdS8MJEj6e466xVftL07px89kwMrNuOSoFIRpRCkiB3bNcCWkC/g0UrY
         8wWlJOK/BDviWMLbN2icgnGMbx9ivIk+5yv+aXGOKrzAlc1I/DBXA0INXKNc+0tHskGn
         MhmvcxZgF2VFW45HCU+C/P38wHkWku5uMvedxJmdvWtYdMWeaiBQH0XSpTQGW37ozxnm
         5E3z3yvqRGrzV4i5RQf/8N1BXcPqZTKty3sebfu5cYtrOk5PcFfjKX2lwIuin6bZbHNp
         XQApdFCZpDnCj7DULGeeOMJoBczpS6w9Gc8qrZyXAm5qh9yEaDkEN+hv5NpY6/MMs07c
         +4Mw==
X-Gm-Message-State: AOAM533gq/So+288YKu4c5P5nkH1z9uWMKXeIsgj9uTxe/Tf66MstI+8
        ApT6G6cwy5PC2Uvh1OL1dGIocg==
X-Google-Smtp-Source: ABdhPJziIP0yy6VFGDSzEDpXgjnnii3nRas65WqOReE+0zLadJZrRJovVeLK958oNQvts5jST9/aBA==
X-Received: by 2002:a17:90b:3718:: with SMTP id mg24mr13114884pjb.158.1628718915513;
        Wed, 11 Aug 2021 14:55:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
        by smtp.gmail.com with ESMTPSA id n33sm529500pgm.55.2021.08.11.14.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:55:14 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:55:07 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/7] t7814: show lack of alternate ODB-adding
Message-ID: <YRRHO0h+eDH8oxGX@google.com>
References: <cover.1628618950.git.jonathantanmy@google.com>
 <f1fc89894b8832ab0f64f301b1621ae15654e08c.1628618950.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1fc89894b8832ab0f64f301b1621ae15654e08c.1628618950.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 11:28:45AM -0700, Jonathan Tan wrote:
> 
> The previous patches have made "git grep" no longer need to add
> submodule ODBs as alternates, at least for the code paths tested in
> t7814. Demonstrate this by making adding a submodule ODB as an alternate
> fatal in this test.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  t/t7814-grep-recurse-submodules.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> index 828cb3ba58..3172f5b936 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -8,6 +8,9 @@ submodules.
>  
>  . ./test-lib.sh
>  
> +GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
> +export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
> +
>  test_expect_success 'setup directory structure and submodule' '
>  	echo "(1|2)d(3|4)" >a &&
>  	mkdir b &&
> -- 
> 2.33.0.rc1.237.g0d66db33f3-goog
> 

This proof seems pretty handy, assuming nobody else is directly calling
add_to_alternates_memory() (and therefore skipping the envvar check). I
would feel slightly more convinced if that function was file-static
somewhere, but I am not familiar with the problem space enough to say
whether that's possible.

This patch by itself, though:
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

 - Emily
