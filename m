Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA5C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994B22074D
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRCbjTwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgHGT2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGT2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 15:28:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85CEC061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 12:28:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z14so3392937ljm.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3XMxHnDi+2OyajF4cRM0si7AgT1UzkFdl/vSvhrPn8E=;
        b=IRCbjTwzk6YJHpECSQqqxI0tvgVIB3gBbs6KaIcBH0OtoqjyIoDGM0phvGGW4DMybP
         pNv/PIup1RLGZ3B0M5hdrKtm4Ggr6Vzap03pKJPKRUQi72dO4j5dAzRAY8h0C0Qi7KTH
         7hVZ3hE1iRE5SwVW8lryMDH5F1eMfKFs4A5Mp7JaxR7FSUvrQJxz+zBGBhXQ9YjO4lYp
         6TMtR9NIMf9zg9YjX6HINcCWxBndrkONZJ2lliw9qeTBBMCsQCPqjlaodKjcAq7jPih1
         5RPpvQiIxqQAG3/9W3r9YyOrEPbXtRFv6lOi0+BXdY3hBNJvsDDghvsgTKorPj9LstE6
         upsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=3XMxHnDi+2OyajF4cRM0si7AgT1UzkFdl/vSvhrPn8E=;
        b=FAiGUfDXRcdtxESgb98qd562DNKOavkmsx8nKkIXmToS30TzkGVW2FQeCChoUIVQFD
         TiQdH0DE4c3HT8cl7bmeoRi1TjoPyNQDKrpGSTK9tkp4Bx+TMrid7wGZVsSyp+bBqvNZ
         Q1iQHheJBSDVeJVqlcwVSKfjUC9Yc5869RtKcZM4IS0Iek8nicfWnbb/o8WuExN4nO4n
         xRYlSYOamtC9e5cvMIVMn+fwKkRH5scMhiwxhMY1AzsY3Qyd0y3YiqOu04l+CslTc5RY
         XMfkoabjAbJIPpWwTNx+BFiVweyUFLwFq21yjV11dzZmXiSJoOalu+6DZ9e1pqLHrxME
         8+PQ==
X-Gm-Message-State: AOAM5312ZI+pVL5Cats+A/XxekblgvGvFvhmEYpWNmAvABuQv2shZ5hg
        apdp2Gax8iKLZzbqYlWopI8=
X-Google-Smtp-Source: ABdhPJzPuG/PacVneCfW18Mj4b45O2cImJr9EgyYYofoi133CiOjkcTJJBWi0J0iM37esGGTfPobyA==
X-Received: by 2002:a2e:81cc:: with SMTP id s12mr6702093ljg.232.1596828502085;
        Fri, 07 Aug 2020 12:28:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y1sm4911110lfb.45.2020.08.07.12.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 12:28:21 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com> <878seuxdz8.fsf@osv.gnss.ru>
        <20200804221440.GC2022650@coredump.intra.peff.net>
        <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
        <20200807082643.GA34012@coredump.intra.peff.net>
        <xmqqlfiqgxn7.fsf@gitster.c.googlers.com> <87364ymji7.fsf@osv.gnss.ru>
        <xmqqh7tegu0m.fsf@gitster.c.googlers.com> <87tuxel17m.fsf@osv.gnss.ru>
        <20200807192001.GA1308960@coredump.intra.peff.net>
Date:   Fri, 07 Aug 2020 22:28:20 +0300
In-Reply-To: <20200807192001.GA1308960@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 7 Aug 2020 15:20:01 -0400")
Message-ID: <87imdul0h7.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Aug 07, 2020 at 10:12:29PM +0300, Sergey Organov wrote:
>
>> I thought it's just a -c, -cc, and -m in better wording. No any
>> matrix:
>> 
>> -c  = --diff-merges=combined
>> -cc = --diff-merges=dense
>> -m  = --diff-merges=split
>> 
>> Just separate mutually exclusive options assembled into one multi-value
>> option, so it's explicit they are mutually exclusive. I don't see any
>> matrix here.
>
> FWIW, those names make sense to me. Coupled with "none" or "off" for
> disabling all of them.

Thanks, we have "off" along with your --no-diff-merges in already
submitted patches, and I see no harm in adding "none" as synonym, as
Junio seems to prefer it over "off".

Thanks,
-- Sergey
