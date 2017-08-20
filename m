Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438C020899
	for <e@80x24.org>; Sun, 20 Aug 2017 20:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbdHTUJk (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 16:09:40 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36063 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbdHTUJi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 16:09:38 -0400
Received: by mail-lf0-f68.google.com with SMTP id c189so713093lfe.3
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4MT1dR5jdG0HeCM8NVDfzyhj3beFHBv7kbX9xkOuu24=;
        b=V/I5hPmE7UA2rBd0n7yfBPll4msODzNl9DVMoIsiLHA/ePIqyoldbL6P1OT53gtNf1
         DY1gEKRx9jTSWciodTehU8BjpqdbHRjy1lchXBFlTK2BJ3u5tExMVn2dFWJScfoRjB3e
         DWYHYG2MXAtSIrNn9JdAHPIEugI+c4fBIkb5DhQHbi9ngzKLcXFJA30IPNPiY0yhrj3v
         QM2PhzJ7H5NoHIOTqdiOF06SnSOwUFPEwG9m2EzHapoj4c24UYsaAxjK/QKaKqvlUCSB
         3Tar9ySbo5jhLyxXyiOgTkH5UMb5NGS96mrso/pAPtsdGYHmpU/aWPYA6SpU89Q7B5nD
         ELOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=4MT1dR5jdG0HeCM8NVDfzyhj3beFHBv7kbX9xkOuu24=;
        b=fy9fl0SzgnoaXIBGWf+E9+C02vxuY5iV+CUk2HnhBEDfwBDqoXo9vi8CsAqTUwGhNZ
         QGiVOpmR7U64BEHG0ofVfT08YicSf5y6yY36L6J6OlQg7Dth+4vfxyjerATuGYEpISmW
         HONvD07xIV6zbC+RcjqHn8nvH0Z673vB3ZJkL43b17HH9lqUxErVI5V36uKt2D5h9v6C
         NDP71q8+I5nsi5G+2MM2LccUSSGJtRHyFJWy078mo1dhJ49wFYtl3sa+UlJrwTmEn26d
         BZ0Ux2ycBpdiZiRf+fCLrs2oK7S29ZO95RQNoD3QgGUxF/F1Fn9F0N+IWeoNf9nOtTRG
         S2PQ==
X-Gm-Message-State: AHYfb5idoAW1QMCFscNRsQIW7aOWAWPf6BQBNArPlazEnzKg6tNneLC3
        rNbV/DukYbzchZjyi4c=
X-Received: by 10.25.15.159 with SMTP id 31mr1143018lfp.10.1503259777100;
        Sun, 20 Aug 2017 13:09:37 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id a64sm928869lfl.36.2017.08.20.13.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2017 13:09:36 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/6] builtin/hash-object: convert to struct object_id
Date:   Sun, 20 Aug 2017 22:09:26 +0200
Message-Id: <0eab0c65a0c80f4b367fbf560f51b4dacb556ba9.1503258223.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503258223.git.patryk.obara@gmail.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503258223.git.patryk.obara@gmail.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 builtin/hash-object.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index d04baf9..1c0f0f3 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -16,7 +16,7 @@
  * needs to bypass the data conversion performed by, and the type
  * limitation imposed by, index_fd() and its callees.
  */
-static int hash_literally(unsigned char *sha1, int fd, const char *type, unsigned flags)
+static int hash_literally(struct object_id *oid, int fd, const char *type, unsigned flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
@@ -24,7 +24,7 @@ static int hash_literally(unsigned char *sha1, int fd, const char *type, unsigne
 	if (strbuf_read(&buf, fd, 4096) < 0)
 		ret = -1;
 	else
-		ret = hash_sha1_file_literally(buf.buf, buf.len, type, sha1, flags);
+		ret = hash_sha1_file_literally(buf.buf, buf.len, type, oid->hash, flags);
 	strbuf_release(&buf);
 	return ret;
 }
@@ -33,16 +33,16 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 		    int literally)
 {
 	struct stat st;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	if (fstat(fd, &st) < 0 ||
 	    (literally
-	     ? hash_literally(sha1, fd, type, flags)
-	     : index_fd(sha1, fd, &st, type_from_string(type), path, flags)))
+	     ? hash_literally(&oid, fd, type, flags)
+	     : index_fd(oid.hash, fd, &st, type_from_string(type), path, flags)))
 		die((flags & HASH_WRITE_OBJECT)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
-	printf("%s\n", sha1_to_hex(sha1));
+	printf("%s\n", oid_to_hex(&oid));
 	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
-- 
2.9.5

