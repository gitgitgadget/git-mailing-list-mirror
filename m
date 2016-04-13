From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/26] clone: define shallow clone boundary with --shallow-exclude
Date: Wed, 13 Apr 2016 19:55:06 +0700
Message-ID: <1460552110-5554-23-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:57:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKMB-0004gG-4q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758068AbcDMM5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:57:15 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36041 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586AbcDMM5K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:57:10 -0400
Received: by mail-pa0-f65.google.com with SMTP id k3so3877216pav.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wVzHQerx65H/IONyYZmzkVC4RNgDnggdpRk1K14Zqg=;
        b=u61dG4OELAsn9g/7FcSJjLFNYC3AmwP8dFS7NRAxHvSoKvt+biKPd8aRQGswBCJJxq
         3CH/wpthwMAUWHmnClwN0QXFVQvX/3HqsMYI+bo6ONDPTD7/x1CFPok8bu0DYgUq67wo
         yxlcC5ruJOECKE1GVLpj7G4z605TOoY/mso1r8eAdGGdm7WKFgRvNqb+tuFFkUeM7lUN
         rhTL+EzsZhpKrRGSoyzDyHjqyguONv3R/aYnJV/bX3Tj4b0bv6EuzfZVRuCZz3g0NvQp
         tMoC0xFG4FKOoeK4TTBID5RoVPHDUe7VaCfSSOwOSpPbPNn3MJqr2OIytsgM8xDbENq7
         w4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wVzHQerx65H/IONyYZmzkVC4RNgDnggdpRk1K14Zqg=;
        b=fCWwwdCImqU26MF4CFzkVTEClxsBvKumlBro/r76vJDLi3pDsHtowQ+WizyvQQpR6g
         gg9vtxlKgjf/csC3/3qhFJoS4xPm1/mQFg4PhCd6fDDOpnYcaR6qQRr2C8esQJpqU9ny
         bo0Um2ePKH7ppKgPgCqTY3Ng54hQ+1kTnlrtLQwdjLHtaVA6AXw1Wwa8nPd96g0o6J/C
         OmYgbB0MEWc7xGehX3K1h21GD/qomGxApLSMPEm4P7ZceFYA53oYL2sDk9Il+p5Hsz8c
         2g4i94+CFiyHu1fXatTjWAtbneZcT05BkJ8BVNhXDCic5FMQd0exyGiT0sqKW1WCtQEG
         yd3Q==
X-Gm-Message-State: AOPr4FUfg7mFM2XBQlN8lX4vrm1ydwD6f7G1j2nMuYkNal1t83GcVdQSKxwzEIdmWi/KiA==
X-Received: by 10.66.122.100 with SMTP id lr4mr12179477pab.99.1460552229472;
        Wed, 13 Apr 2016 05:57:09 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id s64sm51060390pfi.77.2016.04.13.05.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:57:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:57:15 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291415>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |  5 +++++
 builtin/clone.c             | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index a410409..5049663 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -196,6 +196,11 @@ objects from the source repository into a pack in =
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
2.8.0.rc0.210.gd302cd2
