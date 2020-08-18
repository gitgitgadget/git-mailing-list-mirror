Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5B3C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 05:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8C92072D
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 05:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+/PPWeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgHRFXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRFXa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 01:23:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A11AC061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 22:23:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x6so9206311pgx.12
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 22:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYI0SRlazO3YxSbmnDYN+yCuSrx9q/dTaVzK3azAO2k=;
        b=Y+/PPWegIL1wZZXCaJ+zLxVgIaOw4twXv/gZT5H6AB4TAWAzFmMt+lYxUIWMeEGaWG
         Wpdy7SygDfO/FGomMwJvpl1wCFAjytpvV4gzg35eAPbD4m8uzgjjToTlowakPaJU5dAe
         7GOCy6YRSZrsk4Cqsr83oisg+ARYOByFZGT5vjc8/skSHAPRjrryO/W7VCHzLK368wLy
         2skzTr5qkMM/Ce/2IPra6zMgqrP5qYyB69ns0bXFtG5Cn2tKYx651Oekk1cH3FHtDa5S
         5RB5T9+XJfbmBsbNtFlcoxdId+d8MMrOCSmdNBy1PhsVDbFJ3KESxx1NOw6TWKwxBwia
         JpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYI0SRlazO3YxSbmnDYN+yCuSrx9q/dTaVzK3azAO2k=;
        b=AtqlcfPiSD8WCnGMEOIduFoOzGVAgWksFWa+ZYMDx86eAWXe9LR/9wyUOxZi739/Sd
         /BtSuZzo3gJXM6GF4C5Q9KMqT19ezen5is9JK7NLgpHZGcFmWj06j8JOLQtNcNkyKWtK
         2QvWQguYHBHupjS979h5qZ+s4strWI+u/agnuwnh9SZEyGNr0CoB9QhzzfsqmIFr3po4
         i9Vu8qKsR6zwqOyDiNfWgiUBVmAkw0Tz7qUmAeTiOIO123wNwSW9WjLwhtRhirvejazM
         REwICcTFLNw4pxwMEvPH4VOJvUGXVfbvGRuXCI4s38j20wIEsLJbPg1ymmIWV10327Gc
         ycHA==
X-Gm-Message-State: AOAM532hnwGM+iFL29kByI+5vFYSonnuFUZ6+mEw3Rbj7UVy03fYqsa/
        iAZta+fqfwFejSfPaxJ74Go=
X-Google-Smtp-Source: ABdhPJwXdR9oWEuBfgyAWnwkHpNV03UFKYhidXDTjTV4MeaxyzT5SAesCWsh+3KuzFqTOEW/5fM+fQ==
X-Received: by 2002:a62:c5c6:: with SMTP id j189mr11119725pfg.145.1597728209108;
        Mon, 17 Aug 2020 22:23:29 -0700 (PDT)
Received: from localhost.localdomain (36-225-225-45.dynamic-ip.hinet.net. [36.225.225.45])
        by smtp.gmail.com with ESMTPSA id w23sm19940271pgj.5.2020.08.17.22.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 22:23:28 -0700 (PDT)
From:   Danny Lin <danny0838@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git develop <git@vger.kernel.org>, Danny Lin <danny0838@gmail.com>
Subject: [PATCH] contrib/subtree: document 'push' does not take '--squash'
Date:   Tue, 18 Aug 2020 13:22:49 +0800
Message-Id: <20200818052248.1880-1-danny0838@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <xmqqzh6t2p43.fsf@gitster.c.googlers.com>
References: <xmqqzh6t2p43.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git subtree push does not support --squash, as previously illustrated in
6ccc71a9 (contrib/subtree: there's no push --squash, 2015-05-07)

Signed-off-by: Danny Lin <danny0838@gmail.com>
---
 contrib/subtree/git-subtree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 9ccd431c7f..0db02fe3c0 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -143,8 +143,8 @@ OPTIONS
 	Specify <message> as the commit message for the merge commit.
 
 
-OPTIONS FOR add, merge, push, pull
-----------------------------------
+OPTIONS FOR add, merge, and pull
+--------------------------------
 --squash::
 	This option is only valid for add, merge, and pull
 	commands.
-- 
2.28.0.windows.1

