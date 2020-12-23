Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC06BC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 04:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B2E22287
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 04:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgLWEyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 23:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgLWEyl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 23:54:41 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6D0C0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 20:54:01 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id x13so14013805oto.8
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 20:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxNVtwpkHxLTs8MehNRp84LpOfdRT0jBqTPwO5rrY5g=;
        b=urtNxyVHZAwCCC04TgSIQgLXsdC/QcmGJeVJbGlCRuQqvx2bJPsPFzsfPiQa3nF+GW
         U6TgTEnhGKJ9Zj6gbwOIrO5LUWDonklGqTS3BQ+MEDT/oDxAVv8DEaoM4ifnb4mpULaZ
         GDXxLjq7KcjNRmEtWgEWV1ll7XX5VjLgGXF6GPvA1AtN0CgIrDg5NZjoii8AGY1CSK+n
         79WuCjr15fXQqT7Yird63Oo4H59KRCGVS7EumY5SI4hMf2MM/y8sxx9EMKoEEakfyYmW
         EYllnALZQGl/7eD00uMl/hdAtSqU8yWQJXRSUnMlIRViqY7Sdj4SSvOtTdfSSD7ng8CK
         36kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxNVtwpkHxLTs8MehNRp84LpOfdRT0jBqTPwO5rrY5g=;
        b=n5mIPf6claMyvCFlicZNcXRN0LN1gwFMzLBPKCrVcHBfxZ0FwRUWPDBvdNAjCgAM3+
         5JiudhTBSm5RyUyUXKmoRem03o5wL7yDWHVqzi6GTAw1Azsb3Doprz5pS80eT++0a7eY
         UcEAlvXofYFDn1585MjAkCuvVt3JvssnyHWVvtykavI8V4uS2ki/YQvRAdtHox2f03iq
         yG+9PPblRGskb2IoIL9Ih5kt7uMyTfKIUZcjK2F+9CADlQhKcRdkxUp1RaVYCsYOYHQF
         fLrOOaaeh6vwDDGSZH7IVZQwYHR7KYk1sdH9fVHcy/K9aNurYSW21Yxjyl5cmNw52Rxu
         mYGA==
X-Gm-Message-State: AOAM531j5hdwU6nUGVgk64pqswN9vjrQm0iiOPKBptm7SrQ256sut8r8
        isqVXTFsiArpXGa3Ythg6PkvvKDNFkjQvw==
X-Google-Smtp-Source: ABdhPJxQ54JKyjxDEg3NjW+k87xZGLg1bxWd67qhsSWBPjSAX631zeX0rE4PXRurmh0/AQMDpFBI7g==
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr18833839otq.240.1608699240215;
        Tue, 22 Dec 2020 20:54:00 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r133sm4686023oia.17.2020.12.22.20.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 20:53:59 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 0/1] mergetool: remove unconflicted lines
Date:   Tue, 22 Dec 2020 22:53:57 -0600
Message-Id: <20201223045358.100754-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's not much to say other that what the commit message of the patch says.

Note: no feedback has been ignored; I replied to all the feedback, I didn't hear anything back.

Changes since v4:

 * Improved commit message with suggestions from Phillip Wood.

Felipe Contreras (1):
  mergetool: add automerge configuration

 Documentation/config/mergetool.txt |  3 +++
 git-mergetool.sh                   | 17 +++++++++++++++++
 t/t7610-mergetool.sh               | 18 ++++++++++++++++++
 3 files changed, 38 insertions(+)

Range-diff:
1:  776c1fbb97 ! 1:  2dc53f4dda mergetool: add automerge configuration
    @@ Metadata
      ## Commit message ##
         mergetool: add automerge configuration
     
    -    It doesn't make sense to display lines without conflicts in the
    -    different views of all mergetools.
    +    The purpose of mergetools is to resolve conflicts when git cannot
    +    automatically do so.
     
    -    Only the lines that warrant conflict markers should be displayed.
    +    In order to do that git has added markers in the specific areas that
    +    need resolving, which the user must manually fix. The tool is supposed
    +    to help with that.
     
    -    Most people would want this behavior on, but in case some don't; add a
    -    new configuration: mergetool.autoMerge.
    +    However, by passing the original BASE, LOCAL, and REMOTE files, many
    +    changes without conflict are presented to the user when in fact nothing
    +    needs to be done for those.
    +
    +    We can fix that by propagating the final version of the file with the
    +    automatic merge to all the panes of the mergetool (BASE, LOCAL, and
    +    REMOTE), and only make them differ on the places where there are actual
    +    conflicts.
    +
    +    As most people will want the new behavior, we enable it by default.
    +    Users that do not want the new behavior can set the new configuration
    +    mergetool.autoMerge to false.
     
         See Seth House's blog post [1] for the idea, and the rationale.
     
-- 
2.30.0.rc1

