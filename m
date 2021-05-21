Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F42C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04AE6135C
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhEUWfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhEUWeo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:34:44 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91FC061351
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:33:18 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so4913904ooa.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=Tn0Lt3mWAI2flsSlRFTKYI1Gpb2LDK513KFJkZ/b3G4=;
        b=pPuOCXHzefgwbJLu8nHe69VshlCG32bO5QoiCnEnfKvyj9l2xg4HTDe9SVpsiJK0lJ
         dt1Z63LGaUJLI+fQ/tyg00zrbA2BOQRCrJ3C4K89i7hUPTWrHgYSlKypQGgaPI/TbwAJ
         Jj4yO/ec9kqrfESAOZQLphwP8UB67WQTk7mAd4Uxdd6jEehVNjAclDPmb0LBBKknn2vq
         bLeGHFPfD7mnycOrcz7eF9RvIKvoznS9wYh7NTZaAzre1BpoM4PGNsuLnBWx1OWD3Tid
         v1M8+duIueBaNnaAridjciZP5HCt0LOEsIpdh/6B1HJLuhB1JeRVw58zRDkTyeyiPTHn
         QVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=Tn0Lt3mWAI2flsSlRFTKYI1Gpb2LDK513KFJkZ/b3G4=;
        b=RjkdijjEW6Lu7kRvzkYZH2AaCq5xBMxy9qP5iTgdMS0aVpP8LFXX/gtJeVkkYg8TPV
         aHKofHV4eDHrMlzmiZhogUDnm07scIYOnadV9K0pL0zyd17rVeoHKALXL8TYDqC3yafo
         p9fKu/5gdXuBjfVcaScSgM3/9rONLf1MGB03fyEDE0TAEHVACYNLTg9WYjZacC/tSFrE
         gbdTWcwng5P/ZT8yIaFYz/DKDi2AW9XD6NDmfcbWiWInRXWR5htFNTI0FsuUKJLaNqF0
         8KXo2S1DiBizeLCgXsJJGT/65Enz9tLrDgKUsNawHkpaDD2gFpkC7sTjIx9qLwkaI2+6
         jQLg==
X-Gm-Message-State: AOAM532mMPE111mEsMRsI3VOpkvTHOiUGocyP5f4+AQTrlmGjrVYYOTI
        JVpWq8eOMIzFP9ZyrBKcJtI=
X-Google-Smtp-Source: ABdhPJzah3TufEtARVY5ZkWw0NRNqDPOIhGvcVy0NLBcPl0iEA4LcMyvWKOOL0AEOXEkrAks/pL/Bw==
X-Received: by 2002:a4a:250e:: with SMTP id g14mr9995006ooa.31.1621636398209;
        Fri, 21 May 2021 15:33:18 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id p3sm1420269oov.2.2021.05.21.15.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:33:17 -0700 (PDT)
Date:   Fri, 21 May 2021 17:33:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60a8352c936aa_55d9020873@natae.notmuch>
In-Reply-To: <xmqqtumyulv8.fsf@gitster.g>
References: <xmqqtumyulv8.fsf@gitster.g>
Subject: RE: What's cooking in git.git (May 2021, #03; Thu, 20)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Here are the topics that have been cooking.

> --------------------------------------------------
> [New Topics]

Is this not a topic?

1. doc: asciidoc cleanups
https://lore.kernel.org/git/20210514115631.503276-1-felipe.contreras@gmail.com/

Or this?

2. doc: asciidoctor: direct man page creation and fixes
https://lore.kernel.org/git/20210514121435.504423-1-felipe.contreras@gmail.com/

How about this?

3. doc: cleanup old cruft and asciidoctor revamp
https://lore.kernel.org/git/20210515115653.922902-1-felipe.contreras@gmail.com/

Granted, they step into one another, but at least #1 is more than ready
to be merged.

I'm sending new versions of all of those.

-- 
Felipe Contreras
