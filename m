Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F968C433E3
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCED20781
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSqWya9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403931AbgFXOqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391195AbgFXOql (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:46:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F4CC061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so2548210wrv.9
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WUPWeulKmQQH8FkbLGh+IcH9HZkPjnJ6yx1vD1e9ZYo=;
        b=fSqWya9j8cXdCQUzj+WUfqmwjiaPJmSUlZ28zHclKEStDAZjzS4z8YUP6UTyorlJtp
         is4gVLg5ZLi3oW/ZcAFK0gQOG/WYXYFhX0erJ9J7ACwj2ON1NJD8A7guPp6/8LPC9WIf
         MHOuP+eaNA3fKKUnRL9X01jj47lxXeWCA9btwKV1S4u/X8z3YqlIkF9SGU+EZIHAB+cH
         GafJ0/HYsFzbiPBg+0ImVYgu86BvyBOtFFPOTPAtMqZy5QUfn+yztNhnY9/VZrIaaXNH
         X84XoC4vHBAEdIigBt83B7KvFX6ncjjjtkEQU2bmEX6+1QiVc8W4Egzwtrql0+Vv4vGc
         Pw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WUPWeulKmQQH8FkbLGh+IcH9HZkPjnJ6yx1vD1e9ZYo=;
        b=U2Jft0thFFPZSqyw4SQEBh4xGQ/fKbQjSQI6/OX7uRzAA78qAwDeeaJsA2wrrWedve
         lnwhrqoDYPZ0dPlhYsRoRREt54B2iC7jpTSg2gdC0xG47ntOHzoM4FLEiLPL0KEYe6wd
         l9be2OTxGGmD0zJgB3zHHdh1r5w/MDAaq/lDrKgRwfP+U4q4apVLrap81KjyF+sHGFWw
         hjopjKyn7l9Qw3Y1//3HuAoWF0dKV6XKa38KiA2zINyRcMyCzbWCsB73gBIEnrzILvZ3
         h7OlEMY9yUUulWxv6WIY2gDzA2HbYqfXpsOuosOeHOkxCBD+in/z8BOneB9XCtKzBpxi
         89WQ==
X-Gm-Message-State: AOAM531blb5BAXaPDEOcKb8HBMvWEPGTZRRdZcN6CCYz2aDwi5tYHdUz
        cHB53iziK99uMpqx7VOK7eLvXiqftik=
X-Google-Smtp-Source: ABdhPJy+zymm1IOqbZPyVdRowOwZKaEB+2cnbmrr5N8WSZOSxQvV1wZFnzhL5WZ5ccdMZwrLoCnCcA==
X-Received: by 2002:adf:916a:: with SMTP id j97mr11999448wrj.231.1593009998745;
        Wed, 24 Jun 2020 07:46:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm27151304wrc.22.2020.06.24.07.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:46:38 -0700 (PDT)
Message-Id: <fffdb9944fc2672ccb7eac776cdd18855a1f99dc.1593009996.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:46:28 +0000
Subject: [PATCH v4 1/9] fmt-merge-msg: stop treating `master` specially
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the context of many projects renaming their primary branch names away
from `master`, Git wants to stop treating the `master` branch specially.

Let's start with `git fmt-merge-msg`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fmt-merge-msg.c                               |  5 +-
 t/t1507-rev-parse-upstream.sh                 |  2 +-
 t/t4013-diff-various.sh                       |  4 +-
 t/t4013/diff.log_--decorate=full_--all        |  2 +-
 t/t4013/diff.log_--decorate_--all             |  2 +-
 ...--patch-with-stat_--summary_master_--_dir_ |  2 +-
 t/t4013/diff.log_--patch-with-stat_master     |  2 +-
 .../diff.log_--patch-with-stat_master_--_dir_ |  2 +-
 ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
 ..._--root_--patch-with-stat_--summary_master |  2 +-
 .../diff.log_--root_--patch-with-stat_master  |  2 +-
 ...root_-c_--patch-with-stat_--summary_master |  2 +-
 t/t4013/diff.log_--root_-p_master             |  2 +-
 t/t4013/diff.log_--root_master                |  2 +-
 t/t4013/diff.log_-m_-p_--first-parent_master  |  2 +-
 t/t4013/diff.log_-m_-p_master                 |  4 +-
 t/t4013/diff.log_-p_--first-parent_master     |  2 +-
 t/t4013/diff.log_-p_master                    |  2 +-
 t/t4013/diff.log_master                       |  2 +-
 t/t4013/diff.show_--first-parent_master       |  2 +-
 t/t4013/diff.show_-c_master                   |  2 +-
 t/t4013/diff.show_-m_master                   |  4 +-
 t/t4013/diff.show_master                      |  2 +-
 ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
 ...root_-c_--patch-with-stat_--summary_master |  2 +-
 t/t4202-log.sh                                | 72 +++++++++----------
 t/t6200-fmt-merge-msg.sh                      | 36 +++++-----
 t/t7600-merge.sh                              | 14 ++--
 t/t7608-merge-messages.sh                     | 10 +--
 29 files changed, 94 insertions(+), 97 deletions(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 72d32bd73b..cfb8ff2f33 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -451,10 +451,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
 			strbuf_addf(out, " of %s", srcs.items[i].string);
 	}
 
-	if (!strcmp("master", current_branch))
-		strbuf_addch(out, '\n');
-	else
-		strbuf_addf(out, " into %s\n", current_branch);
+	strbuf_addf(out, " into %s\n", current_branch);
 }
 
 static void fmt_tag_signature(struct strbuf *tagbuf,
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index dfc0d96d8a..f213aa8053 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -137,7 +137,7 @@ test_expect_success 'merge my-side@{u} records the correct name' '
 	git branch -t new my-side@{u} &&
 	git merge -s ours new@{u} &&
 	git show -s --pretty=tformat:%s >actual &&
-	echo "Merge remote-tracking branch ${SQ}origin/side${SQ}" >expect &&
+	echo "Merge remote-tracking branch ${SQ}origin/side${SQ} into master" >expect &&
 	test_cmp expect actual
 )
 '
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 3f60f7d96c..43267d6024 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -117,12 +117,12 @@ test_expect_success setup '
 
 : <<\EOF
 ! [initial] Initial
- * [master] Merge branch 'side'
+ * [master] Merge branch 'side' into master
   ! [rearrange] Rearranged lines in dir/sub
    ! [side] Side
 ----
   +  [rearrange] Rearranged lines in dir/sub
- -   [master] Merge branch 'side'
+ -   [master] Merge branch 'side' into master
  * + [side] Side
  *   [master^] Third
  *   [master~2] Second
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index 3f9b872ece..c56783b985 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -31,7 +31,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index f5e20e1e14..1cbdc038f4 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -31,7 +31,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
index a18f1472a9..f5b1b6516b 100644
--- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.log_--patch-with-stat_master
index ae425c4672..af23803cdc 100644
--- a/t/t4013/diff.log_--patch-with-stat_master
+++ b/t/t4013/diff.log_--patch-with-stat_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
index d5207cadf4..814098fbf8 100644
--- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
index 0fc1e8cd71..b927fe4a98 100644
--- a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
index dffc09dde9..6db3cea329 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013/diff.log_--root_--patch-with-stat_master
index 55aa98012d..98e9c320c3 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
index 019d85f7de..b61b1117ae 100644
--- a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.log_--root_-p_master b/t/t4013/diff.log_--root_-p_master
index b42c334439..345bd9e8a9 100644
--- a/t/t4013/diff.log_--root_-p_master
+++ b/t/t4013/diff.log_--root_-p_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_master b/t/t4013/diff.log_--root_master
index e8f46159da..db56b1fe6b 100644
--- a/t/t4013/diff.log_--root_master
+++ b/t/t4013/diff.log_--root_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-m_-p_--first-parent_master b/t/t4013/diff.log_-m_-p_--first-parent_master
index 7a0073f529..bcadb50e26 100644
--- a/t/t4013/diff.log_-m_-p_--first-parent_master
+++ b/t/t4013/diff.log_-m_-p_--first-parent_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
diff --git a/t/t4013/diff.log_-m_-p_master b/t/t4013/diff.log_-m_-p_master
index 9ca62a01ed..2acf43a9fb 100644
--- a/t/t4013/diff.log_-m_-p_master
+++ b/t/t4013/diff.log_-m_-p_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
@@ -33,7 +33,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 diff --git a/dir/sub b/dir/sub
 index 7289e35..992913c 100644
diff --git a/t/t4013/diff.log_-p_--first-parent_master b/t/t4013/diff.log_-p_--first-parent_master
index 3fc896d424..c6a5876d80 100644
--- a/t/t4013/diff.log_-p_--first-parent_master
+++ b/t/t4013/diff.log_-p_--first-parent_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-p_master b/t/t4013/diff.log_-p_master
index bf1326dc36..1841cded94 100644
--- a/t/t4013/diff.log_-p_master
+++ b/t/t4013/diff.log_-p_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_master b/t/t4013/diff.log_master
index a8f6ce5abd..f8ec445eb3 100644
--- a/t/t4013/diff.log_master
+++ b/t/t4013/diff.log_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.show_--first-parent_master b/t/t4013/diff.show_--first-parent_master
index 3dcbe473a0..94548f4598 100644
--- a/t/t4013/diff.show_--first-parent_master
+++ b/t/t4013/diff.show_--first-parent_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
diff --git a/t/t4013/diff.show_-c_master b/t/t4013/diff.show_-c_master
index 81aba8da96..1c46ed64fd 100644
--- a/t/t4013/diff.show_-c_master
+++ b/t/t4013/diff.show_-c_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 diff --combined dir/sub
 index cead32e,7289e35..992913c
diff --git a/t/t4013/diff.show_-m_master b/t/t4013/diff.show_-m_master
index 4ea2ee453d..7559fc22f8 100644
--- a/t/t4013/diff.show_-m_master
+++ b/t/t4013/diff.show_-m_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
@@ -33,7 +33,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 diff --git a/dir/sub b/dir/sub
 index 7289e35..992913c 100644
diff --git a/t/t4013/diff.show_master b/t/t4013/diff.show_master
index fb08ce0e46..57091c5d90 100644
--- a/t/t4013/diff.show_master
+++ b/t/t4013/diff.show_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
 diff --cc dir/sub
 index cead32e,7289e35..992913c
diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
index 30aae7817b..5f13a71bb5 100644
--- a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
index d1d32bd34c..8acb88267b 100644
--- a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-    Merge branch 'side'
+    Merge branch 'side' into master
 
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index a0930599aa..fd9af658af 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -483,7 +483,7 @@ test_expect_success 'set up merge history' '
 '
 
 cat > expect <<\EOF
-*   Merge branch 'side'
+*   Merge branch 'side' into master
 |\
 | * side-2
 | * side-1
@@ -502,7 +502,7 @@ test_expect_success 'log --graph with merge' '
 '
 
 cat > expect <<\EOF
-| | | *   Merge branch 'side'
+| | | *   Merge branch 'side' into master
 | | | |\
 | | | | * side-2
 | | | | * side-1
@@ -521,7 +521,7 @@ test_expect_success 'log --graph --line-prefix="| | | " with merge' '
 '
 
 cat > expect.colors <<\EOF
-*   Merge branch 'side'
+*   Merge branch 'side' into master
 <BLUE>|<RESET><CYAN>\<RESET>
 <BLUE>|<RESET> * side-2
 <BLUE>|<RESET> * side-1
@@ -555,7 +555,7 @@ cat > expect <<\EOF
 |\  Merge: A B
 | | Author: A U Thor <author@example.com>
 | |
-| |     Merge branch 'side'
+| |     Merge branch 'side' into master
 | |
 | * commit tags/side-2
 | | Author: A U Thor <author@example.com>
@@ -632,11 +632,11 @@ test_expect_success 'set up more tangled history' '
 '
 
 cat > expect <<\EOF
-*   Merge tag 'reach'
+*   Merge tag 'reach' into master
 |\
 | \
 |  \
-*-. \   Merge tags 'octopus-a' and 'octopus-b'
+*-. \   Merge tags 'octopus-a' and 'octopus-b' into master
 |\ \ \
 * | | | seventh
 | | * | octopus-b
@@ -646,14 +646,14 @@ cat > expect <<\EOF
 |/ /
 | * reach
 |/
-*   Merge branch 'tangle'
+*   Merge branch 'tangle' into master
 |\
 | *   Merge branch 'side' (early part) into tangle
 | |\
 | * \   Merge branch 'master' (early part) into tangle
 | |\ \
 | * | | tangle-a
-* | | |   Merge branch 'side'
+* | | |   Merge branch 'side' into master
 |\ \ \ \
 | * | | | side-2
 | | |_|/
@@ -735,16 +735,16 @@ test_expect_success 'log.decorate configuration' '
 
 test_expect_success 'decorate-refs with glob' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tag-reach-into-master
+	Merge-tags-octopus-a-and-octopus-b-into-master
 	seventh
 	octopus-b (octopus-b)
 	octopus-a (octopus-a)
 	reach
 	EOF
 	cat >expect.no-decorate <<-\EOF &&
-	Merge-tag-reach
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tag-reach-into-master
+	Merge-tags-octopus-a-and-octopus-b-into-master
 	seventh
 	octopus-b
 	octopus-a
@@ -765,8 +765,8 @@ test_expect_success 'decorate-refs with glob' '
 
 test_expect_success 'decorate-refs without globs' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tag-reach-into-master
+	Merge-tags-octopus-a-and-octopus-b-into-master
 	seventh
 	octopus-b
 	octopus-a
@@ -779,8 +779,8 @@ test_expect_success 'decorate-refs without globs' '
 
 test_expect_success 'multiple decorate-refs' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tag-reach-into-master
+	Merge-tags-octopus-a-and-octopus-b-into-master
 	seventh
 	octopus-b (octopus-b)
 	octopus-a (octopus-a)
@@ -794,8 +794,8 @@ test_expect_success 'multiple decorate-refs' '
 
 test_expect_success 'decorate-refs-exclude with glob' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach (HEAD -> master)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tag-reach-into-master (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b-into-master
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
 	octopus-a (tag: octopus-a)
@@ -811,8 +811,8 @@ test_expect_success 'decorate-refs-exclude with glob' '
 
 test_expect_success 'decorate-refs-exclude without globs' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach (HEAD -> master)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tag-reach-into-master (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b-into-master
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b, octopus-b)
 	octopus-a (tag: octopus-a, octopus-a)
@@ -828,8 +828,8 @@ test_expect_success 'decorate-refs-exclude without globs' '
 
 test_expect_success 'multiple decorate-refs-exclude' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach (HEAD -> master)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tag-reach-into-master (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b-into-master
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
 	octopus-a (tag: octopus-a)
@@ -851,8 +851,8 @@ test_expect_success 'multiple decorate-refs-exclude' '
 
 test_expect_success 'decorate-refs and decorate-refs-exclude' '
 	cat >expect.no-decorate <<-\EOF &&
-	Merge-tag-reach (master)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tag-reach-into-master (master)
+	Merge-tags-octopus-a-and-octopus-b-into-master
 	seventh
 	octopus-b
 	octopus-a
@@ -866,8 +866,8 @@ test_expect_success 'decorate-refs and decorate-refs-exclude' '
 
 test_expect_success 'deocrate-refs and log.excludeDecoration' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach (master)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tag-reach-into-master (master)
+	Merge-tags-octopus-a-and-octopus-b-into-master
 	seventh
 	octopus-b (octopus-b)
 	octopus-a (octopus-a)
@@ -881,10 +881,10 @@ test_expect_success 'deocrate-refs and log.excludeDecoration' '
 
 test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach (HEAD -> master)
+	Merge-tag-reach-into-master (HEAD -> master)
 	reach (tag: reach, reach)
 	seventh (tag: seventh)
-	Merge-branch-tangle
+	Merge-branch-tangle-into-master
 	Merge-branch-side-early-part-into-tangle (tangle)
 	tangle-a (tag: tangle-a)
 	EOF
@@ -1068,7 +1068,7 @@ cat >expect <<\EOF
 |\  Merge: MERGE_PARENTS
 | | Author: A U Thor <author@example.com>
 | |
-| |     Merge branch 'tangle'
+| |     Merge branch 'tangle' into master
 | |
 | *   commit COMMIT_OBJECT_NAME
 | |\  Merge: MERGE_PARENTS
@@ -1102,7 +1102,7 @@ cat >expect <<\EOF
 |\ \ \ \  Merge: MERGE_PARENTS
 | | | | | Author: A U Thor <author@example.com>
 | | | | |
-| | | | |     Merge branch 'side'
+| | | | |     Merge branch 'side' into master
 | | | | |
 | * | | | commit COMMIT_OBJECT_NAME
 | | |_|/  Author: A U Thor <author@example.com>
@@ -1343,7 +1343,7 @@ cat >expect <<\EOF
 *** |\  Merge: MERGE_PARENTS
 *** | | Author: A U Thor <author@example.com>
 *** | |
-*** | |     Merge branch 'tangle'
+*** | |     Merge branch 'tangle' into master
 *** | |
 *** | *   commit COMMIT_OBJECT_NAME
 *** | |\  Merge: MERGE_PARENTS
@@ -1377,7 +1377,7 @@ cat >expect <<\EOF
 *** |\ \ \ \  Merge: MERGE_PARENTS
 *** | | | | | Author: A U Thor <author@example.com>
 *** | | | | |
-*** | | | | |     Merge branch 'side'
+*** | | | | |     Merge branch 'side' into master
 *** | | | | |
 *** | * | | | commit COMMIT_OBJECT_NAME
 *** | | |_|/  Author: A U Thor <author@example.com>
@@ -1540,8 +1540,8 @@ cat >expect <<-\EOF
 * reach
 |
 | A	reach.t
-* Merge branch 'tangle'
-*   Merge branch 'side'
+* Merge branch 'tangle' into master
+*   Merge branch 'side' into master
 |\
 | * side-2
 |
@@ -1562,8 +1562,8 @@ cat >expect <<-\EOF
 * reach
 |
 | reach.t
-* Merge branch 'tangle'
-*   Merge branch 'side'
+* Merge branch 'tangle' into master
+*   Merge branch 'side' into master
 |\
 | * side-2
 |
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index e4c2a6eca4..2b3fd498d0 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -79,7 +79,7 @@ test_expect_success GPG 'set up a signed tag' '
 '
 
 test_expect_success 'message for merging local branch' '
-	echo "Merge branch ${apos}left${apos}" >expected &&
+	echo "Merge branch ${apos}left${apos} into master" >expected &&
 
 	git checkout master &&
 	git fetch . left &&
@@ -107,7 +107,7 @@ test_expect_success GPG 'message for merging local tag signed by unknown key' '
 '
 
 test_expect_success 'message for merging external branch' '
-	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
+	echo "Merge branch ${apos}left${apos} of $(pwd) into master" >expected &&
 
 	git checkout master &&
 	git fetch "$(pwd)" left &&
@@ -118,7 +118,7 @@ test_expect_success 'message for merging external branch' '
 
 test_expect_success '[merge] summary/log configuration' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos}
+	Merge branch ${apos}left${apos} into master
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -160,7 +160,7 @@ test_expect_success 'setup FETCH_HEAD' '
 
 test_expect_success 'merge.log=3 limits shortlog length' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos}
+	Merge branch ${apos}left${apos} into master
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -177,7 +177,7 @@ test_expect_success 'merge.log=3 limits shortlog length' '
 
 test_expect_success 'merge.log=5 shows all 5 commits' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos}
+	Merge branch ${apos}left${apos} into master
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -195,7 +195,7 @@ test_expect_success 'merge.log=5 shows all 5 commits' '
 
 test_expect_success '--log=5 with custom comment character' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos}
+	Merge branch ${apos}left${apos} into master
 
 	x By Another Author (3) and A U Thor (2)
 	x Via Another Committer
@@ -212,14 +212,14 @@ test_expect_success '--log=5 with custom comment character' '
 '
 
 test_expect_success 'merge.log=0 disables shortlog' '
-	echo "Merge branch ${apos}left${apos}" >expected &&
+	echo "Merge branch ${apos}left${apos} into master" >expected &&
 	git -c merge.log=0 fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success '--log=3 limits shortlog length' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos}
+	Merge branch ${apos}left${apos} into master
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -236,7 +236,7 @@ test_expect_success '--log=3 limits shortlog length' '
 
 test_expect_success '--log=5 shows all 5 commits' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos}
+	Merge branch ${apos}left${apos} into master
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -253,13 +253,13 @@ test_expect_success '--log=5 shows all 5 commits' '
 '
 
 test_expect_success '--no-log disables shortlog' '
-	echo "Merge branch ${apos}left${apos}" >expected &&
+	echo "Merge branch ${apos}left${apos} into master" >expected &&
 	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success '--log=0 disables shortlog' '
-	echo "Merge branch ${apos}left${apos}" >expected &&
+	echo "Merge branch ${apos}left${apos} into master" >expected &&
 	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
@@ -300,7 +300,7 @@ test_expect_success 'fmt-merge-msg -m' '
 
 test_expect_success 'setup: expected shortlog for two branches' '
 	cat >expected <<-EOF
-	Merge branches ${apos}left${apos} and ${apos}right${apos}
+	Merge branches ${apos}left${apos} and ${apos}right${apos} into master
 
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -397,7 +397,7 @@ test_expect_success 'merge-msg with nothing to merge' '
 
 test_expect_success 'merge-msg tag' '
 	cat >expected <<-EOF &&
-	Merge tag ${apos}tag-r3${apos}
+	Merge tag ${apos}tag-r3${apos} into master
 
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
@@ -418,7 +418,7 @@ test_expect_success 'merge-msg tag' '
 
 test_expect_success 'merge-msg two tags' '
 	cat >expected <<-EOF &&
-	Merge tags ${apos}tag-r3${apos} and ${apos}tag-l5${apos}
+	Merge tags ${apos}tag-r3${apos} and ${apos}tag-l5${apos} into master
 
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
@@ -448,7 +448,7 @@ test_expect_success 'merge-msg two tags' '
 
 test_expect_success 'merge-msg tag and branch' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos}, tag ${apos}tag-r3${apos}
+	Merge branch ${apos}left${apos}, tag ${apos}tag-r3${apos} into master
 
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
@@ -479,7 +479,7 @@ test_expect_success 'merge-msg tag and branch' '
 test_expect_success 'merge-msg lots of commits' '
 	{
 		cat <<-EOF &&
-		Merge branch ${apos}long${apos}
+		Merge branch ${apos}long${apos} into master
 
 		* long: (35 commits)
 		EOF
@@ -516,7 +516,7 @@ test_expect_success 'merge-msg with "merging" an annotated tag' '
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	{
 		cat <<-\EOF
-		Merge tag '\''annote'\''
+		Merge tag '\''annote'\'' into master
 
 		An annotated one
 
@@ -531,7 +531,7 @@ test_expect_success 'merge-msg with "merging" an annotated tag' '
 	git merge --no-commit --no-ff $annote &&
 	{
 		cat <<-EOF
-		Merge tag '\''$annote'\''
+		Merge tag '\''$annote'\'' into master
 
 		An annotated one
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 5883a6adc3..1d45f9a4ed 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -14,9 +14,9 @@ Testing basic merge operations/option parsing.
     ! [c4] c4
      ! [c5] c5
       ! [c6] c6
-       * [master] Merge commit 'c1'
+       * [master] Merge commit 'c1' into master
 --------
-       - [master] Merge commit 'c1'
+       - [master] Merge commit 'c1' into master
  +     * [c1] commit 1
       +  [c6] c6
      +   [c5] c5
@@ -44,8 +44,8 @@ test_write_lines '1 X' 2 '3 X' 4 '5 X' 6 7 8 '9 X' >result.1-3-5-9
 test_write_lines 1 2 3 4 5 6 7 8 '9 Z' >result.9z
 
 create_merge_msgs () {
-	echo "Merge tag 'c2'" >msg.1-5 &&
-	echo "Merge tags 'c2' and 'c3'" >msg.1-5-9 &&
+	echo "Merge tag 'c2' into master" >msg.1-5 &&
+	echo "Merge tags 'c2' and 'c3' into master" >msg.1-5-9 &&
 	{
 		echo "Squashed commit of the following:" &&
 		echo &&
@@ -258,7 +258,7 @@ test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
 	git commit --no-edit -a &&
 
 	cat >expect <<-\EOF &&
-	Merge tag '"'"'c7'"'"'
+	Merge tag '"'"'c7'"'"' into master
 
 	# ------------------------ >8 ------------------------
 	# Do not modify or remove the line above.
@@ -808,10 +808,10 @@ test_expect_success 'merge with conflicted --autostash changes' '
 '
 
 cat >expected.branch <<\EOF
-Merge branch 'c5-branch' (early part)
+Merge branch 'c5-branch' (early part) into master
 EOF
 cat >expected.tag <<\EOF
-Merge commit 'c5~1'
+Merge commit 'c5~1' into master
 EOF
 
 test_expect_success 'merge early part of c2' '
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 8e7e0a5865..2af33f195b 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -16,7 +16,7 @@ test_expect_success 'merge local branch' '
 	git checkout master &&
 	test_commit master-2 &&
 	git merge local-branch &&
-	check_oneline "Merge branch Qlocal-branchQ"
+	check_oneline "Merge branch Qlocal-branchQ into master"
 '
 
 test_expect_success 'merge octopus branches' '
@@ -26,7 +26,7 @@ test_expect_success 'merge octopus branches' '
 	test_commit octopus-2 &&
 	git checkout master &&
 	git merge octopus-a octopus-b &&
-	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ"
+	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ into master"
 '
 
 test_expect_success 'merge tag' '
@@ -35,7 +35,7 @@ test_expect_success 'merge tag' '
 	git checkout master &&
 	test_commit master-3 &&
 	git merge tag-1 &&
-	check_oneline "Merge tag Qtag-1Q"
+	check_oneline "Merge tag Qtag-1Q into master"
 '
 
 test_expect_success 'ambiguous tag' '
@@ -44,7 +44,7 @@ test_expect_success 'ambiguous tag' '
 	git checkout master &&
 	test_commit master-4 &&
 	git merge ambiguous &&
-	check_oneline "Merge tag QambiguousQ"
+	check_oneline "Merge tag QambiguousQ into master"
 '
 
 test_expect_success 'remote-tracking branch' '
@@ -54,7 +54,7 @@ test_expect_success 'remote-tracking branch' '
 	git checkout master &&
 	test_commit master-5 &&
 	git merge origin/master &&
-	check_oneline "Merge remote-tracking branch Qorigin/masterQ"
+	check_oneline "Merge remote-tracking branch Qorigin/masterQ into master"
 '
 
 test_done
-- 
gitgitgadget

