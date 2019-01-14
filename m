Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790531F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 23:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfANXzi (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 18:55:38 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42133 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfANXzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 18:55:36 -0500
Received: by mail-wr1-f51.google.com with SMTP id q18so923455wrx.9
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 15:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BhSfjOv9cTVCyToxw3rjJjRAKG4zJ8Zu/IprPKxSksY=;
        b=LkSQCmP5PKHfWwm/yEAm0sI8x6nvndrWFIDLozQ2tzA1O8QgWV/SkSgaUQT3dI+C5B
         +ATEY+rEnNJAya/zuKHy2K61M+qyGEPWaxlkm3mZAEQmdHYqMlxVFuodgvGD+FUXV4id
         dSGlOOkVFddkuC+uxGhtfcxeZm9wpCox8/6cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhSfjOv9cTVCyToxw3rjJjRAKG4zJ8Zu/IprPKxSksY=;
        b=fEn/ZJPdYJhk8VNl0O+KIogUr/2S580hfSJ2h8XY8luq5EMsa/ZxZ1Ymy/GwNVbEu4
         DiABGGOhzLVBWTq8/vJWja0L7owBxhhscWdwkJ0c21sygGmeqnQwEEgerFrVz0b1oiAZ
         uUvqL4HZTJ18WqLJgDNCui5zDeCg4E9paU/yvqqGTiEvPp3hpw4bGOCzJJs5S6KmDVZT
         NhDhcHDhQa7VKN8RAIQ3GQ/gJyz1lzgkVqM2DsTIUYlaDoEbEXhvlY1CRWpmVmdDrKiR
         vPnG1SItnLt+luVDZRmrJEwxMjKcVB17KtE9oOKjYz6+H2ngrUjVCyo10AfkCUQKKxfT
         u46g==
X-Gm-Message-State: AJcUukfPjSjsT8WXJ+BNgCWkbPObOLPLq5cLtC5x8Xqg5WGvT2oW7mJ2
        py6C5I6M8eILgnoLpCEdvLbAzPefzLc=
X-Google-Smtp-Source: ALg8bN4d4lDu0fBKdCzTJANO8IZSIZP18x6hQmTo9CckjUkp/xtfCf0YyHTRM810AnAyJrYooRSykg==
X-Received: by 2002:adf:c888:: with SMTP id k8mr768274wrh.6.1547510133838;
        Mon, 14 Jan 2019 15:55:33 -0800 (PST)
Received: from ethel.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id x10sm89224806wrn.29.2019.01.14.15.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 15:55:33 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrew Oakley <aoakley@roku.com>,
        Romain Merland <merlorom@yahoo.fr>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 2/2] git-p4: handle update of moved files when updating a shelve
Date:   Mon, 14 Jan 2019 23:55:24 +0000
Message-Id: <20190114235524.3947-3-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.100.g9ee79a14a8
In-Reply-To: <20190114235524.3947-2-luke@diamand.org>
References: <20190114235524.3947-1-luke@diamand.org>
 <20190114235524.3947-2-luke@diamand.org>
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
index c390af56ad..c4ddd28f41 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -546,7 +546,7 @@ test_expect_success 'submit --update-shelve' '
 	)
 '
 
-test_expect_failure 'update a shelve involving a moved file' '
+test_expect_success 'update a shelve involving a moved file' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$cli" &&
-- 
2.20.1.100.g9ee79a14a8

