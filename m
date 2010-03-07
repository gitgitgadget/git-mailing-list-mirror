From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/18] hash-object: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:55:53 +0700
Message-ID: <1267937767-12504-5-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8az-0000K9-HT
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab0CGE7m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 23:59:42 -0500
Received: from mail-px0-f188.google.com ([209.85.216.188]:54566 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab0CGE7l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 23:59:41 -0500
Received: by pxi26 with SMTP id 26so1738333pxi.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 20:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+LPr4g6PNPlLQjhhNNXmKdu3DDSEaxX5g6icpzxVvA0=;
        b=P58ITlDsIHP1RiIvI8NCGKrVkX1XQ37nwjs9FOirewCjhcqxdoAGZLFTyW/5MHK9C8
         eqav331eqvHfokPAF1FK8psT7qb3lms6ydyxeoLVwrti4gHLyBRQmT3TKwZO5S3eilP2
         3eKE1LiHmqMADsSshv+o9JgiebAOsfzrMyi8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xN6TtckMXMhRRK7kMRDk3Db0UMzb5GCcwY8B6+7hCAtDFZvUwemQ2uGwFQiDWkdykm
         GvXYk/YptmebA8HJP0BPfBUsIbWdBtLt0Wn9GHb8270HmRnqmZ/kA3uDFSbfUXt0GDTD
         DowPHWZ7Plk8jTi+QRjU4UED3IFkAxzuOXxjA=
Received: by 10.142.60.4 with SMTP id i4mr2065443wfa.296.1267937980956;
        Sat, 06 Mar 2010 20:59:40 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 21sm3227480pzk.8.2010.03.06.20.59.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 20:59:40 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:25 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141649>

hash-object needs to inspect repository's config, so it must try to
find a repository regardless the object will be written in object
store.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/hash-object.c |    9 +++++----
 git.c                 |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 6a5f5b5..57330b8 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -76,7 +76,7 @@ static const struct option hash_object_options[] =3D =
{
 int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int prefix_length =3D -1;
+	int prefix_length;
 	const char *errstr =3D NULL;
=20
 	type =3D blob_type;
@@ -84,9 +84,10 @@ int cmd_hash_object(int argc, const char **argv, con=
st char *prefix)
 	argc =3D parse_options(argc, argv, NULL, hash_object_options,
 			     hash_object_usage, 0);
=20
+	prefix_length =3D prefix ? strlen(prefix) : 0;
 	if (write_object) {
-		prefix =3D setup_git_directory();
-		prefix_length =3D prefix ? strlen(prefix) : 0;
+		if (!startup_info->have_repository)
+			die("No repository found");
 		if (vpath && prefix)
 			vpath =3D prefix_filename(prefix, prefix_length, vpath);
 	}
@@ -121,7 +122,7 @@ int cmd_hash_object(int argc, const char **argv, co=
nst char *prefix)
 	for (i =3D 0 ; i < argc; i++) {
 		const char *arg =3D argv[i];
=20
-		if (0 <=3D prefix_length)
+		if (prefix_length)
 			arg =3D prefix_filename(prefix, prefix_length, arg);
 		hash_object(arg, type, write_object,
 			    no_filters ? NULL : vpath ? vpath : arg);
diff --git a/git.c b/git.c
index 4c99319..2069ef3 100644
--- a/git.c
+++ b/git.c
@@ -327,7 +327,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, USE_PAGER },
-		{ "hash-object", cmd_hash_object },
+		{ "hash-object", cmd_hash_object, RUN_SETUP_GENTLY },
 		{ "help", cmd_help },
 		{ "index-pack", cmd_index_pack },
 		{ "init", cmd_init_db },
--=20
1.7.0.195.g637a2
