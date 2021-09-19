Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3B6C433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B382610CF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhISB7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 21:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbhISB7A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 21:59:00 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82111C061757
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:57:34 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r21so12282533qtw.11
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKbUAdZ2pFDQd+NsXCuY/9ZHnCPcqDJj51rmfbO5W70=;
        b=M4QMv1KaTScu6Tu3A3a480TfR/cgtz6jdRYLzjVPD9/W3hxfacSPt93+kX1LI1m2L8
         zLWUdsN0Jaura4mHv049yvi8g9pvfoi84iTvYJmmtmLDDOeAg4FPm+hrgmmpBE+UEdBG
         K70JDKTGe37ovYmSyYlQgTjXyn8gXJ46LhsoyDr2BmK3lSYOunuyKvJo0+f+BxhGO9aR
         VbZQ57YPAJa7htO47/vQUwBYXuH1HYq119WRyO45reJM+3/0OtQV5Ot8VHHxghOW7ETi
         Ir7l4OMw2gfYmAYKloSV3AC/2PO5vF+yztSJQDWfg/tjHcqVE4KNLCFI+Ae/sf35T/5o
         Osmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKbUAdZ2pFDQd+NsXCuY/9ZHnCPcqDJj51rmfbO5W70=;
        b=lUIw2AIwBW0vzDjnNVB9YnHKBe69unIUWreJFK1Nlo+GyiwSXSAEAOiiLdk7e00VbJ
         V9GrZj84IONQBnQR8+PbQG0mWvzIIX8dkH6zUmltH50wJZFcL1jVrP6YOFp8UMqF4QTG
         kXwqJS8qt70KUlGLOV9ofceaJl8nlhSBnsyPtcrnZoGsGFUP0bJk11VOuGsg556MQKBN
         MfFRMaTIeK5WL2Xt42CO5+G14Th8ZGOJ0al5loWYCShaOjnV86xah5HmHgoO/caqEzAn
         cuoVBA6zu/arF2Z1s6Xz5UOgaOIWsTKVI6utrdKPbEoD1KlnLEPHSmlk833VY2Zd7joS
         Hk7Q==
X-Gm-Message-State: AOAM531rOwVyz8OQq2rZYCQXjsVfgGmllXJ8mBmGiC3on8MaIeGpM9a+
        PuvK3T35YO6SCCnE4zJfdRY=
X-Google-Smtp-Source: ABdhPJxD486CDdjYG8VvcF6meHeeYdx/TuL19A+HLiZjA6EcMF4lL8i8BlTt0zxYeoUZrNAC66XT2g==
X-Received: by 2002:ac8:67d7:: with SMTP id r23mr17206577qtp.227.1632016653587;
        Sat, 18 Sep 2021 18:57:33 -0700 (PDT)
Received: from sarawiggum.attlocal.net ([2600:1700:5d80:a320:4412:822d:c222:aea8])
        by smtp.gmail.com with ESMTPSA id k10sm6759062qth.44.2021.09.18.18.57.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Sep 2021 18:57:33 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/4] difftool: add a missing space to the run_dir_diff() comments
Date:   Sat, 18 Sep 2021 18:57:27 -0700
Message-Id: <20210919015729.98323-2-davvid@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210919015729.98323-1-davvid@gmail.com>
References: <20210919015729.98323-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index bb9fe7245a..4d2e772031 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -548,7 +548,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	}
 
 	/*
-	 * Symbolic links require special treatment.The standard "git diff"
+	 * Symbolic links require special treatment. The standard "git diff"
 	 * shows only the link itself, not the contents of the link target.
 	 * This loop replicates that behavior.
 	 */
-- 
2.30.1 (Apple Git-130)

