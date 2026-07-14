Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50810335BBB
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052011; cv=none; b=PADsROabjos1Q4cUgks2P9SKDcQbFM9vEaxXb4ES+ntU40PIXSXdotCqZfZJeZoA9Q21RcEGtfbVSBdFUbuD3RgEs5deZCw++yqTGQQ/Mg4iAt2hAAq3knPLoYhzxseGxtvkoO2Ssev/sk2WRX3mRjjNLXT1j367IIX4+79ADJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052011; c=relaxed/simple;
	bh=V5dO+NVF5FGr7J2K5bI761gc1lJGMUrKG0Tzk2ND/HE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=em3t5+RNT403cGz5qUZdPri2/clfM3J9GpC8vM53LXZshCPfkLoXaUKIoHm75fkJ0evA3Y+ciJSBm5TTG3qbJGdkvAHhWaIsNkt/tzTs3m9813YENOfwBLjZcfJ1EHbn2w5snGgeC2fKMfVratrub1KaIXN3VNvmbsifNDG3bzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Bt2ePjP+; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Bt2ePjP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784052007; x=1784656807; i=l.s.r@web.de;
	bh=4PfUlo+VM7fgL7JQ/b/eaVRf2JK4R6aWQF6sjdQCfsU=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bt2ePjP+5L4gIEWywD5Hcfnz1BxMh+RzYt3dtCkTr4uFPS5Af9XByZgiY1xddm6S
	 ylEl5Cg6KKLh2TO1PQerdc/y/rq/1+bSF+G3EmF+HMInULuTsiv2rWDIncn/b/5t+
	 LKW/18kcmRBBugD4iVi/X7wkebYDGTz1kcrjYdymJtLqCYk66xsjp0vsym9BfCi6F
	 o3gM+++BWT0W9Sh2woeJLfaK9yLgLQ5eGw2XbI7d5FhumjbegxPnVpSy9bdz7Rp5s
	 x+Dp3HKwjDJVHvlLzOdmyVjWW4i4RbA7PsIwhaNrFJCBjCAJ8+oVYLAmfLpUWtr0t
	 IDlvfQdVGizlqZob1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl0p-1xOkji0cCz-00p7Kz for
 <git@vger.kernel.org>; Tue, 14 Jul 2026 20:00:07 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 3/5] lockfile: add repo_hold_lock_file_for_update{,_timeout}{,_mode}()
Date: Tue, 14 Jul 2026 19:59:54 +0200
Message-ID: <20260714175956.54601-4-l.s.r@web.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714175956.54601-1-l.s.r@web.de>
References: <20260714175956.54601-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1xDLd6d/68ADDtycSq3h5iutziPnlEPiDuLHIWSAsMPSpAC8P82
 JxiSo2m1dKXS5z4UDpzeQ/U8s9mx/Sp1Z67o0UFvu9qZLTcFSFRnkz/u4uXYDdus5Qq8TRC
 oKVVEYVPQ4d8LEZbYEaIAEApDwqdF0TFYKPNoIZhimV5p9lK4LX3zQYdY9mi+NQGLDs+2UH
 PYiWQQcozLVpMrAmgnHYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bhwAD3d7c3A=;3MxDiB9XQiY0DnaiVXY+AXSlacA
 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
 60pzbBEnOHM+OnrGxvreIEfVrsAryw

Add variants of hold_lock_file_for_update_timeout_mode() that handle
arbitrary repositories.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 lockfile.c | 30 ++++++++++++++++++++++--------
 lockfile.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 7add2f136a..100f603771 100644
=2D-- a/lockfile.c
+++ b/lockfile.c
@@ -2,11 +2,14 @@
  * Copyright (c) 2005, Junio C Hamano
  */
=20
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "gettext.h"
 #include "lockfile.h"
 #include "parse.h"
+#include "repository.h"
 #include "strbuf.h"
 #include "wrapper.h"
=20
@@ -162,8 +165,8 @@ static int read_lock_pid(const char *pid_path, uintmax=
_t *pid_out)
 }
=20
 /* Make sure errno contains a meaningful value on error */
-static int lock_file(struct lock_file *lk, const char *path, int flags,
-		     int mode)
+static int lock_file(struct repository *r, struct lock_file *lk,
+		     const char *path, int flags, int mode)
 {
 	struct strbuf base_path =3D STRBUF_INIT;
 	struct strbuf lock_path =3D STRBUF_INIT;
@@ -176,7 +179,7 @@ static int lock_file(struct lock_file *lk, const char =
*path, int flags,
 	get_lock_path(&lock_path, base_path.buf);
 	get_pid_path(&pid_path, base_path.buf);
=20
-	lk->tempfile =3D create_tempfile_mode(lock_path.buf, mode);
+	lk->tempfile =3D repo_create_tempfile_mode(r, lock_path.buf, mode);
 	if (lk->tempfile)
 		lk->pid_tempfile =3D create_lock_pid_file(pid_path.buf, mode);
=20
@@ -200,8 +203,9 @@ static int lock_file(struct lock_file *lk, const char =
*path, int flags,
  * timeout_ms milliseconds. If timeout_ms is 0, try locking the file
  * exactly once. If timeout_ms is -1, try indefinitely.
  */
-static int lock_file_timeout(struct lock_file *lk, const char *path,
-			     int flags, long timeout_ms, int mode)
+static int lock_file_timeout(struct repository *r, struct lock_file *lk,
+			     const char *path, int flags, long timeout_ms,
+			     int mode)
 {
 	int n =3D 1;
 	int multiplier =3D 1;
@@ -209,7 +213,7 @@ static int lock_file_timeout(struct lock_file *lk, con=
st char *path,
 	static int random_initialized =3D 0;
=20
 	if (timeout_ms =3D=3D 0)
-		return lock_file(lk, path, flags, mode);
+		return lock_file(r, lk, path, flags, mode);
=20
 	if (!random_initialized) {
 		srand((unsigned int)getpid());
@@ -223,7 +227,7 @@ static int lock_file_timeout(struct lock_file *lk, con=
st char *path,
 		long backoff_ms, wait_ms;
 		int fd;
=20
-		fd =3D lock_file(lk, path, flags, mode);
+		fd =3D lock_file(r, lk, path, flags, mode);
=20
 		if (fd >=3D 0)
 			return fd; /* success */
@@ -308,7 +312,17 @@ int hold_lock_file_for_update_timeout_mode(struct loc=
k_file *lk,
 					   const char *path, int flags,
 					   long timeout_ms, int mode)
 {
-	int fd =3D lock_file_timeout(lk, path, flags, timeout_ms, mode);
+	return repo_hold_lock_file_for_update_timeout_mode(the_repository,
+							   lk, path, flags,
+							   timeout_ms, mode);
+}
+
+int repo_hold_lock_file_for_update_timeout_mode(struct repository *r,
+						struct lock_file *lk,
+						const char *path, int flags,
+						long timeout_ms, int mode)
+{
+	int fd =3D lock_file_timeout(r, lk, path, flags, timeout_ms, mode);
 	if (fd < 0) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			unable_to_lock_die(path, errno);
diff --git a/lockfile.h b/lockfile.h
index e7233f28de..1667612674 100644
=2D-- a/lockfile.h
+++ b/lockfile.h
@@ -189,6 +189,11 @@ int hold_lock_file_for_update_timeout_mode(
 	struct lock_file *lk, const char *path,
 	int flags, long timeout_ms, int mode);
=20
+int repo_hold_lock_file_for_update_timeout_mode(struct repository *r,
+						struct lock_file *lk,
+						const char *path, int flags,
+						long timeout_ms, int mode);
+
 static inline int hold_lock_file_for_update_timeout(
 	struct lock_file *lk, const char *path,
 	int flags, long timeout_ms)
@@ -197,6 +202,16 @@ static inline int hold_lock_file_for_update_timeout(
 						      timeout_ms, 0666);
 }
=20
+static inline int repo_hold_lock_file_for_update_timeout(struct repositor=
y *r,
+							 struct lock_file *lk,
+							 const char *path,
+							 int flags,
+							 long timeout_ms)
+{
+	return repo_hold_lock_file_for_update_timeout_mode(r, lk, path, flags,
+							   timeout_ms, 0666);
+}
+
 /*
  * Attempt to create a lockfile for the file at `path` and return a
  * file descriptor for writing to it, or -1 on error. The flags
@@ -208,6 +223,13 @@ static inline int hold_lock_file_for_update(
 	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
 }
=20
+static inline int repo_hold_lock_file_for_update(struct repository *r,
+						 struct lock_file *lk,
+						 const char *path, int flags)
+{
+	return repo_hold_lock_file_for_update_timeout(r, lk, path, flags, 0);
+}
+
 static inline int hold_lock_file_for_update_mode(
 	struct lock_file *lk, const char *path,
 	int flags, int mode)
@@ -215,6 +237,15 @@ static inline int hold_lock_file_for_update_mode(
 	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode);
 }
=20
+static inline int repo_hold_lock_file_for_update_mode(struct repository *=
r,
+						      struct lock_file *lk,
+						      const char *path,
+						      int flags, int mode)
+{
+	return repo_hold_lock_file_for_update_timeout_mode(r, lk, path, flags,
+							   0, mode);
+}
+
 /*
  * Return a nonzero value iff `lk` is currently locked.
  */
=2D-=20
2.55.0

