From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/8] archive: support creating archives from index
Date: Wed,  8 Apr 2009 20:05:33 +1000
Message-ID: <1239185133-4181-9-git-send-email-pclouds@gmail.com>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
 <1239185133-4181-2-git-send-email-pclouds@gmail.com>
 <1239185133-4181-3-git-send-email-pclouds@gmail.com>
 <1239185133-4181-4-git-send-email-pclouds@gmail.com>
 <1239185133-4181-5-git-send-email-pclouds@gmail.com>
 <1239185133-4181-6-git-send-email-pclouds@gmail.com>
 <1239185133-4181-7-git-send-email-pclouds@gmail.com>
 <1239185133-4181-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 12:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUjI-0005yX-3q
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758695AbZDHKHc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 06:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763959AbZDHKHa
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:07:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:44704 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763897AbZDHKH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:07:28 -0400
Received: by rv-out-0506.google.com with SMTP id f9so37692rvb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=U6YZdLW10FpgnvJWIdJo0K1SPO7wjACOKM5PQBVmUho=;
        b=artD/ccDkCDU8llpmC6ybwO1Hx0LsrPfjXfR1uAVknzZAvIZIIC8g+bBeuP5ME1h9I
         oMf4zQjNGKzg38PL/4PhBFI5fcSSxqrSjm8TWXDLsnIRw1FmutfWqGAjwWL7goTojiVL
         vOKPVqihazyuvsahXj4gJGNdxhj73NHgMrhc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WSWIGdF5eVM+wt+9223thvmUmN1e4l1RMcCcMNc6yebDhKw1DFyxNBdqgkNfEpVS2q
         nQU4SjG07SxUlSTVAQ7uEPpvw9UuTtV6EjCI8DDeqewHf19cAwPxIhPUeHR/0gaSL5NK
         ZsqL+tDIFzE/FOP/xIjOha0OxDcjdLUFjakZ4=
Received: by 10.141.29.11 with SMTP id g11mr468365rvj.17.1239185248068;
        Wed, 08 Apr 2009 03:07:28 -0700 (PDT)
Received: from dektop ([121.91.216.142])
        by mx.google.com with ESMTPS id b8sm24922863rvf.32.2009.04.08.03.07.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 03:07:27 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Apr 2009 20:07:21 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
In-Reply-To: <1239185133-4181-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116072>

This is more or less for fun. Does anyone really want to create archive=
s
from index?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c |   38 +++++++++++++++++++++++++-------------
 archive.h |    1 +
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/archive.c b/archive.c
index 1ce644e..bb0a0f1 100644
--- a/archive.c
+++ b/archive.c
@@ -181,7 +181,7 @@ int write_archive_entries(struct archiver_args *arg=
s,
 			len--;
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)len, args->base);
-		err =3D write_entry(args, args->tree->object.sha1, args->base,
+		err =3D write_entry(args, args->tree ? args->tree->object.sha1 : nul=
l_sha1, args->base,
 				len, 040777, NULL, 0);
 		if (err)
 			return err;
@@ -190,15 +190,19 @@ int write_archive_entries(struct archiver_args *a=
rgs,
 	context.args =3D args;
 	context.write_entry =3D write_entry;
=20
-	memset(&opts, 0, sizeof(opts));
-	opts.index_only =3D 1;
-	opts.head_idx =3D -1;
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
-	opts.fn =3D oneway_merge;
-	init_tree_desc(&t, args->tree->buffer, args->tree->size);
-	if (unpack_trees(1, &t, &opts))
-		return -1;
+	if (args->tree) {
+		memset(&opts, 0, sizeof(opts));
+		opts.index_only =3D 1;
+		opts.head_idx =3D -1;
+		opts.src_index =3D &the_index;
+		opts.dst_index =3D &the_index;
+		opts.fn =3D oneway_merge;
+		init_tree_desc(&t, args->tree->buffer, args->tree->size);
+		if (unpack_trees(1, &t, &opts))
+			return -1;
+	}
+	else
+		read_cache();
 	prefix_len =3D common_prefix(args->pathspec);
 	if (prefix_len)
 		prune_cache(args->pathspec[0], prefix_len);
@@ -300,6 +304,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 	int verbose =3D 0;
 	int i;
 	int list =3D 0;
+	int use_index =3D 0;
 	struct option opts[] =3D {
 		OPT_GROUP(""),
 		OPT_STRING('f', "format", &format, "fmt", "archive format"),
@@ -307,6 +312,8 @@ static int parse_archive_args(int argc, const char =
**argv,
 			"prepend prefix to each pathname in the archive"),
 		OPT_STRING(0, "output", &output, "file",
 			"write the archive to this file"),
+		OPT_BOOLEAN('i', "index", &use_index,
+			"generate from index instead"),
 		OPT__VERBOSE(&verbose),
 		OPT__COMPR('0', &compression_level, "store only", 0),
 		OPT__COMPR('1', &compression_level, "compress faster", 1),
@@ -348,7 +355,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 	}
=20
 	/* We need at least one parameter -- tree-ish */
-	if (argc < 1)
+	if (argc < 1 && !use_index)
 		usage_with_options(archive_usage, opts);
 	*ar =3D lookup_archiver(format);
 	if (!*ar)
@@ -366,6 +373,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 	args->verbose =3D verbose;
 	args->base =3D base;
 	args->baselen =3D strlen(base);
+	args->use_index =3D use_index;
=20
 	return argc;
 }
@@ -376,12 +384,16 @@ int write_archive(int argc, const char **argv, co=
nst char *prefix,
 	const struct archiver *ar =3D NULL;
 	struct archiver_args args;
=20
+	memset(&args, 0, sizeof(args));
 	argc =3D parse_archive_args(argc, argv, &ar, &args);
 	if (setup_prefix && prefix =3D=3D NULL)
 		prefix =3D setup_git_directory();
=20
-	parse_treeish_arg(argv, &args, prefix);
-	parse_pathspec_arg(argv + 1, &args, prefix);
+	if (!args.use_index) {
+		parse_treeish_arg(argv, &args, prefix);
+		argv++;
+	}
+	parse_pathspec_arg(argv, &args, prefix);
=20
 	git_config(git_default_config, NULL);
=20
diff --git a/archive.h b/archive.h
index 0b15b35..fb94d47 100644
--- a/archive.h
+++ b/archive.h
@@ -10,6 +10,7 @@ struct archiver_args {
 	time_t time;
 	const char **pathspec;
 	unsigned int verbose : 1;
+	unsigned int use_index : 1;
 	int compression_level;
 };
=20
--=20
1.6.2.2.602.g83ee9f
