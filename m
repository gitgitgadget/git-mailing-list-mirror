Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3994EC433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 14:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA966117A
	for <git@archiver.kernel.org>; Tue,  4 May 2021 14:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhEDOTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 10:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhEDOTy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 10:19:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935EC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 07:18:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s25so11396415lji.0
        for <git@vger.kernel.org>; Tue, 04 May 2021 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=006jv1iPTdf/4kj3hNCkrPDOyXzDoa3aWVbuTywcbac=;
        b=LXvqX85HmnpEPJv8ev158f3UVV8VRYsX/uoeYJDjELc5F4Gq8sFPGg7vCT9AJX2nQC
         N7boD44o+q9dDj8CzndMx3v/Eswomf1d0tbuvoUVKNsyNfa7+JFpZCKb4sAs5DskIt1l
         TKXKVrPNZvAqSMyXvimFQN627fnpl92yjWyE+cI2Jp7rpElrNrK8kfjhGudskairwk+/
         lwKpHcC4aTFksHojjpjVofYme68R0P9sK+Wm/KkKbDw9q3KcWdtHCwH5iOWCxwk6Gai7
         FOTdsFO1GIi1ckAP5kYqrlhR+16/FrPqkOJTU1nV1jkEPPrmV7SrMxHXvucMptDJ2n8L
         +9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=006jv1iPTdf/4kj3hNCkrPDOyXzDoa3aWVbuTywcbac=;
        b=R3x2oUqJCdPUQGIczLcXkWtUbKi++gH8kRYM/vbCb3m60VnngVk9ZfjYcq8K7ZOWFt
         ICSntTP0IvJ8TVW/8lG1rOVl1Gpsfxxc/lVipeqr0jQNWtE9ICM8NNjBDXRR3PRoYHgs
         rNrFim7ntQsl4YUxI3Ww20lHdaDWquhFeikRxrNosxdIaqI18hEeVfY6zF95Yh/wK52L
         JXyB73sIZrB8fPI72MUwpBeXyajyw8MTb1C4c7IUFDHVmqidQKyKPgQvulA66AOsKpqV
         k2nDhCIi4B2FPcxoWJzaor4yIuG/ypbbaG59duNG5jwzqTih8k3fyDRj4R71aFbuP+7G
         2JQw==
X-Gm-Message-State: AOAM532Ka14J62mm+aSirL4PVybiIHj/LjxkRfWWMptfg4/eiTcb88B5
        j/lVFgNmR1GFIElE8XITlwIIDgiI268=
X-Google-Smtp-Source: ABdhPJz7a1ZwPGUzR/gmSXqjC60Ci971I6mE9NtHw5G/Lg64qnDWD+uZlLh9LPS5cxe+9Db0ovDMdw==
X-Received: by 2002:a2e:a795:: with SMTP id c21mr18460760ljf.353.1620137938037;
        Tue, 04 May 2021 07:18:58 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f36sm276285lfv.248.2021.05.04.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:18:57 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
        <87v9837tzm.fsf@osv.gnss.ru> <xmqqzgxfb80r.fsf@gitster.g>
        <87czu7u32v.fsf@osv.gnss.ru> <xmqqtunj70zy.fsf@gitster.g>
        <87eeemhnj4.fsf@osv.gnss.ru> <xmqqbl9q7jxf.fsf@gitster.g>
Date:   Tue, 04 May 2021 17:18:56 +0300
In-Reply-To: <xmqqbl9q7jxf.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        04 May 2021 21:38:52 +0900")
Message-ID: <87r1imbmzz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> That said, what do we decide about -m to finally join -c/--cc party and
>> start to imply -p? Last time we've discussed it, we decided that -m has
>> been simply overlooked when -c/--cc started to imply -p. Should we
>> finally fix this?
>
> I thought I already said this, but in case I didn't, I think
> "--diff-merges=separate" should imply "some kind of diff", and not
> necessarily "-p".

Is this a more polite way to say "no"? If not, how is it relevant for
-m, now being a synonym for --diff-merges=on?

As for particular idea, I'll repeat myself as well and say that I'm
still against implying anything by any off --diff-merges, and even more
against implying something that affects non-merge commits. --diff-merges
are not convenience options that need to be short yet give specific
functionality, so there is no place for additional implications.

That said, I think that something like your idea could be fine if we
introduce another convenience option, say, -d, that will imply both
--diff-merges=separate and "some kind of diff" (whatever the latter
actually means, I'm not sure yet.) But then again, why don't just reuse
-m that, as we've decided before, is not that useful in its current
state anyway?

I must admit that I don't entirely understand your idea above yet. Maybe
you could provide a draft of manual entry for proposed behavior of
--diff-merges=separate, for better understanding? For convenience, right
now it reads:

   --diff-merges=separate
       This makes merge commits show the full diff with respect to
       each of the parents. Separate log entry and diff is generated
       for each parent.

Thanks,

-- Sergey Organov
