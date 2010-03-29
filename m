From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH 3/5] convert: Use the enum constant SAFE_CRLF_FALSE.
Date: Mon, 29 Mar 2010 13:28:57 +0200
Message-ID: <74ce7980eb1fe629a651433ca9f1662f26495ce9.1269860022.git.grubba@grubba.org>
References: <cover.1269860022.git.grubba@grubba.org>
 <a75a46b1b6fdb9d52f608643676512e87474e16d.1269860022.git.grubba@grubba.org>
 <6d9d8b0eaa022f441c507b141ff0efa3f21d1988.1269860022.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 13:29:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwD9i-0005ax-Am
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 13:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab0C2L3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 07:29:12 -0400
Received: from mail.roxen.com ([212.247.29.220]:43043 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab0C2L3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 07:29:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 9EDA7628258
	for <git@vger.kernel.org>; Mon, 29 Mar 2010 13:29:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u0xyMX6Vojz4; Mon, 29 Mar 2010 13:29:05 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 77B07628254;
	Mon, 29 Mar 2010 13:29:05 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o2TBT5GU006183;
	Mon, 29 Mar 2010 13:29:05 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o2TBT5hH006182;
	Mon, 29 Mar 2010 13:29:05 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <6d9d8b0eaa022f441c507b141ff0efa3f21d1988.1269860022.git.grubba@grubba.org>
In-Reply-To: <cover.1269860022.git.grubba@grubba.org>
References: <cover.1269860022.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143456>

A few places used plain zeros as the last argument to convert_to_git,
instead of the corresponding enum constant.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
Suggested by Bert Wesarg <bert.wesarg@googlemail.com>.

 builtin/apply.c |    2 +-
 builtin/blame.c |    2 +-
 sha1_file.c     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7ca9047..6dbe1d7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1759,7 +1759,7 @@ static int read_old_data(struct stat *st, const c=
har *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) !=3D st->st_size)
 			return error("unable to open or read %s", path);
-		convert_to_git(path, buf->buf, buf->len, buf, 0);
+		convert_to_git(path, buf->buf, buf->len, buf, SAFE_CRLF_FALSE);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin/blame.c b/builtin/blame.c
index fc15863..3af045b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2050,7 +2050,7 @@ static struct commit *fake_working_tree_commit(co=
nst char *path, const char *con
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(path, buf.buf, buf.len, &buf, SAFE_CRLF_FALSE);
 	origin->file.ptr =3D buf.buf;
 	origin->file.size =3D buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/sha1_file.c b/sha1_file.c
index a08a9d0..96c69cc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2417,7 +2417,7 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
 	if ((type =3D=3D OBJ_BLOB) && path) {
 		struct strbuf nbuf =3D STRBUF_INIT;
 		if (convert_to_git(path, buf, size, &nbuf,
-		                   write_object ? safe_crlf : 0)) {
+		                   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
 			buf =3D strbuf_detach(&nbuf, &size);
 			re_allocated =3D 1;
 		}
--=20
1.6.4.122.g6ffd7
