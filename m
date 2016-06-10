From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/27] clone: define shallow clone boundary based on time with --shallow-since
Date: Fri, 10 Jun 2016 19:27:05 +0700
Message-ID: <20160610122714.3341-19-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:31:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLZ2-0001UK-8l
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbcFJM3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:29:23 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34261 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843AbcFJM3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:29:22 -0400
Received: by mail-pf0-f194.google.com with SMTP id 66so3246109pfy.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1haUHVSmLGCVGnse4zeFmjoNAO0pKcACD9KME5XTo4=;
        b=gkyLwVIfp34x/N8hGbBX7/0qugwLtBSGLStLnnHeCxzMxBySEL30iNqFQ24x8vZYI5
         SsOCWSi+3BpXqY/NBijWZfW5N8o7Lc1H3lKu13CFY3MGhp4grrAeyETramn8IK1eUPeR
         2HJcTmix20moV48RNtHuhQTkObiRprhpeH93Hju1kPxbvrd9L35IExE/xcX76w+5gWIY
         bCyNwS4Aa+tliPMEGIp5tmXbMzRzxWMseIwKlNpsZByYGkFoPrX0CyZQsnxv7U8P+jTr
         6hMh7ydol5/7YHGu7dI0PqGhAG2nWGSogayQtzIG6lvFXlbrO/DvRzftSDhtPs4R+Qk7
         iqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1haUHVSmLGCVGnse4zeFmjoNAO0pKcACD9KME5XTo4=;
        b=DKp3TzrVdwz5lPYKRGiK1gn9vl1RYrne8D19k7PIIJKsd5IbrIAJ4tMNJwyYm76yeS
         5ffUn+GfEH1nitjPhazep1xkTspV9az4ADuLLB+OaR0rpGbtVz3id0Jy1aTwBo0+20Da
         FqxtJgldWCSlbPAZ2J+k4MEoBVkl63Zy/70JE7SMKiwPqxPm7UL262AgPd8XFA7qOMlJ
         dm9zoDNrHp5rn+HKzfmZlAs64NWOCeYI8dW3zRGegAcuf1lD+jehTfSZvU8LP+5Cienr
         CUiFGMGCN2amsAGpU5Ccwu+V0Jtyr8MWB0/rgAv4h/OXwTdB5fNIKPwjbt+no6bnaxSo
         6H6g==
X-Gm-Message-State: ALyK8tJQUDR0sCzTPPhlFnKhny8RMJiL4mc4Tt1aeIaRh8cp/iJ9Pl6coG1EE77ixP43Fg==
X-Received: by 10.98.196.200 with SMTP id h69mr2064037pfk.158.1465561761598;
        Fri, 10 Jun 2016 05:29:21 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id n66sm17542174pfb.38.2016.06.10.05.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:29:20 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:29:15 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296990>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clone.txt |  3 +++
 builtin/clone.c             | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b7c467a..a410409 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -193,6 +193,9 @@ objects from the source repository into a pack in t=
he cloned repository.
 	`--no-single-branch` is given to fetch the histories near the
 	tips of all branches.
=20
+--shallow-since=3D<date>::
+	Create a shallow clone with a history after the specified time.
+
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
diff --git a/builtin/clone.c b/builtin/clone.c
index bcba080..dc2ef4f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -40,7 +40,8 @@ static const char * const builtin_clone_usage[] =3D {
=20
 static int option_no_checkout, option_bare, option_mirror, option_sing=
le_branch =3D -1;
 static int option_local =3D -1, option_no_hardlinks, option_shared, op=
tion_recursive;
-static char *option_template, *option_depth;
+static int deepen;
+static char *option_template, *option_depth, *option_since;
 static char *option_origin =3D NULL;
 static char *option_branch =3D NULL;
 static const char *real_git_dir;
@@ -86,6 +87,8 @@ static struct option builtin_clone_options[] =3D {
 		   N_("path to git-upload-pack on the remote")),
 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
 		    N_("create a shallow clone of that depth")),
+	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
+		    N_("create a shallow clone since a specific time")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
@@ -849,8 +852,10 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
=20
+	if (option_depth || option_since)
+		deepen =3D 1;
 	if (option_single_branch =3D=3D -1)
-		option_single_branch =3D option_depth ? 1 : 0;
+		option_single_branch =3D deepen ? 1 : 0;
=20
 	if (option_mirror)
 		option_bare =3D 1;
@@ -976,6 +981,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	if (is_local) {
 		if (option_depth)
 			warning(_("--depth is ignored in local clones; use file:// instead.=
"));
+		if (option_since)
+			warning(_("--shallow-since is ignored in local clones; use file:// =
instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
@@ -994,6 +1001,9 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	if (option_depth)
 		transport_set_option(transport, TRANS_OPT_DEPTH,
 				     option_depth);
+	if (option_since)
+		transport_set_option(transport, TRANS_OPT_DEEPEN_SINCE,
+				     option_since);
 	if (option_single_branch)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
=20
@@ -1001,7 +1011,7 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
=20
-	if (transport->smart_options && !option_depth)
+	if (transport->smart_options && !deepen)
 		transport->smart_options->check_self_contained_and_connected =3D 1;
=20
 	refs =3D transport_get_remote_refs(transport);
--=20
2.8.2.524.g6ff3d78
