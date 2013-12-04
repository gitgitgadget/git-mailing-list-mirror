From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 06/11] fetch --prune: allow refname patterns to be specified
Date: Wed,  4 Dec 2013 06:44:45 +0100
Message-ID: <1386135890-13954-7-git-send-email-mhagger@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:46:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5Hn-0003ig-UO
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab3LDFpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:45:35 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47386 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750897Ab3LDFpa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:45:30 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-99-529ec17ac54a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id C1.20.19161.A71CE925; Wed,  4 Dec 2013 00:45:30 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCAB016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:29 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsUixO6iqFt1cF6QQeMVTouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7Y9Wg/Y8FSmYq+K2uYGhi7
	xbsYOTkkBEwkXq/ZyQ5hi0lcuLeeDcQWErjMKPGlUbOLkQvIPs8k0bH+I1gRm4CuxKKeZiYQ
	W0RAXOLt8ZlAcQ4OZoEIiUNvS0BMYQEvie1f9EEqWARUJVqadoCN5BVwkVh+5DIzxCoFic41
	/xlBbE4BV4mO3iXMIK1CQDX3zjpNYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83
	s0QvNaV0EyMkSPh2MLavlznEKMDBqMTDm8A5L0iINbGsuDL3EKMkB5OSKG/9dqAQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEV6bMqAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFM
	VoaDQ0mC1+oAUKNgUWp6akVaZk4JQpqJgxNEcIFs4AHaYApSyFtckJhbnJkOUXSKUVFKnDcM
	JCEAksgozYMbAIvnV4ziQP8I8/KCVPEAUwFc9yugwUxAg81fzQIZXJKIkJJqYIzTnBQUM/Vw
	e8kdhay/dfJrlsxon7bhKYetbo5S0MxrSaG6QQ7uKUFdrU3/470vTAgzWqAxcYWl1Y7+1MCP
	jt6r96d9/CB1QbSOZ6M7x403rF6bsvd/q1d/3v656r5YcoTRz5hOrdVpmpebVvnO/fvQ8Gbu
	ip2LpngqTj73UTVU3ej1K/OpzkosxRmJhlrMRcWJABJH/S3CAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238755>

Allow optional arguments to be passed to "git fetch --prune" to choose
which references are subject to pruning.  The default, if no argument
is specified, is to prune all references as before.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/fetch-options.txt |  6 +++++-
 builtin/fetch.c                 |  8 ++++++--
 t/t5510-fetch.sh                | 12 ++++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index f0ef7d0..61d3f75 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -40,7 +40,7 @@ ifndef::git-pull[]
 	specified. No <refspec>s may be specified.
 
 -p::
---prune::
+--prune[=<pattern>]::
 	After fetching, remove any remote-tracking references that no
 	longer exist on the remote.  Tags are not subject to pruning
 	if they are fetched only because of the default tag
@@ -49,6 +49,10 @@ ifndef::git-pull[]
 	line or in the remote configuration, for example if the remote
 	was cloned with the --mirror option), then they are also
 	subject to pruning.
++
+If pattern is specified, then it should be a glob pattern, and pruning
+is further restricted to references whose names match the pattern.
+This option can be specified multiple times.
 endif::git-pull[]
 
 ifndef::git-pull[]
diff --git a/builtin/fetch.c b/builtin/fetch.c
index fcc06a4..2cb48a6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -73,9 +73,12 @@ static struct option builtin_fetch_options[] = {
 		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
-	{ OPTION_CALLBACK, 'p', "prune", &prune_option, N_("pattern"),
+	{ OPTION_CALLBACK, 'p', NULL, &prune_option, NULL,
 		    N_("prune remote-tracking branches no longer on remote"),
 		    PARSE_OPT_NOARG, prune_option_parse },
+	{ OPTION_CALLBACK, 0, "prune", &prune_option, N_("pattern"),
+		    N_("prune remote-tracking branches (matching pattern, if specified)"),
+		    PARSE_OPT_OPTARG, prune_option_parse },
 	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
 		    N_("control recursive fetching of submodules"),
 		    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
@@ -702,7 +705,8 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
 {
 	int result = 0;
-	struct ref *stale_refs = get_stale_heads(refs, ref_count, ref_map, NULL);
+	struct ref *stale_refs = get_stale_heads(refs, ref_count, ref_map,
+						 &prune_option.prune_patterns);
 	struct ref *ref;
 	const char *dangling_msg = dry_run
 		? _("   (%s will become dangling)")
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5d4581d..42eb21f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -94,6 +94,18 @@ test_expect_success 'fetch --prune on its own works as expected' '
 	test_must_fail git rev-parse origin/extrabranch
 '
 
+test_expect_success 'fetch --prune with arguments' '
+	cd "$D" &&
+	git clone . prune-args &&
+	cd prune-args &&
+	git update-ref refs/remotes/origin/branch1 master &&
+	git update-ref refs/remotes/origin/branch2 master &&
+
+	git fetch --prune="refs/remotes/origin/*1" origin &&
+	test_must_fail git rev-parse origin/branch1 &&
+	git rev-parse origin/branch2
+'
+
 test_expect_success 'fetch --prune with a branch name keeps branches' '
 	cd "$D" &&
 	git clone . prune-branch &&
-- 
1.8.4.3
