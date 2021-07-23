Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38033C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B67C60725
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhGWPV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbhGWPV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 11:21:28 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA3C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:02:02 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso1656755ota.13
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Qz3xf33z6rZ9yFb0/Ynl8S3EDLegu7e2hZRisu8W07Y=;
        b=eQEAevpBDNvenqcNJeSSbWY9Ls2p0fBwtbjv5s+imZp1Mqd/3Hb5ey7ahfhXhQj0BU
         IliEjAGxfnOVF5IwwpSrMp7ZPzCSrqX+D5iXUspyC66H5GlG+U7Y3Ti25UIy+gM60jnJ
         bpVlajvNbyr7SzDYYWbi5+8wyXKTyXMf+tCrzFOcMXiWM5Jvfs+RiJLWRHpPnF2gt+i2
         6R+fHLtqtIt+qvl1sXRlxFDpsZPWMcqy8zAaG+h4HcVDnKszz2sibmZVbw1m5NNROQqW
         ITQHTuEq0R9m9tEFKKIKhXaZevs1glyz3WYLMiTICat8FBnheUEC+KDsv5pletevx55G
         F0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Qz3xf33z6rZ9yFb0/Ynl8S3EDLegu7e2hZRisu8W07Y=;
        b=EkP9oxBPDHa2fmK2PrrKg6veSST5Uvx7hbIv4JIKkWa+ScvPNVhUuCUC1YZu/UlvcW
         YDYT5FeyE1+t7cQeOYypoLm+giHpuPLnZQ+yoqG4c3aniBZv+VlIlD+p73M8bMhYUNgd
         QYN3a/dwasAcc7I6V6QWmbO0Fl00OY0dokQY+bOzA+8fscAYG0heCkyY+fSrr7YYAdd9
         xm1+xylh8vYi1CWZK87eMadHd3Q5exLKjVJpg2kC5x6pc2bBj2oMbBPJF5L+OaSxuRvI
         OARu6k9D1RNtiEJ2rO8JYCIFEj5hRxCo8yOrfuIrzQs64xBV45lltGDvcDMVP8noi1JE
         x42A==
X-Gm-Message-State: AOAM530aQ/wnZdmNAHg2zJnFaGcO5Oe7JpwwYp06Kda3hR/+L+YPDoq/
        JK0O1zDHKjE56sKHTacfkYQ=
X-Google-Smtp-Source: ABdhPJwGN6OFah4tT+wJL2tUB8JfwXysQhdBmW93SDs1H+yOrK5RkYO3apFlOaQAdJ21p+1Xqmw/3g==
X-Received: by 2002:a9d:32f:: with SMTP id 44mr3581455otv.266.1627056121568;
        Fri, 23 Jul 2021 09:02:01 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z81sm5689722oia.41.2021.07.23.09.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:02:01 -0700 (PDT)
Date:   Fri, 23 Jul 2021 11:02:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <60fae7f8747c_defb20888@natae.notmuch>
In-Reply-To: <86becf764243f129c980f073127ec3f08fd4477c.1627042470.git.gitgitgadget@gmail.com>
References: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
 <86becf764243f129c980f073127ec3f08fd4477c.1627042470.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 3/4] merge: apply autostash if fast-forward fails
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>

> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1560,6 +1560,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  					  &head_commit->object.oid,
>  					  &commit->object.oid,
>  					  overwrite_ignore)) {
> +			apply_autostash(git_path_merge_autostash(the_repository));
>  			ret = 1;
>  			goto done;
>  		}

I can verify that this fixes my simple test.

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 1cbc9715a81..216113d3537 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -122,6 +122,8 @@ test_expect_success 'setup' '
>  	c0=$(git rev-parse HEAD) &&
>  	cp file.1 file &&
>  	git add file &&
> +	cp file.1 other &&
> +	git add other &&
>  	test_tick &&
>  	git commit -m "commit 1" &&
>  	git tag c1 &&
> @@ -711,6 +713,15 @@ test_expect_success 'fast-forward merge with --autostash' '
>  	test_cmp result.1-5 file
>  '
>  
> +test_expect_success 'failed fast-forward merge with --autostash' '
> +	git reset --hard c0 &&
> +	git merge-file file file.orig file.5 &&
> +	cp file.5 other &&
> +	test_must_fail git merge --autostash c1 2>err &&
> +	test_i18ngrep "Applied autostash." err &&

I've heard others test we are moving away from test_i18ngrep in favor of
grep.

> +	test_cmp file.5 file
> +'
> +
>  test_expect_success 'octopus merge with --autostash' '
>  	git reset --hard c1 &&
>  	git merge-file file file.orig file.3 &&

-- 
Felipe Contreras
