Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B685C433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 10:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiFDKKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 06:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiFDKKk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 06:10:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E341125E9A
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 03:10:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id q15so2041240wmj.2
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFbX9FdKlOnUD7Ar35Q8cCMfnwgk/ZZf0nDd/pELb+8=;
        b=iCjrgW5SdGTMqSJ2gpOF2w65l5+enS9++gQ2QlqsSmwhN0G6NxDKLTglaKvtYgkpGp
         53b+Enu2HeTzdiRd9nMyae7v1bxRQ10/jUgIvA8wmqkIPAmp3AiI3w4WQYURhr8wQ+R5
         XzEy+L8OWI1c0fWw1tmD6R6ZAcsLFMuXcYcWSKq7yY4TDw8038ehiPVnYUhGGUYAmee0
         MnV7X935m4pDtgKDFIoDedTvjgwrOVH477STh26IIDAC7thicWn1OWBXv07CRA/ZrNNg
         MahZexk9e5JPlVekB8mvfRUOjpimMZwiryUlaMi5WVk6btA5eI1JAcTIeCbDxCUcKl43
         Rsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFbX9FdKlOnUD7Ar35Q8cCMfnwgk/ZZf0nDd/pELb+8=;
        b=psnsqrMF5xGIj6bGDSpP+SYV7u1qyler39HaBxPAykbkmZGtAz+DLPvhuRFiqTjlYp
         kUG+xqGRMNceLnTMolDZqEVkiIWR/eECkJ2D7LB4g/gE78RhZUUejMIo4GS9i/edOMGs
         RHFxJk+u8VqRPnUMpCxKEePGaQBlbADjSNkYNtYnSRWGOuPwQFDAQd5enPKB89yGfIyk
         zu1B2poAAXwx7GP2ra44LqKVQfEIDDL9cIOcRtrt3rYFM3qoQk5GpnqGDQQurltiFOey
         GERa4fjNvU8qM0My976h7itPCoi35nIQ8dW5aH5hLffTiMiz+HEJ63tT0/31IoHYo0re
         DvbQ==
X-Gm-Message-State: AOAM533ib/3nG9qh9Cl2QNRytzFG2s7VSBa3FXNdI13Yga7JumKQcc7I
        uQbv3vnowkBD4cQ9PrlYmjQoaosX2jYcNA==
X-Google-Smtp-Source: ABdhPJx+XfbYmIjwfsAhAOtFICCwIw4vnBWxrhLvRV/pgVFgjb2WXAESVSKTLvlFPQU8NyyBSgCkWA==
X-Received: by 2002:a05:600c:34c6:b0:39a:c4e6:c316 with SMTP id d6-20020a05600c34c600b0039ac4e6c316mr31028355wmq.26.1654337437197;
        Sat, 04 Jun 2022 03:10:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b0039765a7add4sm15069631wmq.29.2022.06.04.03.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 03:10:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v13 4/7] object-file.c: factor out deflate part of write_loose_object()
Date:   Sat,  4 Jun 2022 12:10:25 +0200
Message-Id: <patch-v13-4.7-a0434835fe7-20220604T095113Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g52838f02905
In-Reply-To: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com> <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
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
index ce8b52a8dc3..7946fa5e088 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2000,6 +2000,28 @@ static int start_loose_object_common(struct strbuf *tmp_file,
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
@@ -2048,12 +2070,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
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
 
 	if (ret != Z_STREAM_END)
-- 
2.36.1.1124.g52838f02905

