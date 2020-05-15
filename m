Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AEAC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF8A20760
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4+lLCDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgEOKQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgEOKQi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:16:38 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECB0C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:16:38 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a68so1459142otb.10
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TZrl4GJT7jqu0vPBR30C6txzEAZ+oWXKETn+hmL2oC4=;
        b=O4+lLCDz1dzKd5mKUeZ/GDua0XIk4T65pjIlY4OQD5yE87MsI56gJHdzXVj+uVljce
         ROm37flokOJ7ciecu95bMbXieEuoB+2WbICm3Je2QNC3kXvGHMpoSzzR+CWe2v0O9Ser
         2quU8IaXhysh1M90MTEIvptf/mmDTqYp3bj9FXtWhIC8iBJopj8yDR5JzGZwHfSjcg9S
         28R/dt9fRaBu+D5bdfJ9mrTihl/wUI39yxhfGsvp3ifnfFutOwAxGkc4TGADSArn4tQv
         sx2NvZEMBwFAriNw9W/CjKZcfra3+3aHkh5TU8rERcypd3WNkbHyYgIZjLyynmUYa7wU
         DXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TZrl4GJT7jqu0vPBR30C6txzEAZ+oWXKETn+hmL2oC4=;
        b=CEF3gKuL/UVIB7P7wmongxJXiLRhJ6MuDxZ0c3GIafDTGynb2Zey4WHik/JfARWJSB
         Fr/fBiB5jAR28FNalSlkmNeNDZeACUc3VsdUJvytYbdH/DuNQMH6w9IyKNbPYUiogHXe
         4W8lAGYPBJcfgJdtb9O4CnCpSFpIn8fYutNYlF2FrIwpjr8sxGKanpc8XwAkZ0rYNhnd
         NEn4YZXDz15TCk3kL6J39rj+BWrsp3dJ2/KxEYVkrLebXp1Wf3Okwt19RYmYL0MUM/5O
         dzUpQSMyIrNLK052+BtdY9+LEgRNQdBfwqw6UZxJ8RtN1t4Spz+9seTvOb9+43wE6AlD
         UCNw==
X-Gm-Message-State: AOAM530hXhVkUqcV0jKy4u3DwYN6QPIeJuCMPM2gWdKkGP1oUFGDCZbT
        AYS67Lawxq67YTZP7L+Br0+tLz/2vVs=
X-Google-Smtp-Source: ABdhPJyhvggdm82TLWXR9Zkgfw3q6V63YQ/9bsiEmSuMZNEEF+TL04Mi74NHR5BdrJqqBrjzhdjaiA==
X-Received: by 2002:a9d:6f17:: with SMTP id n23mr1510205otq.124.1589537796905;
        Fri, 15 May 2020 03:16:36 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u1sm522435oif.54.2020.05.15.03.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:16:36 -0700 (PDT)
Subject: Re: What's cooking in git.git (May 2020, #05; Thu, 14)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqpnb6nk7x.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <74397ce4-be15-51e8-fb28-81eafdca792c@gmail.com>
Date:   Fri, 15 May 2020 06:16:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <xmqqpnb6nk7x.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/14/2020 7:57 PM, Junio C Hamano wrote:
> --------------------------------------------------
> [Graduated to "master"]
> 
> * ds/bloom-cleanup (2020-05-11) 7 commits
>   (merged to 'next' on 2020-05-11 at 046d49d455)
>  + completion: offer '--(no-)patch' among 'git log' options
>  + bloom: use num_changes not nr for limit detection
>  + bloom: de-duplicate directory entries
>  + Documentation: changed-path Bloom filters use byte words
>  + bloom: parse commit before computing filters
>  + test-bloom: fix usage typo
>  + bloom: fix whitespace around tab length
> 
>  Code cleanup and typofixes.
>  This is an early part of ds/line-log-on-bloom that has been cooking
>  in 'next'.

Thanks for taking the time to merge this portion for the release
candidate.

> * ds/line-log-on-bloom (2020-05-11) 5 commits
>   (merged to 'next' on 2020-05-11 at 046d49d455)
>  + line-log: integrate with changed-path Bloom filters
>  + line-log: try to use generation number-based topo-ordering
>  + line-log: more responsive, incremental 'git log -L'
>  + t4211-line-log: add tests for parent oids
>  + line-log: remove unused fields from 'struct line_log_data'
> 
>  "git log -L..." now takes advantage of the "which paths are touched
>  by this commit?" info stored in the commit-graph system.
> 
>  Will cook in 'next'.

Good plan. This can wait until after the release.

Thanks,
-Stolee

