From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] pull.c: fix some sparse warnings
Date: Wed, 17 Jun 2015 00:18:57 +0100
Message-ID: <5580AEE1.6090300@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: pyokagan@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 17 01:19:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z508U-0003vf-K7
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 01:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbbFPXTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 19:19:09 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:42993 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752439AbbFPXTH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 19:19:07 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id D3D26A0C088;
	Wed, 17 Jun 2015 00:18:29 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 82D7DA0C085;
	Wed, 17 Jun 2015 00:18:29 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Wed, 17 Jun 2015 00:18:29 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271804>


Commit 191241e5 ("pull: pass git-fetch's options to git-fetch",
14-06-2015) uses the OPT_PASSTHRU macro to add some command line
'struct option' initialisations to the pull_options array. This
causes sparse to complain, thus:

      SP builtin/pull.c
  builtin/pull.c:160:9: warning: Using plain integer as NULL pointer
  builtin/pull.c:163:9: warning: Using plain integer as NULL pointer
  builtin/pull.c:170:9: warning: Using plain integer as NULL pointer
  builtin/pull.c:173:9: warning: Using plain integer as NULL pointer
  builtin/pull.c:182:9: warning: Using plain integer as NULL pointer
  builtin/pull.c:188:9: warning: Using plain integer as NULL pointer
  builtin/pull.c:191:9: warning: Using plain integer as NULL pointer

This is caused by using '0' in the macro which is used to initialise
a pointer field of the 'struct option'. In order to suppress the
warnings, we simply pass 'NULL', rather than '0', to the OPT_PASSTHRU
macro.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Paul,

If you need to re-roll your patches on the 'pt/pull-builtin' branch,
could you please squash this into the patch which corresponds to
commit 191241e5.

Thanks!

ATB,
Ramsay Jones

 builtin/pull.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d690aee..8bbe838 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -157,20 +157,20 @@ static struct option pull_options[] = {
 
 	/* Options passed to git-fetch */
 	OPT_GROUP(N_("Options related to fetching")),
-	OPT_PASSTHRU(0, "all", &opt_all, 0,
+	OPT_PASSTHRU(0, "all", &opt_all, NULL,
 		N_("fetch from all remotes"),
 		PARSE_OPT_NOARG),
-	OPT_PASSTHRU('a', "append", &opt_append, 0,
+	OPT_PASSTHRU('a', "append", &opt_append, NULL,
 		N_("append to .git/FETCH_HEAD instead of overwriting"),
 		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "upload-pack", &opt_upload_pack, N_("path"),
 		N_("path to upload pack on remote end"),
 		0),
 	OPT__FORCE(&opt_force, N_("force overwrite of local branch")),
-	OPT_PASSTHRU('t', "tags", &opt_tags, 0,
+	OPT_PASSTHRU('t', "tags", &opt_tags, NULL,
 		N_("fetch all tags and associated objects"),
 		PARSE_OPT_NOARG),
-	OPT_PASSTHRU('p', "prune", &opt_prune, 0,
+	OPT_PASSTHRU('p', "prune", &opt_prune, NULL,
 		N_("prune remote-tracking branches no longer on remote"),
 		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "recurse-submodules", &opt_recurse_submodules,
@@ -179,16 +179,16 @@ static struct option pull_options[] = {
 		PARSE_OPT_OPTARG),
 	OPT_BOOL(0, "dry-run", &opt_dry_run,
 		N_("dry run")),
-	OPT_PASSTHRU('k', "keep", &opt_keep, 0,
+	OPT_PASSTHRU('k', "keep", &opt_keep, NULL,
 		N_("keep downloaded pack"),
 		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "depth", &opt_depth, N_("depth"),
 		N_("deepen history of shallow clone"),
 		0),
-	OPT_PASSTHRU(0, "unshallow", &opt_unshallow, 0,
+	OPT_PASSTHRU(0, "unshallow", &opt_unshallow, NULL,
 		N_("convert to a complete repository"),
 		PARSE_OPT_NONEG | PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "update-shallow", &opt_update_shallow, 0,
+	OPT_PASSTHRU(0, "update-shallow", &opt_update_shallow, NULL,
 		N_("accept refs that update .git/shallow"),
 		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "refmap", &opt_refmap, N_("refmap"),
-- 
2.4.0
