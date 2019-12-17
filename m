Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EFFC2D0C8
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6FF207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWS4sKSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfLQMBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36678 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfLQMBu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so5560739pgc.3
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QMPG2hrOQYiAnKUzMMM87GLRpQyF5v0A1WVo4CGCLpM=;
        b=qWS4sKSeRpBPGh+dcTClhV/4SxIgJwn1Uhbc/wdKf0jTRvJ4kDbbaNRMrjuFUaPFwz
         lCMrI8TRQG1RO0mjnP4LJMtfd9Ws70PmBd13D1bstvlWV5JRSpU26tgRBOiwEz7jUaXa
         Mt5c8AT6c7ZSORtTAO+LVbV+fjN+MRCxHakedj89wCLYUry7xc2dLUuiA+McRVp1ebhE
         AlwU08zvSS67MKN7P6rPA+CRnY6j3/cPofEXF+TVBYcT+MsCUjpJByKng8hJet1FRYmi
         li4zM7POZqsmHhJC3MFaBxx3TSB2LS6rdR6BhtQCP8QWkmxz8fzb5OhtW+/BhyZmBqyb
         SaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMPG2hrOQYiAnKUzMMM87GLRpQyF5v0A1WVo4CGCLpM=;
        b=PEY+88Cytp3apSPAoisKfycnlIsQRIDnCWEfxraA8xE50cRdAR06a2PqO8e4AIwdl2
         1Eopfp7NrqQRgy8GbN4g0YEB1LFrdAqDeNe/2+f2fdDxJX7HFbGuTF9P6T5/CVjGRGA6
         4ye0sWUexiZhd7fCCerF3Os5l+hIywkP0tvrxRHV24WZAxcMOr2xL7ceQljF917C9BWa
         P6atzR91uW+9ij2oGSXnRzoMX8/kWrum329dBXI4celBu326ArYsrwHa5aybLpKPT3r2
         oBYKn6sZeZGtKaz642kZ+zNnq1uX+P3VWHOvdoOEX+L79p/VkvSF9umjIgSFN5Rby0fj
         iWXg==
X-Gm-Message-State: APjAAAXxGX4XVC5mp3HfhbQ3WIG08m6CfdKOm5sa+X8oSDKBlXIYo9b7
        GiKIhdyHCpxaglitA9uJatjEExN3
X-Google-Smtp-Source: APXvYqyQuZceT2rQ5DeYzX00YwO3B76uM/6s7hZGLBg6TUcmep2NbJPnVlHkJHvJwENP+dbXmRvT6Q==
X-Received: by 2002:a62:6187:: with SMTP id v129mr6749064pfb.212.1576584109492;
        Tue, 17 Dec 2019 04:01:49 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:49 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 09/15] t0020: use ! check_packed_refs_marked
Date:   Tue, 17 Dec 2019 04:01:34 -0800
Message-Id: <b77b474422061960615449318b00488fb0f5277b.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. Since
check_packed_refs_marked() just wraps a grep invocation, replace
`test_must_fail check_packed_refs_marked` with
`! check_packed_refs_marked`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1409-avoid-packing-refs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index e5cb8a252d..c46848eb8e 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -46,7 +46,7 @@ test_expect_success 'check that marking the packed-refs file works' '
 	git for-each-ref >actual &&
 	test_cmp expected actual &&
 	git pack-refs --all &&
-	test_must_fail check_packed_refs_marked &&
+	! check_packed_refs_marked &&
 	git for-each-ref >actual2 &&
 	test_cmp expected actual2
 '
@@ -80,7 +80,7 @@ test_expect_success 'touch packed-refs on delete of packed' '
 	git pack-refs --all &&
 	mark_packed_refs &&
 	git update-ref -d refs/heads/packed-delete &&
-	test_must_fail check_packed_refs_marked
+	! check_packed_refs_marked
 '
 
 test_expect_success 'leave packed-refs untouched on update of loose' '
-- 
2.24.0.627.geba02921db

