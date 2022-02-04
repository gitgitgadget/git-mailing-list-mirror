Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C08C433FE
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378307AbiBDXtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378247AbiBDXs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33419E009511
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u15so14078775wrt.3
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uHnYJkH3h3WGADw5t6CHNSaL3fnkRy5wYVLdwtn4Nlw=;
        b=V+RtSLinx+9WVq1AehzAtqctZAwVpxRJH/V+Gj3Th8EUgYpTd+uSsOF9BmRHy1j8hG
         fKoLTaN1OaeNinPmASyjioxAT/S5E8om8i6zKH79sN8vAm1uzC+mTmuIdeOLAg7Kq2Fq
         MlsxNVoR/0b1DZMmbSMijWZ7t6NA0mLBUf/11P0+RINEN+R/zURHWkYzFC38DXh+vRIo
         +UmCiuyhhXVT6kTOwaR7xtR/2P7cwoxP3OmKx8AV/abwdbLLonwrpy+jYbe8lOmM0Vhi
         HZBO1v2i+HsUMWdSd/0oEFxYJjwQ/Y3MfzjrIpeuPLxVT1c0m5u+YoA0xG9qqI650QS8
         Rduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHnYJkH3h3WGADw5t6CHNSaL3fnkRy5wYVLdwtn4Nlw=;
        b=N5eoP7fmYLNM6c+OjOJ2I7LsO9ul5GtAFYUAekJa+dOstPggC9RHapTDhern5f2ZIx
         QSnL8HX7jMok/Oqwe4Oo2ixpDGi+LeA8nQvymkPEbLn2VnUeXlP+DkTr7FTzFo1IVIR+
         Xff+1WQAbZ8DtWVJc5ZmptCyUFy14vtXJJQZpHdpL2cDuQWk7fln//MyENBDM61aE5Wa
         qAFtUJwiTtpSvVOjd0Ih+ilFTKJxAAT3Xh8mK2kXg8qIVoQ8W54ef7JRx3RmGquIQNKM
         /dUYOnCxqS6PK58eBgDmXO+U3BOlx7/q0qX9wuL7SUiH9O1ZilP33bvYYVRxd/doe2i6
         8l1A==
X-Gm-Message-State: AOAM531IW0bpIRumve1sVq7b5oJtWZ1NYNnQjyeMbzwsx14i+OGVCByC
        DPgeW8oCL3NxCVXwmiN1iD4iFYiWdUGl8Q==
X-Google-Smtp-Source: ABdhPJzTGloXMLhYPSDJb+/xODjJKpf2wsfZcRRLGHdkgMyT00uPh2hJTNt/rCU9YGjiY0zxhv9Nug==
X-Received: by 2002:a05:6000:25c:: with SMTP id m28mr934679wrz.511.1644018528251;
        Fri, 04 Feb 2022 15:48:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:47 -0800 (PST)
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
Subject: [PATCH v3 09/12] object API: rename hash_object_file_literally() to write_*()
Date:   Sat,  5 Feb 2022 00:48:31 +0100
Message-Id: <patch-v3-09.12-1276c2d1ed6-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
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
index f9854922741..9e5b849693e 100644
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

