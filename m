From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/7] Rerolling sb/submodule-parallel-fetch for the time after 2.7
Date: Tue, 15 Dec 2015 16:19:54 -0800
Message-ID: <1450225194-18386-1-git-send-email-sbeller@google.com>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 16 01:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8zpD-0003Bg-DW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbbLPAUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:20:05 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32837 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbbLPAUE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:20:04 -0500
Received: by mail-pa0-f49.google.com with SMTP id ur14so13634545pab.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 16:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FJpBBvzKOV38fttK3NU08J5qZoL21aWM2uhx4DL1ZGw=;
        b=X0e9P8UuWLxtmkKwXMlF3KJmd6CIVAxK3Oi9ElJxZpDJFLNMAEetIWW3wqleT6wwmH
         isFUUrP/JOHDdwWE5qZW1wXlNr4mV9inRVyVmKPubVtOMEHA9ce321PoFOQq2y9VSscZ
         Idj6slyG92NtkTZWdPVH5DIAeCsYKNW1Eld6vz+hKqU6uUOvyB9/rxg74ctrXviZYtPf
         vq+Bd9vr6o4oVm3I/Y2ecBVVKhi4P81pjOvAsQjSGFWCTVxaOHzr3ELOiUSyE4UhtwOh
         v6W9/EUYhcxzHAiGsfjEtJIiQdHKfW39p5d8ZEpA8ZHKmsRwrBbr0RQaZ9tvFnYmroY3
         Kmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FJpBBvzKOV38fttK3NU08J5qZoL21aWM2uhx4DL1ZGw=;
        b=fhcJ9OupldTLa1UpI1Of7SevUSv+39seUeu61cDEQCxw5Gm8saHjyFx4NYeeBXNnSe
         kd6hxK+gjzREHIhoRAH6GHxSeq5VGrhXEiAcXnIG3QYX7uuJfqnb/xWG/84COASSZbT9
         FqZMq6l8myGcegvkSQyP5pNqDgKR6haBPBevyAuErSFnQvUEE+Go7sGjuiy6MG/6n/SA
         xQqFbYbZWa0EcGBvR8ZUTYXh5TrZF5jnPmpSwYb70OisCl0telM2uSOpa0npH+PXrPuD
         KukIU8aXaYpM9JuvYaa3ipv8RM67sJiHfLLjVRCdNqQZo6kPAhVjeAasVb6fmaapTNSM
         8UWg==
X-Gm-Message-State: ALoCoQk33eNSY1r5/67dRjeFxohg7WcxPUpRd81GL8tTjoWEbGs47pc9IuKyUenM5btvK5fCMVhKBHHQmt4UjOrrAQiKbl1CYw==
X-Received: by 10.66.158.193 with SMTP id ww1mr29716942pab.21.1450225203908;
        Tue, 15 Dec 2015 16:20:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a171:258:4778:14b4])
        by smtp.gmail.com with ESMTPSA id p83sm437928pfi.96.2015.12.15.16.20.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 16:20:03 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450224252-16833-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282522>

with the interdiff below:

diff --git a/git-compat-util.h b/git-compat-util.h
index 87456a3..8e39867 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -723,7 +723,6 @@ extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_
 extern void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern int xopen(const char *path, int flags, ...);
 extern ssize_t xread(int fd, void *buf, size_t len);
-extern ssize_t xread_nonblock(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
diff --git a/strbuf.c b/strbuf.c
index b552a13..38686ff 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -389,7 +389,7 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 	ssize_t cnt;

 	strbuf_grow(sb, hint ? hint : 8192);
-	cnt = xread_nonblock(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
+	cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
 	if (cnt > 0)
 		strbuf_setlen(sb, sb->len + cnt);
 	return cnt;
diff --git a/strbuf.h b/strbuf.h
index c3e5980..2bf90e7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,10 +367,10 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);

 /**
- * Returns the number of new bytes appended to the sb.
- * Negative return value signals there was an error returned from
- * underlying read(2), in which case the caller should check errno.
- * e.g. errno == EAGAIN when the read may have blocked.
+ * Read the contents of a given file descriptor partially by using only one
+ * attempt of xread. The third argument can be used to give a hint about the
+ * file size, to avoid reallocs. Returns the number of new bytes appended to
+ * the sb.
  */
 extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
diff --git a/wrapper.c b/wrapper.c
index f71237c..1770efa 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -243,7 +243,14 @@ ssize_t xread(int fd, void *buf, size_t len)
 				struct pollfd pfd;
 				pfd.events = POLLIN;
 				pfd.fd = fd;
-				/* We deliberately ignore the return value */
+				/*
+				 * it is OK if this poll() failed; we
+				 * want to leave this infinite loop
+				 * only when read() returns with
+				 * success, or an expected failure,
+				 * which would be checked by the next
+				 * call to read(2).
+				 */
 				poll(&pfd, 1, -1);
 			}
 		}
@@ -252,28 +259,6 @@ ssize_t xread(int fd, void *buf, size_t len)
 }

 /*
- * xread_nonblock() is the same a read(), but it automatically restarts read()
- * interrupted operations (EINTR). xread_nonblock() DOES NOT GUARANTEE that
- * "len" bytes is read. EWOULDBLOCK is turned into EAGAIN.
- */
-ssize_t xread_nonblock(int fd, void *buf, size_t len)
-{
-	ssize_t nr;
-	if (len > MAX_IO_SIZE)
-		len = MAX_IO_SIZE;
-	while (1) {
-		nr = read(fd, buf, len);
-		if (nr < 0) {
-			if (errno == EINTR)
-				continue;
-			if (errno == EWOULDBLOCK)
-				errno = EAGAIN;
-		}
-		return nr;
-	}
-}
-
-/*
  * xwrite() is the same a write(), but it automatically restarts write()
  * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
  * GUARANTEE that "len" bytes is written even if the operation is successful.
