Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B87EC433E0
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 23:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CB5207A1
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 23:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbhABXlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 18:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbhABXlA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 18:41:00 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B2CC061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 15:40:19 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id l200so27876604oig.9
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 15:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hRxfDvqfDXXSUHSu0UUoLkmj8JIlyCzmng16NJnnKgU=;
        b=Nd66BTuQhZwmmfEc0xaV6EsDy6tR59NK7umu2bJgLQC/9qpIS4cHhNRiaFDYgH8DIl
         +nDAbtGd4DgWq6GUoXsZkBWk+ecl8V8hcSSmBuSCyr31utQYW3W8GwJ7KGTyLsbugJN/
         0fgRI+wnV2KYpZMjQPEbQ+I5TF3SNcjTMWn3B07yAMgTzx6shDWV4nrlTLg1+3olgeKa
         rkrLUzR0i/nka1I/bulh8oS6KAi0jGo69YuCE5LN2jTK7vQn+UfhmGfy6V3/JzGTaepS
         zC/QchTFrAdpAmPogGcvpXWxnJRgwVeSH+lXfdWmfMwXAyL9vFkaVROjRugZAj/rImO/
         RTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hRxfDvqfDXXSUHSu0UUoLkmj8JIlyCzmng16NJnnKgU=;
        b=Bovk6BBXNHeJ5geJBZUAvJui55tUKHbjE0yQTI69gTfAiikCtx/HivQYDvJgDqoFPi
         0lRtq08DmU3eJvKTLLw+ek/9r6tmaXTPbm06yD61kydNgcLo6AXqbi5v0NBqBqR0Ugi1
         HB8r/kpMb6oqBVOrvGIPoGG6pAbRjXqIg6yH7OyZhEwtntSjkSEOS6E8MncrBBEZLmA0
         /5n2pVQt9Q84SUj6TbWvcS2Cpa8nxP2OOV2g5npkoiNnrnDMWg3mBVc1tnUVV/QU1SEz
         GvL2zAfJG03AV2FORx+tTeX1sKJp2GCgI0m7z2WVZ3VI2ibeBpmU04ynSm+GVyHT+6Iu
         rXwA==
X-Gm-Message-State: AOAM53056fP7MSLZhE7pEESBhycMrdi5U2SpZoq5kYhz7PbTqRog7pja
        Hsgm3VCppJftBwFT3zXwdT23xxtEpde2Dg==
X-Google-Smtp-Source: ABdhPJzOcz1CjRmGxG968foaQO2vfJYfs7SRnlKvBtaJ6qU/L/VoKptb/SyrI5XwpcUFwHpsBqfmgw==
X-Received: by 2002:aca:a9c8:: with SMTP id s191mr14261546oie.11.1609630819111;
        Sat, 02 Jan 2021 15:40:19 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id w9sm12873377otq.44.2021.01.02.15.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 15:40:18 -0800 (PST)
Date:   Sat, 02 Jan 2021 17:40:17 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Ackermann <th.acker@arcor.de>
Message-ID: <5ff1046161825_b3a4208be@natae.notmuch>
In-Reply-To: <CAN0heSq3q1X8jJqBkHtrTxaxJ4xfw5kQtH+b8GG9OWRXHExt+g@mail.gmail.com>
References: <pull.831.git.1609609214040.gitgitgadget@gmail.com>
 <CAN0heSojPyr=g5PBVmT4VTfxxKxzYcFXJ1jynM1tGuZSyQMykg@mail.gmail.com>
 <5ff0f31315732_a76d20833@natae.notmuch>
 <CAN0heSq3q1X8jJqBkHtrTxaxJ4xfw5kQtH+b8GG9OWRXHExt+g@mail.gmail.com>
Subject: Re: [PATCH] doc: fix some typos
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Sat, 2 Jan 2021 at 23:26, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Martin =C3=85gren wrote:

> > > #if 0
> > > #error might or mightn't work
> > > #endif
> >
> > But this works:
> >
> > #error "might or mightn't work"

[...]

> And now I ended up laying out my thoughts anyway. :-) Of course, others=

> may well disagree with me about this being code churn.

Either way it's not integral to the rest of the patch. The change can
be dropped, or fixed properly. It probably doesn't matter much.

-- =

Felipe Contreras=
