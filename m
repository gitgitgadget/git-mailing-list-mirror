Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E05C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B246A60FF2
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhEGWtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 18:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGWtt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 18:49:49 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC86DC061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 15:48:48 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w16so1955919oiv.3
        for <git@vger.kernel.org>; Fri, 07 May 2021 15:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=VzGM0Qe7siTv6RDGXbxJf6bmMgwMY4+DteHVFc9/fL4=;
        b=FPjggiaYWm/vgsdHlmyp37VX7hFQ+d+QZ+RiFsvlBW2hakMkhqkbYmWh5ReJF4NJLh
         xchuazw3LrbNfH7cfmMEYElbkQH6KpC9U9kRomosxaJkEKDrvSBc3yJVhgvZ/1aGIWyo
         ZS3brlO2Z0rn1/bpU7ruuXoJrOoc/Qo/A4SRIeBlS26hl79Luqqp9Fh4pZUNpRuLgnS4
         dL4ejzqvIBrnxvnegd4QiJJGcSSTR4szyDcrvPz7IYCCYkSPkuKiJJZW5NU5S5gBQIXe
         7HB3qBF5hXNZPhm78CKqjkSRyD+yYiG9XPqB4gmPuTRu/av6tVL+m9DzLfCHhAyZh2lL
         TrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=VzGM0Qe7siTv6RDGXbxJf6bmMgwMY4+DteHVFc9/fL4=;
        b=QdruB/zOjIM6Gm0BzAfagZ9e30RVCsHllNb6QQSNqajbOihom2ZvHcVB+zrPWNB8dr
         tqFcZDzTL+krAbzRMJuT80mml1MmMYlxs3l/s+GgtL2RsWULK10XZwJVDcy0s9m3mLRj
         Usrgq8fA1XUXrQh0Bgw0mfajy2HgnxsOLRyVS2JIcJFyGwdpRPSGBcK4crDgFadmv7f8
         lXykJUMmK7vuCSBjDQJgX1Kk9eM/jtfoL6/ki9JrfOxkem/8EhxidHfWWW090HJxNMe/
         hTFoeXR+KsHw78qz/4ZgxMKlcFs1GBLQL3xJwBuMZM6ToMfgJpTaiC+YcKhYluJnH+jJ
         FV+g==
X-Gm-Message-State: AOAM530gqv5XOhA/ERT+ELF37GVoOe7z72CCchRiO1PsWQXSx/sMgm9J
        YEx1Pomuh25JnVxtqFGvtbnMSVr/OAln2Q==
X-Google-Smtp-Source: ABdhPJwRP+ATRF+fTS+WsGmdTe8NliHtdHsRS1mvf3Fma9uxilca2oNpIp++kWif39WBA+hcVrRtMw==
X-Received: by 2002:aca:a9c2:: with SMTP id s185mr17303527oie.109.1620427728053;
        Fri, 07 May 2021 15:48:48 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m67sm1439430otm.69.2021.05.07.15.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 15:48:47 -0700 (PDT)
Date:   Fri, 07 May 2021 17:48:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <6095c3c8fba6_cfc72088a@natae.notmuch>
In-Reply-To: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
Subject: RE: [RFC suggestion] Generate manpage directly with Asciidoctor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> Asciidoctor has support for directly generating manpage, see [1].
> 
> We support using Asciidoctor as drop-in replacement for original
> Asciidoc, but currently we need to use xmlto together with Asciidoc(tor)
> to produce manpages. However, most users don't inclined to install
> xmlto toolchain, partly because they had to download more than 300 MB
> of data just to install xmlto and its dependencies (including dblatex
> and texlive).
> 
> So completely migrating to Asciidoctor can eliminate xmlto requirement
> for generating manpage.
> 
> What do you think about above?

Makes complete sense. If only we had some patches to go along with that
proposal.

-- 
Felipe Contreras
