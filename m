Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A0EC43332
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 13:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE90520409
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 13:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYGJBsbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgCSNal (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:30:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33003 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgCSNak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 09:30:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id g18so1083132plq.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=DFlH9l/qFGmuvZUXQtHF7yvN/jq382DVQxqh77evjHA=;
        b=pYGJBsbn6ubhwQ3DkqiSJ8XpAnP1gt6p5h76Bwc60zdQlNbvpSYEUe37Kh1yTCYNiL
         V77I60Ie36yeemx/0NP+qL9rIL3isnM5bl7HP+C/6sc+ahG4CxyiVnCe/ihxDKli6qPu
         vn7tJPJ/KIDbpS9fR+GJ2j5VL72tHWBctJ4IRm0tcx7P//VNKt0eN/bgiRdzkg01ZXN7
         5SA8qKBjk5ikUGHFnjmCy1+qrGbwSzf97tPiOfGzlU/ehpSl9vp2jYuobNj6sZcojrgI
         dkLAYOzRRXMIP96B3YqMnwjZyxL40YIIZIoLhnVjEne965HY+lx+PLW1JmiBzRLEqx05
         SrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=DFlH9l/qFGmuvZUXQtHF7yvN/jq382DVQxqh77evjHA=;
        b=HPEpEPDRdCjDFxzHULXbwklK5dSWzjhKQg3IgA0Q7sF+hKihkCANkWtpNgICv607jR
         rXy80O20+sSTgd0CJzEntF4zLGxlR3jPICvIAyMsGG2OHI1e6mEA3bdtJlG+/E46upDy
         0qbgjyVMXgnZaSwJ/Nuc3jMbpiueJlEV+kzTwntzf7MXEq6aQSOVqIWaImt5+65Y55TK
         bUXcDFlRTiy5ma1HN3Bqu7X3JlmFOnA5D6e7ElH6txx1rsP6mZgno2p6lYw/4Z4kL/fg
         VWddEpm/uNdUIwauETFdRnaBMiDTfPg14S+uqP8m8Zepn/HMONsMQsdKDVJfvke5BTew
         SKsQ==
X-Gm-Message-State: ANhLgQ0yzoaUWS4vlzASGyB0MuwZgNhvDUSUuIDjSKRt3CDZZMEbloD1
        vMyBEOGM+ROpFYiNekYZ7Lvq47ErrBc=
X-Google-Smtp-Source: ADFU+vskNJuxBLDMqkimLUq6Rzg2jU5tyepNlf+vd1u8/o4Q3r2cKo6GU+3AhFbojXydcHEKYLzLsQ==
X-Received: by 2002:a17:90a:26ed:: with SMTP id m100mr3906341pje.130.1584624639219;
        Thu, 19 Mar 2020 06:30:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:4052:2e20:ac22:ec32:affe:2929:752d])
        by smtp.gmail.com with ESMTPSA id my15sm1960440pjb.28.2020.03.19.06.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Mar 2020 06:30:38 -0700 (PDT)
From:   Harshit Jain <harshitjain1371999@gmail.com>
To:     git@vger.kernel.org
Cc:     Harshit Jain <harshitjain1371999@gmail.com>
Subject: [GSoC][PATCH 2/2] t4131: use helper function to replace test -f <path>
Date:   Thu, 19 Mar 2020 18:59:57 +0530
Message-Id: <20200319132957.17813-3-harshitjain1371999@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200319132957.17813-1-harshitjain1371999@gmail.com>
References: <20200319132957.17813-1-harshitjain1371999@gmail.com>
Reply-To: Harshit Jain <harshitjain1371999@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace 'test -f' with the helper function 'test_path_is_file' as the helper function improves the code readability and also gives better error messages.

Signed-off-by: Harshit Jain <harshitjain1371999@gmail.com>
---
 t/t4131-apply-fake-ancestor.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4131-apply-fake-ancestor.sh b/t/t4131-apply-fake-ancestor.sh
index 828d1a355b..21ee359632 100755
--- a/t/t4131-apply-fake-ancestor.sh
+++ b/t/t4131-apply-fake-ancestor.sh
@@ -33,7 +33,7 @@ test_expect_success 'apply --build-fake-ancestor in a subdirectory' '
 	(
 		cd sub &&
 		git apply --build-fake-ancestor 3.ancestor ../3.patch &&
-		test -f 3.ancestor
+		test_path_is_file 3.ancestor
 	) &&
 	git apply --build-fake-ancestor 3.ancestor 3.patch &&
 	test_cmp sub/3.ancestor 3.ancestor
-- 
2.26.0.rc2

