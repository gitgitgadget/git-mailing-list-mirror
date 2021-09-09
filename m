Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6E8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE5B61059
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350053AbhIID1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 23:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350147AbhIID0c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 23:26:32 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87041C061796
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 20:25:19 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b10so512095ioq.9
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 20:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mDeGGO4oyqxo9L8YtU/mBXVY0SatXK3Wj/QeNSit4PM=;
        b=NPo5ERliiCI0OGHl9m8LdTLlx7atXapKXRwTE3n2yfTYD3YaPX7T/o0EnYFQ7sZpTg
         t03p8fso1a21HTwMB3Nw3miTNxnpaOWeslHXXlH77euykN+YaB2+oi/AMA8hexHWloSs
         PtHcJhxVa3clZtT0SYFtP5VBUCRtN1cGiYJHAF4PS4y4SHiwsgis3OaZPfm/bJWueIlS
         7DkEgqqIyHKVXw4a349yDdza/vmN8u62jpeGi5LyNGc/LglMKa5sPbhJqjJZ9HBTh81K
         OWC8JYgYeff3WfKFcFXaN6grBQ5+SOKDiMqHb9oM12LcxDMQhL/eMHVKsbIZICncy1AN
         58fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mDeGGO4oyqxo9L8YtU/mBXVY0SatXK3Wj/QeNSit4PM=;
        b=rKyYVG8nDr/MSDpEEC8Yt2hDA45NUaLNRQTe3de3MuQgSyOiNfPfTLpoX7w/QwvMlN
         VzqD1lK6F7ccrOVSuU1IKuuMgFFD+zyPLt1fKZBdKq0Yf5fNHQm3WFbX8qmjxyxfdlQ+
         /eHDmHQ5PW5RZwamJ/gCI9SsFGBy9pJRP896WZLWBzkQmrhzEfDwPucju7TRhVfscCoP
         y7MvaYhp3EkVP9Y2po3dUGl8ZCZj39RdWqAdq+L3vEdrDuuaFRBueFk2NCec62m/FD/F
         ATAascYHZkuXTRI9hTlNqSbBJfS/5k6pJf05zPKaw8CP0FQVDYmWFOMQfMO6vQNyvF6C
         rNAQ==
X-Gm-Message-State: AOAM530piItwwhS+brRRZqQxuSEfKtJuFqu+N+y7Dx4CCm0ds/ZCwggm
        EJ5wMrs2LEaR/RN//eRKLG7t5r/JEOrpe3sR
X-Google-Smtp-Source: ABdhPJwQyWInBPQKdgQ5JWZ/x++qVQOnexw9cIYwKbizQRvW9NsBs/vwsYBGP3de2kdn4s6yu6DzRg==
X-Received: by 2002:a05:6602:22d4:: with SMTP id e20mr740632ioe.203.1631157918854;
        Wed, 08 Sep 2021 20:25:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e1sm278527ils.76.2021.09.08.20.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:25:18 -0700 (PDT)
Date:   Wed, 8 Sep 2021 23:25:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 8/9] pack-write: split up finish_tmp_packfile() function
Message-ID: <5c553229b00c5d09c74a0947d1cbc9bd5cc880e4.1631157880.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631157880.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Split up the finish_tmp_packfile() function and use the split-up version
in pack-objects.c in preparation for moving the step of renaming the
*.idx file later as part of a function change.

Since the only other caller of finish_tmp_packfile() was in
bulk-checkin.c, and it won't be needing a change to its *.idx renaming,
provide a thin wrapper for the old function as a static function in that
file. If other callers end up needing the simpler version it could be
moved back to "pack-write.c" and "pack.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  7 +++++--
 bulk-checkin.c         | 16 ++++++++++++++++
 pack-write.c           | 22 +++++++++++++---------
 pack.h                 |  7 +++++--
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2a105c8d6e..944134b6f2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1217,6 +1217,7 @@ static void write_pack_file(void)
 		if (!pack_to_stdout) {
 			struct stat st;
 			struct strbuf tmpname = STRBUF_INIT;
+			char *idx_tmp_name = NULL;
 
 			/*
 			 * Packs are runtime accessed in their mtime
@@ -1246,9 +1247,10 @@ static void write_pack_file(void)
 					&to_pack, written_list, nr_written);
 			}
 
-			finish_tmp_packfile(&tmpname, pack_tmp_name,
+			stage_tmp_packfiles(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
-					    &pack_idx_opts, hash);
+					    &pack_idx_opts, hash, &idx_tmp_name);
+			rename_tmp_packfile_idx(&tmpname, &idx_tmp_name);
 
 			if (write_bitmap_index) {
 				size_t tmpname_len = tmpname.len;
@@ -1265,6 +1267,7 @@ static void write_pack_file(void)
 				strbuf_setlen(&tmpname, tmpname_len);
 			}
 
+			free(idx_tmp_name);
 			strbuf_release(&tmpname);
 			free(pack_tmp_name);
 			puts(hash_to_hex(hash));
diff --git a/bulk-checkin.c b/bulk-checkin.c
index c19d471f0b..8785b2ac80 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -23,6 +23,22 @@ static struct bulk_checkin_state {
 	uint32_t nr_written;
 } state;
 
+static void finish_tmp_packfile(struct strbuf *basename,
+				const char *pack_tmp_name,
+				struct pack_idx_entry **written_list,
+				uint32_t nr_written,
+				struct pack_idx_option *pack_idx_opts,
+				unsigned char hash[])
+{
+	char *idx_tmp_name = NULL;
+
+	stage_tmp_packfiles(basename, pack_tmp_name, written_list, nr_written,
+			    pack_idx_opts, hash, &idx_tmp_name);
+	rename_tmp_packfile_idx(basename, &idx_tmp_name);
+
+	free(idx_tmp_name);
+}
+
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
 	unsigned char hash[GIT_MAX_RAWSZ];
diff --git a/pack-write.c b/pack-write.c
index 077710090e..d40d2ddd01 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -470,21 +470,28 @@ static void rename_tmp_packfile(struct strbuf *nb, const char *source,
 	strbuf_setlen(nb, nb_len);
 }
 
-void finish_tmp_packfile(struct strbuf *name_buffer,
+void rename_tmp_packfile_idx(struct strbuf *name_buffer,
+			     char **idx_tmp_name)
+{
+	rename_tmp_packfile(name_buffer, *idx_tmp_name, "idx");
+}
+
+void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
 			 struct pack_idx_option *pack_idx_opts,
-			 unsigned char hash[])
+			 unsigned char hash[],
+			 char **idx_tmp_name)
 {
-	const char *idx_tmp_name, *rev_tmp_name = NULL;
+	const char *rev_tmp_name = NULL;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
 
-	idx_tmp_name = write_idx_file(NULL, written_list, nr_written,
-				      pack_idx_opts, hash);
-	if (adjust_shared_perm(idx_tmp_name))
+	*idx_tmp_name = (char *)write_idx_file(NULL, written_list, nr_written,
+					       pack_idx_opts, hash);
+	if (adjust_shared_perm(*idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
 	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
@@ -493,9 +500,6 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
 	if (rev_tmp_name)
 		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
-	rename_tmp_packfile(name_buffer, idx_tmp_name, "idx");
-
-	free((void *)idx_tmp_name);
 }
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
diff --git a/pack.h b/pack.h
index 1c17254c0a..b22bfc4a18 100644
--- a/pack.h
+++ b/pack.h
@@ -110,11 +110,14 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 int read_pack_header(int fd, struct pack_header *);
 
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-void finish_tmp_packfile(struct strbuf *name_buffer,
+void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
 			 struct pack_idx_option *pack_idx_opts,
-			 unsigned char sha1[]);
+			 unsigned char hash[],
+			 char **idx_tmp_name);
+void rename_tmp_packfile_idx(struct strbuf *basename,
+			     char **idx_tmp_name);
 
 #endif
-- 
2.33.0.96.g73915697e6

