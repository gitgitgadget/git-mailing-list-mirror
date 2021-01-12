Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F371AC43381
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23F923122
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438157AbhALVh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437113AbhALVIG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 16:08:06 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31891C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 13:07:26 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 19so3232615qkm.8
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 13:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=57KmgMQsyTSzqwudZ2jwxQdPLqIxJ7MaS3SLHy6LgtY=;
        b=QMlZmE93odTEKQV0W+LravnepHNv9Tj3e5XOwg7ZqZtHj/qVP5Q75+jzzlgVlr/hJL
         wDfxz+g4c0x0yI6KbuI06McuM2DHIJtXwMU/uE9FKZ55W1Nr/1h+wPf9TKbauDxw+7r0
         CtST8jA/30h/DnZaDm/u4RJ2qRvk6jxOVuniMDTB7vbQfB2rDjAsqFzdwNp8qqRrZufB
         pSh7Q8uB4bznPGEoJl2IWihcs/dpkIcKSB0b4h+xd53pVPDPf3tVk06xR1j/KTnLAbS4
         zdAWKm0GsB1nwvsIM0lj8mQy93iaGg67/nz3fCwUivNeHubFCTnXdVldWmDByQba9uVA
         lEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=57KmgMQsyTSzqwudZ2jwxQdPLqIxJ7MaS3SLHy6LgtY=;
        b=jIUGLpm93WFxC+P2QrMFK93hffs6EV7P1tUh58d3mI53nePX1+JfR5QL2Eiri81Srn
         WEC1ar185MzoEOpMWbDN6HCtuN2/xltj+GOY7CGkIyht0TVzFIFA503JWZBBfHww8bFu
         NfFBoetwHIjzZ5bA2ehagjZuqCl9nhpQnAp5PTW5v7QdmdJspwL4BHIcHJZBNcTDfOKQ
         SLipMYUokALqE8YalzQtMhLw11nEkz2IOI5oApVSeGcTurO6pDEaPwGpnajO6JHReIq9
         yllU5VUFDi/+Q5MI3l30GJKtEIlYMbLmnmslvAAZEO1LCxXGYEJ2iFXHbID2rcWKBKLb
         dkdA==
X-Gm-Message-State: AOAM531fnRLHIET0CGZK9Y9BXjKwgj6EA7uZyIxMGqnCeTKeFLdvDPGx
        RKd0Ve8yPKsBMEHubmZoci4jLw==
X-Google-Smtp-Source: ABdhPJxNDf6XM81TSW+oCKt7YIOrvTzaVii10Ww1rc9gsCAaYDBfw9ZxAfL3BjzwV7FZ11iGoR3gMw==
X-Received: by 2002:ae9:ef88:: with SMTP id d130mr1464773qkg.92.1610485645430;
        Tue, 12 Jan 2021 13:07:25 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id q185sm2024490qka.96.2021.01.12.13.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 13:07:24 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:07:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH] refs: Always pass old object name to reftx hook
Message-ID: <X/4Pin4Zdf58n1jc@nand.local>
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
 <X8n1Qf7TJyqIOE/l@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8n1Qf7TJyqIOE/l@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 09:37:21AM +0100, Patrick Steinhardt wrote:
> Quick ping on this patch. Is there any interest or shall I just drop it?

Apologies for completely dropping this from inbox. I am interested in
it, and the patch looks good to me. I suspect the reason that this never
got queued was that nobody reviewed it.

Would you consider resubmitting this patch if you are still interested
in pushing it forwards?


Thanks,
Taylor
