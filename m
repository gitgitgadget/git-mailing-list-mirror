From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 09/10] fetch and pull: learn --progress
Date: Wed, 24 Feb 2010 20:50:28 +0800
Message-ID: <1267015829-5344-10-git-send-email-rctay89@gmail.com>
References: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@googlemail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:51:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkGi5-0005M5-Pe
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 13:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904Ab0BXMvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 07:51:12 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:64550 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895Ab0BXMvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 07:51:09 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so338835qyk.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wLHTCoZ6TZX0fggv+QDCgTS8s3B1yp8OTlH4yqCIaFQ=;
        b=OvSQ2s6OVMvuwB/e8oids4gk5Jmk08/9xkezmvqIGJcFbOde4fc4rPMvZEVzBHJnAn
         mld3zCwEZOXTCq30wQsZ8Yz3l6OPPursfpvRzshN+I7LaCgF4AeyeHehlKTUmd3ktSw1
         sM8h7icnYj5LHiDS+k71cwHZvZlWCNmc153IA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PMxoQo+ddgd0JVvIygNdC/E5jQapP4MyOZDs81/lR4H4z1gVp9/5kwALSw27p2mGGX
         LkY4hnKYIhglXdDCEQqDxN3TOlUDL0+sCzX6IHudPeI3b/K773hHkNJ0EsAF+5Tht+qG
         V4yzs5Mozn/BblGBDYjiGgEC78iszeHNH5B1U=
Received: by 10.224.34.223 with SMTP id m31mr7685236qad.351.1267015868460;
        Wed, 24 Feb 2010 04:51:08 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 23sm253680qyk.15.2010.02.24.04.51.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 04:51:07 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140933>

Note that in the documentation for git-pull, documentation for the
--progress option is displayed under the "Options related to fetching"
subtitle via fetch-options.txt.

Also, update the documentation of the -q/--quiet option for git-pull to
mention its effect on progress reporting during fetching.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changes from v1:
  - teach --progress to git-fetch and git-pull in one patch instead of
    two previously; after all, git-pull is a wrapper of git-fetch.

 Documentation/fetch-options.txt |    9 ++++++++-
 Documentation/git-pull.txt      |    4 +++-
 builtin-fetch.c                 |    4 +++-
 git-pull.sh                     |    6 ++++--
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index fe716b2..044ec88 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -78,9 +78,16 @@ ifndef::git-pull[]
 -q::
 --quiet::
 	Pass --quiet to git-fetch-pack and silence any other internally
-	used git commands.
+	used git commands. Progress is not reported to the standard error
+	stream.

 -v::
 --verbose::
 	Be verbose.
 endif::git-pull[]
+
+--progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index d47f9dd..ab4de10 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -33,7 +33,9 @@ OPTIONS

 -q::
 --quiet::
-	Pass --quiet to git-fetch and git-merge.
+	This is passed to both underlying git-fetch to squelch reporting of
+	during transfer, and underlying git-merge to squelch output during
+	merging.

 -v::
 --verbose::
diff --git a/builtin-fetch.c b/builtin-fetch.c
index bc3fcf3..00fded2 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -28,6 +28,7 @@ enum {
 };

 static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
+static int progress;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -57,6 +58,7 @@ static struct option builtin_fetch_options[] = {
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
+	OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
 	OPT_STRING(0, "depth", &depth, "DEPTH",
 		   "deepen history of shallow clone"),
 	OPT_END()
@@ -823,7 +825,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 		die("Where do you want to fetch from today?");

 	transport = transport_get(remote, NULL);
-	transport_set_verbosity(transport, verbosity, 0);
+	transport_set_verbosity(transport, verbosity, progress);
 	if (upload_pack)
 		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
diff --git a/git-pull.sh b/git-pull.sh
index 38331a8..d45b50c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -38,7 +38,7 @@ test -z "$(git ls-files -u)" || die_conflict
 test -f "$GIT_DIR/MERGE_HEAD" && die_merge

 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
-log_arg= verbosity=
+log_arg= verbosity= progress=
 merge_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
@@ -50,6 +50,8 @@ do
 		verbosity="$verbosity -q" ;;
 	-v|--verbose)
 		verbosity="$verbosity -v" ;;
+	--progress)
+		progress=--progress ;;
 	-n|--no-stat|--no-summary)
 		diffstat=--no-stat ;;
 	--stat|--summary)
@@ -214,7 +216,7 @@ test true = "$rebase" && {
 	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity --update-head-ok "$@" || exit 1
+git fetch $verbosity $progress --update-head-ok "$@" || exit 1

 curr_head=$(git rev-parse -q --verify HEAD)
 if test -n "$orig_head" && test "$curr_head" != "$orig_head"
--
1.7.0.20.gcb44ed
