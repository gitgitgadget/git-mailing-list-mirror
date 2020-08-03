Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFD2C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 21:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1782A22BF3
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 21:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+dKkM1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHCVTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCVTA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 17:19:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B20FC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 14:19:00 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 140so21216867lfi.5
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EqDlD1FrQqbf2GAlWVompwjVXgJVX3yMG4TwiUMWayA=;
        b=V+dKkM1bJETxe1yNBoEsSUDw6gMjX1sV41igX8auyCe2VpgHvoMxb+YltWhLlR4qJb
         g7YOl7a6yJ4tX5712dzpRlWMBo329BiO/PXqpF41+mrwd0ZgsoagH5Sl8BQE9c0OSnaG
         7CW6xrp9IiE+JGHY3XZtnJuqKtEJAKMxnISnXEefpnCXBv+3J1RorzVP6SzffhgojFIf
         BaywbnCFPYiKc0T/DwCxzO4ScJeFJVf3ytLhHklS/1ujlcigEtIRKqs2WTZoQGkdbq8r
         JhiDUHnSRww//Je2mH+eEYgxvyO3CoolXhpDoF7f6CTOYzvhkYST35FGdMpyDNsCdqLn
         8BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=EqDlD1FrQqbf2GAlWVompwjVXgJVX3yMG4TwiUMWayA=;
        b=ZPYjUUy4bynzmWBXr0kop6TI6FTBLp+/QynBHxSu4TwAHbrpt9pUpm9UqDUhW+Bwtg
         8cTu1hqALDcMKP34FG+YuIzZFFJCIOB3fRLQA2HMW/XUuiO40Jnqk9n1eQdVlOV4rVQi
         x/dxJ53X1p1ScD2YkMAKZTZgucoZY8CcizEloynQ2uucwGFWQUwnA/csSLMRT3V1/6TF
         ndh2F2LCeHvhK3GPO285I/klUOuA4GzXeyZZnh8u27LsmZZhQvfgdbHpNMgrOKTRMqqB
         j0AjKrx/g8LQJgnLCEz6+0MvfkIb6yAcjzpF++OHIfqYioegszwjsWEcsJppNW3ugS9G
         FUng==
X-Gm-Message-State: AOAM530xQS5jsP9cffFVQMZbn5XpRhHTo6jWxYE5kK/pE4LC9wUzEexv
        L2TX7Nz2leZzUsVqJi17vj+w6xmD
X-Google-Smtp-Source: ABdhPJy+thPIp7nAGeW1SsrYd48orQnABaCqFh/1fthiW4mwtlfyXt1AFgK4aWSRIaeFAm84F/M86g==
X-Received: by 2002:a19:848d:: with SMTP id g135mr9373264lfd.1.1596489538787;
        Mon, 03 Aug 2020 14:18:58 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o16sm4654260ljc.66.2020.08.03.14.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:18:57 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <871rknsdo4.fsf@osv.gnss.ru>
        <20200803205532.GC2715275@coredump.intra.peff.net>
Date:   Tue, 04 Aug 2020 00:18:56 +0300
In-Reply-To: <20200803205532.GC2715275@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 3 Aug 2020 16:55:32 -0400")
Message-ID: <87lfivqvgf.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 03, 2020 at 11:00:11PM +0300, Sergey Organov wrote:
>
>> > It's too late for "-m" to change semantics (we could do a long
>> > deprecation, but I don't see much point in doing so).
>> 
>> I thought not of changing semantics of -m. Suppose we introduce
>> 
>>   --diff-merges=(none|<parent-number>|c|cc|all)
>> 
>> before your patch(es). Then your patch would read: "making --first-parent
>> imply --diff-merges=1" and it'd miss that --[no-]diff-merges part, no?
>
> Sure, that would be OK with me. You'd have --diff-merges=none to get
> the current behavior, and probably make --no-diff-merges an alias for
> that.

Yes, keeping --no-diff-merges as an alias might make sense, especially
if it's on top of yours.

>
>> > But --diff-merges is definitely still changeable until we release
>> > v2.29. My resistance was mostly that I didn't want to complicate my
>> > series by adding new elements. But we could do something on top.
>> 
>> Can't we do yours on top instead? I'd expect it'd then be even simpler.
>
> Mine is in 'next', so there is no rebuilding it on top of anything else
> without a revert. But I don't see any particular reason to do that
> versus just changing the behavior on top. What's in 'next' is generally
> not rewound, but the behaviors are not cemented with respect to
> backwards compatibility.

Ah, now I see, thanks!

-- Sergey
