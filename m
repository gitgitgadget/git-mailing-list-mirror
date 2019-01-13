Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1EBF211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 13:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfAMN60 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 08:58:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38253 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAMN6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jan 2019 08:58:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so19975473wrw.5
        for <git@vger.kernel.org>; Sun, 13 Jan 2019 05:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dg10weZKrLpQCKULD51feFNIi/ItBFB1MljK6PFKT7E=;
        b=GAppg3AXTjAEuTXHfq+uxzbEfzZav7IkPWxikZLF9RONLUOTMSgzWWiKbe6RLi0W9o
         tEs7uocupZfmj1ZBUTFXT8CdeBoqdToTk5RbCyNX1IeM1KIRDQ3c3P/ZmRdBkJxIAy2U
         aYaBWEt92x1nun8BMRFZZI31uv5TusaWQ0Ocs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dg10weZKrLpQCKULD51feFNIi/ItBFB1MljK6PFKT7E=;
        b=guF+HJ8/L0zyhaj+SnjvHTZw5qixJqaCHgvMIAnonjTm4CnQBSEcWEqAfAUGJvrpRg
         IVXODxSsS6yMX5euwDopkxrfL8U+ZOE1QEcvSJDZhnSqi5ORrLbL+3wKqUIUd6R3L/R6
         VUnw+fzyxKXFOjZ5ECMkVjfKNXh/R2+Yxh3hT6NoaAdyD7wPzoT3vzrJN9/lSrgGNUEV
         alJnPvq1ze0tqORu/1ZE3OrraK30Iq1ABieHI+LH+oIwardHwbexoQ+G4PrRcIBxmo4T
         +bL4qrOVfS1WEgQx4RauxM20WdddlqAm97Suww4ZeLUoIN88tyO2K+YnaPCtyQowUNsX
         hrtA==
X-Gm-Message-State: AJcUukfY4JGyBrVlCcsmEHniaFDk5oN6+EbzNJ/nDOK0AQ4tlpXzOwNT
        vCJkZf1B9bD0WBN2icNcKpcJPoXW/rQ=
X-Google-Smtp-Source: ALg8bN70Eg0dzUhNJR8wsZ6VsXHlDIz4ioF2bFKb193sT3iNVMhS8cjjK3KA+8mQs9+5gIlos7xyBg==
X-Received: by 2002:adf:ffca:: with SMTP id x10mr21647524wrs.289.1547387903911;
        Sun, 13 Jan 2019 05:58:23 -0800 (PST)
Received: from ethel.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id o5sm44186864wmg.25.2019.01.13.05.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 05:58:23 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org, viniciusalexandre@gmail.com,
        Romain Merland <merlorom@yahoo.fr>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>, amazo@checkvideo.com,
        aoakley@roku.com
Cc:     Luke Diamand <luke@diamand.org>
Subject: [PATCH 2/2] git-p4: handle update of moved files when updating a shelve
Date:   Sun, 13 Jan 2019 13:58:15 +0000
Message-Id: <20190113135815.11286-3-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.100.g9ee79a14a8
In-Reply-To: <20190113135815.11286-2-luke@diamand.org>
References: <20190113135815.11286-1-luke@diamand.org>
 <20190113135815.11286-2-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perforce requires a complete list of files being operated on. If
git is updating an existing shelved changelist, then any files
which are moved were not being added to this list.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py                | 1 +
 t/t9807-git-p4-submit.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 1998c3e141..20c5ce9903 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1875,6 +1875,7 @@ def applyCommit(self, id):
                 editedFiles.add(dest)
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
+                all_files.append(dest)
                 if self.p4HasMoveCommand:
                     p4_edit(src)        # src must be open before move
                     p4_move(src, dest)  # opens for (move/delete, move/add)
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 08dc8d2caf..4d5ea9e64c 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -548,7 +548,7 @@ test_expect_success 'submit --update-shelve' '
 	)
 '
 
-test_expect_failure 'update a shelve involving a moved file' '
+test_expect_success 'update a shelve involving a moved file' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$cli" &&
-- 
2.20.1.100.g9ee79a14a8

