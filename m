Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A01C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 14:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E68C64EFC
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 14:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhCOObr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhCOObo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 10:31:44 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED80C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 07:31:44 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so5216895otn.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WE8/OPQNyN1IovXzx6eVmmEczx3moZw1xz8cglSINpU=;
        b=t7sF3nbtHEE3lzU9IM4v+JSpq69Q1SAigPfjakNU1YIkdKMYrQGAycFnwM0NHkRVcG
         GEpJm7MIr5aue5JJSStxIiTSUl+qOo7bLrRjTCFSHZk1nByIvBbhJVSpHt+jecKunm2n
         IAyMdAUvTw+7R1znrsNqleCGpeUWSliuo1IedXTFJ23YfuZlCGdDYrF8PwdvVTOaDkA2
         22tafjYIYH5mFE1ON1pGSbHJHTYCDZmpW1GTfJ5pcojGXJQf4o0w133xykvnJEzU/y+l
         2q76bOMWVvNEnWCzRYSpvBD9uJ/e8womsqDeaKtnhiJQl2vj0qf8zrtxh/JFZe2ABYMa
         ehDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WE8/OPQNyN1IovXzx6eVmmEczx3moZw1xz8cglSINpU=;
        b=AefNyESzZEKKLVONLoOET6Md0Ng8G7k2p41spKCmDl9Sj1ahaxEZJ7NfRN7um+QJsF
         lc7Ze14kSlUgl634mPZGocEjUQ1oJvvOdveqcrZJgUsOGReeq9HgXt3whglOQW8fu/y6
         syj7eK9xRgxVgYE42XUiyZb4hKAhvw5aaDLK+LZ5KYjsSMUXhM2ZQ6dH+T01r6ZZWRq0
         VbdzX1ZjVWOrH6+lvL0QWZu858ntQarNACk7N2/FzBRWmxSqjXDiwr/1igCwUx0hy/Gx
         jOW3QY7NOKMyuoDOALJpUslA3fvx48tArw833pic5VBMC2jQtLA4fhhSjxMq9VbS9UHc
         hd0Q==
X-Gm-Message-State: AOAM533NgynUJbC/T/FMvXhIzLEQ4e/NILoMVs3CtIsZcQnW8fSRdA3n
        4s84pXbuD1f7Z4Ycv2EGUp2KnqVq+C0xZA==
X-Google-Smtp-Source: ABdhPJzAcItjBSpfV4x/ib3l27NfAIBTiZnzJ7py5QVsKmLdDOaW+NIzYp7mwtzUTw+Vy91nC6pqPw==
X-Received: by 2002:a05:6830:1546:: with SMTP id l6mr14831183otp.139.1615818703311;
        Mon, 15 Mar 2021 07:31:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:44e0:e2f9:fa7e:56fa? ([2600:1700:e72:80a0:44e0:e2f9:fa7e:56fa])
        by smtp.gmail.com with ESMTPSA id h24sm7227496otg.20.2021.03.15.07.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 07:31:42 -0700 (PDT)
Subject: Re: [PATCH 3/8] merge-ort: record the reason that we want a rename
 for a directory
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
 <05850cb49823ea9c6d6c7cfd3b4adbbc1c47abc6.1615674128.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <baca2700-0959-c4ca-6ba9-ceb5188f96f4@gmail.com>
Date:   Mon, 15 Mar 2021 10:31:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <05850cb49823ea9c6d6c7cfd3b4adbbc1c47abc6.1615674128.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/13/2021 5:22 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When one side of history renames a directory, and the other side of
> history added files to the old directory, directory rename detection is
> used to warn about the location of the added files so the user can
> move them to the old directory or keep them with the new one.
> 
> This sets up three different types of directories:
>   * directories that had new files added to them
>   * directories underneath a directory that had new files added to them
>   * directories where no new files were added to it or any leading path
> 
> Save this information in dirs_removed; the next several commits will
> make use of this information.
...
> +/* dir_rename_relevance: the reason we want rename information for a dir */
> +enum dir_rename_relevance {
> +	NOT_RELEVANT = 0,
> +	RELEVANT_FOR_ANCESTOR = 1,
> +	RELEVANT_FOR_SELF = 2
> +};

Is this potentially a flag list? It's hard to tell because we don't
have another item (3 or 4?).

>  		unsigned sides = (0x07 - dirmask)/2;
> +		unsigned relevance = (renames->dir_rename_mask == 0x07) ?
> +					RELEVANT_FOR_ANCESTOR : NOT_RELEVANT;
> +		/*
> +		 * Record relevance of this directory.  However, note that
> +		 * when collect_merge_info_callback() recurses into this
> +		 * directory and calls collect_rename_info() on paths
> +		 * within that directory, if we find a path that was added
> +		 * to this directory on the other side of history, we will
> +		 * upgrade this value to RELEVANT_FOR_SELF; see below.
> +		 */

This comment seems to imply that RELEVANT_FOR_SELF is "more important"
than RELEVANT_FOR_ANCESTOR, so the value will just be changed (not a
flag).

> +	/*
> +	 * Here's the block that potentially upgrades to RELEVANT_FOR_SELF.
> +	 * When we run across a file added to a directory.  In such a case,
> +	 * find the directory of the file and upgrade its relevance.
> +	 */
> +	if (renames->dir_rename_mask == 0x07 &&
> +	    (filemask == 2 || filemask == 4)) {
> +		/*
> +		 * Need directory rename for parent directory on other side
> +		 * of history from added file.  Thus
> +		 *    side = (~filemask & 0x06) >> 1
> +		 * or
> +		 *    side = 3 - (filemask/2).
> +		 */
> +		unsigned side = 3 - (filemask >> 1);
> +		strintmap_set(&renames->dirs_removed[side], dirname,
> +			      RELEVANT_FOR_SELF);

Yes, using "RELEVANT_FOR_SELF" here, not "relevance | RELEVANT_FOR_SELF".
OK. This should make the later consumers simpler.

Thanks,
-Stolee
