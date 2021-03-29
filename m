Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6190C433E4
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 15:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B435761987
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 15:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhC2PET (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhC2PEH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 11:04:07 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8EBC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 08:04:07 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id q127-20020a4a33850000b02901b646aa81b1so3038190ooq.8
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S2abKVsZO5X6n3vWKVTrNgScXOgjldQ6pZLgyoddlZU=;
        b=mPYLS8vRKBecuorckLl19X2/qkrhlTxwJraRj0PEudlavVhIT9L3CS+jbZWDXdguLW
         IMDE5m78zczrnkK4BjZgA2JhrHsBxtcMLtPdjLQNMIOgEflUQwBLVzh4GnJ4d13Lh3fA
         30uTTAfu7b1T6xe8lUpNXlIGjZg2HmWk7R17whvm1CBEaSje7ae9GE+YGBFO1XM/6ajl
         klQy5hiYl+rdiFDHzh+B9quZB0JRXESdBrgFBkcQA3oZqoGPC/Pf5hTQpOj5z0jMHDSB
         93aAnqxp4a2gRvQiCVSR/IXIasRjFi6it10OOPEgejqNy7jaXv/A1b9uLbxejs+1kgZH
         Lalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S2abKVsZO5X6n3vWKVTrNgScXOgjldQ6pZLgyoddlZU=;
        b=jkJFwJYmtgAAsjgDxozY6OgNvXM5L4cpFFqqZT9iPLCcBJYrsDHOwaboI1wdmUK/rb
         LxEgSn2PFlfICQuBk/BzE3EpdYkszUJ8hDONr5TvoorCRqeWtvipQFpHDyzxq0WwG5P8
         6Za/cQGEQIJLota9nqsVdkI5lPtJIrRirK4L5qjyGoGJKeWllRMY0ObkG5hR1bwfdp6b
         FsVYHtFo1MfDIp5JWWIe7J7tTK/1qMwiMQDWqDlZw31aOQTrAam0OztvcMJ6F8kiSsSi
         CNpHIwTdq+Kn6eUqtbHGn6qoUaXHecTi94WEP5iFj4/OzvM8EoxVsY0NLtC7KcpHtKuj
         SNfA==
X-Gm-Message-State: AOAM533xPpNKx9Rm7FyM8e8YWe3HdGbjzmLUogrk79zH0sQZ5rTvj8GA
        +W1htXqv14J30ruQnUX42SU=
X-Google-Smtp-Source: ABdhPJx+w6EXgvOYFupywyvTQ+w+qr5a+b1HJrf7XzWsfTc4IgVSeE833ODl79Se6xtyFfgO603YPA==
X-Received: by 2002:a4a:e2c6:: with SMTP id l6mr21768230oot.31.1617030246533;
        Mon, 29 Mar 2021 08:04:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:18fb:da6e:ec24:b27d? ([2600:1700:e72:80a0:18fb:da6e:ec24:b27d])
        by smtp.gmail.com with ESMTPSA id h23sm4382629ots.0.2021.03.29.08.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 08:04:06 -0700 (PDT)
Subject: Re: [PATCH 2/3] read-cache: use hashfile instead of git_hash_ctx
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
 <e2611bbc007a4583af55e006136c2bc74351a7de.1616785928.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8b368872-bb36-db61-20d7-47aa5af0ec37@gmail.com>
Date:   Mon, 29 Mar 2021 11:04:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <e2611bbc007a4583af55e006136c2bc74351a7de.1616785928.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/26/2021 3:12 PM, Derrick Stolee via GitGitGadget wrote:
>  
> -	if (ce_flush(&c, newfd, istate->oid.hash))
> -		return -1;
> +	finalize_hashfile(f, istate->oid.hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
>  	if (close_tempfile_gently(tempfile)) {
>  		error(_("could not close '%s'"), get_tempfile_path(tempfile));
>  		return -1;

It was bothering me all weekend why this change made index writes
slower. The reason was this CSUM_FSYNC. Other performance measurement
(instructions, branches, branch misses, etc.) are all really close to
the old code, so this I/O is the only explanation. And truly, it is
the case.

It seems that we avoid an fsync() on the index exactly for this perf
reason, but we don't on other applications of the hashfile API because
writes are not critical paths.

I'll update this series in a v2 soon that has some other improvements
that I noticed while digging deep into things.

Thanks,
-Stolee
