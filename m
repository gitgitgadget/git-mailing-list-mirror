From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 17/25] clone: define shallow clone boundary based on time with --shallow-since
Date: Thu,  4 Feb 2016 16:03:53 +0700
Message-ID: <1454576641-29615-18-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:06:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFrZ-0007AS-Uu
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965565AbcBDJGA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:06:00 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36377 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965563AbcBDJFw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:05:52 -0500
Received: by mail-pf0-f180.google.com with SMTP id n128so38179466pfn.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PH4x+UO+d5idy/UkVrMI3kp29Mop3eB5MUKolSBZjco=;
        b=JKKjrAgt0AXlN8jt0QBVv7zP+6cgFjwIMQkYSuanm11XojIQH0lcFScEj2BQpe/k+c
         EpKgtcrC+VLW3ka8lGMKYXsJFAo35U032FeegVPwH2DdBLeiIqNXHF1URWR6Bd3pA04J
         sQre81T7i4P2/57gkaS+UaSRusABVu8r1utv7mZH3Gae+tMpwaxrhW0XNEzPYp9txKXl
         UaCTt4KcouFHH/B6/2+cnKj5mCKL/tG0IvMPKwSfDKvpnj73Ho+J7TBs9yuf8GaDVTK9
         fXv/jqA0WV3j+dEmKReJanH1IJzG2YwAiAFxPbCLUjI5uMFfL57V+lA7sbkDpoN6LakP
         fNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=PH4x+UO+d5idy/UkVrMI3kp29Mop3eB5MUKolSBZjco=;
        b=F9nB+J/oDPSSyH5IKzDKEV+OeCpF1H/f8pd+1xzBKqntpWL34KIdW2SMZ4lKIFTqBi
         o9JGhr53KAfEh6R9K4sCGBFoypqrFRfWh4nYczrZhC6azOFQHE3pUXA0KwkOiE9UgDSs
         emDBfI+fZ0you4UNb0F4Ff9kWCZ0kFEpkRrCo2PI7PT1Ac9i6ro7Ji3NUWoESlCj/3Jv
         23s/GcrxG5isDvRri9GrKa0oAe+OmtF9MNNlUSNh//UyAjjY0anryviWekj/NFKvW01Q
         s/IjLBc6yjKfIuydApa5RER/4cDF5B5Pnh4h5LDBO5ImNNd7rvxOWW1Al1x9yqk3n9ry
         QFGQ==
X-Gm-Message-State: AG10YOTx/lo1pnVH4/SmYZOi/GFa/AvPeMPuhAQunQYRbPJ6L5VTzxeXa5VDfhdZDR0uHQ==
X-Received: by 10.66.253.137 with SMTP id aa9mr9251703pad.139.1454576752016;
        Thu, 04 Feb 2016 01:05:52 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id p20sm15325427pfi.86.2016.02.04.01.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:05:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:06:05 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285430>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |  3 +++
 builtin/clone.c             | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 789b668..1b6b639 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -194,6 +194,9 @@ objects from the source repository into a pack in t=
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
2.7.0.377.g4cd97dd
