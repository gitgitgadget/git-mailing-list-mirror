Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA0C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 02:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A3A207E8
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 02:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="TmclPFvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgGBCfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgGBCfH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 22:35:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3864BC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 19:35:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so10674578plq.6
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 19:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=EYTZterfJSGhPCY0FR+sLQ2N5FardYN0ZQEMEVy7k+g=;
        b=TmclPFvg30N9+4CWHDA0OD7mquNWz1fK71KUwF3EN0a166UITIs1vcJcowcGaZZDJy
         vywJNSPExkwDzzb+qlS85OYuci9Z7ZzBJaY2EWyO0XRDOH4u/CcyV/oQwI9QxfnBWoKg
         lchm1OIp9LzEuA47hNJ93CKuBSHdi1hF00gkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=EYTZterfJSGhPCY0FR+sLQ2N5FardYN0ZQEMEVy7k+g=;
        b=aFaRS5M7gYEqOHFNNNC2jkgGjncIDjuyxW4tDNAGTIcHWJdIgn8okCbX02MyH1RPGQ
         O73x2eVDamP6dlJbcRXcliiyQncANAPCsP8m4hH5P/XbKiSk94z4i/PG5XID2ceK/3oj
         VzEYRapYNOpiMOsviFouav+ZsHyJLEv+GigAa/Wm8QcAKiTXCOr/wvCt/hWVrP+uk5Kd
         OcoCe+uBU51/SOgsTg/l4u/SIkwBWi6diVKrMjeZEFx9+zbAPDMCNK8H/fvOmQVTfMTw
         kmYyZdRW+wj8EPutIos4pUIFPGVTC59m+5gKX6iiTK4vx7jY5UjtrSQzdo1/tBln8Ixr
         nHDw==
X-Gm-Message-State: AOAM531xO6W5pyZe4U5P/oDY+KAYi/93l2IsFHhJVIDGd/jcozMtOXEo
        gqZRz+jc2viIMUmJX3KubKbKIA==
X-Google-Smtp-Source: ABdhPJyyZv3zCzGpQ78bGoVEMQtu+KUmvZEfPWertA2sMVvj1HPE7/VrbRUVgTYB96Ey2PVS5b8K9A==
X-Received: by 2002:a17:90a:71c3:: with SMTP id m3mr24685012pjs.225.1593657306631;
        Wed, 01 Jul 2020 19:35:06 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id y10sm6941515pfn.121.2020.07.01.19.35.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 19:35:06 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>, "'Junio C Hamano'" <gitster@pobox.com>,
        "'David Aguilar'" <davvid@gmail.com>, <git@vger.kernel.org>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
References: <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com> <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com>
Subject: RE: [PATCH v6] Support auto-merge for meld to follow the vim-diff behavior
Date:   Thu, 2 Jul 2020 10:35:00 +0800
Message-ID: <18df901d65019$6492b8f0$2db82ad0$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL1zGm+763T+IyJ8eZ0BxMuyQEl5gHMDywQpqY4XFA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The [PATCH v6] changes to follow comments from Danh, Junio, David.=20
Please review again. Thank you all.

https://lore.kernel.org/git/pull.781.v6.git.git.1593650687697.gitgitgadge=
t@gmail.com/

Regards
Lin



