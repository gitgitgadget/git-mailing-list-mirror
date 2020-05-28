Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E067EC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F9A206C3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 13:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn8TJb1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390232AbgE1NRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 09:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390160AbgE1NRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 09:17:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEBAC05BD1E
        for <git@vger.kernel.org>; Thu, 28 May 2020 06:17:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f3so689800pfd.11
        for <git@vger.kernel.org>; Thu, 28 May 2020 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/AMe44mN85tL4AOMdj2jGbMptKrjyqvk+rgQnILThV4=;
        b=nn8TJb1A5O3almpvLLRfF1cnEe/vyG/uJtHJpNKUn6lKQZOP8vfgfSR86PG7jk4ZS8
         y9AzblU8q9K8a4Q74iB8u8h3TB84Vw0PHoC+v6e+3nxFQvwbfuK4L6QtINpmieHefuoM
         3sYHaTJEaybhyYbQah8NQu7i8rg7kLZP1LE5p+MjtohiKwVSRiGcerdnh22WlpFmoblv
         4kJHUhHxR/03kd9fLDJvePqF2kkC+UhejLUZtSfT0pBBpKcxgWkftpbhG6cQ1eY+Rreb
         i6rWDGcUQxcU64gXCjZYyFsb0sF2KBRVzmYbps4vHcSAbtyfExmvEV1nNoY+V3yazsty
         BExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/AMe44mN85tL4AOMdj2jGbMptKrjyqvk+rgQnILThV4=;
        b=KYJSh4nK5vxlG67wa3lFGtJ0vvuqBS/nSm0tx57YioEBaY33GotchLN3njt4zXzSbO
         PcjaOn7XNvCyXZSeKiJ8N1HR5aP3OZDLLl5SJHkYRlgmGHM2bmJh3xPGkJqgN1FiE1NP
         PVO/J3pylwQt74FmVnbFhAxtOU8ZoUw6bLuZ8ZNzSFRc3rRpF/gI70jCAJidQ3k9Dr8e
         2cMw1XPNcH0G0NuB+aZEOELHH8wivknxo9bdE3xiRQGG+7QyDxPx1Q1nK9x8U4OMqhVV
         UBMsOx78+fh75gROS/KB2aPCtuOFZuU3cdJLHZC0Ta9leBf4Uu4jUonQvh713Ud6hw4u
         LuaQ==
X-Gm-Message-State: AOAM530r8QSe3a2zEDSnggVltExlZyUaOLrSBIeq76q64fcENn3z1+nN
        6cjNjQQ/Jb8BLaAkmJdKz1w=
X-Google-Smtp-Source: ABdhPJwXOci7ejJ8H1+vQxO6YX/bckvbgIBxE2P7y5eY1omDa+ZnU97H5O40WCclSDhYoIB8gZZuLg==
X-Received: by 2002:a63:1d02:: with SMTP id d2mr2952458pgd.206.1590671823764;
        Thu, 28 May 2020 06:17:03 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id 188sm4813700pfu.165.2020.05.28.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:17:03 -0700 (PDT)
Date:   Thu, 28 May 2020 20:17:01 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 6/5] fixup! rebase: add --reset-author-date
Message-ID: <20200528131701.GD1983@danh.dev>
References: <20200527173356.47364-6-phillip.wood123@gmail.com>
 <20200527175748.54468-1-phillip.wood123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527175748.54468-1-phillip.wood123@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-27 18:57:48+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Sorry I somehow forgot to commit this before sending the v4 patches,
> it fixes up the final patch
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t3436-rebase-more-options.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
> index 5ee193f333..ecfd68397f 100755
> --- a/t/t3436-rebase-more-options.sh
> +++ b/t/t3436-rebase-more-options.sh
> @@ -196,7 +196,7 @@ test_expect_success '--ignore-date is an alias for --reset-author-date' '
>  	git rebase --apply --ignore-date HEAD^ &&
>  	git commit --allow-empty -m empty --date="$GIT_AUTHOR_DATE" &&
>  	git rebase -m --ignore-date HEAD^ &&
> -	git log -2 --pretty="format:%ai" >authortime &&
> +	git log -2 --pretty=%ai >authortime &&
>  	grep "+0000" authortime >output &&
>  	test_line_count = 2 output
>  '

This version addressed all of my concerns, LGTM.

Only the last

	test_line_count = 2 output

puzzled me at first.
Since it's the only usage of test_line_count in this version
Turn out, it's equivalence with:
-----------8<-----------
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index ecfd68397f..abe9af4d8c 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -197,8 +197,7 @@ test_expect_success '--ignore-date is an alias for --reset-author-date' '
 	git commit --allow-empty -m empty --date="$GIT_AUTHOR_DATE" &&
 	git rebase -m --ignore-date HEAD^ &&
 	git log -2 --pretty=%ai >authortime &&
-	grep "+0000" authortime >output &&
-	test_line_count = 2 output
+	! grep -v "+0000" authortime
 '
 
 # This must be the last test in this file
------>8------

This is the check used in t3436.15
Current version is good as is, anyway.

-- 
Danh
