Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9411F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754449AbeAGSPZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:25 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45217 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754445AbeAGSPY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:24 -0500
Received: by mail-qt0-f196.google.com with SMTP id g10so11261361qtj.12
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LltNVmSW+Vb+3UKbjZvz1Mk+ZKxtHfCVCjUhN4fgYvE=;
        b=G1H+hs+1C5FYlv6ZBg7iyY/s6mRoP/L7DIh840j3ji/TMt9BOzNW+HxmzOdYarq09C
         nngGlmQIonJ0HKRujML299jPZMeWlPSGuo2fpHRs3WneilobVKMpvPfjgt1iCi0njWeB
         BkZosUizqR0IFrdM8PAA2T6j/RV0fUxDoH9mblKvQ5rgfa6iGvmOTd1uobZRMXV5v9f7
         /0YNjba/Qc/NlHTggvOOpifde/DR4/5/TNyJxgw36EVaI1LkjlZCvfeSPTlkZluXfgLH
         8SbGSGPHDlREob5qjftQlXdvPace7bJq9toHSi8ulGn70xkNFyzGyyxr8lZ5ik1AoROC
         fCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LltNVmSW+Vb+3UKbjZvz1Mk+ZKxtHfCVCjUhN4fgYvE=;
        b=aeKfNWOR1Qtx1xeVolaKreoU4gKboXRwzCDk5IQK6fF2vS89eEkIO6EFxOHueUSZ7Z
         Jspz5HKc/S6FsFFshOTqhfWNUG7qFum7QllfbxAyqi8tQ1duRn3E/jhS6RSxla/SGLfS
         wxO/4ju212qEw7NJeZqkojc+Clpc4WspMoKPPilAxomNbSQ5TtU2D/AQel9cUZyLnXTT
         x3lHGzMErK9c6ByEpknt5j+K2jpruW10NrkjKtv5PB5tp+Xoak3RMUWxmWJQsiyqA4JJ
         xWmzqpvf7YozbP1x7LOVNcY03ZTR9v9WuOLb3D+kJRShbT9eVXdHMvHO6R5aMXtxo+fc
         SMKw==
X-Gm-Message-State: AKwxytfsdDenpptkh9LBJVnCX97mzg7WAWRSTAZghIRBzIB2w9Jhhg6n
        4usgsMQLO+KKZh1OL9WIzK4RtOjauiQ=
X-Google-Smtp-Source: ACJfBot0Q59psbc0HEeqTNBxEdVGY6QicTRofA/QAlyWjj4dQ+2+TOmSAUBrhNar1PSp1tRSqYz32g==
X-Received: by 10.200.8.69 with SMTP id x5mr13926500qth.182.1515348923099;
        Sun, 07 Jan 2018 10:15:23 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:21 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 12/18] midx: teach git-midx to delete expired files
Date:   Sun,  7 Jan 2018 13:14:53 -0500
Message-Id: <20180107181459.222909-13-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we write new MIDX files, the existing files are probably not needed. Supply
the "--delete-expired" flag to remove these files during the "--write" sub-
command.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-midx.txt |  4 ++++
 builtin/midx.c             | 15 ++++++++++++++-
 midx.c                     | 26 ++++++++++++++++++++++++++
 midx.h                     |  2 ++
 packfile.c                 |  2 +-
 packfile.h                 |  1 +
 t/t5318-midx.sh            |  9 ++++++---
 7 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
index c184d3a593..4635247d0d 100644
--- a/Documentation/git-midx.txt
+++ b/Documentation/git-midx.txt
@@ -43,6 +43,10 @@ OPTIONS
 	If specified with --write, update the midx-head file to point to
 	the written midx file.
 
+--delete-expired::
+	If specified with --write and --update-head, delete the midx file
+	previously pointed to by midx-head (if changed).
+
 EXAMPLES
 --------
 
diff --git a/builtin/midx.c b/builtin/midx.c
index b30ef36ff8..6f56f39390 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -10,7 +10,7 @@
 
 static char const * const builtin_midx_usage[] = {
 	N_("git midx [--pack-dir <packdir>]"),
-	N_("git midx --write [--update-head] [--pack-dir <packdir>]"),
+	N_("git midx --write [--update-head [--delete-expired]] [--pack-dir <packdir>]"),
 	N_("git midx --clear [--pack-dir <packdir>]"),
 	NULL
 };
@@ -22,6 +22,7 @@ static struct opts_midx {
 	const char *midx_id;
 	int write;
 	int update_head;
+	int delete_expired;
 	int has_existing;
 	struct object_id old_midx_oid;
 } opts;
@@ -276,6 +277,16 @@ static int midx_write(void)
 	if (opts.update_head)
 		update_head_file(opts.pack_dir, midx_id);
 
+	if (opts.delete_expired && opts.update_head && opts.has_existing &&
+	    strcmp(midx_id, oid_to_hex(&opts.old_midx_oid))) {
+		char *old_path = get_midx_filename_oid(opts.pack_dir, &opts.old_midx_oid);
+		close_midx(midx);
+		if (remove_path(old_path))
+			die("failed to remove path %s", old_path);
+
+		free(old_path);
+	}
+
 cleanup:
 	if (pack_names)
 		FREE_AND_NULL(pack_names);
@@ -300,6 +311,8 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
 			N_("write midx file")),
 		OPT_BOOL('u', "update-head", &opts.update_head,
 			N_("update midx-head to written midx file")),
+		OPT_BOOL('d', "delete-expired", &opts.delete_expired,
+			N_("delete expired head midx file")),
 		OPT_END(),
 	};
 
diff --git a/midx.c b/midx.c
index 53eb29dac3..3ce2b736ea 100644
--- a/midx.c
+++ b/midx.c
@@ -651,3 +651,29 @@ const char *write_midx_file(const char *pack_dir,
 
 	return final_hex;
 }
+
+int close_midx(struct midxed_git *m)
+{
+	int i;
+	if (m->midx_fd < 0)
+		return 0;
+
+	for (i = 0; i < m->num_packs; i++) {
+		if (m->packs[i]) {
+			close_pack(m->packs[i]);
+			free(m->packs[i]);
+			m->packs[i] = NULL;
+		}
+	}
+
+	munmap((void *)m->data, m->data_len);
+	m->data = 0;
+
+	close(m->midx_fd);
+	m->midx_fd = -1;
+
+	free(m->packs);
+	free(m->pack_names);
+
+	return 1;
+}
diff --git a/midx.h b/midx.h
index 1e7a94651c..27d48163e9 100644
--- a/midx.h
+++ b/midx.h
@@ -117,4 +117,6 @@ extern const char *write_midx_file(const char *pack_dir,
 				   struct pack_midx_entry **objects,
 				   uint32_t nr_objects);
 
+extern int close_midx(struct midxed_git *m);
+
 #endif
diff --git a/packfile.c b/packfile.c
index 4a5fe7ab18..c36420b33f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -299,7 +299,7 @@ void close_pack_index(struct packed_git *p)
 	}
 }
 
-static void close_pack(struct packed_git *p)
+void close_pack(struct packed_git *p)
 {
 	close_pack_windows(p);
 	close_pack_fd(p);
diff --git a/packfile.h b/packfile.h
index 0cdeb54dcd..7cf4771029 100644
--- a/packfile.h
+++ b/packfile.h
@@ -61,6 +61,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
+extern void close_pack(struct packed_git *p);
 extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
diff --git a/t/t5318-midx.sh b/t/t5318-midx.sh
index 9337355ab3..42d103c879 100755
--- a/t/t5318-midx.sh
+++ b/t/t5318-midx.sh
@@ -75,6 +75,7 @@ test_expect_success 'write-midx with two packs' \
     'pack3=$(git rev-list --objects commit2 ^commit1 | git pack-objects --index-version=2 ${packdir}/test-3) &&
      midx3=$(git midx --write --update-head) &&
      test_path_is_file ${packdir}/midx-${midx3}.midx &&
+     test_path_is_file ${packdir}/midx-${midx2}.midx &&
      test_path_is_file ${packdir}/midx-head &&
      test $(cat ${packdir}/midx-head) = "$midx3" &&
      _midx_read_expect \
@@ -107,8 +108,10 @@ test_expect_success 'Add more packs' \
      done'
 
 test_expect_success 'write-midx with twelve packs' \
-    'midx4=$(git midx --write --update-head) &&
+    'midx4=$(git midx --write --update-head --delete-expired) &&
      test_path_is_file ${packdir}/midx-${midx4}.midx &&
+     test_path_is_missing ${packdir}/midx-${midx3}.midx &&
+     test_path_is_file ${packdir}/midx-${midx2}.midx &&
      test_path_is_file ${packdir}/midx-head &&
      test $(cat ${packdir}/midx-head) = "$midx4" &&
      _midx_read_expect \
@@ -118,7 +121,7 @@ test_expect_success 'write-midx with twelve packs' \
      cmp output expect'
 
 test_expect_success 'write-midx with no new packs' \
-    'midx5=$(git midx --write --update-head) &&
+    'midx5=$(git midx --write --update-head --delete-expired) &&
      test_path_is_file ${packdir}/midx-${midx5}.midx &&
      test "a$midx4" = "a$midx5" &&
      test_path_is_file ${packdir}/midx-head &&
@@ -133,7 +136,7 @@ test_expect_success 'create bare repo' \
      baredir=./objects/pack'
 
 test_expect_success 'write-midx in bare repo' \
-    'midxbare=$(git midx --write --update-head) &&
+    'midxbare=$(git midx --write --update-head --delete-expired) &&
      test_path_is_file ${baredir}/midx-${midxbare}.midx  &&
      test_path_is_file ${baredir}/midx-head &&
      test $(cat ${baredir}/midx-head) = "$midxbare" &&
-- 
2.15.0

