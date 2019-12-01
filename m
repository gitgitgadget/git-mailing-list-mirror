Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2800BC43215
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 09:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19AD2146E
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 09:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncFgKJ4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLAJdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 04:33:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36777 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLAJdN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 04:33:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so40337870wru.3
        for <git@vger.kernel.org>; Sun, 01 Dec 2019 01:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fWfI1R4EMb5C4vDuFfsI5qcF4swAGuZhcYZQ2RCo7Hs=;
        b=ncFgKJ4lzUTXb1qNT4LofQyvGbRK3RAK+0AJQl+21K8N/2u4XmiikvzCnpbJm9Z49S
         bJt4IcEBR6DCkdFRhEOvaRt0MyZ3N5yZ1CBAtUo1+IA7cFiemiJ+gV4YbrLRyn/sV0ey
         RIAswUSFrVO71tmO0CPFGva7TBYHzwHpFuhg9HMn3pMVEiQQhZ9dUsu4qPBEsncodm9t
         eLxci9WC6yG0IS3in6HmGTUJo/+LWjd8QPulwW2nZ7vLcqhv58ihDI4E8K3nus8xh++Y
         fJW6HIe+fWd7LQNq7Q/rnsFarPvCxbV0LrZrYr2OvUO93omsJkRyE1qUOWDkXAeSLD2G
         qM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fWfI1R4EMb5C4vDuFfsI5qcF4swAGuZhcYZQ2RCo7Hs=;
        b=RjJXMudComD2/IzmSG3vE09RbuelwN9/UOu+gyI9nL4X6yPje4TSpnI1sl2ccopwE+
         00+FMl2WCZN4YnqqPcMZTZnSEh90wfpVe8MKTK4Inl5DQEq3k8eFzld30nF00pL4T1OW
         +KZOo4fOovEZ/jfHz4421aupbPui32Q5kIhjAZiqJFeUzPnLYrAwcD4OLcmLzNkaaysW
         CWTYvBOyKMihJIJ8vuTgmupYDTmtF7c/tvJhHzTgTTKmsOMna2qbHuGyotOrPxQI9cHy
         u6lyykMgj8dNMWGFS6DiDOwuwwWdKGoNKj9ypp+XDHfuNDu4py4wV4lWhSGxkRxVMts4
         wvWA==
X-Gm-Message-State: APjAAAUROcbgbVsPt6pASTK9HFLXnfzSMTsPh1C11UAG4cj5W8qN6G8G
        mtmmoeWw0/bjrjb7eolJSKQ=
X-Google-Smtp-Source: APXvYqz1hSYVNXKil14QZA9JetMPjxSaKpZZ+I27GZRaDqa2C16M439so0jUSQ1YuVBhvEdTtwnLiQ==
X-Received: by 2002:adf:8426:: with SMTP id 35mr64152491wrf.262.1575192791355;
        Sun, 01 Dec 2019 01:33:11 -0800 (PST)
Received: from szeder.dev (x4db454dc.dyn.telefonica.de. [77.180.84.220])
        by smtp.gmail.com with ESMTPSA id s19sm15330442wmc.4.2019.12.01.01.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Dec 2019 01:33:10 -0800 (PST)
Date:   Sun, 1 Dec 2019 10:33:08 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, ryenus@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 0/2] commit-graph: use start_delayed_progress()
Message-ID: <20191201093308.GI23183@szeder.dev>
References: <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
 <pull.450.v5.git.1574717303.gitgitgadget@gmail.com>
 <20191126122022.GB10290@sigill.intra.peff.net>
 <fe7c0e41-8379-4933-4ff1-026d3f1f8472@gmail.com>
 <xmqq36e54eie.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36e54eie.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 30, 2019 at 06:36:57AM -0800, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> > On 11/26/2019 7:20 AM, Jeff King wrote:
> >> On Mon, Nov 25, 2019 at 09:28:21PM +0000, Derrick Stolee via GitGitGadget wrote:
> >> 
> >>> Update in V5:
> >>>
> >>> I took Peff's advice for using "env" to use this delay in the GC test.
> >> 
> >> Thanks. No further complaints from me. :)

> Thanks, all.  It seems that this round is ready for 'next'?

Yes, I think it is.

