Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106881F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 09:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJIQXJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 12:23:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40185 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJIQXI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 12:23:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id z204-v6so1081247wmc.5
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 02:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EaKY2JB8M2s/u85m2+VMR/HQCpanwiNt7eaR8ZGWEVQ=;
        b=Tnca6XghmA7GcBeYhxLLKTA1SVz7KXrGwdZMFat9MSpFsOKNJak/y72a22JH4294TD
         7sAKkLY1JwCDvyG2x5V2tvyVD0lXyXPmpu3nGB8f1ke2EtfL5ZLWRhH1KRadtSFwlOfY
         DRBvH+86XCLJCXrWtgNqNg2ny0i+e+IsA4+3w1vwM2CGUQP5JSzorAG0ghtK6cpm60iA
         zaRqy5lHyMJ5ukz5Rs+G0pdfCFzhUg2vIvvPC67NvSwTpiJdRqoqT39cVKDxiRb2V8gp
         sQ1kjXrM1dCoLBv/EZw/dWZmTrDYr5prgWVeDOllBa4PJ4KAvxFFkkJpAT7M88wY4amo
         +amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EaKY2JB8M2s/u85m2+VMR/HQCpanwiNt7eaR8ZGWEVQ=;
        b=JNrNBbj1WCPHruALxxYk6IbKBfGhBMDkyUKz8aCTpN8jayoXDtXn1SR8AqSzXap+7G
         dKahR6/s1m3BrWQTnTddJVy8ggJv8HOL7rKPtTK0M3QHattIM05lEf/lFJmhe8eDWJ6x
         NfiA6pgm76YtcEcBvFNcXKEk++/fiJ5Jn7H7ACRxO1+Z2scytHRETCaqLVO1YWFaSZoq
         DW2vHAxZ9kEKENeeT/0QMjG8nT1VcsoS7Mn2ir4YaR5txXnir0fjEQGCph5MaZNokIHW
         ClTEAQOsDryoKViao5R5nKWcQ+zMshLmvbtt27LWX+DNVThgus1M7wipB/0nNnnStkXt
         GfkQ==
X-Gm-Message-State: ABuFfoi6JxYHU/arY+LDBFa1L8BXAf+sJr1QwTfEOqcra8/zdzX5o6T0
        0g56Zvx3VVtA7/c6BDv+lq4=
X-Google-Smtp-Source: ACcGV63xtBBpyQT3AGFeWbc5pNhk6xW0QQErD6cGCCoFr5AfZhTrEzlnbJ3DO4djajdhST8wm3BOYQ==
X-Received: by 2002:a1c:7dd5:: with SMTP id y204-v6mr1246772wmc.63.1539076032258;
        Tue, 09 Oct 2018 02:07:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e67-v6sm13440772wmd.41.2018.10.09.02.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:07:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] midx: fix broken free() in close_midx()
References: <pull.27.git.gitgitgadget@gmail.com>
        <9fcbbe336dffb16b7cb5f4de0163404a81597af1.1539011820.git.gitgitgadget@gmail.com>
Date:   Tue, 09 Oct 2018 18:07:10 +0900
In-Reply-To: <9fcbbe336dffb16b7cb5f4de0163404a81597af1.1539011820.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 08 Oct 2018
        08:17:03 -0700 (PDT)")
Message-ID: <xmqq8t37qyip.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When closing a multi-pack-index, we intend to close each pack-file
> and free the struct packed_git that represents it. However, this
> line was previously freeing the array of pointers, not the
> pointer itself. This leads to a double-free issue.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/midx.c b/midx.c
> index f3e8dbc108..999717b96f 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -190,7 +190,7 @@ static void close_midx(struct multi_pack_index *m)
>  	for (i = 0; i < m->num_packs; i++) {
>  		if (m->packs[i]) {
>  			close_pack(m->packs[i]);
> -			free(m->packs);
> +			free(m->packs[i]);
>  		}
>  	}
>  	FREE_AND_NULL(m->packs);

Yup, kinda obvious when we view it with the post context.
