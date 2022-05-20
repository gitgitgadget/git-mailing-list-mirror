Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23048C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354043AbiETXSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354032AbiETXRw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:17:52 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CEA195906
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:40 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i68so7659270qke.11
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bo+ivTzf0EDZiLZ3Ib1QjcIVdR0ks/eiqC5eD2VZ25s=;
        b=A080MEWTWPJ3N5/sT9LA1gn8zOWtE+1l6IjWEj3pJxKWFfkY0iiZOogXMmTeE12GG1
         s5zkArxW+AMSGdG/RpveuArC//JnotvxlViFZNZsGLZbnra8XOSm7jyu+EAIUtMAM4b1
         hwLIH7+rmxrpbO6TvOPAJJbONfLh2lfl7Z/XmAE/MFd7/HKxyQkpFAyygYNcIyRDKqSz
         LbVeV/N0l2GbTKc2GmnFEtXCrdIXHBNiQwoWuRpL7P92tru1BV1byvw434YbjN6xpTBg
         rDTfLdM2f8wPJZ+HHQZfRVZEL3N6ASIgOd5DsDJ/1rrtyKXKIXZVuQNWZcELrvTg30zf
         xe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bo+ivTzf0EDZiLZ3Ib1QjcIVdR0ks/eiqC5eD2VZ25s=;
        b=Y4cn/JXruJVhRplp+4haOX5oBqA5qbv5L/yQ+TzXjQh/TPo7eaIj/4qGiaFbB2y+Iq
         5veuF5W/flZ/oaxES6WP7DALydcd2aYP3NICjq/lRR90g9/54EKfpuWZHF6elazl7pdb
         pkFgU0XI224XGpGhS9FD2B7MMx9FkmZ2V0h2m7IOwIfc3e1z21pB0g2XYaH4vN4xRYQa
         EtPKhIzD2Q1yu1yavqMkwNm1Mm4bfYEk6y0p4gf6TAuWaXgngg6MmS8GkmY3K7kywBM7
         +kj1VcF5J3Rd/Cp/j8oNbNb8SJZqyYUfDGFoTDWo9h4cvQYqhBcXmhg+f5Pvpn7s/3Dk
         hubQ==
X-Gm-Message-State: AOAM531Fk4EirwaupdPIuvddFCpcc8NKAbD5dAmDM9jneMLSBrukH48x
        fb57dRogmme+V0gwSSaltdVNqOKtZf/EeFG+
X-Google-Smtp-Source: ABdhPJxtjOAUu666LbHoEtpRZ3xh5UoUzmO2Enj1XOI5PQlRRCqfTBSw3HINZzY/stm5x9/sFTEx9Q==
X-Received: by 2002:a05:620a:424e:b0:67e:4c1b:c214 with SMTP id w14-20020a05620a424e00b0067e4c1bc214mr7853173qko.651.1653088659660;
        Fri, 20 May 2022 16:17:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d25-20020ac84e39000000b002f9273e3980sm437927qtw.77.2022.05.20.16.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:17:39 -0700 (PDT)
Date:   Fri, 20 May 2022 19:17:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 03/17] pack-write: pass 'struct packing_data' to
 'stage_tmp_packfiles'
Message-ID: <67c4e7209d510c09b5ddf018204f84ad0d0ebf9b.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This structure will be used to communicate the per-object mtimes when
writing a cruft pack. Here, we need the full packing_data structure
because the mtime information is stored in an array there, not on the
individual object_entry's themselves (to avoid paying the overhead in
structure width for operations which do not generate a cruft pack).

We haven't passed this information down before because one of the two
callers (in bulk-checkin.c) does not have a packing_data structure at
all. In that case (where no cruft pack will be generated), NULL is
passed instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 3 ++-
 bulk-checkin.c         | 2 +-
 pack-write.c           | 1 +
 pack.h                 | 3 +++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 014dcd4bc9..6ac927047c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1262,7 +1262,8 @@ static void write_pack_file(void)
 
 			stage_tmp_packfiles(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
-					    &pack_idx_opts, hash, &idx_tmp_name);
+					    &to_pack, &pack_idx_opts, hash,
+					    &idx_tmp_name);
 
 			if (write_bitmap_index) {
 				size_t tmpname_len = tmpname.len;
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6d6c37171c..e988a388b6 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -33,7 +33,7 @@ static void finish_tmp_packfile(struct strbuf *basename,
 	char *idx_tmp_name = NULL;
 
 	stage_tmp_packfiles(basename, pack_tmp_name, written_list, nr_written,
-			    pack_idx_opts, hash, &idx_tmp_name);
+			    NULL, pack_idx_opts, hash, &idx_tmp_name);
 	rename_tmp_packfile_idx(basename, &idx_tmp_name);
 
 	free(idx_tmp_name);
diff --git a/pack-write.c b/pack-write.c
index 51812cb129..a2adc565f4 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -484,6 +484,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
+			 struct packing_data *to_pack,
 			 struct pack_idx_option *pack_idx_opts,
 			 unsigned char hash[],
 			 char **idx_tmp_name)
diff --git a/pack.h b/pack.h
index b22bfc4a18..fd27cfdfd7 100644
--- a/pack.h
+++ b/pack.h
@@ -109,11 +109,14 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 #define PH_ERROR_PROTOCOL	(-3)
 int read_pack_header(int fd, struct pack_header *);
 
+struct packing_data;
+
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
 void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
+			 struct packing_data *to_pack,
 			 struct pack_idx_option *pack_idx_opts,
 			 unsigned char hash[],
 			 char **idx_tmp_name);
-- 
2.36.1.94.gb0d54bedca

