Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759DAC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 13:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbiC2N6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbiC2N6F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 09:58:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5A522385F
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id yy13so35352093ejb.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWY/unzhQkolwOpDjUfMMFSQ3k7/dBT5XnZDr53TTu8=;
        b=IfzH0UkMtb8fHEPRyrmojfnz+hF7DkNaqszXU7STf//PUEZmFkjwaxr2JNBbZykFA/
         HjbIKDsRphdhSwoDZMjhN2G8oBWkU+pQf9MiedT/tO0ex+dPXNG8A8iC20SgvWXEsAvS
         PNJ5FR0t+pXMi/5/WQDc8rA8w8umlvYOY+PdJrMkWdZGlvheSm1kr+79T8pwfq4fFJpE
         fSCIRBStcP6fRr8sSZ+vJsX1CH4R4um8dhlFg1cN+ROQOiS6UFSnsF94OktmGWnNrX3r
         vsmPvjtVtf9trIBnQfBKuJ7Fb9wY6iTjELPqYOFEwnKkn6vtypeCB2bZcjDAI9h9uRNP
         2+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWY/unzhQkolwOpDjUfMMFSQ3k7/dBT5XnZDr53TTu8=;
        b=mEHUM6bQ82M0sYJ4T4Enl3jb5UazMJabjOj6ZB0fGJDdBAXj6fIlom3TecjTyAXprd
         toEu/D14j9MewIbHzi7AirVXJ3UkU3cUYasnVXDGKAjVaYeXtesHIiAyvQ09klGSnkGr
         GiJHFhIkqqmDpI+pVzRydFtO/pBvgKghkBzqiRC9tqUcGakkCJF54Ers5MrncJplLwT/
         Be1FJlSDYeNe383gY0HgvZwhCFYy9e/jMgN+cDT2X4XbziB87IVguAl8LpKc0nxg57LW
         wodoPSbq8HKoGJltQ/E6K20PNEzv+2SeRf0L92xozo7jSPzKTRBEpueWFGr36eQ95l5N
         ZMXA==
X-Gm-Message-State: AOAM5330hjmsC6xBVY6QP7BLJTlTw/1UImvlVhxfi/F1FDQkfeF8qfC+
        OYL9lbiEyhif/SILmbUf8SjDGAtFsiax2Q==
X-Google-Smtp-Source: ABdhPJyM1TKjd9JMUqt//1GI7lrNEQypGJAgZzIveIURrs1X+yhyVuY45eig3ddrcEZZNhRvE203jA==
X-Received: by 2002:a17:907:7ea5:b0:6e1:13c3:e35f with SMTP id qb37-20020a1709077ea500b006e113c3e35fmr10575266ejc.99.1648562180261;
        Tue, 29 Mar 2022 06:56:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm7006601ejc.218.2022.03.29.06.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:56:19 -0700 (PDT)
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
Subject: [PATCH v12 2/8] object-file.c: do fsync() and close() before post-write die()
Date:   Tue, 29 Mar 2022 15:56:07 +0200
Message-Id: <patch-v12-2.8-54060eb8c6b-20220329T135446Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1548.g36973b18e52
In-Reply-To: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com> <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change write_loose_object() to do an fsync() and close() before the
oideq() sanity check at the end. This change re-joins code that was
split up by the die() sanity check added in 748af44c63e (sha1_file: be
paranoid when creating loose objects, 2010-02-21).

I don't think that this change matters in itself, if we called die()
it was possible that our data wouldn't fully make it to disk, but in
any case we were writing data that we'd consider corrupted. It's
possible that a subsequent "git fsck" will be less confused now.

The real reason to make this change is that in a subsequent commit
we'll split this code in write_loose_object() into a utility function,
all its callers will want the preceding sanity checks, but not the
"oideq" check. By moving the close_loose_object() earlier it'll be
easier to reason about the introduction of the utility function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index 62ebe236c90..5da458eccbf 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1886,7 +1886,14 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 	hash_object_file_literally(algo, buf, len, type_name(type), oid);
 }
 
-/* Finalize a file on disk, and close it. */
+/*
+ * We already did a write_buffer() to the "fd", let's fsync()
+ * and close().
+ *
+ * Finalize a file on disk, and close it. We might still die() on a
+ * subsequent sanity check, but let's not add to that confusion by not
+ * flushing any outstanding writes to disk first.
+ */
 static void close_loose_object(int fd)
 {
 	if (the_repository->objects->odb->will_destroy)
@@ -2006,12 +2013,12 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
 	the_hash_algo->final_oid_fn(&parano_oid, &c);
+	close_loose_object(fd);
+
 	if (!oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(fd);
-
 	if (mtime) {
 		struct utimbuf utb;
 		utb.actime = mtime;
-- 
2.35.1.1548.g36973b18e52

