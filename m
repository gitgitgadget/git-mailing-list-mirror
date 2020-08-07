Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46C9C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FDA2224D
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU7C4B3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHGU35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGU35 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 16:29:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83DCC061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 13:29:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m22so3451083ljj.5
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 13:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ckk0HdkqEvMYHgdCh96jAvJArKqatYdf4Xvd6gLQXns=;
        b=BU7C4B3bYC01Y8FO3LT5yfGF/P6Vvhjr7nW0WI14qIpp++rL/Yprl4cvVZnggFQqlj
         c44edExB+GDhnWxbe7enQBVnOdJQvxeIWV1I8WcObAs8CZO14MfrmnuBkjlW3P4auny8
         +RZoea4MqR1FpLK9Cu4K6fKTrljLhA6WvPqYK3BnkV3ypu4OT99aJXN214E39psSURhz
         NafA+BPXr0RaLgeXjIHbQrnx2iiB2jTMWBiFMC2PFpU7wpXuSPZyVwbM05Bezk60UUD+
         Qf3yExwQcgZJbFgdLI8hGTzzQTGTQWGFw3hYN26ifXfwKtp1otY5nwMFtf8kCPhPj1AH
         Kq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Ckk0HdkqEvMYHgdCh96jAvJArKqatYdf4Xvd6gLQXns=;
        b=DIbhdUHRmDJFeheRqo3FCCRR6KalZ/1PGU2N3Svf0UaWioezbLT6ikSfWJEES0U8YY
         9o5VE0gMjkN+E8e9s3nzV8AP9AK+LCrRlPDnfGNvoa+mLOl/ztNvyDf8zA7vdhelRGw0
         VfVA3f4LJIGujigkfo2mi4P7swCmfzz8oZRBjxw5S9yIrvVEnrEu7+R3giYmM6VFT6Mm
         FFlDOXdMqgZBO/rP+mcSpHeoB4Gb4ZEHmFif4hZ3bdxWCKHayQ3vP8U6zbxoYuAjmdWi
         56zSm2NjMxWi0GW3DKH5JScZwRoQnWw+ase/Cbvl5N6fAmQpDzo7+sn5eh236vEq1FJY
         htcQ==
X-Gm-Message-State: AOAM533jhn9sXAjFzLZHGJjqWh+AL3mkR9iB+GKotYSEMt9ejui2t6KR
        x21jRHiCuE3dE3JTolBdcASbrH2h
X-Google-Smtp-Source: ABdhPJyn/DksdLzQwuITyu7yKPyHo0mvv2PFO7buKSCKc73MDRS8t3Aj+cvTu2BCdd2NZm16ulhGdQ==
X-Received: by 2002:a05:651c:1349:: with SMTP id j9mr6788271ljb.392.1596832195335;
        Fri, 07 Aug 2020 13:29:55 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n29sm5018697lfi.9.2020.08.07.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:29:54 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com> <878seuxdz8.fsf@osv.gnss.ru>
        <20200804221440.GC2022650@coredump.intra.peff.net>
        <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
        <20200807082643.GA34012@coredump.intra.peff.net>
        <xmqqlfiqgxn7.fsf@gitster.c.googlers.com> <87364ymji7.fsf@osv.gnss.ru>
        <xmqqh7tegu0m.fsf@gitster.c.googlers.com> <87tuxel17m.fsf@osv.gnss.ru>
        <xmqq8seqgrx3.fsf@gitster.c.googlers.com>
Date:   Fri, 07 Aug 2020 23:29:53 +0300
In-Reply-To: <xmqq8seqgrx3.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 07 Aug 2020 12:46:48 -0700")
Message-ID: <87a6z6kxmm.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>>> So, does
>>>>
>>>> --diff-merges=(off,none|comb|dense,dense-comb,comb-dense|sep,split)
>>>>
>>>> make sense as covering all the current features?
>>>
>>> If we are primarily interested in theoretical completeness, it may.
>>> If we are interested more in practical usefulness, I am not sure if
>>> such a "full flexibility" matrix is a good way to present the
>>> feature to the end-users.
>>
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
> Oh, matrix comes from specifying the set of parents in a separate
> parameter.  If we are not doing that, then you cannot even express
> "when showing a merge, compare only with the first parent", no?
>
> And when you add --diff-parents=1 (i.e. diff with first-parent), you
> are opening the interface up so that it can express dubious
> combinations like --diff-merges=dense-combined --diff-parents=1,3
> (i.e. --cc but exclude the second parent as one of the preimages).

I had no intention to introduce --diff-parents, at least for now, and
maybe never. What I said about it was theoretical discussion rather than
actual proposal.

If we agree on the above, I intended to instead propose something like:

--diff-merges=first-parent or just =first

for a start.

Thanks,
-- Sergey
