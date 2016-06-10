From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/27] clone: define shallow clone boundary with --shallow-exclude
Date: Fri, 10 Jun 2016 19:27:10 +0700
Message-ID: <20160610122714.3341-24-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:31:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLZQ-0001kO-Ob
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932958AbcFJM3r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:29:47 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34525 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173AbcFJM3q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:29:46 -0400
Received: by mail-pa0-f66.google.com with SMTP id ug1so5027912pab.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=koNA9AJuJ4ZvrlUUKTRH6NZWKQJLiJnc8vvN4aZ28cI=;
        b=COWmoNLr3K1J3Ie3BfNgETCxjYD2cEqAmcYeeAHQYSI88d+VYF/tS5OPTn1mjq6zAo
         YJPYUcP9st8nLr3fslrLq+Pr1uvqK0nEvd8rqZZ5LV6ew092YdGfLGdN1ObmEAn8JDz3
         BsuaoNbJpL1Ds+4ZskPHG1/0lBDeAC3fs9FwAC2mPEVlzflNElNC5izZ1byNru/G31/c
         qvqQlG8xW9eKDpwGfg7iqaCRiXTZwnq6xC/c7jeRXxAs0FbA3C6x+s0SAskzWiF0QDfI
         3DUb/lidfufcImLVjX+nlcUDQLu81mmFpgYbbkSfMldWRrIYPLId36RitYhMDQlrirTP
         qXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=koNA9AJuJ4ZvrlUUKTRH6NZWKQJLiJnc8vvN4aZ28cI=;
        b=S15kmB0A5kEI36VZEPvuRl5agwcC0x/MSMXbJS7c6M9h22DwoQGsTeuCYrsk8bz92Y
         FF+cXxuaylUUUGLCzwnTf/Y7zO8BT8pNLpVZbtPnmHINOkFdYCUJ/6Q6FejRGf1L7Ple
         hfEJSMXlYywj0R5mXe7Xhakw3+AT735zk1HfG5JOF2FwP2xqm/5kCwUBt/h8ZgPrMKwF
         sEJETHAwfhhK8JiljdTyKy9szF0xMf4f4SI7Aj9EZ4AeLUSjcTxvGcwUxrZXd00bVkHx
         SIbwXLMLuTBPwqFQyoAWg8S+eefPs9MVw3/eEk4wQBV8vqb4mme2gjFaclN65g1MfaS3
         avFA==
X-Gm-Message-State: ALyK8tJJnQhfXRD7i9rplM6vosr6x8pO/sttNwu4AuS5KqqCQ9HjSv6szwZZtYufQch9kQ==
X-Received: by 10.66.126.179 with SMTP id mz19mr2020127pab.27.1465561785152;
        Fri, 10 Jun 2016 05:29:45 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id q188sm17488159pfq.66.2016.06.10.05.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:29:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:29:40 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296992>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
