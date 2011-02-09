From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/16] Add ls command
Date: Wed,  9 Feb 2011 19:24:39 +0700
Message-ID: <1297254284-3729-12-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:27:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn999-0007qM-Mw
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab1BIM1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:27:42 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62856 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1BIM1l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:27:41 -0500
Received: by ywo7 with SMTP id 7so40057ywo.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=SCyFNb1+1/03U6sntVHRpQP4itZ02+Apf2iexwVycWc=;
        b=OMPHqm82XDuCIGubOXGBZ9W5tfEvVSwhU2GZZyyzuoqBE+edmlAvAb4d3KnrgM5d2R
         zPtj9bAvP2/VCbhQjagl9ub8HpQNMfSiSEFZFIHTyTo7CAC73pu5HTPhQjFcSI56i+GC
         zaDxe846DpUCplRG6k1+me56evqNOcy5txBKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Nx9YXC9VtEKszUijhhfYsSHVYZAnttNq1szEXiky5mYR2sehcYT05qcsIEP9HepsgO
         Dm/1PJlKaS37efGHYRIy4NMeR8JBRSQubvL5l1jgsOlwNsEPSbFPnUQ6bv8RF6opQzn/
         YgXLPCwN0/whlVK/h+EUF1zFu+eVcjsqpASqA=
Received: by 10.151.106.15 with SMTP id i15mr1499381ybm.396.1297254460408;
        Wed, 09 Feb 2011 04:27:40 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id q33sm120220yba.19.2011.02.09.04.27.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:27:39 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:26:09 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166415>

The command is supposed to be git variant of UNIX ls. Currently
it's just a stripped down version of ls-files with some porcelain touch=
:

 - auto refreshing index
 - setup standard excludes

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore         |    1 +
 Makefile           |    2 +-
 builtin.h          |    1 +
 builtin/ls-files.c |   52 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 command-list.txt   |    1 +
 git.c              |    1 +
 6 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index a1a1202..c090d21 100644
--- a/.gitignore
+++ b/.gitignore
@@ -66,6 +66,7 @@
 /git-instaweb
 /git-log
 /git-lost-found
+/git-ls
 /git-ls-files
 /git-ls-remote
 /git-ls-tree
diff --git a/Makefile b/Makefile
index 0e459e4..5efbb1c 100644
--- a/Makefile
+++ b/Makefile
@@ -1958,7 +1958,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
-branch.o column.o pager.o help.o tag.o: column.h
+branch.o builtin/ls-files.o column.o pager.o help.o tag.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/builtin.h b/builtin.h
index 904e067..5aede6e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -80,6 +80,7 @@ extern int cmd_index_pack(int argc, const char **argv=
, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix=
);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *pre=
fix);
+extern int cmd_ls(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_ls_tree(int argc, const char **argv, const char *prefix=
);
 extern int cmd_ls_remote(int argc, const char **argv, const char *pref=
ix);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index fb2d5f4..cab7a10 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -619,3 +619,55 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
=20
 	return 0;
 }
+
+int cmd_ls(int argc, const char **argv, const char *cmd_prefix)
+{
+	struct dir_struct dir;
+	struct option builtin_ls_files_options[] =3D {
+		OPT_BOOLEAN('c', "cached", &show_cached,
+			"show cached files in the output (default)"),
+		OPT_BOOLEAN('d', "deleted", &show_deleted,
+			"show deleted files in the output"),
+		OPT_BOOLEAN('m', "modified", &show_modified,
+			"show modified files in the output"),
+		OPT_BOOLEAN('o', "others", &show_others,
+			"show other files in the output"),
+		OPT_BIT('i', "ignored", &dir.flags,
+			"show ignored files in the output",
+			DIR_SHOW_IGNORED),
+		OPT_BOOLEAN('k', "killed", &show_killed,
+			"show files on the filesystem that need to be removed"),
+		OPT_END()
+	};
+
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(ls_files_usage, builtin_ls_files_options);
+
+	memset(&dir, 0, sizeof(dir));
+	prefix =3D cmd_prefix;
+	if (prefix)
+		prefix_len =3D strlen(prefix);
+	git_config(git_default_config, NULL);
+
+	if (read_cache() < 0)
+		die("index file corrupt");
+
+	argc =3D parse_options(argc, argv, prefix, builtin_ls_files_options,
+			ls_files_usage, 0);
+
+	if (dir.flags & DIR_SHOW_IGNORED || show_others)
+		setup_standard_excludes(&dir);
+
+	pathspec =3D get_pathspec(prefix, argv);
+
+	if (show_modified)
+		refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
+
+	/* With no flags, we default to showing the cached files */
+	if (!(show_stage | show_deleted | show_others | show_unmerged |
+	      show_killed | show_modified | show_resolve_undo))
+		show_cached =3D 1;
+
+	show_files(&dir);
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index 95bf18c..15e6770 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -59,6 +59,7 @@ git-instaweb                            ancillaryinte=
rrogators
 gitk                                    mainporcelain
 git-log                                 mainporcelain common
 git-lost-found                          ancillarymanipulators	deprecat=
ed
+git-ls                                  mainporcelain
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
diff --git a/git.c b/git.c
index 68334f6..f8e20d2 100644
--- a/git.c
+++ b/git.c
@@ -357,6 +357,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP },
+		{ "ls", cmd_ls, RUN_SETUP | NEED_WORK_TREE },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
--=20
1.7.2.2
