From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 07/11] remote update --prune: allow refname patterns to be specified
Date: Wed,  4 Dec 2013 06:44:46 +0100
Message-ID: <1386135890-13954-8-git-send-email-mhagger@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5OH-000822-Ox
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab3LDFws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:52:48 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57644 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754092Ab3LDFwd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:52:33 -0500
X-AuditID: 1207440c-b7f566d000004272-51-529ec17b0bdb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FD.0A.17010.B71CE925; Wed,  4 Dec 2013 00:45:31 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCAC016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:30 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsUixO6iqFt9cF6QwbP5ohZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ2x7koTc8EtmYrfy86xNzBe
	FO9i5OCQEDCReLdTuYuRE8gUk7hwbz0biC0kcJlR4s1Gvi5GLiD7PJPEmjPn2EESbAK6Eot6
	mplAbBEBcYm3x2eyg8xhFoiQOPS2BCQsLBAk8ezXQ7ASFgFViTMb9zCD2LwCLhJfVq5hgtil
	ING55j8jiM0p4CrR0buEGWSMEFDNvbNOExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3S
	NdTLzSzRS00p3cQICRKeHYzf1skcYhTgYFTi4U3gnBckxJpYVlyZe4hRkoNJSZS3fjtQiC8p
	P6UyI7E4I76oNCe1+BCjBAezkgivTRlQjjclsbIqtSgfJiXNwaIkzqu6RN1PSCA9sSQ1OzW1
	ILUIJivDwaEkwbvxAFCjYFFqempFWmZOCUKaiYMTRHCBbOAB2rAOpJC3uCAxtzgzHaLoFKOi
	lDjvZJCEAEgiozQPbgAsnl8xigP9I8x7GKSKB5gK4LpfAQ1mAhps/moWyOCSRISUVANjx/ZX
	0mlSf8t8Y1XuaatPSXCu4/96bf1D0e5VDV+3h8e/r5gqkt5aKL5a8XxafJgg27GXP1XPmzQ/
	XH6yzpq/muV5rHne5NuK0czCj7/N92er3cxV0PmYf6+Q+KZFc37uuJMnPO/JZpMpWpclfp/1
	KspM/83/o5z53GGzgH/rLk0ILzN+bRykxFKckWioxVxUnAgAj48fE8ICAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238759>

Allow optional arguments to be passed to "git remote update --prune"
to choose which references are subject to pruning.  The default, if no
argument is specified, is to prune all references as before.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-remote.txt |  7 +++++--
 builtin/remote.c             |  9 ++++++---
 t/t5505-remote.sh            | 13 +++++++++++++
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 2507c8b..02e50a9 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -20,7 +20,8 @@ SYNOPSIS
 'git remote set-url --delete' [--push] <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>...
 'git remote prune' [-n | --dry-run] <name>...
-'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
+'git remote' [-v | --verbose] 'update' [-p | --no-prune | --prune[=<pattern>]...]
+				       [(<group> | <remote>)...]
 
 DESCRIPTION
 -----------
@@ -168,7 +169,9 @@ remotes.default is not defined, all remotes which do not have the
 configuration parameter remote.<name>.skipDefaultUpdate set to true will
 be updated.  (See linkgit:git-config[1]).
 +
-With `--prune` option, prune all the remotes that are updated.
+The options `--prune`, `--no-prune`, and `--prune=<pattern>` affect
+whether remote-tracking branches associated with the remotes are
+pruned.  See linkgit:git-fetch[1] for more information.
 
 
 DISCUSSION
diff --git a/builtin/remote.c b/builtin/remote.c
index 09b965a..6aab923 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,7 +16,7 @@ static const char * const builtin_remote_usage[] = {
 	N_("git remote set-head <name> (-a | --auto | -d | --delete |<branch>)"),
 	N_("git remote [-v | --verbose] show [-n] <name>"),
 	N_("git remote prune [-n | --dry-run] <name>"),
-	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
+	N_("git remote [-v | --verbose] update [-p | --prune[=<pattern>] | --no-prune] [(<group> | <remote>)...]"),
 	N_("git remote set-branches [--add] <name> <branch>..."),
 	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
 	N_("git remote set-url --add <name> <newurl>"),
@@ -1375,9 +1375,12 @@ static int update(int argc, const char **argv)
 	int i;
 	struct prune_option prune_option = PRUNE_OPTION_INIT;
 	struct option options[] = {
-		{ OPTION_CALLBACK, 'p', "prune", &prune_option, N_("pattern"),
-			N_("prune remotes after fetching"),
+		{ OPTION_CALLBACK, 'p', NULL, &prune_option, NULL,
+			N_("prune remote-tracking branches no longer on remote"),
 			PARSE_OPT_NOARG, prune_option_parse },
+		{ OPTION_CALLBACK, 0, "prune", &prune_option, N_("pattern"),
+			N_("prune remote-tracking branches (matching pattern, if specified)"),
+			PARSE_OPT_OPTARG, prune_option_parse },
 		OPT_END()
 	};
 	struct argv_array fetch_argv = ARGV_ARRAY_INIT;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8f6e392..0dffe47 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -614,6 +614,19 @@ test_expect_success 'update --prune' '
 	)
 '
 
+test_expect_success 'update --prune with argument' '
+	git clone one update-prune-arg &&
+	(
+		cd update-prune-arg &&
+		git update-ref refs/remotes/origin/branch1 master &&
+		git update-ref refs/remotes/origin/branch2 master &&
+
+		git remote update --prune="refs/remotes/*1" origin &&
+		test_must_fail git rev-parse origin/branch1 &&
+		git rev-parse origin/branch2
+	)
+'
+
 cat >one/expect <<-\EOF
   apis/master
   apis/side
-- 
1.8.4.3
