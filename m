From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 14:13:54 -0500
Message-ID: <20120710191354.GE8439@burratino>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-2-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 21:14:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sofst-0005VT-OT
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 21:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab2GJTOA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jul 2012 15:14:00 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45880 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab2GJTN7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2012 15:13:59 -0400
Received: by yhmm54 with SMTP id m54so380649yhm.19
        for <git@vger.kernel.org>; Tue, 10 Jul 2012 12:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xQh7CpJw7bNMqjyI3XvSMc2szdOOrWPu0pkXx+I3/xc=;
        b=kaWX9NYJ+1wVoT7aaIW19R/m13I1VrAnn2sI+2gnrJE49qcH8XDAO9iaRlAmjxH5xN
         b0Jt08U/MtfRAsC1XksYmeZPxOyj6yw7/+sYyh9ySynJq/1p7mDj8MHgWCeTe8y6WF5m
         mt57tKkmjt5nksOwX+tfmF83knhCV8QoLhRXDxXQCJya6GLKGY+Y1iq8kY+WTPa+R8p4
         CXefSkNEkwWlwrfuUlXE+fHsY2WXVGlIJDff1DAx2jroJtV0AyiDN6bQ3LTPKwBKmnQr
         jf0C1zF8iqKPnLbSe+/NF9Pu+OW/dS99oonN7suoQxo41PHehPPdLmH2Kk2EdPvlrLJP
         j+CA==
Received: by 10.50.94.166 with SMTP id dd6mr12348587igb.11.1341947639096;
        Tue, 10 Jul 2012 12:13:59 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id q1sm26743706igj.15.2012.07.10.12.13.58
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jul 2012 12:13:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1341939181-8962-2-git-send-email-cmn@elego.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201270>

Hi,

Carlos Mart=C3=ADn Nieto wrote:

> The existing --set-uptream option can cause confusion, as it uses the
> usual branch convention of assuming a starting point of HEAD if none
> is specified, causing
>
>     git branch --set-upstream origin/master
>
> to create a new local branch 'origin/master' that tracks the current
> branch. As --set-upstream already exists, we can't simply change its
> behaviour. To work around this, introduce --set-upstream-to which
> accepts a compulsory argument

Thanks.  A part of me really dislikes this --set-upstream-to which
is named more awkwardly than the deprecated mistake it replaces,
though.

Here's a patch on top to play with that names the new option
"--set-upstream=3D".  Untested.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git i/Documentation/git-branch.txt w/Documentation/git-branch.tx=
t
index f572913f..57935a64 100644
--- i/Documentation/git-branch.txt
+++ w/Documentation/git-branch.txt
@@ -49,7 +49,7 @@ branch so that 'git pull' will appropriately merge fr=
om
 the remote-tracking branch. This behavior may be changed via the globa=
l
 `branch.autosetupmerge` configuration flag. That setting can be
 overridden by using the `--track` and `--no-track` options, and
-changed later using `git branch --set-upstream-to`.
+changed later using `git branch --set-upstream`.
=20
 With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>=
=2E
 If <oldbranch> had a corresponding reflog, it is renamed to match
@@ -174,11 +174,13 @@ start-point is either a local or remote-tracking =
branch.
 	like `--track` would when creating the branch, except that where
 	branch points to is not changed.
=20
--u <upstream>::
---set-upstream-to=3D<upstream>::
+--set-upstream=3D<upstream>::
 	Set up <branchname>'s tracking information so <upstream> is
 	considered <branchname>'s upstream branch. If no branch is
 	specified it defaults to the current branch.
++
+If no argument is attached, for historical reasons the meaning is
+different.  See above.
=20
 --edit-description::
 	Open an editor and edit the text to explain what the branch is
diff --git i/builtin/branch.c w/builtin/branch.c
index c886fc06..0d705790 100644
--- i/builtin/branch.c
+++ w/builtin/branch.c
@@ -669,6 +669,31 @@ static int opt_parse_merge_filter(const struct opt=
ion *opt, const char *arg, int
 	return 0;
 }
=20
+struct set_upstream_params {
+	enum branch_track *track;
+	const char **new_upstream;
+};
+static int parse_opt_set_upstream(const struct option *opt, const char=
 *arg, int unset)
+{
+	struct set_upstream_params *o =3D opt->value;
+
+	if (unset) {	/* --no-set-upstream */
+		*o->track =3D BRANCH_TRACK_NEVER;
+		*o->new_upstream =3D NULL;
+		return 0;
+	}
+
+	*o->track =3D BRANCH_TRACK_OVERRIDE;
+	if (!arg)	/* --set-upstream <branchname> <start-point> */
+		*o->new_upstream =3D NULL;
+	else	/* --set-upstream=3D<upstream> <branchname> */
+		*o->new_upstream =3D arg;
+	return 0;
+}
+#define OPT_SET_UPSTREAM(s, l, v) \
+	{ OPTION_CALLBACK, (s), (l), (v), "upstream", "change upstream info",=
 \
+	  PARSE_OPT_OPTARG, &parse_opt_set_upstream }
+
 static const char edit_description[] =3D "BRANCH_DESCRIPTION";
=20
 static int edit_branch_description(const char *branch_name)
@@ -716,6 +741,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 	const char *new_upstream =3D NULL;
 	enum branch_track track;
 	int kinds =3D REF_LOCAL_BRANCH;
+	struct set_upstream_params set_upstream_args =3D { &track, &new_upstr=
eam };
 	struct commit_list *with_commit =3D NULL;
=20
 	struct option options[] =3D {
@@ -725,9 +751,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		OPT__QUIET(&quiet, "suppress informational messages"),
 		OPT_SET_INT('t', "track",  &track, "set up tracking mode (see git-pu=
ll(1))",
 			BRANCH_TRACK_EXPLICIT),
-		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
-			BRANCH_TRACK_OVERRIDE),
-		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "chang=
e the upstream info"),
+		OPT_SET_UPSTREAM(0, "set-upstream", &set_upstream_args),
 		OPT__COLOR(&branch_use_color, "use colored output"),
 		OPT_SET_INT('r', "remotes",     &kinds, "act on remote-tracking bran=
ches",
 			REF_REMOTE_BRANCH),
