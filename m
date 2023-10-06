Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9C6E94133
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjJFWCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjJFWCI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:02:08 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86487C6
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:02:06 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-65afac36b2cso14129586d6.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 15:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696629725; x=1697234525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kXgj0ajSWXQjnEa7XOp0OEDTb8UQQh3uAxx9x3ixfEI=;
        b=NirsXLMbYnuwR1Akd54UZcJ6sTfPgjaEUqyxg33F5yV1i1TQUTRmQ7bwD2FshEnE7H
         dB9+ALlDvE4v3mda1eXgNX5+aidjTQ/c/sn5ZC3lYsOsgJFsHiSRoOIg5SkDdoEMb5xO
         pMcW+1nUgxiUrRRswEABZ8izEHVtLTSX7RZgpNmHi8Wepkjo1MoGjOR7c9S1GMRG/Tfq
         frbwFNrwYvIPh0v9yM4MB4JBhfzMBX6IkSsBapEmyZi6Q99HlQryv/Alz0p1Q0lCLvM6
         ObKRfGK5vq7HgEgnZrkpcqR6OaeB2nDNHduIgUvAS889iwrQ/o3W7vut7wIC3gA5nT4Y
         WpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696629725; x=1697234525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXgj0ajSWXQjnEa7XOp0OEDTb8UQQh3uAxx9x3ixfEI=;
        b=NlUQMRot9pxMtyklqHY2VKrOuQcKTSxdwGlgfd8jMxtYEzw8W6PyM1UtFJVSoVkpaS
         Z/9tfai7aiIk3DS2PecmGxM9JVNAW4nCP0+rHYjlIK8h0v09rz4tTSy6w5cUMakumCDK
         HpQvC2cVpSCQ+flcTUtR0+Fh+d9IWbEg3fzMGaO3QuVdQr8ziv/2HbCuoPcNeAUUY6Ix
         oGiNdQ9PADkF4xaiQvJHCrgDZ3DUtP+/lxkL22NcvTGyVjPJEbpOsIg/wPZjQf36mhT+
         Wds4X0Yqz9cV57BBWUbcnaP8GkVagUWUmbvtoZGKyaNiSP6uMUAM9ZjgEUrlLPcjdXAp
         Ta2A==
X-Gm-Message-State: AOJu0Yz0n9KoYpDcVckUJp2a5SdJSzTW5kFQIIoCB+dRBMx/OOddWP7h
        PJXznZucYDFUi07DDsh5y46A4Z+KEGpGx5sTUNMRRA==
X-Google-Smtp-Source: AGHT+IH21SJwmBeuH153MpqmiqrXfClcfQHJSIDAM3VZ74hrqhgvoEJgZAl3HOvMQ35NdDJTnAt7QA==
X-Received: by 2002:a0c:e184:0:b0:641:8d17:96fd with SMTP id p4-20020a0ce184000000b006418d1796fdmr9564222qvl.41.1696629725490;
        Fri, 06 Oct 2023 15:02:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c29-20020a0ca9dd000000b0065af24495easm1744157qvb.51.2023.10.06.15.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:02:05 -0700 (PDT)
Date:   Fri, 6 Oct 2023 18:02:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] bulk-checkin: introduce
 `index_tree_bulk_checkin_incore()`
Message-ID: <cb0f79cabb7921ab7e334ad8a467ae84853bbd39.1696629697.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696629697.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The remaining missing piece in order to teach the `merge-tree` builtin
how to write the contents of a merge into a pack is a function to index
tree objects into a bulk-checkin pack.

This patch implements that missing piece, which is a thin wrapper around
all of the functionality introduced in previous commits.

If and when Git gains support for a "compatibility" hash algorithm, the
changes to support that here will be minimal. The bulk-checkin machinery
will need to convert the incoming tree to compute its length under the
compatibility hash, necessary to reconstruct its header. With that
information (and the converted contents of the tree), the bulk-checkin
machinery will have enough to keep track of the converted object's hash
in order to update the compatibility mapping.

Within `deflate_tree_to_pack_incore()`, the changes should be limited
to something like:

    if (the_repository->compat_hash_algo) {
      struct strbuf converted = STRBUF_INIT;
      if (convert_object_file(&compat_obj,
                              the_repository->hash_algo,
                              the_repository->compat_hash_algo, ...) < 0)
        die(...);

      format_object_header_hash(the_repository->compat_hash_algo,
                                OBJ_TREE, size);

      strbuf_release(&converted);
    }

, assuming related changes throughout the rest of the bulk-checkin
machinery necessary to update the hash of the converted object, which
are likewise minimal in size.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 25 +++++++++++++++++++++++++
 bulk-checkin.h |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 319921efe7..d7d46f1dac 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -418,6 +418,20 @@ static int deflate_blob_to_pack_incore(struct bulk_checkin_packfile *state,
 						   flags);
 }
 
+static int deflate_tree_to_pack_incore(struct bulk_checkin_packfile *state,
+				       struct object_id *result_oid,
+				       const void *buf, size_t size,
+				       const char *path, unsigned flags)
+{
+	git_hash_ctx ctx;
+
+	format_object_header_hash(the_hash_algo, &ctx, OBJ_TREE, size);
+
+	return deflate_obj_contents_to_pack_incore(state, &ctx, result_oid,
+						   buf, size, OBJ_TREE, path,
+						   flags);
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -508,6 +522,17 @@ int index_blob_bulk_checkin_incore(struct object_id *oid,
 	return status;
 }
 
+int index_tree_bulk_checkin_incore(struct object_id *oid,
+				   const void *buf, size_t size,
+				   const char *path, unsigned flags)
+{
+	int status = deflate_tree_to_pack_incore(&bulk_checkin_packfile, oid,
+						 buf, size, path, flags);
+	if (!odb_transaction_nesting)
+		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
+	return status;
+}
+
 void begin_odb_transaction(void)
 {
 	odb_transaction_nesting += 1;
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 1b91daeaee..89786b3954 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -17,6 +17,10 @@ int index_blob_bulk_checkin_incore(struct object_id *oid,
 				   const void *buf, size_t size,
 				   const char *path, unsigned flags);
 
+int index_tree_bulk_checkin_incore(struct object_id *oid,
+				   const void *buf, size_t size,
+				   const char *path, unsigned flags);
+
 /*
  * Tell the object database to optimize for adding
  * multiple objects. end_odb_transaction must be called
-- 
2.42.0.8.g7a7e1e881e.dirty

