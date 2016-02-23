From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 21/25] clone: define shallow clone boundary with --shallow-exclude
Date: Tue, 23 Feb 2016 20:44:59 +0700
Message-ID: <1456235103-26317-22-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:47:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDJ5-0001J1-0h
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbcBWNrK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:47:10 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34130 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbcBWNrD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:47:03 -0500
Received: by mail-pf0-f171.google.com with SMTP id x65so112644054pfb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GLiJ3i/sqbaYM8BAvgXnHS4ygWZHEOo+rgaCYMhOOiw=;
        b=G5+OvMVBpF52w5TZQGZuK2IvihLDPwFWPdSSM6wgcPZhV10mj30Pa9KWJTbvSoz+Zw
         6IbYFUpQBxFUcm7EM7MwvQM8GjUnMTAkoLU1+9RestGKZPiNjWNhySKo4b7QgqDS1TSd
         CFS+QBHjzQTSAXANKi0f5Yf1ahLiMHUXwevoEcxf8fedDz02c0BKXGSFna4Ahjl0zDW9
         4Ti8G7P+FZKAyIJbFyA3Irx0Im6SloCh9PV4RhGF1pxbppuFvmq8JoWPJARuoLP/+NNI
         5Zqv5iilQ/DCePKDTuCnQ62cEQ7NHTy7/YEqA+n2S/fT4mPAuosdTRuqTAQD/jZuNl2d
         TT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=GLiJ3i/sqbaYM8BAvgXnHS4ygWZHEOo+rgaCYMhOOiw=;
        b=QdPupub+s6Qwm4ibzKaBqcCKAyRXjwvfea85CSIbyzPbeUL+N9AVJZgVz7GXoltlir
         mzOGf4s7bqmH8vG76DeDFQP5T4jRYCTRurOx8MWQ5hoH6PTp9RCbV6Q/6VqSfu5N9oyx
         y52we6mYKTU6qEtx57ZwNN5H6SZacZlqLlTHTFc035j1slfjJ74gqLzDc4r2/rk96d5J
         TrDLWCKZQYG975xGA90qytRf/wvI37Ak7rm2+tW3VQXNx5uxfFd38mHfJa1FBUufHYco
         4ZHbKxjV795HLaAEU6D28IfvjUm+FdwLVFHbhyp3W4qwtu9qP6S0pn3o92CFpSAxzEPC
         tkOA==
X-Gm-Message-State: AG10YOT9mY7lvp3ocQ6Mit1DXKwrMqSp3nXDNVVY2mWo1mI8ULcqJnWDn3/xIL3At2TcDA==
X-Received: by 10.98.0.11 with SMTP id 11mr46405278pfa.5.1456235222043;
        Tue, 23 Feb 2016 05:47:02 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id yh5sm44735483pab.13.2016.02.23.05.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:47:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:47:29 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287072>

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
2.7.1.532.gd9e3aaa
