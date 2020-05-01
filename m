Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61009C47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6AC21775
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="zVKHTctc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgEAXMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 19:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXMo (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 19:12:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0391EC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 16:12:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l20so5185832pgb.11
        for <git@vger.kernel.org>; Fri, 01 May 2020 16:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GUkfhrLCjv2w0MleJfVn2/PyK6aQ1hGwEqdWB+9qX6A=;
        b=zVKHTctc0rcFoiCdU/gcTUvampKQASAwOI7iYr0h1So7Q3is0sgnfUKLEO+mngXzmb
         H23+v5J2nUX3OoYXoj1UO6Kzoxn2HM0pM3aVoQCJUIK+7qt6v2PzAxAmLKAnnNZFQhu0
         79xm3d/PEfDzfXGF8gBvW7vr/fDEsxw5Av27x01FWeGFLtTR5uo9iKta9nRCzDgQ/Ei0
         d5fggBXcPAVI5O9jdxSmiqntWnndqOH33LzQoiMqt4wHkU4IMb7nytxEa6KpdkXBXuwd
         uyJOVFR+aTB5uYinXVBz1iX0WgvUDLChbpZyKU9Ik/JTx0acza48F9KG8AlDSt/FdhTP
         rQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GUkfhrLCjv2w0MleJfVn2/PyK6aQ1hGwEqdWB+9qX6A=;
        b=mlBk9jkc1OemhKNH6cIW0pg8nd0kvNTis4dMz7j2KVm3eS+OJRDSG+gA/IZ+hTxgFu
         Ckftgore0a1DtJNe4q25b1WXG3+VX+7+Uyfug4kdxyr59pcULLJcRSXmqYGHu4gGy6Vv
         mK0Gi6GJeZXHLb6oZBslnQQvBBu0xfzhJZq5K83GA8QihWhlQrp4py0McyhCHjZjycs5
         6RmXYda8/02BTYvsfPNoV0u0tFo4kCDBB4uGH4uMnP1JbIWdvpurJBLJEe1G51E6f361
         9MivpmNUIzjXTOTqh5UNJM+Nws4eiE43/cCavMC9406pzSzZ5+hOZIavjsHzZKTBjCHL
         PepA==
X-Gm-Message-State: AGi0Puad8m0ps1S+KcFowYqxXwbD++Ty8OJ72yTQ+MfTB9ro0QmeXhfN
        AMMiX8vuMkiMMJ076qG9/JNiYQ==
X-Google-Smtp-Source: APiQypInYtfWrjUWUlxuETZNZ+BshrDzHwD4czRWgXrqoBoy9d072KBwpwWRn+SQWOkLWlr2g0RrHw==
X-Received: by 2002:aa7:97b2:: with SMTP id d18mr6427211pfq.89.1588374762463;
        Fri, 01 May 2020 16:12:42 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c1sm3063768pfc.94.2020.05.01.16.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 16:12:41 -0700 (PDT)
Date:   Fri, 1 May 2020 17:12:40 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 06/12] bloom: use num_changes not nr for limit detection
Message-ID: <20200501231240.GC46422@syl.local>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <7d5561575d5e81128dcccb411bf2b052491d1850.1588347029.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d5561575d5e81128dcccb411bf2b052491d1850.1588347029.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 03:30:23PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> As diff_tree_oid() computes a diff, it will terminate early if the
> total number of changed paths is strictly larger than max_changes.
> This includes the directories that changed, not just the file paths.
> However, only the file paths are reflected in the resulting diff
> queue "nr" value.

Nit; s/queue/queue's

>
> Use the "num_changes" from diffopt to check if the diff terminated
> early. This is incredibly important, as it can result in incorrect
> filters! For example, the first commit in the Linux kernel repo
> reports only 471 changes, but since these are nested inside several
> directories they expand to 513 "real" changes, and in fact the
> total list of changes is not reported. Thus, the computed filter
> for this commit is incorrect.

Wow, this is a great find. Nicely done!

> Demonstrate the subtle difference by using one fewer file change
> in the 'get bloom filter for commit with 513 changes' test. Before,
> this edited 513 files inside "bigDir" which hit this inequality.
> However, dropping the file count by one demonstrates how the
> previous inequality was incorrect but the new one is correct.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  bloom.c          | 2 +-
>  t/t0095-bloom.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/bloom.c b/bloom.c
> index c3b81b1a38a..9a8386ac676 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -215,7 +215,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
>  	diffcore_std(&diffopt);
>
> -	if (diff_queued_diff.nr <= max_changes) {
> +	if (diffopt.num_changes <= max_changes) {
>  		struct hashmap pathmap;
>  		struct pathmap_hash_entry *e;
>  		struct hashmap_iter iter;
> diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
> index 6defeb544f1..48a90625596 100755
> --- a/t/t0095-bloom.sh
> +++ b/t/t0095-bloom.sh
> @@ -100,7 +100,7 @@ test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
>  	rm actual &&
>  	rm expect &&
>  	mkdir bigDir &&
> -	for i in $(test_seq 0 512)
> +	for i in $(test_seq 0 511)

Thanks for demonstrating the fix. This is change is very subtle, but I
think that it's right on.

>  	do
>  		echo $i >bigDir/$i
>  	done &&
> --
> gitgitgadget

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
