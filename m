Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8698BC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 03:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B146613B6
	for <git@archiver.kernel.org>; Tue, 11 May 2021 03:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhEKDS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 23:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEKDS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 23:18:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27E0C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 20:17:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z6so18583487wrm.4
        for <git@vger.kernel.org>; Mon, 10 May 2021 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=u8J3fGO9MsyUxDHnrabGGF9RTjIcTizXo/w/MkEOIFU=;
        b=pgLqjUu0ukxCiD1uYENIbfJHPg4Cwn4iZ7bd/F06Z4jrVGXwuRSrByGREKSKNr5Jvk
         VYjk4Bpv+S6ou1uUMSRywAUIkQXnOTMUpB064WzmjZAJa0sE3vV1CBGxtNNmBYm+xpqw
         fcikTvHGf7GZzslpkLq6Y7pr0IyxyWN9k4J/u/3u3D8hR1IJzsdtLAmry+rr0wxkD1SD
         6FGU+XSlc75gMubVDfvhGxHrNgAtAJNPzFvKOCbxbYGpqG/TUeRhudqbZ5rbxHuUQ/0Y
         wz3iPwNWLEiWatvtVosA0gJhxLXQps1kqaD0mhl8PI56PnVaivld7OX/rNnn5slEhqvL
         dQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=u8J3fGO9MsyUxDHnrabGGF9RTjIcTizXo/w/MkEOIFU=;
        b=DB8S2mQaQdE+foLjSTIXjyLgmGkPW33AUgNN0QBP1ynt4PiBXfTN/G9d0r5jb/wCVE
         1UFNn9gnCdPhzTXSJAzauzSBZROrujb7HT4o6Q1f9Tmo0g/KUSGVYt7T85kWFbicqvSo
         4Xmv5ahQBCTKFGjHwUtLYZbHYFiTVlr23HtwLYLgRYEZIr3sPdGmdyEnjC3FWiKcpAuc
         1jvc+r9Uhr9hCD5sXGlTmg27TjDJFQFadio3AMbd0sAp2BRGSrRvefNNV5/qkEw8v0Oi
         cntdlJQ6SXFYASbG0hu06RjEkEy40RfoHFbrauUvBO0Sk9JCZM3faHOZ0PZ+16mpNCnY
         zJ2Q==
X-Gm-Message-State: AOAM532vXRVv/MRvnf7j10iwxbrg3LLlyRSvfG07n7/BR0f3zIUXwIPE
        6ZU/Jm1I5gDaURagH09M3Iw=
X-Google-Smtp-Source: ABdhPJw7s5A4dsNoHgjD7iItUppbCXxJibXBsRKrm0pcsXYT/O2PsX2dwHMthYwzP9+2zAIhu7d+wA==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr33266253wrt.136.1620703041486;
        Mon, 10 May 2021 20:17:21 -0700 (PDT)
Received: from Inspiron (2a01cb04010c4200a87bd4460637fee8.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:a87b:d446:637:fee8])
        by smtp.gmail.com with ESMTPSA id s18sm26119699wro.95.2021.05.10.20.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 20:17:20 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 2/8] format-patch: confirmation whenever patches exist
In-Reply-To: <xmqq8s4nqc0u.fsf@gitster.g>
References: <878s4ngta2.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
 <xmqq8s4nqc0u.fsf@gitster.g>
Date:   Tue, 11 May 2021 05:17:19 +0200
Message-ID: <87pmxyez7k.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Firmin Martin <firminmartin24@gmail.com> writes:
>
>>> True.  But if we require confirmation before overwriting patches,
>>> that would be overall worsening the end-user experience, I am
>>> afraid.  In a 5-patch series with a cover-letter that was formatted,
>>> proofread, corrected with "rebase -i" and then re-formatted, unless
>>> you rephrased the titles of the patches, you'd get prompted once for
>>> the cover letter (which *IS* valuable) and five-times for patches
>>> (which is annoying).
>> This is true for this patch, but the semantics changed after the patch
>> #3. I really should have squashed them together to not create
>> confusion. Sorry about that.
>
> No, please keep them separate.  What we can do to avoid confusion
> like I showed is to make a note on the earlier one, saying "with
> this the user experience looks like this, which may be suboptimal
> for such and such reasons, but in a later step it will be improved
> in this and that way".

Ok, it's noted.
