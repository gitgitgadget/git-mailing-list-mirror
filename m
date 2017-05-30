Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75AE2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbdE3RbZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:25 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36249 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdE3RbX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:23 -0400
Received: by mail-pf0-f170.google.com with SMTP id m17so78250832pfg.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sNlQ0gyxVMngtOswlY1d6NJPR4K+NFkKJTfn6+VeVtg=;
        b=ACkLOEuINbmiqrAu6gpmpD9Uvm3M7LAVbxRxG6SV7iTSxoR33wfsQRaKEToJTWpiIo
         O+X4ch4mdT8uvWWSrIm1KP5pAGj5w1iqWhR5n8ObjNDHM8fi8HHZW/dlrBtM211EsODE
         8Cu/xudBj3X6eDMkiXyxfekShaCt2VCrE4xXHPwsKa6nadYZBIU6ipXMymcm+M8YN31U
         n1fx/006v4tFRlOAAC/Ng0fhecV/xV8JLNJe+F22B4DQygqRYK/hgcM3pfcfdcyvj6lH
         y41G/XWzcxAZW6oX1fFkLYKq4r/1WgjqvorrZcBppnJ89je21m0Mz1gy8987ex2QqqkY
         WUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sNlQ0gyxVMngtOswlY1d6NJPR4K+NFkKJTfn6+VeVtg=;
        b=Tmkns/F6u+vQkvx6MAckVP+OrYSL3fNL5FTydlhnrSxUv0ihWJ8TxUXZQMHMUt4g+m
         nWS1IJ3bruJdH2uI40C0hUjwIsxRGo1ueZc2IhErYE9KKC2bRIh+vqkdZCh9j+lwzTgh
         j6IbTGdDKR6hsIx1xPHObbOCOOC5IPqP0GNPBIu5UuR3adCgNwm/TskRK1RHeOPHLZ50
         CEHFZELs3urnTEQBKxMiGIyjEA8WUxPxggv+9zRvOBOCP8bP7gqmv8kU11O/XDfxYbK2
         b1cmo7IoGNWlhiCcLpT+Toio+hfOPpBnkHfW3aVvmWW93NbcvkZT9irdLdEDYEX8q9Wh
         /4hg==
X-Gm-Message-State: AODbwcCKL6saaaehCNzeOfk6/25bsVIBXX+KiUlh/BL8ufm9Q/0fDNFy
        aonwUE2jan2J4Dn/
X-Received: by 10.84.224.77 with SMTP id a13mr84937847plt.132.1496165482820;
        Tue, 30 May 2017 10:31:22 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:21 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 05/33] notes: convert format_display_notes to struct object_id
Date:   Tue, 30 May 2017 10:30:41 -0700
Message-Id: <20170530173109.54904-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 log-tree.c | 2 +-
 notes.c    | 8 ++++----
 notes.h    | 2 +-
 revision.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index a4ec11c2b..9c0c64a2d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -655,7 +655,7 @@ void show_log(struct rev_info *opt)
 		struct strbuf notebuf = STRBUF_INIT;
 
 		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
-		format_display_notes(commit->object.oid.hash, &notebuf,
+		format_display_notes(&commit->object.oid, &notebuf,
 				     get_log_output_encoding(), raw);
 		ctx.notes_message = notebuf.len
 			? strbuf_detach(&notebuf, NULL)
diff --git a/notes.c b/notes.c
index fe4db2c1e..b5cabafde 100644
--- a/notes.c
+++ b/notes.c
@@ -1215,7 +1215,7 @@ void free_notes(struct notes_tree *t)
  * (raw != 0) gives the %N userformat; otherwise, the note message is given
  * for human consumption.
  */
-static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
+static void format_note(struct notes_tree *t, const struct object_id *object_oid,
 			struct strbuf *sb, const char *output_encoding, int raw)
 {
 	static const char utf8[] = "utf-8";
@@ -1229,7 +1229,7 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (!t->initialized)
 		init_notes(t, NULL, NULL, 0);
 
-	oid = get_note(t, object_sha1);
+	oid = get_note(t, object_oid->hash);
 	if (!oid)
 		return;
 
@@ -1277,13 +1277,13 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	free(msg);
 }
 
-void format_display_notes(const unsigned char *object_sha1,
+void format_display_notes(const struct object_id *object_oid,
 			  struct strbuf *sb, const char *output_encoding, int raw)
 {
 	int i;
 	assert(display_notes_trees);
 	for (i = 0; display_notes_trees[i]; i++)
-		format_note(display_notes_trees[i], object_sha1, sb,
+		format_note(display_notes_trees[i], object_oid, sb,
 			    output_encoding, raw);
 }
 
diff --git a/notes.h b/notes.h
index c72bb9710..a66532103 100644
--- a/notes.h
+++ b/notes.h
@@ -277,7 +277,7 @@ void init_display_notes(struct display_notes_opt *opt);
  *
  * You *must* call init_display_notes() before using this function.
  */
-void format_display_notes(const unsigned char *object_sha1,
+void format_display_notes(const struct object_id *object_oid,
 			  struct strbuf *sb, const char *output_encoding, int raw);
 
 /*
diff --git a/revision.c b/revision.c
index b02394530..475d5b2dc 100644
--- a/revision.c
+++ b/revision.c
@@ -2908,7 +2908,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (opt->show_notes) {
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
-		format_display_notes(commit->object.oid.hash, &buf, encoding, 1);
+		format_display_notes(&commit->object.oid, &buf, encoding, 1);
 	}
 
 	/*
-- 
2.13.0.219.gdb65acc882-goog

