From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 23/27] clone: define shallow clone boundary with --shallow-exclude
Date: Sun, 12 Jun 2016 17:54:05 +0700
Message-ID: <20160612105409.22156-24-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:56:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC34O-00046p-DQ
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbcFLK4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:56:40 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34770 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbcFLK4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:56:39 -0400
Received: by mail-pa0-f66.google.com with SMTP id ug1so8417312pab.1
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aEYd5c0T7KJVBHovx/hGGPErmwqMsPhvviMJDsHuTzI=;
        b=zvm4uWhdzPApTtpcbHk6a2OK9JRW2lCFs4SAuViObLvNeCf3YtRwlXRwEprxQitLK9
         qQu2SIwk+tZSze362w3Nouu5aVn/NimMcAjjIvkQFTjq0tMC3RamkZlq7DkjG/tfGvTU
         TgBiDEv4UkwKB2N7mP3xbvaSvciV0KB/qUcv9iribkyZOuVveWFw+zv5igz3+SuR3F+Y
         Z1pUMMzqVpwiG0PisJ+o8rilVB11Vn4tEIF6XP8tOWkJFkIZqT1Z+XftdTo8uVo7iJOv
         t846RuZe3iRJJ6aIOJpKL6o9U8FTJ5wSG48qndnsppdE5aua8Ie7uBNbiS59SLtxTXUf
         Mr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aEYd5c0T7KJVBHovx/hGGPErmwqMsPhvviMJDsHuTzI=;
        b=aZdpSXWZXHFwNMJx+cYGA48PXqkms8HmbrpuZypb7XwE//fq29gOJwdP97xKcrQon9
         TjjfTlVPlefvW9N8LNHYF3ni6hxL0n5NlbLqMNdGjR9jjWTdsfgNVFEfg8xGyYgrmr6s
         l3w406hFW4P6kZpEDgVbbNkBjDCFdwDkfATII4ptKFA6NKHTYueXathZJWQIny95bRty
         qVnApkxiCTdFCFaGub4FieyTsZFvR+Q9prrstj5glysJLFdPnR1QgAk94JAQazVWKU9h
         vHnChpCJhF8AymRTLtJwAWXAQ3gN2hD2W6BYZvtPjSL2WpKG4Ebp9EUnbtk0RdwA0NVo
         OEwQ==
X-Gm-Message-State: ALyK8tIC7XXrjqNB+503xfZMvnV2z2BpguXbdWnRj7HPqAgdpgXmnANtb1lXCI5mNUddsg==
X-Received: by 10.67.16.108 with SMTP id fv12mr14796695pad.8.1465728998854;
        Sun, 12 Jun 2016 03:56:38 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id 6sm3008977pfx.68.2016.06.12.03.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:56:38 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:56:34 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297131>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clone.txt |  5 +++++
 builtin/clone.c             | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index dc2ef4f..3849231 100644
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
@@ -89,6 +90,8 @@ static struct option builtin_clone_options[] =3D {
 		    N_("create a shallow clone of that depth")),
 	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
 		    N_("create a shallow clone since a specific time")),
+	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
+			N_("deepen history of shallow clone by excluding rev")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
@@ -852,7 +855,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
=20
-	if (option_depth || option_since)
+	if (option_depth || option_since || option_not.nr)
 		deepen =3D 1;
 	if (option_single_branch =3D=3D -1)
 		option_single_branch =3D deepen ? 1 : 0;
@@ -983,6 +986,8 @@ int cmd_clone(int argc, const char **argv, const ch=
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
@@ -1004,6 +1009,9 @@ int cmd_clone(int argc, const char **argv, const =
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
2.8.2.524.g6ff3d78
