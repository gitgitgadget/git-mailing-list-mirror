Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D42C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD38364FC3
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhCIVwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhCIVwL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:52:11 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D241C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:52:11 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id r24so7277824otq.13
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Om7v6a9kwcICRwxVdLkpO1ZX1PSFsfhW6HLG21615h8=;
        b=YzXM1CkNWMW7hPEpSNTmnleALj29J0NJpc3pM8Cff6au+S9cMO6yXvdJL6mMsdDAzf
         xuCeElWQf3zBDwDzOzJgBkn9iiq+va/au/nOvShNDzvXjyuR0mXNNUyIgQgTYmkW3jVG
         iVsEkcUIdonfNGzObXEA/SmJ5Flm2qdBOytd3vPXJsX5FJmW4hYiU4eUtYrUeVwCE7nW
         yHnbnIdYSN5RIGaR1ers6z//nuvj/8PxD2Arz3QkDX3QwkbCJsvfS5fOnowKXCLQnsVo
         Ck29D0GbyBglQVIVlFtY2ay+cJAJiWsWYqZDSjaq74/gkDsLqY8r2BjVK7/Ocuo4RN1t
         6dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Om7v6a9kwcICRwxVdLkpO1ZX1PSFsfhW6HLG21615h8=;
        b=mzD2ilNVDtrUpY/7fB/QNUHB1892mbOLx+V6M262aEnuE+0IJuEC7U/GTFlGvaY6lq
         +giIoQFp8FyXxieurq6mqV2GDaPDFKlggalQbZEdR9iQ7yT/wVjWv+5Vlcc6iCKkmlp/
         QysOdCIlWEjIhl0BUp3YW/N6DCCAPACGV1yVK+vsius1WI1MwFcIXXfK7efqfH78Cb1H
         ELTpdNxSrPZ2nsPNG4O59pBdKWyFospRUNQYzFHPQgJVW3/Idjlk4LdKDH3eI8p6iUez
         /jFj3KqPnT5ADHilptSGyYmDlLaEHImB2gbbHNfmYa+HgUV8ZattHXjtY+UQurBDsoQz
         mRKA==
X-Gm-Message-State: AOAM533Hq90sF/Zrc9lCzfsKhi8QHrxnuvpX3fV1NTf42BY837FAQpqR
        bBHcI35UUJMFX8kdfsAE0hU8BAIY8fO+9A==
X-Google-Smtp-Source: ABdhPJzPDBJ+PMb2Za8zlGqGNfxbbgoPMTx6oRz/5d/jvRB0GO0dVbRMHJD0YCIjUhBhTE0sug9Lnw==
X-Received: by 2002:a05:6830:1113:: with SMTP id w19mr178702otq.55.1615326731047;
        Tue, 09 Mar 2021 13:52:11 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id r126sm3336924oih.12.2021.03.09.13.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 13:52:10 -0800 (PST)
Subject: Re: [PATCH v4 00/10] Optimization batch 8: use file basenames even
 more
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
 <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <98dcac36-4c0f-e29c-2bdd-e3d89f4f9275@gmail.com>
Date:   Tue, 9 Mar 2021 16:52:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/26/2021 7:30 PM, Elijah Newren via GitGitGadget wrote:
> This series depends on en/diffcore-rename (a concatenation of what I was
> calling ort-perf-batch-6 and ort-perf-batch-7).
> 
> Changes since v3:

I'm very late in doing this, but I reviewed the range-diff and found
this version to be satisfactory. Thanks!

-Stolee
