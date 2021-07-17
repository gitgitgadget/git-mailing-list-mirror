Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B5FC636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A5761164
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhGQS21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 14:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbhGQS20 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 14:28:26 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1EC061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:25:29 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id s2-20020a0568301e02b02904ce2c1a843eso2938851otr.13
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ZSE3ApIsT6qu65rmCplJEr+XfG1xXFbJynlH17P1Q3g=;
        b=h7g5AuQz4NCwJ+DkuQvPqQaXdxf3y+tI0ob4RoMCVK4pFEc7xsVvdMQnkQzalV+zHe
         r4rL0sgri8Ha3jLZPYvoyoJRA8Nb55nuFVrSMr96uvwIQNa9Gybvve4sBpimoLlo6NjU
         U0iib0+GC4LDsKnDc8Vwb9eIWX0Ats5+rdliwsYttG3u6b0QG48k77ow8jpM8LdmH3U5
         wNa2ldKBixUuwakPCsJUCDuvWlq7bK75l7s4KzJ9FC5+nAij0Mhs+THV+CPDL7NMe1z1
         OaMCggIfoBsY7YdNkD52UTue8Z7J9qy1UrW6Wj0qPF/7p3U0O/3YUtcCjNL+8VNlgz8r
         otHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ZSE3ApIsT6qu65rmCplJEr+XfG1xXFbJynlH17P1Q3g=;
        b=kAe/nxTg0b20LT0KyK/LEkXUy6EPEBHycoIXZgfQeK9QC8EU4eyMExgSDhDm9V8g5J
         yndWO4EepmOmbg6KpKY+9Fry6ZeGpxmHmNKmNV9uOgdFIWaglNqQtmf7OiQJK6/6F6Mt
         tTU1GDA54ITpoOH0U+G+cR0vixW9Ae93b6QWPbT4z5qWq3HOISBidOzfrDSrvMJJnM9V
         DtHTAdSZg0QrGZG7gZIhM3Wu4eTAgJnfBWVclkao/qf9o3qEIG8+aBvXB2KRWiFs5Z2r
         as+RfCrt6NyW2RiF8WC4ew3Xwn1k/c3Mw2gwRU/b7kFZWZKauT+1SQou8ltuAytbMPQ1
         cw3Q==
X-Gm-Message-State: AOAM532GcMMe9BQrLOIv1lejqW2Rr+RD2vh0oNL6478sZ5ldzoXg8WYS
        Ihi5DYK5EfcoTHltnc/6qNA=
X-Google-Smtp-Source: ABdhPJw2M+5AtorVeYGS9L7PrHCMAA/f35B5TM/MtUE4es05RFM95S5sL+c3ydrxyCKoN/u6jQzybQ==
X-Received: by 2002:a05:6830:1c2f:: with SMTP id f15mr2686502ote.23.1626546329299;
        Sat, 17 Jul 2021 11:25:29 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id b14sm50121oic.58.2021.07.17.11.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:25:28 -0700 (PDT)
Date:   Sat, 17 Jul 2021 13:25:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f3209797d62_25f2208d2@natae.notmuch>
In-Reply-To: <3d9ff69198e5a604b124bf861df4d6ecf6eb661e.1626536508.git.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <3d9ff69198e5a604b124bf861df4d6ecf6eb661e.1626536508.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 5/9] pull: ensure --rebase overrides ability to ff
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Now that the handling of fast-forward-only in combination with rebases
> has been moved before the merge-vs-rebase logic, we have an unnecessary
> special fast-forward case left within the rebase logic.  Actually, more
> than unnecessary, it's actually a violation of the rules.  As per
> https://lore.kernel.org/git/xmqqwnpqot4m.fsf@gitster.g/, --rebase is
> supposed to override all ff flags other than an explicit --ff-only.
> Ensure that it does so by removing the fast-forward special case that
> exists within the rebase logic.

What Junio said in one mail are not the rules.

This goes against what is described in the documentation.

-- 
Felipe Contreras
