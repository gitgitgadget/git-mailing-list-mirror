Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA8C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D718A6103D
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbhKHXYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240934AbhKHXYM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 18:24:12 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D434AC061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 15:21:27 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b13so17446865plg.2
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 15:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AAIdfzvGT+JCGUzXtPwR0iCtElMTqwUm/9ha06YyAQo=;
        b=lGaBZbmNkwvAIVrIEgYRFSz//4Z1Z8v0gCDXAWpK/535tno2eQY5/xJVQ+a63F260a
         vwxDf/sMVnCCM8M308B43L6gJnfTx98PbE9Md9V62LesBXFjdFjMBz+YCfaVNnVpC4jV
         rCXfep8ZSWipAc5rv2fFundee2ZlSyps3mZHtKZyHsXUMPoo6zvAa/UuLhiJoNec2NBA
         /keIfPVUYZBJJQMiQ0mdWWkcTBekLZguM5nSStzXAeFs7IxxAW5Pujs++woGVwAcg6mQ
         EngdhFfwtgjjl2pn8XBg6qtFPe7mJUZCY0SPjNxH+l3sXI57aU8+0WARqj5jdeZrt9s3
         6Q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AAIdfzvGT+JCGUzXtPwR0iCtElMTqwUm/9ha06YyAQo=;
        b=kF5iuT7zUJvwz4shimQkJs4T48kvhcEa6JBU4kmj5Tr7vC/2hKNrVjLnP8XlYOSc/s
         vslFLKVirJ0GvbfB3CFEvipxvgeWaDqsONOIPCChT0E0BCB5LOrpUusIyx0jlISvFfyf
         StET5W1M0sSlu3eHB6lGyGHbohxAWn3QAtV0Fs1f2ksJpxUyfi4ZkHCPKZ7eGM0UcjJj
         5ulYdzESijFaPoYXOI5rSiMZ7Iu8dWz2i78x5/xnSUl/MqhG6QfuqCCfWAHHn2FY/2fy
         vumpQZs7t7/B37cvCWTXIQrflJZN95spktfwJXnAcwZnTRnGEDYzKO3HhlydLyk34zkM
         fAQA==
X-Gm-Message-State: AOAM530DQtbayY66KEyVuB+PaP6+mhwP+KST85gyCYo/g2HJsDl0GR1b
        tg3iGct81jfMyDuWerwJ67hSQJNyW27NUw==
X-Google-Smtp-Source: ABdhPJyH7lN9KGHEIhHPjHGi+7aP2GtOQvxWNYrFapnpC+BtIeC7lrqwVnpG/Jnfa5LxE5LLUJQ83w==
X-Received: by 2002:a17:90b:4f42:: with SMTP id pj2mr2239316pjb.7.1636413686932;
        Mon, 08 Nov 2021 15:21:26 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:f405:d461:2b86:9d34])
        by smtp.gmail.com with ESMTPSA id y184sm10430401pfg.175.2021.11.08.15.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 15:21:26 -0800 (PST)
Date:   Mon, 8 Nov 2021 15:21:22 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 4/4] submodule: record superproject gitdir during
 'update'
Message-ID: <YYmw8vEyFnQpe58z@google.com>
References: <20211104234942.3473650-1-emilyshaffer@google.com>
 <20211104234942.3473650-5-emilyshaffer@google.com>
 <xmqqzgqjxl4e.fsf@gitster.g>
 <211105.861r3vhtot.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211105.861r3vhtot.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 09:43:56AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Nov 04 2021, Junio C Hamano wrote:
> 
> > Emily Shaffer <emilyshaffer@google.com> writes:
> >
> >> A recorded hint path to the superproject's gitdir might be added during
> >> 'git submodule add', but in some cases - like submodules which were
> >> created before 'git submodule add' learned to record that info - it might
> >> be useful to update the hint. Let's do it during 'git submodule
> >> update', when we already have a handle to the superproject while calling
> >> operations on the submodules.
> >
> > We are hearing repeated mention of "cache" and "hint".  Do we ever
> > invalidate it, or if we have such a record, do we blindly trust it
> > and use it without verifying if it is still fresh?
> >
> > Also, this step and the previous step both say we record gitdir on
> > their title, but we instead record common dir.  Whichever is the
> > right choice to record, let's be consistent.
> 
> I had similar (AFAICT still unaddressed) feedback on the v2[1]. I'd lost
> track of this series, and see one reason is that the In-Reply-Chain was
> broken between v3..v4.
> 
> I.e. it seems to me that this whole thing started as a way to avoid
> shellscript overhead by calling git-rev-parse from git-submodule.sh, but
> now that the relevant bits are moved to C we could just call some
> slightly adjusted code in setup.c.

No, that is not the case. It is the case that `git -C .. rev-parse
--git-dir` is *very* expensive in the case where `../` is not, in fact,
a gitdir; when I attempted another series which relied on finding the
parent superproject's gitdir in this way, our testsuite took something
like 5x longer to run than before. In other words, the expensive part is
not the shelling out overhead - the expensive part is searching up the
entire filesystem directory structure in the worst-case ("we are not a
submodule") scenario. This is still needed, even with 'git-submodule.sh'
moving to C.

> 
> Maybe I'm entirely wrong, but I think if I am that this series has a
> commit message gap between the "hint" and "cache" and this really *does*
> need to be written at clone/init/update time in some way that I've
> missed.
> 
> Otherwise I still don't really get it, sorry. I.e. maybe the relevant
> code in setup.c really does need caching, or maybe it doesn't anymore,
> and this cache-via-config is a hold-over from when figuring out the
> parent repo implied needing to shell out somewhere for every operation.
> 
> 1. https://lore.kernel.org/git/87r1cnfkqx.fsf@evledraar.gmail.com/
