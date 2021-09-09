Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE8AC433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA36610C9
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349593AbhIIX0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349786AbhIIX0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:26:10 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90AEC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 16:24:57 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a15so40527iot.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1uinzz2bN2Y1Ub0Dz+81s2OdRoZ4GU5uPFUToyOrrOI=;
        b=oChU+nk4T/T3vh7WISZ8BRtKLvdOAD+p/GuMaMHM01Q2Jcalt2/ydgjdxvpeKKwXFP
         1jC6na4I7LIAZ94QM5xnT+9Eo5t2OQg3pkxOHmMtkgcjbvXUoD4sqxj15B6gclFB3+t2
         319edK+B3qnhqhEJLY4hQuwCSw3qNbKgT3hsv8AcOnnyEJruj0acFbqNUuTypLFzLBm/
         TzP0NybBDN38f9G8x29o9lYPuaNT9MtDyfkWnGuZ26gR6tLPC0Zlr2HskC+SykbQOQAq
         aNJm7kJ4UleyDJZW27ZEQb1yahgxmhEzlWkhphOe+bj93SC7CNYO0YQ0+44GIt7+wrrM
         AgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1uinzz2bN2Y1Ub0Dz+81s2OdRoZ4GU5uPFUToyOrrOI=;
        b=of4ipRyRfR6Kws+6z9L3oYmBZ+GHTQvGayNTZAbfSSe3BMha93iFjMPzcKhy4dvC/n
         Qzf9ohQ7n/cSmwHjQz0Pp4fctbA8HIibSj1sO/pjcJ7nnV3rco5XaVu0yz1VHT8YvokE
         dHZNbT9zuHqv2N+okMDsr6pizBlmUw++tpffHPyAZ+VCZU8YuxilLVmoN3PRXhKMDhFY
         bsAAtwnEqxmKaQKvkPqqLH+8nP5d1ePjRde/yHK/tRC9d0PkZCYJMN2OdflSz1zCJWyY
         mAWAjfrVIfrmU34gB2xrYqQQMrKa91QwZykqP+pqV+eWRBI0t4Kn/qkXzcOg1f1iqasl
         1YwA==
X-Gm-Message-State: AOAM5311w+oFu2kR3mPWmBDvb6/CLhdgVIjS+7NcfKKqhLIaYSFHmhcW
        cxO10Ksrn1ktKwYSYUHaX4y3qYENZEucTf1Z
X-Google-Smtp-Source: ABdhPJykz3CwOzakMjSCUXdumz76L+nM7Zob8J2wRm89959jwey8w1u3X+FRQbXJBgh8sH2hsDkARw==
X-Received: by 2002:a5e:c30c:: with SMTP id a12mr4617524iok.52.1631229897107;
        Thu, 09 Sep 2021 16:24:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v1sm1561115ile.83.2021.09.09.16.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:24:56 -0700 (PDT)
Date:   Thu, 9 Sep 2021 19:24:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 8/9] pack-write: split up finish_tmp_packfile() function
Message-ID: <90bebe4e51c3bc84d156912db84e0d2774f56354.1631228928.git.me@ttaylorr.com>
References: <cover.1631157880.git.me@ttaylorr.com>
 <cover.1631228928.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631228928.git.me@ttaylorr.com>
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
index b9f9cd5c14..c21aed64b3 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -470,21 +470,28 @@ static void rename_tmp_packfile(struct strbuf *name_prefix, const char *source,
 	strbuf_setlen(name_prefix, name_prefix_len);
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

