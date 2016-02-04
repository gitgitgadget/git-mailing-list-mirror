From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 22/25] clone: define shallow clone boundary with --shallow-exclude
Date: Thu,  4 Feb 2016 16:03:58 +0700
Message-ID: <1454576641-29615-23-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:06:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFs0-0007oA-8Q
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965467AbcBDJG0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:06:26 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35554 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965481AbcBDJGV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:06:21 -0500
Received: by mail-pf0-f179.google.com with SMTP id 65so38520947pfd.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jJRhWkOM+IAgQjQUAz9m6LqdwMLQGDssvvrGNjIqhVQ=;
        b=Mjwt8p6L/nXfRa6UuJwJHIsbOb+B4f9nT/8im8pxudfieTpZBbMXM3tlb4/U6rHO8w
         cqxNeXov4hnG2d3Rms1cIzbjdFBFV9NDpS6+hY9YC7nFjz5EaYl9Kp5O0xOYqRuCN/cY
         IfrNle5y0fJTnBlQgyBbtjdWTumg1RWbz0aVnq0i3xEU4w4U/J2JE7mOlSw8oEJ4K2n1
         AG4Apr6GJBYP3IYlkYa0hMD1id8yx2IijIeq4ZPuKhFNvaApIY5KL7oREUlxM+iDCojF
         /fUzANuXpLkmouypDfZVtlvDyUH61D13Gf+IpBItwGmA/bkTzPYBpT32lagWYiLdJiBx
         KD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=jJRhWkOM+IAgQjQUAz9m6LqdwMLQGDssvvrGNjIqhVQ=;
        b=hAamlLVbTeHFTHLtKjRUVfcb3d4qg2B/uJvw0ysvq+c2aK/CdbU3Uoq9Xft0gOz272
         hYU/wDXx/Y66NWmZHab6pBvI0iViZS6y58n5kcg1bnHtr38bxsSF+fq4r08qDFnVKu2W
         ZnP1maFToMZ/8zLE8TXHOyomoGGUdlNwUJJkdMQtv0dhBguvOWeu1F6wKXI3vQdT+1ya
         W7g7pSwP2IkgG0pjCDvhwCdKvpEls0eExelptw2nptr+i/NV1YIp+2mr6Tf7yvw8csIC
         QmmjuqAWny0eyy7mo8T0eS3wNSKoMZrEknqsFI2ctWIdvp1MZDUgsZVx11nqNRLLZeJo
         VsNg==
X-Gm-Message-State: AG10YORjpDRikRjZRrvRT0Is+Otjfp+gBh2g6bz/olLEzMtHrENPu8mGQxDlSg1gYcuCCw==
X-Received: by 10.66.141.71 with SMTP id rm7mr9415316pab.32.1454576780929;
        Thu, 04 Feb 2016 01:06:20 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id vy6sm2429243pac.38.2016.02.04.01.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:06:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:06:33 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285434>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |  5 +++++
 builtin/clone.c             | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 1b6b639..31e1610 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -197,6 +197,11 @@ objects from the source repository into a pack in =
the cloned repository.
 --shallow-since=3D<date>::
 	Create a shallow clone with a history after the specified time.
=20
+--shallow-exclude=3D<revision>::
+	Create a shallow clone with a history, excluding commits
+	reachable from a specified remote branch or tag.  This option
+	can be specified multiple times.
+
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
diff --git a/builtin/clone.c b/builtin/clone.c
index dc2ef4f..5ccf6b7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -44,6 +44,7 @@ static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin =3D NULL;
 static char *option_branch =3D NULL;
+static struct string_list option_not =3D STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbosity;
@@ -52,6 +53,13 @@ static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
=20
+static int option_parse_deepen_not(const struct option *opt,
+				   const char *arg, int unset)
+{
+	string_list_append(&option_not, arg);
+	return 0;
+}
+
 static struct option builtin_clone_options[] =3D {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
@@ -89,6 +97,9 @@ static struct option builtin_clone_options[] =3D {
 		    N_("create a shallow clone of that depth")),
 	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
 		    N_("create a shallow clone since a specific time")),
+	{ OPTION_CALLBACK, 0, "shallow-exclude", NULL, N_("revision"),
+		    N_("deepen history of shallow clone by excluding rev"),
+		    PARSE_OPT_NONEG, option_parse_deepen_not },
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
@@ -852,7 +863,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
=20
-	if (option_depth || option_since)
+	if (option_depth || option_since || option_not.nr)
 		deepen =3D 1;
 	if (option_single_branch =3D=3D -1)
 		option_single_branch =3D deepen ? 1 : 0;
@@ -983,6 +994,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			warning(_("--depth is ignored in local clones; use file:// instead.=
"));
 		if (option_since)
 			warning(_("--shallow-since is ignored in local clones; use file:// =
instead."));
+		if (option_not.nr)
+			warning(_("--shallow-exclude is ignored in local clones; use file:/=
/ instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
@@ -1004,6 +1017,9 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 	if (option_since)
 		transport_set_option(transport, TRANS_OPT_DEEPEN_SINCE,
 				     option_since);
+	if (option_not.nr)
+		transport_set_option(transport, TRANS_OPT_DEEPEN_NOT,
+				     (const char *)&option_not);
 	if (option_single_branch)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
=20
--=20
2.7.0.377.g4cd97dd
