From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 4/4] gc: remove broken refs
Date: Thu, 24 Sep 2015 11:14:02 +0200
Organization: gmx
Message-ID: <8855bae256311446dffd221ab33c1163eb104c4a.1443085919.git.johannes.schindelin@gmx.de>
References: <cover.1443085919.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 24 11:14:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf2bW-0004c9-Gj
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 11:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbbIXJOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 05:14:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:65362 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbbIXJOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 05:14:07 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LeBPM-1aUXFH00ui-00psr3; Thu, 24 Sep 2015 11:14:03
 +0200
In-Reply-To: <cover.1443085919.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:dXY9QfDuhDnAms6mQmMZeBQrR9nOp74eGRMHHp98cEhSoJg12Nk
 Kwtt1CMKumEXXUeXIs7+mCHgeQN4TFcB3TbAgC6MWvKY9hBoahy+nWnqiZIIKOq/BGxMYAS
 UyovZASS8Oq/KonVBcxytYnLpvpynA9MabXXI4n/fVaLCVLGskhX+X6Kh5CjQCT716XmjZd
 nTJ9KJczCxJNrFXfdOcJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AiPDOgv4SRQ=:fqlG0qCXGsqKL/9XGWnECy
 7n91grBYQMft1y+AmwVnzutM7GgUKBRyn7iB5QUlWqUcMgttcRS2huzCY4jAFtqGXjrRe2Cba
 /M1cRYCig3rClrCWQ0j7hR4Qdbi7i0zSuUfPIzNJCbIUKYok/9LfkWBK/+yvj8KE+HRujwcIY
 5l6v4HKzPcCIRhC7VrIcpz8ao6hQKymCCWGY+KLf43TfFgg6VuD05+OBk0gWUVXMPM3oj04fz
 jLJTZHhtV0/Lwvw+kN6QehsUddXbJrjk+mWvxR4DWX0+PEgXFijEyQ4mRWMa//2eDS2GI7WqF
 J4ueCq5lzjzeFZBV5GYedBdcxGozeXSfPdZOxiMFC/2Bmio73qJz1VFdnWS77VQ8H61aSofPi
 ApR/r6xgtNh5PpB6WRNS6raBDldzrI0Kx3Lixf5PtKNyjcQxbb1hbaGj9UoMHmTg8FCMFUkDx
 H8P/Uw8UtR5ixlSEYq96bLt+ryNAmkioXbzYdMtU0KPYbCC1d/KNYvdBDLCWaSFaGD7rqI1hJ
 k74yE0t0NsKVWqywzZMPMkHuQX9xktzJVnfguKIcC/g5fn0KL6Vh3esAINqHVpG2ImJknbq1q
 jXwBrodmQ8yPrax/EMrDvKo/PxdpwHIgTxiakFp+hcNj2KI9HJABAxYm0ax3Kq31ZagALZNf9
 HQFfNPV/9Maco7pEXhfhxhCatD/CJntmqjddrtIEAdDI6yp5i1eFpXF5bLj+0bVyA05aXltPC
 a48GCJer3ywqu3oz/WZBS60QrvRcsNRUKWcGCw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278542>

When encountering broken refs, such as a stale remote HEAD (which can
happen if the active branch was renamed in the remote), it is more
helpful to remove those refs than to exit with an error.

This fixes https://github.com/git-for-windows/git/issues/423

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/prune.c | 12 +++++++++++-
 t/t6500-gc.sh   |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index d6f664f..1a30f65 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -6,6 +6,7 @@
 #include "reachable.h"
 #include "parse-options.h"
 #include "progress.h"
+#include "refs.h"
 
 static const char * const prune_usage[] = {
 	N_("git prune [-n] [-v] [--expire <time>] [--] [<head>...]"),
@@ -100,6 +101,7 @@ static void remove_temporary_files(const char *path)
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
+	struct string_list broken_refs = STRING_LIST_INIT_DUP;
 	struct progress *progress = NULL;
 	const struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
@@ -110,6 +112,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	char *s;
+	int i;
 
 	expire = ULONG_MAX;
 	save_commit_buffer = 0;
@@ -136,7 +139,14 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	if (show_progress)
 		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
 
-	mark_reachable_objects(&revs, 1, expire, progress, NULL);
+	revs.ignore_missing = 1;
+	mark_reachable_objects(&revs, 1, expire, progress, &broken_refs);
+	for (i = 0; i < broken_refs.nr; i++) {
+		char *path = broken_refs.items[i].string;
+		printf("Removing stale ref %s\n", path);
+		if (!show_only && delete_ref(path, NULL, REF_NODEREF))
+			die("Could not remove stale ref %s", path);
+	}
 	stop_progress(&progress);
 	for_each_loose_file_in_objdir(get_object_directory(), prune_object,
 				      prune_cruft, prune_subdir, NULL);
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index b736774..0ae4271 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -30,7 +30,7 @@ test_expect_success 'gc -h with invalid configuration' '
 	test_i18ngrep "[Uu]sage" broken/usage
 '
 
-test_expect_failure 'gc removes broken refs/remotes/<name>/HEAD' '
+test_expect_success 'gc removes broken refs/remotes/<name>/HEAD' '
 	git init remote &&
 	(
 		cd remote &&
-- 
2.5.2.windows.2
