From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFC PATCHv4] repack: rewrite the shell script in C.
Date: Wed, 21 Aug 2013 00:36:36 +0200
Message-ID: <5213EF74.7020408@googlemail.com>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com> <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com> <52136F9C.6030308@kdbg.org> <52138686.1070304@googlemail.com> <5213BC0C.6090901@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7829C36277526FB884DD105B"
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, mackyle@gmail.com
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 21 00:36:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBuXZ-0000K5-6e
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab3HTWgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 18:36:37 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54613 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab3HTWgg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 18:36:36 -0400
Received: by mail-ee0-f46.google.com with SMTP id c13so473882eek.5
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 15:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=j9UKZA9BYSi84jWCElgnXdqIWMNfA65oQR2qqH7Fo3M=;
        b=vD4Ui62hUQvd+dkuashfFrQzhQuAW515qqA6/+4zyiWgu7VEjkWqxdhC8rwKwBZPnS
         hXWrffXXoCn9h0AIOH7a8JU76Q+TVADgco1koxpU/FJH+dh8UUfD9WtD5qJqOtKHZ0wG
         yOvKtgYsQSkRmSrsMHytV4KxQSNOESKdRd5FqF6EM5P/Tv+7xZVBmVYZT0cg+eFYO5yx
         vcn1BQEyN9b1tctbeVxwhBlHllAIN8U5WKAPBlb4tUVXmC6TWTg3AXXrDM5VJy6jR4Na
         jZ/ZGUTQ36fZcH4ElYZB9i4gFQ8ciAfuJL6V+mmWDtMsW/fi4fI9uh2fTBKK3gT5l9aU
         ugeg==
X-Received: by 10.14.5.78 with SMTP id 54mr4887511eek.55.1377038195080;
        Tue, 20 Aug 2013 15:36:35 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id r48sm5211081eev.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 15:36:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <5213BC0C.6090901@web.de>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232656>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7829C36277526FB884DD105B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


So here is an update of git-repack
Thanks for all the reviews and annotations!
I think I got all the suggestions except the
use of git_path/mkpathdup.
I replaced mkpathdup by mkpath where possible,
but it's still not perfect.
I'll wait for the dokumentation patch of Jonathan,=20
before changing all these occurences forth and back
again.

What would be perfect here would be a function
which just does string processing and returning,
so=20
	fname =3D create_string(fmt, ...);
or with duplication:
	fname =3D create_string_dup(fmt, ...);

Ah wait! There are struct str_buf, but these
would require more lines (init, add to buffer,=20
get as char*)=20

Below there is just the diff against RFC PATCHv4,
however I'll send the whole patch as well.

Thanks,
Stefan

--8<--
=46rom e544eb9b7bdea6c2000c5f0d3043845fb901e90b Mon Sep 17 00:00:00 2001
From: Stefan Beller <stefanbeller@googlemail.com>
Date: Wed, 21 Aug 2013 00:35:18 +0200
Subject: [PATCH] Suggestions of reviewers

---
 builtin/repack.c | 104 +++++++++++++++++++++++++++----------------------=
------
 1 file changed, 51 insertions(+), 53 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a87900e..9fbe636 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -67,7 +67,7 @@ void get_pack_filenames(char *packdir, struct string_li=
st *fname_list)
 	struct dirent *e;
 	char *path, *suffix, *fname;
=20
-	path =3D mkpathdup("%s/pack", get_object_directory());
+	path =3D mkpath("%s/pack", get_object_directory());
 	suffix =3D ".pack";
=20
 	dir =3D opendir(path);
@@ -78,7 +78,6 @@ void get_pack_filenames(char *packdir, struct string_li=
st *fname_list)
 			string_list_append_nodup(fname_list, fname);
 		}
 	}
-	free(path);
 	closedir(dir);
 }
=20
@@ -88,14 +87,25 @@ void remove_pack(char *path, char* sha1)
 	int ext =3D 0;
 	for (ext =3D 0; ext < 3; ext++) {
 		char *fname;
-		fname =3D mkpathdup("%s/%s%s", path, sha1, exts[ext]);
+		fname =3D mkpath("%s/%s%s", path, sha1, exts[ext]);
 		unlink(fname);
-		free(fname);
 	}
 }
=20
 int cmd_repack(int argc, const char **argv, const char *prefix) {
=20
+	char *exts[2] =3D {".idx", ".pack"};
+	char *packdir, *packtmp, line[1024];
+	struct child_process cmd;
+	struct string_list_item *item;
+	struct argv_array cmd_args =3D ARGV_ARRAY_INIT;
+	struct string_list names =3D STRING_LIST_INIT_DUP;
+	struct string_list rollback =3D STRING_LIST_INIT_DUP;
+	struct string_list existing_packs =3D STRING_LIST_INIT_DUP;
+	int count_packs, ext;
+	FILE *out;
+
+	/* variables to be filled by option parsing */
 	int pack_everything =3D 0;
 	int pack_everything_but_loose =3D 0;
 	int delete_redundant =3D 0;
@@ -107,24 +117,17 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix) {
 	int no_update_server_info =3D 0;
 	int quiet =3D 0;
 	int local =3D 0;
-	char *packdir, *packtmp;
-	struct child_process cmd;
-	struct string_list_item *item;
-	struct string_list existing_packs =3D STRING_LIST_INIT_DUP;
-	struct stat statbuffer;
-	int ext;
-	char *exts[2] =3D {".idx", ".pack"};
=20
 	struct option builtin_repack_options[] =3D {
-		OPT_BOOL('a', "all", &pack_everything,
+		OPT_BOOL('a', NULL, &pack_everything,
 				N_("pack everything in a single pack")),
-		OPT_BOOL('A', "all-but-loose", &pack_everything_but_loose,
+		OPT_BOOL('A', NULL, &pack_everything_but_loose,
 				N_("same as -a, and turn unreachable objects loose")),
-		OPT_BOOL('d', "delete-redundant", &delete_redundant,
+		OPT_BOOL('d', NULL, &delete_redundant,
 				N_("remove redundant packs, and run git-prune-packed")),
-		OPT_BOOL('f', "no-reuse-delta", &no_reuse_delta,
+		OPT_BOOL('f', NULL, &no_reuse_delta,
 				N_("pass --no-reuse-delta to git-pack-objects")),
-		OPT_BOOL('F', "no-reuse-object", &no_reuse_object,
+		OPT_BOOL('F', NULL, &no_reuse_object,
 				N_("pass --no-reuse-object to git-pack-objects")),
 		OPT_BOOL('n', NULL, &no_update_server_info,
 				N_("do not run git-update-server-info")),
@@ -154,9 +157,6 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix) {
 	packdir =3D mkpathdup("%s/pack", get_object_directory());
 	packtmp =3D mkpathdup("%s/.tmp-%d-pack", packdir, getpid());
=20
-	remove_temporary_files();
-
-	struct argv_array cmd_args =3D ARGV_ARRAY_INIT;
 	argv_array_push(&cmd_args, "pack-objects");
 	argv_array_push(&cmd_args, "--keep-true-parents");
 	argv_array_push(&cmd_args, "--honor-pack-keep");
@@ -191,7 +191,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix) {
 		for_each_string_list_item(item, &fname_list) {
 			char *fname;
 			fname =3D mkpathdup("%s/%s.keep", packdir, item->string);
-			if (stat(fname, &statbuffer) && S_ISREG(statbuffer.st_mode)) {
+			if (file_exists(fname)) {
 				/* when the keep file is there, we're ignoring that pack */
 			} else {
 				string_list_append(&existing_packs, item->string);
@@ -217,34 +217,34 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix) {
 	argv_array_push(&cmd_args, packtmp);
=20
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.argv =3D argv_array_detach(&cmd_args, NULL);
+	cmd.argv =3D cmd_args.argv;
 	cmd.git_cmd =3D 1;
 	cmd.out =3D -1;
 	cmd.no_stdin =3D 1;
=20
-	if (run_command(&cmd))
+	if (start_command(&cmd))
 		return 1;
=20
-	struct string_list names =3D STRING_LIST_INIT_DUP;
-	struct string_list rollback =3D STRING_LIST_INIT_DUP;
-
-	char line[1024];
-	int counter =3D 0;
-	FILE *out =3D xfdopen(cmd.out, "r");
+	count_packs =3D 0;
+	out =3D xfdopen(cmd.out, "r");
 	while (fgets(line, sizeof(line), out)) {
 		/* a line consists of 40 hex chars + '\n' */
-		assert(strlen(line) =3D=3D 41);
+		if (strlen(line) !=3D 41)
+			die("repack: Expecting 40 character sha1 lines only from pack-objects=
=2E");
 		line[40] =3D '\0';
 		string_list_append(&names, line);
-		counter++;
+		count_packs++;
 	}
-	if (!counter)
-		printf("Nothing new to pack.\n");
+	if (finish_command(&cmd))
+		return 1;
 	fclose(out);
=20
+	if (!count_packs && !quiet)
+		printf("Nothing new to pack.\n");
+
 	int failed =3D 0;
 	for_each_string_list_item(item, &names) {
-		for (ext =3D 0; ext < 1; ext++) {
+		for (ext =3D 0; ext < 2; ext++) {
 			char *fname, *fname_old;
 			fname =3D mkpathdup("%s/%s%s", packdir, item->string, exts[ext]);
 			if (!file_exists(fname)) {
@@ -252,7 +252,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix) {
 				continue;
 			}
=20
-			fname_old =3D mkpathdup("%s/old-%s%s", packdir, item->string, exts[ex=
t]);
+			fname_old =3D mkpath("%s/old-%s%s", packdir, item->string, exts[ext])=
;
 			if (file_exists(fname_old))
 				unlink(fname_old);
=20
@@ -260,23 +260,21 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix) {
 				failed =3D 1;
 				break;
 			}
-			free(fname_old);
 			string_list_append_nodup(&rollback, fname);
+			free(fname);
 		}
 		if (failed)
-			/* set to last element to break for_each loop */
-			item =3D names.items + names.nr;
+			break;
 	}
 	if (failed) {
 		struct string_list rollback_failure;
 		for_each_string_list_item(item, &rollback) {
 			char *fname, *fname_old;
 			fname =3D mkpathdup("%s/%s", packdir, item->string);
-			fname_old =3D mkpathdup("%s/old-%s", packdir, item->string);
+			fname_old =3D mkpath("%s/old-%s", packdir, item->string);
 			if (rename(fname_old, fname))
 				string_list_append(&rollback_failure, fname);
 			free(fname);
-			free(fname_old);
 		}
=20
 		if (rollback.nr) {
@@ -301,33 +299,33 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix) {
 	for_each_string_list_item(item, &names) {
 		for (ext =3D 0; ext < 2; ext++) {
 			char *fname, *fname_old;
+			struct stat statbuffer;
 			fname =3D mkpathdup("%s/pack-%s%s", packdir, item->string, exts[ext])=
;
-			fname_old =3D mkpathdup("%s-%s%s", packtmp, item->string, exts[ext]);=

-			stat(fname_old, &statbuffer);
-			statbuffer.st_mode &=3D ~S_IWUSR | ~S_IWGRP | ~S_IWOTH;
-			chmod(fname_old, statbuffer.st_mode);
+			fname_old =3D mkpath("%s-%s%s", packtmp, item->string, exts[ext]);
+			if (!stat(fname_old, &statbuffer)) {
+				statbuffer.st_mode &=3D ~S_IWUSR | ~S_IWGRP | ~S_IWOTH;
+				chmod(fname_old, statbuffer.st_mode);
+			}
 			if (rename(fname_old, fname))
-				die("Could not rename packfile: %s -> %s", fname_old, fname);
+				die_errno(_("renaming '%s' failed"), fname_old);
 			free(fname);
-			free(fname_old);
 		}
 	}
=20
 	/* Remove the "old-" files */
 	for_each_string_list_item(item, &names) {
 		char *fname;
-		fname =3D mkpathdup("%s/old-pack-%s.idx", packdir, item->string);
+		fname =3D mkpath("%s/old-pack-%s.idx", packdir, item->string);
 		if (remove_path(fname))
-			die("Could not remove file: %s", fname);
-		free(fname);
+			die_errno(_("removing '%s' failed"), fname);
=20
-		fname =3D mkpathdup("%s/old-pack-%s.pack", packdir, item->string);
+		fname =3D mkpath("%s/old-pack-%s.pack", packdir, item->string);
 		if (remove_path(fname))
-			die("Could not remove file: %s", fname);
-		free(fname);
+			die_errno(_("removing '%s' failed"), fname);
 	}
=20
 	/* End of pack replacement. */
+
 	if (delete_redundant) {
 		sort_string_list(&names);
 		for_each_string_list_item(item, &existing_packs) {
@@ -345,7 +343,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix) {
 			argv_array_push(&cmd_args, "--quiet");
=20
 		memset(&cmd, 0, sizeof(cmd));
-		cmd.argv =3D argv_array_detach(&cmd_args, NULL);
+		cmd.argv =3D cmd_args.argv;
 		cmd.git_cmd =3D 1;
 		run_command(&cmd);
 	}
@@ -355,7 +353,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix) {
 		argv_array_push(&cmd_args, "update-server-info");
=20
 		memset(&cmd, 0, sizeof(cmd));
-		cmd.argv =3D argv_array_detach(&cmd_args, NULL);
+		cmd.argv =3D cmd_args.argv;
 		cmd.git_cmd =3D 1;
 		run_command(&cmd);
 	}
--=20
1.8.4.rc3.1.gc1ebd90


--------------enig7829C36277526FB884DD105B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSE+90AAoJEJQCPTzLflhqdI0P/jOzfcnUDk+RnIsfJEeQxsps
FskwQZHan/becowxevKVZS8m/Y+zYX8WO5edxHrRckB68ODTJAGJowVQ52MSqjHG
MnrN9ke63bMw/RlFZ4ef7bppVDaMlvx+iEbTw/NtNb9kgQO1CdnH1vy3B9BOk1KS
iRN/yZ0zGZMnV29fnb8Yo7UfQGQ2bzNgWErGX6njtn7z/SoavIISRQeN+H7ZT8KK
P8xTRd/M6JvBV6HNnQucbAXAqz7Q1VVA8u2kqggrAZeRVVztzEsSe8LhQWH0fWWu
EtTWeV0dXzSi0QH/QOxNOOEb5Cl7hHjOG9BCwrENkDXg6mKg/hSRb2hKhDY7y9hn
5a5GvnQyxARiIG2oMsv9Tms4Xbo3okSXqGcB1ik20YmhfX24F2B4HrhTxHsQXi5D
xcNTOxbegORhv6q1e90Eyg0izaa2B3tMXwdlj+oKe+rJe663KBNcbRXeBCr5q6XI
D/j8nFx5AJuL2iVuCIDS5ILjuOx3gjLKSNiO36DEmo+uKjsYKRWcSvaOqBc2j51B
Dq02p1pyU1+QVKwCRRey+qc3Nm70szpC5F8sn9rld1P5/WqK63zIBT8LzMjZpYFN
neBeNWsv2xs+DQ3inV2wW7pPbFcSHqHOGBvEZ9JkltbbTPrTXAyzTN2ytdWplWO8
aToZcIOc0jBmLN2Wftth
=/bhA
-----END PGP SIGNATURE-----

--------------enig7829C36277526FB884DD105B--
