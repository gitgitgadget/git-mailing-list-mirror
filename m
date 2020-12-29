Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85993C433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 01:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE7D21D94
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 01:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgL2BgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 20:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgL2BgS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 20:36:18 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46458C061793
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 17:35:38 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 9so13289144oiq.3
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 17:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=4/30HazMSP0Ul+f6TQelNWqCCnfnplXvdGaiccrTTVI=;
        b=aFnYj6qumyknWAFw62d/+UMrt46UFxt6ctSMVLuMk+mvNeL0KyWAIZ7CON2HGL/19r
         77ZjXDj7vJxJ8egKKyaOzgthuvxvZlHW01VXhe2Elh4Eav8HecQ80fr2wQM/16WiBZ+t
         mNTjsxyhtZxpcnA0dLkxioC0dYB3dIffq9Dg+gkHYnC5+4ddFZjPqjkMxnvT4as7vLXg
         LWxN9JIT/7ILeFTjnKsxr0JpEHiQz1KWvfDG0RpcdPAjmYb5MNaNI3BAs+94oV3GS87E
         jmvBIdufsXJcv9NHbLGkl8TRXCEKgnbPcUAVjk3pYHOvji0+YGYgcBR0UV88brAqM3Ah
         Q/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=4/30HazMSP0Ul+f6TQelNWqCCnfnplXvdGaiccrTTVI=;
        b=d9v+4aUTyENqiH4aRfw/NU1LHmSZAuR2wUwgp2/3EuFUtIjBfiU7BL2IumxfSOQZHk
         3WgYKIGNBVWDty/RQwEAuSHsntY/UTmegPJAgRLED8OylrVEmWdJY1maxM+yDyQfG0ty
         LkOL5pfuhndtanM+a6kc+8rIfLrCLmkxo10nz5Bzm+3p1fc4RMyFBES0c3nPyUpq7WAA
         dO6s6Oa66ezOJsTRatcKUcNAvRKcZd4kNpCnWcOILP/FVCzPZLjNYS1vlQMYGx55An4e
         c49eaSTs1hdCkpr7uTPfGV7iMuvtj2g4Sjv/YX2ywCnW8Sz3eT2eEVpfwHXB1mL2hrWh
         C9/g==
X-Gm-Message-State: AOAM531Bc8SN64Mn9u2v7W+ovhd+tlwEkP/DD/xQq9ua7KMW3DeXy4Rg
        9sGMdkdoSpidyBwE2rYBCCk=
X-Google-Smtp-Source: ABdhPJxKIA4H2LxQWafyjQI2WxFWi5Q4DV7gfwjHqQv4PoKcdihGT744Y2mYbWgEe9eGy22ZZRqWgA==
X-Received: by 2002:aca:ec09:: with SMTP id k9mr1024970oih.153.1609205737669;
        Mon, 28 Dec 2020 17:35:37 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y10sm9743185ota.42.2020.12.28.17.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 17:35:37 -0800 (PST)
Date:   Mon, 28 Dec 2020 19:35:36 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <5fea87e816fff_23821208d4@natae.notmuch>
In-Reply-To: <xmqqeej9g325.fsf@gitster.c.googlers.com>
References: <xmqqeej9g325.fsf@gitster.c.googlers.com>
Subject: RE: What's cooking in git.git (Dec 2020, #05; Mon, 28)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * fc/bash-completion-post-2.29 (2020-12-23) 4 commits
>  . completion: bash: add correct suffix in variables
>  . completion: bash: fix for multiple dash commands
>  . completion: bash: fix for suboptions with value
>  . completion: bash: fix prefix detection in branch.*
> 
>  Seems to break tests on Windows
>  cf. https://github.com/git/git/runs/1597682180#step:5:35614

This was addressed in v2 already:

https://lore.kernel.org/git/20201223144845.143039-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
