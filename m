Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4950C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 03:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiBKDNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 22:13:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiBKDNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 22:13:49 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D971105
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 19:13:48 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id f24-20020aa782d8000000b004bc00caa4c0so5663963pfn.3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 19:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0X/3mFuVgfrU3uhTnCNOXZ8LTT7Rd9/TqANVo94XUvg=;
        b=Bl04dXz+XELx8z3gIFq/zJqbOnS2zY9M3SKjNidvqGr7/wkPVUg7jajmEDqFTzMaJO
         ezkV9BsJjp7CfXpxu44K7kAIKHrMuViutclQ4iPOpV0njuj1LPOqE9MnSslO0DFK5p9c
         sPnuAxB/wCKXKcLibsKcY/ZQyd/cMN8P0VvSwtoJfyzZB/NuEt2/RagYKAXIvUWbkJzg
         ordyDqnvdhmd+cDGt3/Cc9Cq78bJhGNgSsMCf63Hm+zuVUpBcDNSXsi+6k5YmcRor9+d
         ssriCm0Lfnk/hXsbFRl08ar245T0Inr1KdTXxURy2uuuRmoGTb4HEM/+cQfPTFdSu8Yi
         9iFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0X/3mFuVgfrU3uhTnCNOXZ8LTT7Rd9/TqANVo94XUvg=;
        b=TymvGZezPGazCQ5WbMVJ0kz8uGe2id0yqCz31GaD9K9oSYODAXQ3que/Quy3JRQ/z9
         04R+Cz4qx7KdD3jEk1Dcy8o8ptDoplEqtKvwQQlkdgrQqsZaomVtDZwZS19ilvcnhTKH
         CxG95iOagBHfCEIrd+vqZ51E6A6+Ahp752Km8KWsBdOVfAdHv49ZTL/TZ3RCfAp7aBtx
         aSSnrucaRUhvf8DqAcmhi5wKziOj34reKloJe/SXlREkCpsEDq2CgYFXj0cUXDLKtHif
         YjiMwIQQPNEZp8WCb8N46yGyUgfWDwPco7wOWfuS1xSYGo4fnMIgjePlp+vly9WQbpQ6
         Msdw==
X-Gm-Message-State: AOAM530D0hsw1aIcrwJ/wcqHala6w6V8I6TUGw54328fCdiIZZKu3ZW8
        N6yhMiVnBYpzo8cLCHtYW/J4hV576U8bHQ==
X-Google-Smtp-Source: ABdhPJzhG0pQBBsHJhLldGzxW/9w+X6R5DK6u/tu9J/i+HNl3CsrEtyUVvmvBZj+4qw0omfEV8bMWVe+W5AsqA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:7882:: with SMTP id
 t124mr8607565pgc.406.1644549228361; Thu, 10 Feb 2022 19:13:48 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:13:32 +0800
In-Reply-To: <xmqqpmnue3ig.fsf@gitster.g>
Message-Id: <kl6lr18adrj7.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220210044152.78352-9-chooglen@google.com>
 <xmqqpmnue3ig.fsf@gitster.g>
Subject: Re: [PATCH 8/8] submodule: fix bug and remove add_submodule_odb()
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> add_submodule_odb() is a hack - it adds a submodule's odb as an
>> alternate, allowing the submodule's objects to be read via
>> the_repository. Its last caller is submodule_has_commits(), which calls
>> add_submodule_odb() to prepare for check_has_commit(). This used to be
>> necessary because check_has_commit() used the_repository's odb, but this
>> is longer true as of 13a2f620b2 (submodule: pass repo to
>> check_has_commit(), 2021-10-08).
>
> Yes!  I wonder if we can do this much earlier in the series (or even
> an independent clean-up that the rest of the series depends on) and
> have it graduate earlier?

This patch is totally conflict-free and dependency-free with regard to
the rest of the series, so there's almost no overhead to sending this as
an independent clean up.

And since you seem interested in seeing this graduate early, I'll send
it out independently :)
