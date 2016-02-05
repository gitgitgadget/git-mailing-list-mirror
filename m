From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/8] fetch-pack.c: send "skip" line to pack-objects
Date: Fri,  5 Feb 2016 15:57:54 +0700
Message-ID: <1454662677-15137-6-git-send-email-pclouds@gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 09:58:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRcDz-0007Wn-Js
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 09:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbcBEI6k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 03:58:40 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35636 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbcBEI6h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 03:58:37 -0500
Received: by mail-pa0-f46.google.com with SMTP id ho8so30981306pac.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 00:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4b3kXtLQTBcGtUClN+v7qvw3xwgv6XrGNvQaZRkVFCo=;
        b=hPyukfEk5rp0R36c2fNANtrBAxY4mhbnIWtCRRbTTCY13dtmSW+K2oviRMqMq7qAOQ
         4VSakhkLXaq4+CUzYJz7+VWes3EaiObXzjWzuHz2/042tTW0U34IhGMdGc7RKv82r6dd
         AKq1lA0O9Tvf0Y2w5LcicFsXISiTihxkWQp6dzM/ATV5W/oqzBaYHKhI//WHYpBzG+N0
         GUD0JBkWZUGh4d2hGDIT4CJ6H/6m8dzcHKyAe1gKLvL5StVuwImwJMsp+YD7No2MNS/6
         1cYwS/T+qeAHzgWpOAL3xlXZ1mNQTz7TbHfsotuRlwM3vrH+UVxz0yVPeEekcmplyUQd
         Jiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=4b3kXtLQTBcGtUClN+v7qvw3xwgv6XrGNvQaZRkVFCo=;
        b=AzMJtjar8md9XcnDmi8ZHpU/kkJ9AD/4sUZIRbz5Mbga0DSG8bsSaarDOYuX7DXNO7
         WUMOKZp5kKbGfyUV/HcHFFjA8ek2USe2IeJWDMmtMESUmXE72Wt0XmPl2Rz3B6Ev+jbN
         FJ/6SAEVEeEWWDTIKokkL+zSLcEgb+rsfA5DBIEYaVmF/EscCm4SwgFgzUFQekZHi0V0
         p/XTMq2TEyTd6xTW4X1cnYpxyyEFUI0iwSL5pX5fHXb7dnbaPTPFeQo6Pw/+wBcTzOrH
         TN3qLMeeQfzrDAfvRf/q1960Zqmplh/eoMoFqVlnYtJ15LXzyJDw0cCyBuBJu+iwG6CM
         tjoA==
X-Gm-Message-State: AG10YOThhEciECDne2ELgwocHwE4ZO8IZDPYV5LD3U57WGeWIw7dfqB1Pyv00UX1/pXr1Q==
X-Received: by 10.67.7.129 with SMTP id dc1mr2896949pad.87.1454662717248;
        Fri, 05 Feb 2016 00:58:37 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 3sm22637694pfp.96.2016.02.05.00.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 00:58:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 05 Feb 2016 15:58:51 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285560>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fetch-pack.c | 40 ++++++++++++++++++++++++++++++++++++++++
 fetch-pack.h |  3 +++
 2 files changed, 43 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 01e34b6..ffb5254 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "prio-queue.h"
 #include "sha1-array.h"
+#include "dir.h"
=20
 static int transfer_unpack_limit =3D -1;
 static int fetch_unpack_limit =3D -1;
@@ -330,6 +331,10 @@ static int find_common(struct fetch_pack_args *arg=
s,
 		write_shallow_commits(&req_buf, 1, NULL);
 	if (args->depth > 0)
 		packet_buf_write(&req_buf, "deepen %d", args->depth);
+	if (args->resume_path)
+		packet_buf_write(&req_buf, "skip %s %d",
+				 sha1_to_hex(args->skip_hash),
+				 args->skip_offset);
 	packet_buf_flush(&req_buf);
 	state_len =3D req_buf.len;
=20
@@ -730,6 +735,9 @@ static int get_pack(struct fetch_pack_args *args,
 			argv_array_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
 			argv_array_push(&cmd.args, "--fix-thin");
+		if (args->resume_path && args->skip_offset)
+			argv_array_pushf(&cmd.args, "--append-pack=3D%s",
+					 args->resume_path);
 		if (args->lock_pack || unpack_limit) {
 			char hostname[256];
 			if (gethostname(hostname, sizeof(hostname)))
@@ -856,6 +864,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta =3D 0;
+	if (args->resume_path && !server_supports("partial"))
+		die(_("Server does not support resume capability\n"));
=20
 	if ((agent_feature =3D server_feature_value("agent", &agent_len))) {
 		agent_supported =3D 1;
@@ -1030,6 +1040,35 @@ static void update_shallow(struct fetch_pack_arg=
s *args,
 	sha1_array_clear(&ref);
 }
=20
+static void prepare_resume_fetch(struct fetch_pack_args *args)
+{
+	git_SHA_CTX c;
+	char buf[8192];
+	int fd, len;
+
+	if (!args->resume_path)
+		return;
+
+	args->skip_offset =3D 0;
+	args->keep_pack =3D 1;
+	if (!file_exists(args->resume_path))
+		return;
+
+	fd =3D open(args->resume_path, O_RDONLY);
+	if (fd =3D=3D -1)
+		die_errno(_("failed to open '%s'"), args->resume_path);
+
+	git_SHA1_Init(&c);
+	while ((len =3D xread(fd, buf, sizeof(buf))) > 0) {
+		git_SHA1_Update(&c, buf, len);
+		args->skip_offset +=3D len;
+	}
+	if (len < 0)
+		die_errno(_("failed to read '%s'"), args->resume_path);
+	git_SHA1_Final(args->skip_hash, &c);
+	close(fd);
+}
+
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
@@ -1050,6 +1089,7 @@ struct ref *fetch_pack(struct fetch_pack_args *ar=
gs,
 		die("no matching remote head");
 	}
 	prepare_shallow_info(&si, shallow);
+	prepare_resume_fetch(args);
 	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought,
 				&si, pack_lockfile);
 	reprepare_packed_git();
diff --git a/fetch-pack.h b/fetch-pack.h
index bb7fd76..46f0997 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -10,6 +10,9 @@ struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
 	int depth;
+	const char *resume_path;
+	int skip_offset;
+	unsigned char skip_hash[20];
 	unsigned quiet:1;
 	unsigned keep_pack:1;
 	unsigned lock_pack:1;
--=20
2.7.0.377.g4cd97dd
