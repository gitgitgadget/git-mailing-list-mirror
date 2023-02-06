Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E9C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBFWfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBFWfa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:35:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C593B1716B
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:35:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so16694392pjq.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/MUKGqKTScUYWVefoEqes/B4wD32s2OP9InJS+CBfQ=;
        b=TuMpAzNfNSO2YIZ+uHRcoToN4QBcEbKWuj1QYD1eaECH2VkRUab8flKMFaya0Xcwzp
         eaQlwE5VyT6lttSfwmMDhqD0PAH3yOZwRgOghlSfxC4tQfKAw8NUaR5QtA7MTYsv/J2D
         BUJCT5Mo9Hd/osHvNNB32iyS7tM3BymQh8GCKBP2Nt2NgGhio1j+bsRPGZl4+aYqfjVS
         lbt8OhmU26TrS9eLQIqjGVnuryw/ouQlpSAGhN58Usum0YmvDQ3DpdSYHwZg4UZuRei0
         P/3QBNaofXLkWeOtbeDgnzhh0MvCIHFdIBgPcXA2SKE+TRtPKtQYmfhiaiYF+k42Sbue
         MMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/MUKGqKTScUYWVefoEqes/B4wD32s2OP9InJS+CBfQ=;
        b=zyuBpXKxAIgIUl1QMYECWD0/ZfJq5U/crCQ1Pgh2iX17llGWx9izETo1j3dYrQJ1iN
         mRgd55oaVOAl/JSDzigc6q+9B/7InYpYyhwl9uSPZ3Lz4jpx2e/CoO9e6epkxN9Dt2+m
         QIZ00SeNeVX43PSg5tkUOZ/DbO7Bw8hZ9DllrbVEX8OlDNdZH/VaTCoQUnYLYEvkYiCF
         6xm+lmu7tQ/0baiOXVjYayTnoq29JAQSTorJusE+kgNbiFY2HT+QWfNPCdQ/iQqcKNyj
         CL1cTS/irIQ3xyqKFxuakAllQQS7Q86na4I6PSfvHVeGT+Me4EgMZb9MvJjRDo5ZFH42
         YSKA==
X-Gm-Message-State: AO0yUKX/D+j7xL/SpsbX2I8kpvDu9kZ4PjX4pVple1sC2/XmeL1XNKOW
        3e16nWDUf6aN/5QE5LNNKDA=
X-Google-Smtp-Source: AK7set84LSO8L07lLrquFHzedfX1Rc1k7ljU/OrASso3QBnWT0jH/cQUesBFZaEn8TWNb4lIELuRYA==
X-Received: by 2002:a05:6a20:a01e:b0:bc:78fb:35c with SMTP id p30-20020a056a20a01e00b000bc78fb035cmr792895pzj.43.1675722928244;
        Mon, 06 Feb 2023 14:35:28 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id r5-20020a62e405000000b005815217e665sm7659715pfh.65.2023.02.06.14.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:35:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pack-objects: use strcspn(3) in name_cmp_len()
References: <7315487c-c97c-b8a2-d3b2-4fbf642495dd@web.de>
        <230205.86357j95wj.gmgdl@evledraar.gmail.com>
Date:   Mon, 06 Feb 2023 14:35:27 -0800
In-Reply-To: <230205.86357j95wj.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 05 Feb 2023 21:59:10 +0100")
Message-ID: <xmqqr0v22zio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I wonder if this name_cmp_len() is worth keeping at all. If all we're
> doing is wrapping strcspn() (which b.t.w, seem to be less "open-coding"
> and just that it wasn't known to the original author in 5d4a6003354
> (Make git-pack-objects a builtin, 2006-08-03)), then just inlining that
> in the two name_cmp_len() invocations would be better, or maybe:

Even if the stop candidate bytes were a constant, or if there were
only a single callsite, I am not sure if it is a good idea, simply
because with this

> 	strcspn(..., object_reject);

or with a literal "\n/" to make it easier to see where in the string
we are stopping, it is hard without named function to tell what
length we are computing.

The function being file-scope static, decent compilers hopefully
would inline the calls by two callers.
