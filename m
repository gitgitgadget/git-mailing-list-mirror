Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11502C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED25A610D1
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346622AbhIMRl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343524AbhIMRlK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 13:41:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6660C061786
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso7608136wms.3
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAObiEFm2DHUQ4KXSDgBkJFVd+MCaW15Pp6fawy8Adc=;
        b=GSM8pc70roDZhn12NL3HFJPXuLtpPiI0rNWq0QYPewRCB4gE+hDVIhLcU1KuRdewSc
         krZaGqm+qphZDOmWxDcC9RAGG8JMPit9aOFPP2CFiUezf968FKouB5u6K9uV+HNgCoXP
         VFFIB61fVQZ8lRwdEkiSdecshp9eLOmWTRr46ip/u6g+VIq179lQDZh7J0CxGL4fg4y0
         uCvZJAma0WNVput/qRN/Wr2rIb6AaovL1L6Z1WjGewUCAlmEgAO1IgsiP8JPq6bFWM61
         rIR2+X5sluOq4nQ2JPhF3X3rL7t/KXhtGJWO2HyJnZ/OldKiDxmqjm4lAJqNqTLE4Ky1
         l8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAObiEFm2DHUQ4KXSDgBkJFVd+MCaW15Pp6fawy8Adc=;
        b=zRlNNOunpwxRJvnQRLBosYKpMr2mK1qfffsE8bHzClxzFKIIY9m0NHe7n5/beCykbp
         mH0LYMEU4iaiW4jcZ3HWtfQssb97o52qqvf9gX+1GFY0CxOcydzWiWC7pydbHvhWskxz
         0sfpa83E03jJmyPRueCVumvTdK/+f85wMk3spmfdr21ezxtgtNIuLtbFpdKEAAIBpsAo
         KYZRQxHIU7Y4ZeLZsy0lCXsYWXJRYMRLE7Ry4rOeQP+Wg0QZxDvXU7CNC2+w0hn0QqcE
         Ei60Tk1J+Fqu9+/J2J7raNOFYXFO56Vq7q5tL4TVwht+OCqXQyQpNFbn0gg2WTv9BmE8
         MR7Q==
X-Gm-Message-State: AOAM531RkH7Emev9yrVqz86Ds7o97UrTa70Jo6Q9s6fi+a1IdOEkKUtJ
        r8mjjf6bOGTGBGwfBXuVsXBxPVQA5Fo=
X-Google-Smtp-Source: ABdhPJyFoLTi927SqAU4s6bVrEUp0W/ziSNJQmgVXyczFE8BPrTp3w/KVk0hTOkfoP4zKEArt9olPQ==
X-Received: by 2002:a1c:f607:: with SMTP id w7mr12764583wmc.65.1631554754426;
        Mon, 13 Sep 2021 10:39:14 -0700 (PDT)
Received: from localhost.localdomain ([81.0.34.57])
        by smtp.gmail.com with ESMTPSA id u25sm4428959wmm.5.2021.09.13.10.39.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 10:39:14 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 2/6] t6030-bisect-porcelain: add test for bisect visualize
Date:   Mon, 13 Sep 2021 19:39:00 +0200
Message-Id: <20210913173905.44438-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210913173905.44438-1-mirucam@gmail.com>
References: <20210913173905.44438-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to control breakages in bisect visualize command.

Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 5986fbecd1..1be85d064e 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -973,4 +973,11 @@ test_expect_success 'bisect run fails with exit code equals or greater than 128'
 	test_must_fail git bisect run ./test_script.sh
 '
 
+test_expect_success 'bisect visualize with a filename with dash and space' '
+	echo "My test line" >>"./-hello 2" &&
+	git add -- "./-hello 2" &&
+	git commit --quiet -m "Add test line" -- "./-hello 2" &&
+	git bisect visualize -p -- "-hello 2"
+'
+
 test_done
-- 
2.29.2

