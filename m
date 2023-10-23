Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426024202
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MtyFNImZ"
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CC910C
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:45:06 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6ce353df504so2676390a34.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698101105; x=1698705905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frZHwzCGV5v5rhRlLDXV4Q612DnPcvX7ixs4V4d4tSQ=;
        b=MtyFNImZXx8KluxqywKVJoEHJNHnF0/l5znt0EJkfwuV1rXyrEus0EMLz+zM0emEo/
         5Ul5PSlkxiT36DgNTnNWrW2gpDG7GD8BlDr7TpHBsKcZUMiQHVexxuT/MNl4DiXq/syW
         fpWuQ7MIc8Yz1/PvvSDh0lXRvHLXs2L6jCsoU/xJU/N7yDsaW8fO4WHQ8K3Q5Rry/ueu
         t0a0bat3+Ld4PjWw2bCkcLMAwQOm0fumigoBAyvlB0obQb1+neL6XKybwnWoekCJGpzH
         cph2S9CiYdhLh8/Vqopgku67KqV4qTTBfiQrJZlmm43p+DDLbNSdjht3hEE9/bTOItrM
         8m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698101105; x=1698705905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frZHwzCGV5v5rhRlLDXV4Q612DnPcvX7ixs4V4d4tSQ=;
        b=lZ6o+AnmL62SOjJJEkl35ZXUYcFpdyDhBTzX/pgrW+9Bof8pwdlZb96qv3ZMKAnTo/
         0SFnx35G9S8tqzgGWSW2JSZ6MX0BZorNdbNwbgn77i5c7pys3Ka1qIesdkeXwDO/H+6R
         IHB7eefDQUfl7xtpbZECWyzpbHYCmJhAZ1wZXxxmuH0xP/jYjlPoTUL5mfwwbANiEJSs
         zYm5nXrDcfHlDljrX4w2btcKb4Zc5kVXJX2fsCDOMIsBGRSM75eF8/SPo3wvvYh+/kgC
         UAKRaGpO38z0MEvP/xcMDBL7mhr1/i4NVojNs87AuQW2hz91hFB90Pd+qYrlACBszSYX
         MrJg==
X-Gm-Message-State: AOJu0YxhvdoHSOrUenprRX3I7ZtmPqVlX26vpxOP8/gH7bS7rvsVk1gM
	w7Ks7pbfrILjhnOKcW0T3+Mf9POCrtf902YhC80xMw==
X-Google-Smtp-Source: AGHT+IFVDScx3rOM5km7eDa1pnB6LCY1/dWN5rGxFzudQGtcs88FgPjd5pmo6ZiHIzWG5Y5YHKGeUQ==
X-Received: by 2002:a05:6830:13cc:b0:6bd:b29:85d3 with SMTP id e12-20020a05683013cc00b006bd0b2985d3mr10971706otq.24.1698101105083;
        Mon, 23 Oct 2023 15:45:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c64-20020a0dc143000000b0059a34cfa2a8sm3485296ywd.62.2023.10.23.15.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:45:04 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:45:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 4/5] bulk-checkin: introduce
 `index_tree_bulk_checkin_incore()`
Message-ID: <2670192802a904b42fb0c11c26c9f7311aa8dd90.1698101088.git.me@ttaylorr.com>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1698101088.git.me@ttaylorr.com>

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

Within some thin wrapper around `deflate_obj_to_pack_incore()` (perhaps
`deflate_tree_to_pack_incore()`), the changes should be limited to
something like:

    struct strbuf converted = STRBUF_INIT;
    if (the_repository->compat_hash_algo) {
      if (convert_object_file(&compat_obj,
                              the_repository->hash_algo,
                              the_repository->compat_hash_algo, ...) < 0)
        die(...);

      format_object_header_hash(the_repository->compat_hash_algo,
                                OBJ_TREE, size);
    }
    /* compute the converted tree's hash using the compat algorithm */
    strbuf_release(&converted);

, assuming related changes throughout the rest of the bulk-checkin
machinery necessary to update the hash of the converted object, which
are likewise minimal in size.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 12 ++++++++++++
 bulk-checkin.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index b728210bc7..bd6151ba3c 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -496,6 +496,18 @@ int index_blob_bulk_checkin_incore(struct object_id *oid,
 	return status;
 }
 
+int index_tree_bulk_checkin_incore(struct object_id *oid,
+				   const void *buf, size_t size,
+				   const char *path, unsigned flags)
+{
+	int status = deflate_obj_to_pack_incore(&bulk_checkin_packfile, oid,
+						buf, size, path, OBJ_TREE,
+						flags);
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
2.42.0.425.g963d08ddb3.dirty

