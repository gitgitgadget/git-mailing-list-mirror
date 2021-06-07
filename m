Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15099C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2CE610E5
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhFGOpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 10:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGOpf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 10:45:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E729C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 07:43:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id og14so21802981ejc.5
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjfZZxU0S9qH8okFJg3U91Kp7cds7W2xMNIjRASiGSE=;
        b=RaVZ2IU/hHiMrIjlvyDXu1iE7DLJlbROfUZYiGQtdUdMDInP5rBSyPqLCIA50xKcBH
         rGTn2DufA559XZOYBsD/kLOutagCMR/aX57QSKWPbs0UPvNp/3yWcmY4IpVFSJOtR3tl
         J3tS5TA5Au+f3n7ymgXcklBdhvDIMxld875a4MokBnD6brvFfATS9A1CmYzffOOkEFPs
         0Eh4ay5a3atDH4KLf3KZ7RheRxkIGq8SppEPsy094yaRinYsMnDHbpoM2+3pmpeGNFI8
         h2X1PTWtmApAR+L85u6Nlh6QxiMZO5oRtdqmrJt2iZ7Y3CjpKMijNkclOp0+3GJTw4hi
         MzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjfZZxU0S9qH8okFJg3U91Kp7cds7W2xMNIjRASiGSE=;
        b=cCaK1M7xLOGONJ13Ckf6fgsbXx+0219LGjApiQmN+ArOPDuK0ylw7R0tvowsAMbuF8
         dYPZStK3+2KDfyv/GY2hftQGsG/gajHZXs00D264t2gq9ZTmxVTDX40N+lCdUbzyeBCa
         8/TFXk12wIKtlSyZSC1sxHsJeBK6/jm6WaLr60OUCi9hLOZNSdFUlyZxVa62tDKZuLFV
         0rZZ0LRwDk5LoJCK8+9NF5JfxZCYbiKVRFLLWwKjVB0fyCT1cztR7GOCJyMhTQfmIg5G
         hUBS7sQWI7sHc6eu3vwx6Yp0CTUPCwao//LxNFKCfq0XYfImmiSUeXtBCqSmNDEbGPIy
         xjPg==
X-Gm-Message-State: AOAM531TY5waRiFaL69wh0VnwXjldMW903lJIg19M7bn6hKw+Ttw1jol
        /FGILJHdFiMxdGrAidP/jgkEgSi8f+SJfw==
X-Google-Smtp-Source: ABdhPJx8EC5LvVlFx6BOZ3gYJoA7YJ/OymiKUxqMcym0m2isFhg41W9jC8cJEtWLb2tQZF/MaAkFhg==
X-Received: by 2002:a17:907:7b97:: with SMTP id ne23mr18117155ejc.499.1623077008634;
        Mon, 07 Jun 2021 07:43:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h19sm3446723ejy.82.2021.06.07.07.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:43:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] trivial progress.c API usage fixes
Date:   Mon,  7 Jun 2021 16:43:21 +0200
Message-Id: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of small fixes to the usage of the progress.c API. I have
some subsequent changes queued up locally, but thought it would be
better to submit this more incrementally, and to focus on smaller
cleanups in the immediate post-release period.

Ævar Arnfjörð Bjarmason (2):
  read-cache.c: don't guard calls to progress.c API
  read-cache: fix incorrect count and progress bar stalling

 read-cache.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.32.0.rc3.434.gd8aed1f08a7

