Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E742232ED54
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052011; cv=none; b=m8uAPqt7+WRY9rlEyRfbJzMbo7rtgDszKQ1IRwlAqPjTkjnBopPPBgHVd2XplBHEBzlHFSJ1C3dTrXv8QPYaybLsxEDfLqWKBUhYiTB+F/Le416wUNwZLqB9T4gnqDm89r35BiRQ5j1KBMeKxooCXOxjT6ptZXS4KyXoLd30XfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052011; c=relaxed/simple;
	bh=Lh1HGgzHEsG/8Ka1X7TxbZDNEJ/lWh6uaZWrWoDM0Wg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2+ZwLBIc9jKjPiu3C7u4usainn25hPscUECJEBxkd1905fTBR6hkGXNVP4Gv4VeuNvWkwFekCYIoiFRFloheAO5m08PxIY3U8aQAFeVwnZct4djnbsWUr3CLe8aWjFmEu0kl71ZDNM3Mgu2zWeDOkuZpuMeJjFhFYJAORaeuTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=WpyBqO1r; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="WpyBqO1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784052007; x=1784656807; i=l.s.r@web.de;
	bh=+I4n9Ss9efLmZlOIGCho7NehrLtQA4J3faantR9I9Cc=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WpyBqO1rvHfKiTS46iL8VNWf0GCnIxwfSjjtzOvtco0lLmEyERcxUA/2w/VhzR+O
	 ffNDWcP4EBebaJsEN0EqQUPu5GZZgKygCVGpSzI+/ag2A+bjadnjrgxBZrER9UBLs
	 hHV/BHMrDjcv+dcxqo27BZtrT3zgVqFk3q82wp6EUTkGFTljCMSpf9h1BZdJQPJTg
	 hUPXniwsxi1s+fy5fIkicYN64PiAthAFEkrcStW91gjLRBLb+nxm5YYEuqxihsKJ7
	 sM/kUc4ZEQhKi5yovsOL4U2dtzEaEFGG2woMB8uxFg6q3JIZLRZ2wYtsTWr5hv6gn
	 zRxZTOGYbK+az7OioQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkWK-1xJaCu3qFq-00cB2o for
 <git@vger.kernel.org>; Tue, 14 Jul 2026 20:00:06 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 1/5] tempfile: add repo_create_tempfile{,_mode}()
Date: Tue, 14 Jul 2026 19:59:52 +0200
Message-ID: <20260714175956.54601-2-l.s.r@web.de>
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
X-Provags-ID: V03:K1:/VNZgZ614AcKQUSDy4rkvontXD5J1Dqc9BoIF/4QeWdKQQztx18
 g0vr3d/LL12sJGDhx8/CW5jSfXo8HMqxbzSGfOsrmfTfXkQRvm4h6vUuQLjBuk/B4hd5+oy
 U4uNLSi9Nni7gJyrEKS/2e22jmh3S7Jt7x6BVU76C758DZZZX8KGfb3QkuUoehjNS8wzEka
 csv7nDbTPmBMnKQFJ5+jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vCGSojPWYxo=;Ya78udrM4LqeuK3AwHs/WkAtFEc
 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
 V6QEckp15WiqZ3kEfE=

Add variants of create_tempfile_mode() that handle arbitrary
repositories.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tempfile.c |  8 +++++++-
 tempfile.h | 11 +++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tempfile.c b/tempfile.c
index f0fdf58279..3132eb4371 100644
=2D-- a/tempfile.c
+++ b/tempfile.c
@@ -135,6 +135,12 @@ static void deactivate_tempfile(struct tempfile *temp=
file)
=20
 /* Make sure errno contains a meaningful value on error */
 struct tempfile *create_tempfile_mode(const char *path, int mode)
+{
+	return repo_create_tempfile_mode(the_repository, path, mode);
+}
+
+struct tempfile *repo_create_tempfile_mode(struct repository *r,
+					   const char *path, int mode)
 {
 	struct tempfile *tempfile =3D new_tempfile();
=20
@@ -150,7 +156,7 @@ struct tempfile *create_tempfile_mode(const char *path=
, int mode)
 		return NULL;
 	}
 	activate_tempfile(tempfile);
-	if (adjust_shared_perm(the_repository, tempfile->filename.buf)) {
+	if (adjust_shared_perm(r, tempfile->filename.buf)) {
 		int save_errno =3D errno;
 		error("cannot fix permission bits on %s", tempfile->filename.buf);
 		delete_tempfile(&tempfile);
diff --git a/tempfile.h b/tempfile.h
index 2227a095fd..2d17e4dad3 100644
=2D-- a/tempfile.h
+++ b/tempfile.h
@@ -4,6 +4,8 @@
 #include "list.h"
 #include "strbuf.h"
=20
+struct repository;
+
 /*
  * Handle temporary files.
  *
@@ -94,11 +96,20 @@ struct tempfile {
  */
 struct tempfile *create_tempfile_mode(const char *path, int mode);
=20
+struct tempfile *repo_create_tempfile_mode(struct repository *r,
+					   const char *path, int mode);
+
 static inline struct tempfile *create_tempfile(const char *path)
 {
 	return create_tempfile_mode(path, 0666);
 }
=20
+static inline struct tempfile *repo_create_tempfile(struct repository *r,
+						    const char *path)
+{
+	return repo_create_tempfile_mode(r, path, 0666);
+}
+
 /*
  * Register an existing file as a tempfile, meaning that it will be
  * deleted when the program exits. The tempfile is considered closed,
=2D-=20
2.55.0

