Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FA3CA1008
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 20:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbjIEUgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbjIEUgv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 16:36:51 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAAEF4
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 13:36:48 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59231a1ca9eso28718657b3.1
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 13:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1693946207; x=1694551007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGrKSX49akuTfpqvvhFRP39KLO/xfNXDlJ7hWeKhRJg=;
        b=cQHlI5+jgczaRygDp4hJXLRL82qOeiuTDBYxR3z0KqUQSp8lPcLhoobe0XkWPANuer
         Oc4Rc4hTbOHa4vr8R/SOrYY6i2LHHBgofJCqR5RRwLfQe7y5F6mAa5I0EFBrdIxdrXyC
         XXZ1hlSIkrtMqoDa5eBlZjRJZsD15AQ5Gv/E3n1BCp7qWnVbLYF/ljRi0vA10DszwBPv
         HVmUBemr/o+c4JJWvopsZpcqes2fIaPx8vra5GhGBW9QWJFjjomaCwMryqmMwr68kXUH
         D4gwBU5UQPeqLj53jvxUC+HAzHmtdJo8JyLwBQUUfv4oz3/ww4S/Nb5u3Ds91C+c5zGX
         UXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946207; x=1694551007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGrKSX49akuTfpqvvhFRP39KLO/xfNXDlJ7hWeKhRJg=;
        b=Y6lT7yP/tEUjNRPp9Lwp5cTaTMzb5nSkW2v8aWm2Ut52/0OnOy1YV7oXeY7mK8fzc8
         9TYO1DNyuvsYjV+K1ScUTZUKA5EpUp1Ttocniy84zfuS7eOlmLyIMwnqFfRvyq7f34J+
         jkhp3nMkYSkYV4wx2rFSHwlHwWgQx0Jnyex5MwUViBfFOd25Se6WF2LKQd5VWWnIZeBH
         AH4ls1XsCTRkUBUtZUI9k0CdcekcquXnFtZzhliZloDusQBxGpMQwrxJ0mcjGAZUh/wV
         FytcXVACKwaj5CKOK5Wfrg8np5kzkFjZ0JPrKyfc7TmDs0NCOsY9J5gTREil7e/4Ma29
         avfg==
X-Gm-Message-State: AOJu0Yzg/TlOMkx3o+ve1TdHBCklK+kBXxu8rMKJmUIj11dUyOWXoe6+
        NHZVzj3rx1Z1Y0fAMmsuFQo1wS82JxjEY8g6JMNRpQ==
X-Google-Smtp-Source: AGHT+IEBz46Br7cN9HI93sHXlhdfReiUyIYpyThLh7BFX+pPumeeh4LxqtbiiysCWVtrhdzjrKbjIA==
X-Received: by 2002:a25:3751:0:b0:d7e:8175:4fa9 with SMTP id e78-20020a253751000000b00d7e81754fa9mr12529218yba.4.1693946207145;
        Tue, 05 Sep 2023 13:36:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d1-20020a25bc41000000b00d74c9618c6fsm2848824ybk.1.2023.09.05.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:36:46 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:36:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/8] builtin/repack.c: extract redundant pack cleanup for
 --geometric
Message-ID: <5c25ef87c1430e012a2e48b738b3b5aa760b4b0f.1693946195.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To reduce the complexity of the already quite-long `cmd_repack()`
implementation, extract out the parts responsible for deleting redundant
packs from a geometric repack out into its own sub-routine.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 52 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 708556836e..d3e6326bb9 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -540,6 +540,32 @@ static struct packed_git *get_preferred_pack(struct pack_geometry *geometry)
 	return NULL;
 }
 
+static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
+					    struct string_list *names,
+					    struct existing_packs *existing)
+{
+	struct strbuf buf = STRBUF_INIT;
+	uint32_t i;
+
+	for (i = 0; i < geometry->split; i++) {
+		struct packed_git *p = geometry->pack[i];
+		if (string_list_has_string(names, hash_to_hex(p->hash)))
+			continue;
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, pack_basename(p));
+		strbuf_strip_suffix(&buf, ".pack");
+
+		if ((p->pack_keep) ||
+		    (string_list_has_string(&existing->kept_packs, buf.buf)))
+			continue;
+
+		remove_redundant_pack(packdir, buf.buf);
+	}
+
+	strbuf_release(&buf);
+}
+
 static void free_pack_geometry(struct pack_geometry *geometry)
 {
 	if (!geometry)
@@ -1201,29 +1227,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			remove_redundant_pack(packdir, item->string);
 		}
 
-		if (geometry.split_factor) {
-			struct strbuf buf = STRBUF_INIT;
-
-			uint32_t i;
-			for (i = 0; i < geometry.split; i++) {
-				struct packed_git *p = geometry.pack[i];
-				if (string_list_has_string(&names,
-							   hash_to_hex(p->hash)))
-					continue;
-
-				strbuf_reset(&buf);
-				strbuf_addstr(&buf, pack_basename(p));
-				strbuf_strip_suffix(&buf, ".pack");
-
-				if ((p->pack_keep) ||
-				    (string_list_has_string(&existing.kept_packs,
-							    buf.buf)))
-					continue;
-
-				remove_redundant_pack(packdir, buf.buf);
-			}
-			strbuf_release(&buf);
-		}
+		if (geometry.split_factor)
+			geometry_remove_redundant_packs(&geometry, &names,
+							&existing);
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
-- 
2.42.0.119.gca7d13e7bf

