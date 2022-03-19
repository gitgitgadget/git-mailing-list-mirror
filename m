Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D976C433EF
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 00:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbiCSAZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbiCSAZA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 20:25:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B9712926C
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r64so5655093wmr.4
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=433nM0/Kve+428jQGk6NayhFLHvEIFtvBYsXuzgmexw=;
        b=Ew3RKK6xzpFNwuoukQr5ox7SnESUDFVhBH3zsjJZmmrPkGbQKdzt5k5IKnSukqeR99
         Vsmcp50TGhXR5pjc2nrq3otSE002Nn6Xt/6N6rs6n4yGoGoWdGjEaTh4RqTng32NiV7F
         /GfbyXlzXP+r42ucM/ZhlR63WilXGi4FYFLJKkd8ZCfSHr4wbfDbjd9/eEEH+4WDfQVL
         iFLKLodELOpHkQedlojqkzLVfHA5gkxsMJNLTQX6XNwA8aMD+1Sg2tuUC9tj/IK9eozp
         Nlcbhe9e6XAQ7bISHhaGWu31uDY1IqhydLbdZyK3NXUoDhB3zddc0CL5hHpEWrIeLiyM
         305Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=433nM0/Kve+428jQGk6NayhFLHvEIFtvBYsXuzgmexw=;
        b=XEDMdAWCAz9tG/VhQG/cdmJsAm88pycaZgQS4MFiPFEi/N1CnOM2EMxo+cl50S6mPQ
         L9gWDdsQdW5UXLXGlvY6mCDuStVtW8w0mOukeqU+ZTCwraEU/8u3BtGQKDL8wr3i/qt+
         lIzR+rKIgLLoDpzwdk5IBOIpEHUylPmk03Tsp8U1yVG9a74jNBc0NKTomp4y3vtFWlVs
         PFJU6fSp//eNEsyunCMIJhTubVtchL0g0n3yEPyYko7NR7YybmHP4YwKmIJx8qVTpcUZ
         KBIBFpP4TXHEPxTQ27Z2tG0wnA0+cmxrjKDLQF/KXzGb5gu3IE+h1Oi91pEj0HBBiiQH
         2Gzg==
X-Gm-Message-State: AOAM53110vqjQ1umCQ93xc7D2IaqHoA1CT3ZRx81NUpywWZVTFGC4+MA
        UEw0sH6jrCkHHGL/gHZREeh6RYE0NvLHPA==
X-Google-Smtp-Source: ABdhPJwzK0ZOTqrvPvil2QRZji7VendxU2hGSkEVFHB3VY0z9JwYlBLkD7NrGjaDdIeuVHwOYYtyKA==
X-Received: by 2002:a05:600c:42c1:b0:389:8310:1128 with SMTP id j1-20020a05600c42c100b0038983101128mr10119779wme.3.1647649418337;
        Fri, 18 Mar 2022 17:23:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b00389d4bdb3d2sm14865519wml.36.2022.03.18.17.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 17:23:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 4/8] object-file.c: factor out deflate part of write_loose_object()
Date:   Sat, 19 Mar 2022 01:23:21 +0100
Message-Id: <patch-v11-4.8-20d97cc2605-20220319T001411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1438.g8874c8eeb35
In-Reply-To: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
References: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com> <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split out the part of write_loose_object() that deals with calling
git_deflate() into a utility function, a subsequent commit will
introduce another function that'll make use of it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 4fcaf7a36ce..b66dc24e4b8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1992,6 +1992,28 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 	return fd;
 }
 
+/**
+ * Common steps for the inner git_deflate() loop for writing loose
+ * objects. Returns what git_deflate() returns.
+ */
+static int write_loose_object_common(git_hash_ctx *c,
+				     git_zstream *stream, const int flush,
+				     unsigned char *in0, const int fd,
+				     unsigned char *compressed,
+				     const size_t compressed_len)
+{
+	int ret;
+
+	ret = git_deflate(stream, flush ? Z_FINISH : 0);
+	the_hash_algo->update_fn(c, in0, stream->next_in - in0);
+	if (write_buffer(fd, compressed, stream->next_out - compressed) < 0)
+		die(_("unable to write loose object file"));
+	stream->next_out = compressed;
+	stream->avail_out = compressed_len;
+
+	return ret;
+}
+
 /**
  * Common steps for loose object writers to end writing loose objects:
  *
@@ -2049,12 +2071,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	stream.avail_in = len;
 	do {
 		unsigned char *in0 = stream.next_in;
-		ret = git_deflate(&stream, Z_FINISH);
-		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
-		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
-			die(_("unable to write loose object file"));
-		stream.next_out = compressed;
-		stream.avail_out = sizeof(compressed);
+
+		ret = write_loose_object_common(&c, &stream, 1, in0, fd,
+						compressed, sizeof(compressed));
 	} while (ret == Z_OK);
 
 	end_loose_object_common(fd, ret, &c, &stream, &parano_oid, oid,
-- 
2.35.1.1438.g8874c8eeb35

