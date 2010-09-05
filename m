From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/17] clone: support --narrow option
Date: Sun,  5 Sep 2010 16:47:39 +1000
Message-ID: <1283669264-15759-13-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:50:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os93O-0008Px-UT
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab0IEGuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:50:06 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53862 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab0IEGuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:50:05 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1071800pvg.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zFC0BSj4yvnV54hJJ8YTAViUsVmoDqwqcnqlFOW3uzY=;
        b=r1q2T+YdbnnQOYNAX1vI4tvmYfd2A2ZihHAqSr+4kS2sGsiDFzfLcDgrXv2jBzMCtD
         CYdDKEWLmhChMNLL2AenFCAtfw8JMq2fjYulMj8jL05KhgeAyprXVhNr5b1eOso/+rI+
         Xst/a94LS0J9kwJ78CiQVcbmQzCMdM+X1h2qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DBK83Ur5KqnqEBW78nCOCUAWfNP2plF9z4wn7csNhSfackFUhBNjIxOttkJi7V/iaY
         imDEsUiMx2fnJj74GKLUFZwjpvTS/A2BaDHcoXIR75evRt1+SkbrrtfNTbKXma3vT13+
         lrCcStj2/h8mhUP92pAMCct1YV/xFEjGzY6B0=
Received: by 10.114.131.2 with SMTP id e2mr480525wad.158.1283669404928;
        Sat, 04 Sep 2010 23:50:04 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id q6sm8038979waj.10.2010.09.04.23.50.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:50:03 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:49:56 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155438>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |   14 +++++++++++++-
 builtin/clone.c             |   43 +++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index dc7d3d1..d9a5729 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git clone' [--template=3D<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository=
>]
-	  [--depth <depth>] [--recursive] [--] <repository> [<directory>]
+	  [--depth <depth>] [--narrow <path>] [--recursive]
+	  [--] <repository> [<directory>]
=20
 DESCRIPTION
 -----------
@@ -161,6 +162,17 @@ objects from the source repository into a pack in =
the cloned repository.
 	with a long history, and would want to send in fixes
 	as patches.
=20
+--narrow <path>::
+	Create a 'narrow' clone with all commit trees limited to
+	the given path. A narrow repository has a number of
+	limititations (you cannot clone or fech from it, nor push
+	into it), but is adequate if you are only interested in
+	certain paths of a large repository, and would want to
+	push some fixes.
++
+Multiple --narrow can be given. This option can also be used together
+with --depth to truncate both history and path.
+
 --recursive::
 	After the clone is created, initialize all submodules within,
 	using their default settings. This is equivalent to running
diff --git a/builtin/clone.c b/builtin/clone.c
index efb1e6f..439ce8a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -23,6 +23,7 @@
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
+#include "narrow-tree.h"
=20
 /*
  * Overall FIXMEs:
@@ -40,11 +41,15 @@ static const char * const builtin_clone_usage[] =3D=
 {
 static int option_no_checkout, option_bare, option_mirror;
 static int option_local, option_no_hardlinks, option_shared, option_re=
cursive;
 static char *option_template, *option_reference, *option_depth;
+static const char **option_narrow;
 static char *option_origin =3D NULL;
 static char *option_branch =3D NULL;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbosity;
 static int option_progress;
+static int narrow_nr;
+
+static int add_narrow_prefix(const struct option *opt, const char *arg=
, int unset);
=20
 static struct option builtin_clone_options[] =3D {
 	OPT__VERBOSITY(&option_verbosity),
@@ -78,6 +83,8 @@ static struct option builtin_clone_options[] =3D {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
+	OPT_CALLBACK(0, "narrow", NULL, "prefix", "narrow clone",
+		     add_narrow_prefix),
=20
 	OPT_END()
 };
@@ -86,6 +93,22 @@ static const char *argv_submodule[] =3D {
 	"submodule", "update", "--init", "--recursive", NULL
 };
=20
+static int add_narrow_prefix(const struct option *opt, const char *arg=
, int unset)
+{
+	if (unset)
+		die("--no-narrow is not supported");
+
+	narrow_nr++;
+	option_narrow =3D xrealloc(option_narrow, sizeof(*option_narrow)*narr=
ow_nr);
+	option_narrow[narrow_nr-1] =3D arg;
+	return 0;
+}
+
+static int narrow_cmp(const void *a, const void *b)
+{
+	return strcmp(*(const char**)a, *(const char **)b);
+}
+
 static char *get_repo_path(const char *repo, int *is_bundle)
 {
 	static char *suffix[] =3D { "/.git", ".git", "" };
@@ -443,6 +466,14 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		git_dir =3D xstrdup(mkpath("%s/.git", dir));
 	}
=20
+	if (option_narrow) {
+		int i;
+		qsort(option_narrow, narrow_nr, sizeof(*option_narrow), narrow_cmp);
+		for (i =3D 0; i < narrow_nr; i++)
+			if (!valid_narrow_prefix(option_narrow[i], i ? option_narrow[i-1] :=
 NULL, 0))
+				die("Invalid narrow prefix");
+	}
+
 	if (!option_bare) {
 		junk_work_tree =3D work_tree;
 		if (safe_create_leading_directories_const(work_tree) < 0)
@@ -515,6 +546,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	strbuf_reset(&value);
=20
 	if (path && !is_bundle) {
+		if (option_narrow)
+			die("--narrow is not really for local clone. Please consider --shar=
ed");
 		refs =3D clone_local(path, git_dir);
 		mapped_refs =3D wanted_peer_refs(refs, refspec);
 	} else {
@@ -530,6 +563,16 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 			transport_set_option(transport, TRANS_OPT_DEPTH,
 					     option_depth);
=20
+		/* Do this early in order to set get_narrow_prefix() !=3D NULL */
+		if (option_narrow) {
+			int i;
+			FILE *fp =3D fopen(git_path("narrow"), "w+");
+			for (i =3D 0; i < narrow_nr; i++)
+				fprintf(fp, "%s\n", option_narrow[i]);
+			fclose(fp);
+			check_narrow_prefix(); /* Install the prefix */
+		}
+
 		transport_set_verbosity(transport, option_verbosity, option_progress=
);
=20
 		if (option_upload_pack)
--=20
1.7.1.rc1.69.g24c2f7
