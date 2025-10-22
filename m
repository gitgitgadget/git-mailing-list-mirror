Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41D1DDDD
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111701; cv=pass; b=atW6//eLQX2bWEuRiGmJ1E94GLV/Pe/hZJAzKt9RTccTXI3AzSyylWLJB4l1KipZJkGW8A1v2vNyOGd7l3FrWIUpUxvICgoKqfKc/THcmZvo4p0kTa07C9hAr2UlOuiqTx90RAPHw0KnWvdtCG1aMoiLVhzNeyB4q705MJQnycs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111701; c=relaxed/simple;
	bh=FX0AQ4HuwYBrlazwsAbpwI8ay2vQ9we6CRCjeXo61ao=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtB8qEC82VAqKgp2AA5t6Y3ZUdLKU6PyC6jZwiuKB/KtmTCVcKb8QpIDK28yC7ss4igZim0wfiriQlV11mMXkH2GGDQLJgDOn3MjGbyveTIxE/VHzQM4smnLj2A/YgAHZ5BE/09Qqh3KcgMCmjNNE1ZSnJXldkYhxmmKf/2tl5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=EwXXnBAB; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="EwXXnBAB"
ARC-Seal: i=1; a=rsa-sha256; t=1761111615; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LPC82pyRSGY51qWdMqJ6LPk+FqW+CghWhI7lA5eADb2NXrcqsjzBN8aAjryanxJmnkjjEO+PidNsemfcgDcpqFw0L4XJ6g7yvRsW9EOiSqMbUgv9oaOAQFzLSjl/wzYlKuRf/U2NFt6T/eQ7b6cPRPF1NZITfWIpAy7/QLbozgA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111615; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=gZcVjt5qLnODL27m6vqjHKAf7RZWFGuD4xA75IEoEyU=; 
	b=WgpsJY7uzBdo2I5KH2+eeFWIcfm1YnxRATlbT/jrcW6TR8OpWCIzYvCnNDGb05LQKaoqn6SLBUyukFoexaZtWf9oWAUgYpx7pGYEFX31IE5xWHK0OOgpDYBevCsEQjl6aoVAUO3nUwDuY2FHOBLa8S+H4eEAOdFKTU/FJ4sPrJc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111615;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=gZcVjt5qLnODL27m6vqjHKAf7RZWFGuD4xA75IEoEyU=;
	b=EwXXnBABE7dPFGP/5MCp3Tlk9B6MpFt0LPjr2V6X+uTIHhhagIiECb6pv028YsDA
	O0LHKqp6yVtwU2VjLb21IWm/VdkkZhUAjWvWSP6AvWIZpAXfLMvDEpg5nKdlX5zVgLF
	ODVTSApPt/pujAW9bmhrNdtgyYfQQxVyz4qzPRMg=
Received: by mx.zohomail.com with SMTPS id 1761111612527771.6837656955599;
	Tue, 21 Oct 2025 22:40:12 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 08/29] trailer: handle trailer append failures gently
Date: Wed, 22 Oct 2025 13:39:28 +0800
Message-ID: <20251022053951.602605-9-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
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
index ac6ac2ac20..1f317f4d37 100644
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
index 3d507d4204..1f12dbb2fa 100644
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
index 44a8597ac3..e5f867b200 100644
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

