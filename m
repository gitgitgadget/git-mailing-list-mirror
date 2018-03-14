Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E1B1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeCNT14 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:27:56 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41727 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeCNT1z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:27:55 -0400
Received: by mail-qk0-f193.google.com with SMTP id s78so4737592qkl.8
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HiYboQR5l40F0Z9XIxCF7nrlFenp3hU20sxGeQHzquA=;
        b=DGFsZZi7JoFw6jvcckS8nYjm/ucEKXNfnexVP8/ML2rNVH0AO1Qns5xPynCwkXSeRe
         lO82/1d8TkEKBraQRVMduM1A3bjUBJ/lcLU/79RrJuoCJuIBB2qK1ruAZ0H2t/NjAzIi
         BUoeHJYU3qLx4YCrcSf4dmeZHlskf1/rGS/V31VdPJTr1l7bRWCXXADul92Ja3To6Rwf
         SsU2XgR2qZuvyzCLxzU+qqzWacyEztB1RNJ9e1gtyaik01VsG42f5m0hs71TqRaALtie
         0+R7t4OytsQxdSflQWNp2OqqSVHMhP7tsBbJEDN8WjGX5Um917x7oAkUuHcakeKPdAm1
         CFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HiYboQR5l40F0Z9XIxCF7nrlFenp3hU20sxGeQHzquA=;
        b=dL7TjGBZhfFtPuWz7LRT4yq/nQIJ8+pnMgS1uBpajsGnGPgnk1AtNE95XyvNqeHnjZ
         u75h1lH7+Mui0ucHPi/OFHVpbTRuZc9UcM1gMm6zXMadTDm6d7cWAPrkdBZm03+rJcfe
         ++bp6AqSJxc0GKNreJUJbwPMBMXwG/URRo53ombMvDGf0D3WXgWNIAQl5ABxEW+MQRWq
         +aDTf0EPFixISuWnzu+QkQNZIAj4EZ/MhDOXoGM4fVHKKtyxXycWLkyoLOIoPHZpn8s7
         zmLMllw6lOCdXaakiBYCB/VFkaBFzLrENNH7n07BiLnWly1ee3u5ky451dCRcSM013es
         VJXA==
X-Gm-Message-State: AElRT7HT6FlG6WyiPocJf3Boa0NOKVcwKheYtzezp1bxXaXEJl3s2YYn
        6As1RQyvWcP4KIUwPYJIcfUenb59yVo=
X-Google-Smtp-Source: AG47ELtaheIPYYaSJYRRls0yIxHJqeVr5ZjN5Oic9CiQ5jB7XVwwX7oUaykuWGNJSnyQuvrU3646vQ==
X-Received: by 10.55.192.20 with SMTP id o20mr8228050qki.257.1521055674582;
        Wed, 14 Mar 2018 12:27:54 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id q30sm2847395qte.10.2018.03.14.12.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 12:27:53 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 02/14] csum-file: refactor finalize_hashfile() method
Date:   Wed, 14 Mar 2018 15:27:24 -0400
Message-Id: <20180314192736.70602-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If we want to use a hashfile on the temporary file for a lockfile, then
we need finalize_hashfile() to fully write the trailing hash but also keep
the file descriptor open.

Do this by adding a new CSUM_HASH_IN_STREAM flag along with a functional
change that checks this flag before writing the checksum to the stream.
This differs from previous behavior since it would be written if either
CSUM_CLOSE or CSUM_FSYNC is provided.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/pack-objects.c | 4 ++--
 bulk-checkin.c         | 2 +-
 csum-file.c            | 8 ++++----
 csum-file.h            | 5 +++--
 pack-bitmap-write.c    | 2 +-
 pack-write.c           | 5 +++--
 6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 84e9f57b7f..2b15afd932 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -837,9 +837,9 @@ static void write_pack_file(void)
 		 * If so, rewrite it like in fast-import
 		 */
 		if (pack_to_stdout) {
-			finalize_hashfile(f, oid.hash, CSUM_CLOSE);
+			finalize_hashfile(f, oid.hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
 		} else if (nr_written == nr_remaining) {
-			finalize_hashfile(f, oid.hash, CSUM_FSYNC);
+			finalize_hashfile(f, oid.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 		} else {
 			int fd = finalize_hashfile(f, oid.hash, 0);
 			fixup_pack_header_footer(fd, oid.hash, pack_tmp_name,
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 227cc9f3b1..70b14fdf41 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -35,7 +35,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
-		finalize_hashfile(state->f, oid.hash, CSUM_FSYNC);
+		finalize_hashfile(state->f, oid.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 	} else {
 		int fd = finalize_hashfile(state->f, oid.hash, 0);
 		fixup_pack_header_footer(fd, oid.hash, state->pack_tmp_name,
diff --git a/csum-file.c b/csum-file.c
index e6c95a6915..53ce37f7ca 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -61,11 +61,11 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int fl
 	the_hash_algo->final_fn(f->buffer, &f->ctx);
 	if (result)
 		hashcpy(result, f->buffer);
-	if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
-		/* write checksum and close fd */
+	if (flags & CSUM_HASH_IN_STREAM)
 		flush(f, f->buffer, the_hash_algo->rawsz);
-		if (flags & CSUM_FSYNC)
-			fsync_or_die(f->fd, f->name);
+	if (flags & CSUM_FSYNC)
+		fsync_or_die(f->fd, f->name);
+	if (flags & CSUM_CLOSE) {
 		if (close(f->fd))
 			die_errno("%s: sha1 file error on close", f->name);
 		fd = 0;
diff --git a/csum-file.h b/csum-file.h
index 9ba87f0a6c..c5a2e335e7 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -27,8 +27,9 @@ extern void hashfile_checkpoint(struct hashfile *, struct hashfile_checkpoint *)
 extern int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 
 /* finalize_hashfile flags */
-#define CSUM_CLOSE	1
-#define CSUM_FSYNC	2
+#define CSUM_CLOSE		1
+#define CSUM_FSYNC		2
+#define CSUM_HASH_IN_STREAM	4
 
 extern struct hashfile *hashfd(int fd, const char *name);
 extern struct hashfile *hashfd_check(const char *name);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 662b44f97d..db4c832428 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -535,7 +535,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
 
-	finalize_hashfile(f, NULL, CSUM_FSYNC);
+	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 
 	if (adjust_shared_perm(tmp_file.buf))
 		die_errno("unable to make temporary bitmap file readable");
diff --git a/pack-write.c b/pack-write.c
index 044f427392..a9d46bc03f 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -170,8 +170,9 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	}
 
 	hashwrite(f, sha1, the_hash_algo->rawsz);
-	finalize_hashfile(f, NULL, ((opts->flags & WRITE_IDX_VERIFY)
-				    ? CSUM_CLOSE : CSUM_FSYNC));
+	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
+				    ((opts->flags & WRITE_IDX_VERIFY)
+				    ? 0 : CSUM_FSYNC));
 	return index_name;
 }
 
-- 
2.14.1

