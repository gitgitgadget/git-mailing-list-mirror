Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804AFC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53996207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGEb08+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHCQlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCQlE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 12:41:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C955BC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 09:41:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w25so4916228ljo.12
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FSO+c+qU3XE6ZrUeFYDmIGCl0uFuSjMQABfwGB635L8=;
        b=DGEb08+upabQ5hT9DBnV+kQVxO4QU5TGn9axOP8i8ZNcbWiIU372uKoRg2j72JLgi6
         QXTahSmj1ALoTMqaimQ3KusFlWbWxH48rNe0ySo5EIMUBlewNrAQyEdjyHjsFYASOcLJ
         TpL/ZxI+T4eslj/xwUfmeABGWI44nTxMwKDWJT0rb4H1B2GUbwV1gytcaLjBAgnqOKeM
         ADQP7Ii/nAVZIFCtYXrVcAFsapjbqV/tlTjravDqyypyCFCjv7pPHLJRdT8YrXHdqPyE
         JRhkmnv4Hvsti8JPzTTSFNHPlR4Q9qVURO72+V3nByUPnacvN5eiu4W0JjGqpO0Bmn6+
         TqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=FSO+c+qU3XE6ZrUeFYDmIGCl0uFuSjMQABfwGB635L8=;
        b=jFMVQSPDpwWsQuh/7+qo6xjXrON/IZFHE5wkjbEatM3Oj3w2//lGpf3M0BIvS2YIR9
         sRvzdCWT4U+ofz+tZD3c970tt7GScxSTeRZb/5F4khpLPVF6shn5vbk9iVRjfu4smhSe
         /dnTG26eoWkxq4woGd6QdiEeFQEjY1c7EtEQ4fVz1ucMeS5Acv685qssJ9ulMNwfO/CO
         LB9FLaPtK7bKn7cBrdUMIGzVeHx9icoyxdckFmpsCwgQhKLZPqi4aCf4TOm4PsV3A1YG
         LQTuUSfw0CUDKbCN6reqOAZtAqozwXRm21ZJ5kimPyMMKfU2Qt3FhtAzsv0Tv2l0E3XF
         k7WA==
X-Gm-Message-State: AOAM533hQ1CLHM6+33QMp4QNMdS+pZytfwG55dhunTf+Fu29uWm9zSuv
        k6RaNh7key72TXrV74hBNuM=
X-Google-Smtp-Source: ABdhPJy46nlWPPzHC42IyJ78sryH6Dp9cKFn9ez7I7m/qDFLcDl+n4AfUywO4f/MBTxOyDjjMhsOtw==
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr8224578ljj.199.1596472862329;
        Mon, 03 Aug 2020 09:41:02 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 9sm5035798lff.82.2020.08.03.09.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:41:01 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru> <xmqqd047wuuh.fsf@gitster.c.googlers.com>
Date:   Mon, 03 Aug 2020 19:41:00 +0300
In-Reply-To: <xmqqd047wuuh.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 03 Aug 2020 09:35:34 -0700")
Message-ID: <87pn87smw3.fsf@osv.gnss.ru>
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
>> Sounds great, I only hoped we can do it right now, with this new
>> --diff-merges option, maybe as a pre-requisite to the patches in
>> question, but Jeff said it's too late, dunno why.
>
> A follow-up patch or two to remove the "--diff-merges" option and
> add the "--diff-parents=(none|<number>|c|cc|all)" option on top of
> the jk/log-fp-implies-m topic BEFORE it graduates to 'master' is a
> possibility.
>
> But is it worth the delay?  I dunno.

I don't think it's worth the delay, provided yet another new
--diff-parents is to be implemented rather that using --diff-merges for
that.

-- Sergey
