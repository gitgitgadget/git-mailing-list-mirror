Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BF5C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A02D221E2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrZ0iQEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHFUwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFUwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 16:52:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCE8C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 13:52:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z14so15719200ljm.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FovUeGQ79Znu1mKCaQVUPqZM14wqQjy9j8Nrh/lrb6c=;
        b=FrZ0iQEfECV6HiBCQqJHCCLSlbHR0YEKNCadTcymwzr5XK/UtkMybZKBAgyX9l7ONl
         fHY9hCEeVcwN9nG49YdIwa1btupAltmB4GJCIH0p6/etVN5yxn0EciLg1asW4k6kTNUB
         +f1EvNlk+tisMMIwR9CZsEea3q0KzO2tBNrgYulFNkVPf54TM1kc/wPNWnrkDItbSeox
         UkJYEdo8DsNlHfNK5ikTfXuEIaK0AGiEmiDxOZGrOjyLgFDESSUJY+aa06QSoHWG/m/0
         PbjKBEOhEUrSKYq4aISPqOPkrsR+nSgfd7knmYz4ugyU5NKjs7W+rfzK8B/2osau10Av
         m5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=FovUeGQ79Znu1mKCaQVUPqZM14wqQjy9j8Nrh/lrb6c=;
        b=oxYqR5unrio8TUiy6joKdhAhODpL+uYMQRiRLODfPBYl6OKvg55SVMvNOJzJiiajdu
         Zlo2r60s9QyNXvbCalfzNk8xvcM7QXvIDeY9UCXSlZzviDmz1iDb1BSoC0Tkwt9tGm4O
         tfACUvIeqIRPMjbUABtm2NYI+PmVdBUaCp1PoJRrlIZ+fKf46SN3I04lPik+eNo/O8R4
         BfVt5+NibL3Ru9l78x6p0il3DwG7cDkATxytC59FsJmtKQOfKgRafv5FWxnUEludwKDU
         H+trhhSMslDW/YbK0237nJ4T3mNPReIoxoKReunGSjaEKgBkBqp7CJm9qoPQ1MB9u7lh
         yPcw==
X-Gm-Message-State: AOAM532Yoh+LDxAmCCNqNUtWNJmyKdd0vT+uxJML2+kZYabxS7vznE45
        bVs03t2brX/mx8Tf/0IYBYg7rN7o
X-Google-Smtp-Source: ABdhPJw5TYUckUEPtuwEDXizADOQ2p2znhbE3gzblmMxo0QgHJbWrlLyemRhKp96hkCtXKxu1g2Pnw==
X-Received: by 2002:a2e:9550:: with SMTP id t16mr4416522ljh.372.1596747133533;
        Thu, 06 Aug 2020 13:52:13 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a24sm834297lji.36.2020.08.06.13.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 13:52:12 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  3/3] t/t4013: add test for --diff-merges=off
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-4-sorganov@gmail.com>
        <xmqq3650n2rc.fsf@gitster.c.googlers.com> <87lfisk915.fsf@osv.gnss.ru>
        <xmqqy2msllz0.fsf@gitster.c.googlers.com>
        <xmqqtuxglksy.fsf@gitster.c.googlers.com> <87ft90uq8w.fsf@osv.gnss.ru>
        <xmqqmu37lmym.fsf@gitster.c.googlers.com>
Date:   Thu, 06 Aug 2020 23:52:11 +0300
In-Reply-To: <xmqqmu37lmym.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 06 Aug 2020 10:10:25 -0700")
Message-ID: <875z9v7b0k.fsf@osv.gnss.ru>
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
>> I asked because I thought you see some essential difference between two
>> tests, as you didn't suggest to add similar permutation test to the
>> original. I think this reply resolves my doubt.
>
> Yeah, I didn't explain this very well.
>

> The thing is that the way "--first-parent" interacts with other
> options that countermand "--diff-merges" (i.e. "--no-diff-merges"
> and "--diff-merges=off") needs to be highlighted with extra clarity,
> simply because "--first-parent" is different from a simple
> "combination" of "follow the first parent commit chain while
> traversing" and "--diff-merges" [*1*]

[...]

Thanks a lot for thorough explanations, Junio! I appreciate it and will
re-read them more carefully, in the morning.

For now, can we leave these patches as-is and then add additional tests
on top, please? I'm afraid that adding them now will force me to rewrite
current descriptions, as the result won't be minimal anymore, and I
feel uneasy about writing commit messages for these permuted tests
anyway.

Thanks,
-- Sergey
