From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 16/25] clone: define shallow clone boundary based on time with --shallow-since
Date: Tue, 23 Feb 2016 20:44:54 +0700
Message-ID: <1456235103-26317-17-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:46:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDIR-0000no-NA
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbcBWNqb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:46:31 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36208 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbcBWNq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:46:28 -0500
Received: by mail-pf0-f170.google.com with SMTP id e127so112874826pfe.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WCZQ5w6vDohgH6GAn+eGQwRUlAN1chzjXef0h80mbNs=;
        b=WgzI4ypBtrFKZbBBEJfvd8EC+hFtmU7U+g6g+2a+TREc9OPC3QqVEKgMp0jmz3Gl2P
         jirRucWYudMOvZup/p9z7MdFk1CiFYLFrrUZuRSPB9VYW2/RA7vIgIYVKNPXtkbjbDDw
         fBZIGTyafjGf1gg60QQ7RSDxOfTuMIU9eHT5OUT7GjFzdC/ZDQ1E4DyMUOaUcVbwcuXE
         7VqGKaIE61lar20bd6ddVkJXwJdprWbLumkpPc0pWrBoOsrUew0S7GMmt95/ij36ktBM
         7hhPDBkIVKPWv9H40obYpAkfjGcao7fgB6L+PTK3/pKVX2oFqr2nYTwbL8x50x4e8KjL
         DARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=WCZQ5w6vDohgH6GAn+eGQwRUlAN1chzjXef0h80mbNs=;
        b=ErxWgOEONUQaxyPy395z0VSog0ensGZMXGP4DbFKKyiKjbVQF+MX5jFixCD9ps4q1w
         SsGQ0kbPK6rUJVc5suMGxccCdzjT1k2jbivAYrIyZpgTLUdTaGOT3Ho/o9qaTnwOhTKi
         Iq1B0euagl6AvhOWzxd2/R7WyymGQaaJAKOFLzFMOxb13eza4WsXmvsDiGf0aNVVL/7N
         g5Xej+aD7DLZRzRVau6c76G8aAsNAJKfK4sYpKo20sTU2r5DYFyIa3MINCxVwHwAIJUj
         EQBc3uIJaW5WxvBhvEv6suZ01I99ZgQ9B0oQ9nTptrcEaebODXk1adoBtU0gW6W8FyHk
         w8Yw==
X-Gm-Message-State: AG10YOTgPoLdmUS42kX2twFOFtRmTxvl21vgycTaUFvfwHOBEpucxo8dpn3aVjf5muMcRg==
X-Received: by 10.98.93.155 with SMTP id n27mr46177629pfj.88.1456235187819;
        Tue, 23 Feb 2016 05:46:27 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 87sm44413820pfq.93.2016.02.23.05.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:46:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:46:56 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287066>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
2.7.1.532.gd9e3aaa
