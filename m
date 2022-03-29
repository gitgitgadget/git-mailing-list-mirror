Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9595FC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 13:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiC2N6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbiC2N6G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 09:58:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370B82241C8
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h4so13032580edr.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVK5E1lv48xNvHwAyg6lZY+gFAjM+SJfzs7vh1Z6EIk=;
        b=JugYAzgmeol/rNigpCNPiKLK7D1xl4QuOQ5kzdE7RBB9cN/U8bVQSa3tnJiKRIxJov
         iim/F163DTUFClqSp6+2oku9hQrCf24E6YmD+LFCT7BMxi6vRmSC49T6nzAwCCbuZRX0
         BiEmEkP8SEo1SOJiP3x9bCneSiJmlQ1y5VcFx8y+qoaWSTx9tEsd7FqAIO5ABnT/VMxY
         x/omuDvl4mmHV16UVCMbBWOCM3AftUvXAHF9agxeZO68+0Tk34nRpaXbKbkEmgqL4hxv
         zp8idB5czlG9GS3e53YKg/jzXQSjACTu0MNVFXYMyrKXfSt0WGgWVDIsa+ZMIk0On2p2
         2w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVK5E1lv48xNvHwAyg6lZY+gFAjM+SJfzs7vh1Z6EIk=;
        b=T/bsjBgMO4fPP1wo2FOwFTP36drSCOE1c+3jP9wmNfI5rQsLnWUlY+s8Tudci87IbW
         GGL/Fl//bkdF7E2x1l+GNWldhjapQ5oFQADXy/H9kkmfidqog9Fqc4ZpTwnl6bPZJl8C
         UmG9YKH0QxW3Xqg8KsSxFj/nskFvywRhCqx+WukMPADehtLQz2SulNgN9bLIsDioV8jG
         Um1BxfduQDTJRUUnb+OxB/qCb06y50gOmWhGpA7E+Nnw/lnvD3HpmgUA2wyxutF6jaLR
         2w8YN4MHWHd60+nE+OsNzy1nSCHHeJ0sFhCz71iCb+ze84HGebgUh3Bg1rl9Rdn5uh9J
         YVMw==
X-Gm-Message-State: AOAM533gaBlNNJ45u9wB9Lf76eI+NJ8FxjzHWCsRYlJeQA3s9q371HaZ
        djPEnoiAGTStI8AR287lL09ByEvhBpHJxA==
X-Google-Smtp-Source: ABdhPJyTR845ZBxp1v+7Zstay8KYJ0V+WvWgZsrTlBPVSz3rUD1thotwxqT1aUVe+xkE3Qrr2yoFbA==
X-Received: by 2002:a05:6402:d0e:b0:418:f011:275e with SMTP id eb14-20020a0564020d0e00b00418f011275emr4673014edb.323.1648562182537;
        Tue, 29 Mar 2022 06:56:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm7006601ejc.218.2022.03.29.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:56:21 -0700 (PDT)
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
Subject: [PATCH v12 4/8] object-file.c: factor out deflate part of write_loose_object()
Date:   Tue, 29 Mar 2022 15:56:09 +0200
Message-Id: <patch-v12-4.8-03f4e91ac89-20220329T135446Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1548.g36973b18e52
In-Reply-To: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com> <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
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
index 7f160929e00..6e2f2264f8c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2004,6 +2004,28 @@ static int start_loose_object_common(struct strbuf *tmp_file,
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
 
 	if (ret != Z_STREAM_END)
-- 
2.35.1.1548.g36973b18e52

