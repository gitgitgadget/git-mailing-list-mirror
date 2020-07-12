Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF2DC433DF
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 23:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727FC206B6
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 23:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="LArckHLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgGLX06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 19:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgGLX05 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 19:26:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D9BC061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 16:26:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id md7so5246162pjb.1
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 16:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=GkXDGrTIbk4fjzB2/3ekudYGBEeso5yL5TC2AeoRZzg=;
        b=LArckHLm3ycjJeG1HdAM7Mba+B0R4Rqjmv5zd5M9VuPYnXLqy/IBy0cz+VLR0gewe2
         QoWi4T5k7tejqM07ffYlOP7KdCcY+mFRSEaSrjwuB7f1KhXEuSnlFO27ppwOLeyP4g1R
         Fq8YeXrQdos9EwA72/11AbWF+vFVpxN0X1uzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=GkXDGrTIbk4fjzB2/3ekudYGBEeso5yL5TC2AeoRZzg=;
        b=UL3qf49gu7EXLEi/O6d+xbvMOKdPZzoeqLIOg8+L0OsXu3r2WSxjlU2uidtODNFqRq
         bsax77B59CviCK9KoHySeTU7zRS9E8kcRyU5U4HUEurK4HR9eBbE3wfPt787pM63N+yF
         pIbHW3IupQHr6SjFkswRZnMT7cQc5bAvv9mFqK6u7G6Q1l/NQcYmKpeTXc705TiXp1YV
         UpePX99LffqFFThuDGUzESup4cXe4LPtV0XhlukmPKKem8jau0Lw95CCx/cBql2iFupk
         7dtHZgb44n2C8uOqgVcovFzfxhZZOMo2ay0Uqt/+e0RV7ZbxE+uQlQXij63u5saFH+IX
         F1rA==
X-Gm-Message-State: AOAM5327Gs6wHccrh1U25P5y4m8+/ZJhDNK+IoYt+jwzOILntV26bYdJ
        LE8n2Nlu34cmtp4M44uRvLuWor9ZR76QOPvSKzq5Y+r9qFhiOnPj+gcnERS8HccsDIQoQuve+oL
        xJwiDr3ue16I1TaOm2kukz10zS6hlDslN1L4ZrXcR+IjjFp/Vydc4qFGSiQ==
X-Google-Smtp-Source: ABdhPJwVIUcML/bAkMlTor+3DXl+AFZsp7o7C4FwynN8HcE+sxeK4P9PPnHiC3woT8OMsm2W9Vr+ng==
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr16424363pjb.97.1594596415774;
        Sun, 12 Jul 2020 16:26:55 -0700 (PDT)
Received: from ZoomDell ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id lx9sm7816167pjb.52.2020.07.12.16.26.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 16:26:55 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v15.git.git.1594543148959.gitgitgadget@gmail.com> <pull.781.v16.git.git.1594544903477.gitgitgadget@gmail.com> <xmqqzh84pq3l.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh84pq3l.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH v16] Support auto-merge for meld to follow the vim-diff behavior
Date:   Mon, 13 Jul 2020 07:26:54 +0800
Message-ID: <002701d658a3$f09ca6c0$d1d5f440$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG+/t8vdFv1e8wS+CAYrPJEinGPDQHePt4NAhTR4ZGpE6/BgA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Apologize for the [PATCH v16] which is not well thoughtful, and I =
totally agree that we will not paying too much attention before upcoming =
release.=20
I'll rollback changes to preview one,  thank you so much.

Best Regards
Lin

