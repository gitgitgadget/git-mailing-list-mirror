Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC822E2EF2
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444795; cv=pass; b=h5csGHLLf4AhSzjfHQaTOx/a25Lq6wGOaeF24KCkwq53yGTX+QRpFikAxP5eqIFM8ZbexgEe5vsnOlg7x+Eit4/KsXLXtYpPOxkEFHVTXtn4OS9G81kJqoUE02R5nmZ3v9AP/+MhK+CTHJcd3JDNdHYIZpyyYMQld5sEMihZgiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444795; c=relaxed/simple;
	bh=+uN6AN1H50OPtFXT+YKyXGCyizIvzRniReHYYoHilOQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtAv9iefvK08ufNzzMEw4KJC2jKWFXXmiX0P5YV9n2lJb5uG6mA7f2l1WdIlzbpnLt4e15HA53e8V0J2c5aveRnKclirI0ONkbQRm+bfC94lTNQ8vf2tAzFYFUE3chq+Z6WH3CpF53c7UWca8/zOpp7q0Vdc/IyfKvUwFj/i3oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=pLvLoWwi; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="pLvLoWwi"
ARC-Seal: i=1; a=rsa-sha256; t=1760444732; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C7EO7TnFm0lXabxH+FrvhO2FldJXcSMnSyDbiMNZ7Fu6Boipq6si/9zDHp84YA+5d0U0oJM/ZfIz7j7BQYKPmON5FI1ZjR5gHmnYyIzQeSTdfDdwL1wmhmd6AifcfG0AwJ62hksRQJF2+9bo2hGXLdGcEoxCt9OSkRDYEVM0Q/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444732; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=pTMBQRzXw4ilkZXhNYBRokc4LiyH4krijnCbdlVW+Es=; 
	b=ThmGwZWMjqhVEaCBglq0g1Wm2cCtNeLy6vHqkOlzpD5H+kYAVSAPXgUklUjzo9nC3Uf+edA+24mZil3JYbsXyv+t7MvQlFbgQTn7B0LnYQ/ne0+iUD0PfuXulbfVQJAfGtCJc99kSMNouZkiWFpSL0b4Nty5ZEguDMQIzywUpD0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444732;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=pTMBQRzXw4ilkZXhNYBRokc4LiyH4krijnCbdlVW+Es=;
	b=pLvLoWwimy9laW0qFygVHJTtT3KhvpFu3Cd2Kcq18sOsn3iC0LRNBlvuNPW4ZKSG
	sTJoNxI4zwS6QVriRSS6OziSJEVK+eJqn5VIx83rDNCrvbFOay8Trh5mGViqCW+r4ib
	An/V7ccVNtZ3qN6BkRHxyFVez6L68c5OBe1fu1J0=
Received: by mx.zohomail.com with SMTPS id 1760444729123920.2201957423697;
	Tue, 14 Oct 2025 05:25:29 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 08/29] trailer: handle trailer append failures gently
Date: Tue, 14 Oct 2025 20:24:21 +0800
Message-ID: <20251014122452.1851103-9-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Added write_file_buf_gently so callers can rewrite
files while surfacing errors instead of aborting.

Updated amend_file_with_trailers to release buffers
and propagate trailer and write failures back to the caller,
because amend_file_with_trailers shuold not die.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 trailer.c | 14 ++++++++++----
 wrapper.c | 16 ++++++++++++++++
 wrapper.h |  6 ++++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/trailer.c b/trailer.c
index 5329589064..b0ad7dc5c3 100644
--- a/trailer.c
+++ b/trailer.c
@@ -9,6 +9,7 @@
 #include "commit.h"
 #include "trailer.h"
 #include "list.h"
+#include "wrapper.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -1308,11 +1309,16 @@ int amend_file_with_trailers(const char *path,
 	if (strbuf_read_file(&buf, path, 0) < 0)
 		return error_errno("could not read '%s'", path);
 
-	if (amend_strbuf_with_trailers(&buf, trailer_args))
-		die("failed to append trailers");
+	if (amend_strbuf_with_trailers(&buf, trailer_args)) {
+		strbuf_release(&buf);
+		return error("failed to append trailers");
+	}
+
+	if (write_file_buf_gently(path, buf.buf, buf.len)) {
+		strbuf_release(&buf);
+		return -1;
+	}
 
-	/* `write_file_buf()` aborts on error internally */
-	write_file_buf(path, buf.buf, buf.len);
 	strbuf_release(&buf);
 	return 0;
 }
diff --git a/wrapper.c b/wrapper.c
index 2f00d2ac87..2aeba8b049 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -688,6 +688,22 @@ void write_file_buf(const char *path, const char *buf, size_t len)
 		die_errno(_("could not close '%s'"), path);
 }
 
+int write_file_buf_gently(const char *path, const char *buf, size_t len)
+{
+	int fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+
+	if (fd < 0)
+		return error_errno(_("could not open '%s'"), path);
+	if (write_in_full(fd, buf, len) < 0) {
+		int ret = error_errno(_("could not write to '%s'"), path);
+		close(fd);
+		return ret;
+	}
+	if (close(fd))
+		return error_errno(_("could not close '%s'"), path);
+	return 0;
+}
+
 void write_file(const char *path, const char *fmt, ...)
 {
 	va_list params;
diff --git a/wrapper.h b/wrapper.h
index 7df824e34a..5b7d7a78fb 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -56,6 +56,12 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
  */
 void write_file_buf(const char *path, const char *buf, size_t len);
 
+/**
+ * Like write_file_buf(), but report errors instead of exiting. Returns 0 on
+ * success or a negative value on error after emitting a message.
+ */
+int write_file_buf_gently(const char *path, const char *buf, size_t len);
+
 /**
  * Like write_file_buf(), but format the contents into a buffer first.
  * Additionally, write_file() will append a newline if one is not already
-- 
2.51.0

