Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31267C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359162AbiBDNvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359112AbiBDNvn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:43 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677FAC061748
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:51:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s10so8889185wra.5
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Uv4S67Xcz3inlJE07/KCN9TAUKGS7aObC8hVWLuWOY=;
        b=WMB4jxaZRXmcyOy9BNAH431WOeWSvc5dDYUcAmY/cxlcHGmpdV55B1CSc1yNSml7Q6
         8+3FGR3cNWKXs9KuoaGhJfaVz5pAmPWnj5Zd9Dr0R8LzpJCjY95RyjqavOEYcS3ai9D9
         bgSd57Zkrw0LfB5P2FEv2ZqJjV1/ouFDtN/Ync4KCUAwOVuZt72RHep2yGKBDo4y9c3C
         t/QIXd2lgs/QKA1Ecq2JSmZt1WAneZSwhp6isUBlAAY8CJpQUDeXl1tibeceoZL1ELVQ
         Q6cNkVlICp/Jh/Plb0DivjgysMXFK86NuIjkwqHirtdVz2oU+5MuyCV+FLPp8yVzxMTV
         p42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Uv4S67Xcz3inlJE07/KCN9TAUKGS7aObC8hVWLuWOY=;
        b=iSTHrSGLhcvTRt2acftubOSuvbe9ZsbiWNKiy6cPyIZrksHAAnJntxvvQDJVuo327j
         EpZjCjM3UPOM7bzHkX4KwGNFAgDSn/gbUwggM4Lgoio6crG7r5e0E7RgIHY6OYM/cqXF
         dnKlMbbjBpr3HNvjPuaw0zaZ9iGZXs7fQ/Y+CcxcjC4DSntXr8U+vnz44Wxb3hS2uI1m
         s4tdOf4V6eth6AAIZlZoo6c8Qk4t1qYpgfg1Ej/y4q32uVkNgESYGOApijm7P6Oa7IFS
         ohLqpj7xBOEIlSRd+bW3P95T3TnHIwkIlKqJu/gS4aE2CDHZow/Jz2OyhZAt73G83GlC
         fysg==
X-Gm-Message-State: AOAM531TJ5ezjvqKFSeBcexaglsYudqiqj5ZLbDR8PzMBEuCS6Xwfbf5
        qBxB3QbDIzmcCht6jcWm9c1XPxiu3IxDUg==
X-Google-Smtp-Source: ABdhPJxcfS0ykzlPLXUyCU7QqKLqOWiihj2hBQLvNQnEt4+Wkz7SAytNMNa9/snHVIuXJWKLGogSaA==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr2544541wrw.673.1643982697818;
        Fri, 04 Feb 2022 05:51:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z2sm205963wmi.22.2022.02.04.05.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/11] object API: rename hash_object_file_literally() to write_*()
Date:   Fri,  4 Feb 2022 14:51:22 +0100
Message-Id: <patch-v2-08.11-a5ebd04d462-20220204T135005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before 0c3db67cc81 (hash-object --literally: fix buffer overrun with
extra-long object type, 2015-05-04) the hash-object code being changed
here called write_sha1_file() to both hash and write a loose
object. Before that we'd use hash_sha1_file() to if "-w" wasn't
provided, and otherwise call write_sha1_file().

Now we'll always call the same function for both writing. Let's rename
it from hash_*_literally() to write_*_literally(). Even though the
write_*() might not actually write if HASH_WRITE_OBJECT isn't in
"flags", having it be more similar to write_object_file_flags() than
hash_object_file(), but carrying a name that would suggest that it's a
variant of the latter is confusing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/hash-object.c | 2 +-
 object-file.c         | 6 +++---
 object-store.h        | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index c7b3ad74c60..f4cbd9c4ae3 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -25,7 +25,7 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
 	if (strbuf_read(&buf, fd, 4096) < 0)
 		ret = -1;
 	else
-		ret = hash_object_file_literally(buf.buf, buf.len, type, oid,
+		ret = write_object_file_literally(buf.buf, buf.len, type, oid,
 						 flags);
 	strbuf_release(&buf);
 	return ret;
diff --git a/object-file.c b/object-file.c
index 937a107c5ab..a68af32308e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2027,9 +2027,9 @@ int write_object_file_flags(const void *buf, unsigned long len,
 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
 }
 
-int hash_object_file_literally(const void *buf, unsigned long len,
-			       const char *type, struct object_id *oid,
-			       unsigned flags)
+int write_object_file_literally(const void *buf, unsigned long len,
+				const char *type, struct object_id *oid,
+				unsigned flags)
 {
 	char *header;
 	int hdrlen, status = 0;
diff --git a/object-store.h b/object-store.h
index eab1e2a967e..29169d117f7 100644
--- a/object-store.h
+++ b/object-store.h
@@ -258,9 +258,9 @@ static inline int write_object_file(const void *buf, unsigned long len,
 	return write_object_file_flags(buf, len, type, oid, 0);
 }
 
-int hash_object_file_literally(const void *buf, unsigned long len,
-			       const char *type, struct object_id *oid,
-			       unsigned flags);
+int write_object_file_literally(const void *buf, unsigned long len,
+				const char *type, struct object_id *oid,
+				unsigned flags);
 
 /*
  * Add an object file to the in-memory object store, without writing it
-- 
2.35.1.940.ge7a5b4b05f2

