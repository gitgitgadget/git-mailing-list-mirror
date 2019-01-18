Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE88D1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbfARJhI (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:37:08 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38377 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfARJhH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:37:07 -0500
Received: by mail-wr1-f53.google.com with SMTP id v13so14199160wrw.5
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0TzGOQ+kXoJiWzp1jWGaF02bOOhv0DrgAuLfLNfTLI=;
        b=U0KJm6MnBmtaIWwC6O0yn6puq9kSjzzv1nN1cKdAiBaCwIcHYTYC1zgpcoYAAI+msJ
         fwWza2K/VJXXU+yzZp6SK/7FCs7aglW1RhOeNcBxtyQrN2XC0JFJAam/t7bsg32NlojW
         Luc5g4qNwAY9JnB/IOddSc5+bCmy6xIF7aVhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0TzGOQ+kXoJiWzp1jWGaF02bOOhv0DrgAuLfLNfTLI=;
        b=jwYWVRMNfWRbBjA0oZRAA/i9w+kM26GfkBKGydQOzULazZBCsS/qZUQbq+q2OmU5Da
         DGP1gOq9M5j4xeGmUQ9hwSgtbmi3t1uITtzqzt8m04olIvIBsISn6zMLF1Nw+x6zBRSw
         eeUsyq5VfbAhb4qS/AlAND8TEmQyf7U8Q1lozBabo0r9djtPtuzkjHkwjLZ7c1WIriaj
         GtNR/N4NO2oX4DPHDMH4fcxfFx0nZkq7ErQYeaHXh1gXR+dGuAyp2gtKo15SGZEJYk9R
         /8UGCix+tyZMeoIFoM0uL3uTrdTphPT/Z0hxLONZ864/z1OEjqb84yWPkWo/CJBUzDcd
         YdYA==
X-Gm-Message-State: AJcUukf61eBsx25u8ALJk8Banu6bBdv7BbpSthfMoNlD0ssIgZSnS/Al
        KwyLzzGQAtuZGzjWJMgoj8wyChymgjI=
X-Google-Smtp-Source: ALg8bN7Q2LoGfoe41KJxT/tSRt/EiZ5O8oOi22oQVCsJ4Rp6Ra4zF2FQVRgyIxzL2cuxM6PWFVgaUw==
X-Received: by 2002:adf:f903:: with SMTP id b3mr16314590wrr.82.1547804225612;
        Fri, 18 Jan 2019 01:37:05 -0800 (PST)
Received: from ethel.local.diamand.org (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id x10sm103962059wrn.29.2019.01.18.01.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 01:37:05 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrew Oakley <aoakley@roku.com>,
        Romain Merland <merlorom@yahoo.fr>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 2/2] git-p4: handle update of moved/copied files when updating a shelve
Date:   Fri, 18 Jan 2019 09:36:56 +0000
Message-Id: <20190118093656.16521-3-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.100.g9ee79a14a8
In-Reply-To: <20190118093656.16521-2-luke@diamand.org>
References: <20190118093656.16521-1-luke@diamand.org>
 <20190118093656.16521-2-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perforce requires a complete list of files being operated on. If
git is updating an existing shelved changelist, then any files
which are moved or copied were not being added to this list.

Signed-off-by: Luke Diamand <luke@diamand.org>
Acked-by: Andrey Mazo <amazo@checkvideo.com>
---
 git-p4.py                | 2 ++
 t/t9807-git-p4-submit.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 1998c3e141..b1c262e13d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1859,6 +1859,7 @@ def applyCommit(self, id):
                     filesToAdd.remove(path)
             elif modifier == "C":
                 src, dest = diff['src'], diff['dst']
+                all_files.append(dest)
                 p4_integrate(src, dest)
                 pureRenameCopy.add(dest)
                 if diff['src_sha1'] != diff['dst_sha1']:
@@ -1875,6 +1876,7 @@ def applyCommit(self, id):
                 editedFiles.add(dest)
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
+                all_files.append(dest)
                 if self.p4HasMoveCommand:
                     p4_edit(src)        # src must be open before move
                     p4_move(src, dest)  # opens for (move/delete, move/add)
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 2ad3d801cc..099e5e079d 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -546,7 +546,7 @@ test_expect_success 'submit --update-shelve' '
 	)
 '
 
-test_expect_failure 'update a shelve involving moved and copied files' '
+test_expect_success 'update a shelve involving moved and copied files' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$cli" &&
-- 
2.20.1.100.g9ee79a14a8

