Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBEFC1F516
	for <e@80x24.org>; Sun,  1 Jul 2018 04:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeGAELo (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 00:11:44 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39269 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752281AbeGAELi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 00:11:38 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so3157817oib.6
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 21:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I3VH5DeYS9y2fXP9GEjRtVebg01riFT7Pm1zncObkmk=;
        b=fsqX3QRSp4r3VuMaMoYxiGTTtvxdKFiTgpTlp3RGUsVLGosRlbJT2N6NtuVo1UL739
         wr5VE/rzaSmnlSewjCTnS1oSRt9n9hvOHeOFmGU48qsaYgpLTVexkux+x5E66/b+iU4h
         GL2rMDpWqSmrianVSt5JV7CzXJOiuW7mNe7RufszyPhTGA+JqlYl8A2nuVwXrdN8PjhM
         C4NdEzqKWAaJIKnqccke9VRF2Nt/A+6b8B0qwyg2fPm3MqoHvRFUFc8N6j+eSy+EwFrb
         fEHli3gCnCFXhhxTDeLc9phwL/f0ZtCXMVQmzsqXr2UVQ+eaO+JDBF1WPjCPXlw0LwST
         KfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I3VH5DeYS9y2fXP9GEjRtVebg01riFT7Pm1zncObkmk=;
        b=cRcWWFh0R7VYtZiILTjDJxUrYMCEjABTk5SCYmo9y1q0ZGfMbOM4VWVevAv7AKlWgH
         0Lh2Ni1sROq1RaDsl2MpPLro5TpfDP5eo74AZzJltW2wpz773D7CYpyf7tBfJggmAbP/
         vanLH4ZwD4UNhKxgwOvZcJhIkA5sfqGirDTt291euI4ukppIK5kvz6zlxZV3mpONSp4H
         9TPlU9yahuEpqAp+NtTNKPRqjGQbIuZRtR+tLjG+1ttIOMdkS9XDaajtBWTinjw3D/Lx
         SPS5PTOkbJu995IhuHcztJuDZun/2wsL4/Uz9Q6SBXiGMby7aBw66C1EZYTvCUJM4/Dy
         A3Cw==
X-Gm-Message-State: APt69E2pruXgC7XKFp4lgBIkRAOIA3jjMRE2NN+M02GwCYONfe9D/qYJ
        wdHrdyGTfbsfoIZQaFmEHGhqXg==
X-Google-Smtp-Source: AAOMgpc9qz8WftVEF8HV9Y1dyKiTjhSHS3rN1HpnnKgbiLm5SHsgIRGPodRUo9iO0PxFkmq+3FStIQ==
X-Received: by 2002:aca:5885:: with SMTP id m127-v6mr8328013oib.99.1530418297797;
        Sat, 30 Jun 2018 21:11:37 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id m3-v6sm6222677oif.26.2018.06.30.21.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 21:11:37 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 6/6] t6036: add a failed conflict detection case: regular files, different modes
Date:   Sat, 30 Jun 2018 21:11:22 -0700
Message-Id: <20180701041122.8753-7-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.130.gd703bbb5d
In-Reply-To: <20180701041122.8753-1-newren@gmail.com>
References: <20180701041122.8753-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh | 67 +++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 8b997d7e5..f8f7b3046 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1189,4 +1189,71 @@ test_expect_failure 'check conflicting entry types (submodule vs symlink)' '
 	)
 '
 
+#
+# criss-cross with regular files that have conflicting modes:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: nothing of note
+#   Commit B: introduce file source_me.bash, not executable
+#   Commit C: introduce file source_me.bash, executable
+#   Commit D: merge B&C, resolving in favor of B
+#   Commit E: merge B&C, resolving in favor of C
+#
+# This is an obvious add/add mode conflict.  Can git detect it?
+
+test_expect_success 'setup conflicting modes for regular file' '
+	test_create_repo regular-file-mode-conflict &&
+	(
+		cd regular-file-mode-conflict &&
+
+		touch irrelevant-file &&
+		git add irrelevant-file &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		echo "export PATH=~/bin:$PATH" >source_me.bash &&
+		git add source_me.bash &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		echo "export PATH=~/bin:$PATH" >source_me.bash &&
+		git add source_me.bash &&
+		test_chmod +x source_me.bash &&
+		git commit -m C &&
+
+		git checkout -q B^0 &&
+		git merge -s ours -m D C^0 &&
+		git tag D &&
+
+		git checkout -q C^0 &&
+		git merge -s ours -m E B^0 &&
+		git tag E
+	)
+'
+
+test_expect_failure 'check conflicting modes for regular file' '
+	(
+		cd regular-file-mode-conflict &&
+
+		git checkout D^0 &&
+
+		test_must_fail git merge -s recursive E^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out
+	)
+'
+
 test_done
-- 
2.18.0.130.gd703bbb5d

