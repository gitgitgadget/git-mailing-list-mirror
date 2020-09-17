Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A368CC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 11:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6864421974
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 11:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFMRz2U5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgIQLfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 07:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgIQL3D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 07:29:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D434C061756;
        Thu, 17 Sep 2020 04:28:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so1656992wrn.10;
        Thu, 17 Sep 2020 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acFTRgOXeFja9i45UMq28ZzX4PNnH17O4fPIQK3On2o=;
        b=IFMRz2U5ZEnUCHO8HMxvr8xMuOEpnPrDzMBpzwh36C8oSu4fa3BxXDbe+WmkYCF7XV
         GhqjVdql38wwMxwW9kIrRNdaZLgcP52j7fSwBjJTMBPdjDErqEnEN7yGD2XSRh+jxaSC
         1ITCM4CJYT9dR+oUcQm65AwbG9GkGeapaGpHiLMIvd21g1k8glqZbJONqP8/6oaBW6oC
         JJ9aG03WoVhsVbIqturgOftvSmqr96hn0kEBm4q+6fIHmviIrLpdQ50zDt7hY4TtvxVJ
         2daizVQgeoMCXNbKqCikdMxQpi25IEEQmMwfLNEra8uJhAmXjGR1oieAkqhLdmHbjWNz
         Xd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acFTRgOXeFja9i45UMq28ZzX4PNnH17O4fPIQK3On2o=;
        b=W0sH/beI5shQzqy+sloSvD4mnR7RTwY/LGy9YFLZ2PcJ5t3D1pal3nHw74opXsKGeu
         KYQYr2r8tCSW0nY8EvLepTwnlylqnUzrYtAiOUkzcHXsytHDuDhcUUcnNRS8AG5NdmMU
         cL/6Kop3t69b9q7j+zhz6ZBjg8D1oZarf1UpTTJHlODl/rAn6bPzaIjLfpyc3jYNpBLM
         O9X5629/Y3sj7jfEd3XNRVC/YP2R9pVUHBRqOMkRoyt0mwAdNQdDzgH2ISahmZJbEa4P
         tt24FsHI3ijyIGAsKQol0Hu7GL1sy2HFE8dxfh06BmO7scwowofks4PCorI2fcZIvTtj
         bMNg==
X-Gm-Message-State: AOAM533XeFq11N9CC0+wtjOIzVRmdRrTAD+YaZjgLlLN1qBjhs3q3HK7
        S7OHw1fo4YmDwmPe0kuiHJ3GWe94w0w6Nw==
X-Google-Smtp-Source: ABdhPJyUoKvCAKe8Xv3aMoEG0zbKwplmFjcxsRm83Q1ufq7tW1FBWBCHA6p6gfj7jPnmyK/xWLQ4EQ==
X-Received: by 2002:a05:6000:12c3:: with SMTP id l3mr33482360wrx.164.1600342130926;
        Thu, 17 Sep 2020 04:28:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm38781127wrm.57.2020.09.17.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:28:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when core.fsyncObjectFiles
Date:   Thu, 17 Sep 2020 13:28:29 +0200
Message-Id: <20200917112830.26606-2-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <87sgbghdbp.fsf@evledraar.gmail.com>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of core.fsyncObjectFiles to also sync the
directory entry. I don't have a case where this broke, just going by
paranoia and the fsync(2) manual page's guarantees about its behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-file.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index dd65bd5c68..d286346921 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1784,10 +1784,14 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_loose_object(int fd)
+static void close_loose_object(int fd, const struct strbuf *dirname)
 {
-	if (fsync_object_files)
+	int dirfd;
+	if (fsync_object_files) {
 		fsync_or_die(fd, "loose object file");
+		dirfd = xopen(dirname->buf, O_RDONLY);
+		fsync_or_die(dirfd, "loose object directory");
+	}
 	if (close(fd) != 0)
 		die_errno(_("error when closing loose object file"));
 }
@@ -1808,12 +1812,15 @@ static inline int directory_size(const char *filename)
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(struct strbuf *tmp, const char *filename)
+static int create_tmpfile(struct strbuf *tmp,
+			  const char *filename,
+			  struct strbuf *dirname)
 {
 	int fd, dirlen = directory_size(filename);
 
 	strbuf_reset(tmp);
 	strbuf_add(tmp, filename, dirlen);
+	strbuf_add(dirname, filename, dirlen);
 	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
 	fd = git_mkstemp_mode(tmp->buf, 0444);
 	if (fd < 0 && dirlen && errno == ENOENT) {
@@ -1848,10 +1855,11 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	struct object_id parano_oid;
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
+	static struct strbuf dirname = STRBUF_INIT;
 
 	loose_object_path(the_repository, &filename, oid);
 
-	fd = create_tmpfile(&tmp_file, filename.buf);
+	fd = create_tmpfile(&tmp_file, filename.buf, &dirname);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
@@ -1897,7 +1905,8 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(fd);
+	close_loose_object(fd, &dirname);
+	strbuf_release(&dirname);
 
 	if (mtime) {
 		struct utimbuf utb;
-- 
2.28.0.297.g1956fa8f8d

