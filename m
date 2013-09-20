From: Rodolphe Belouin <rodolphe.belouin@gmail.com>
Subject: [PATCH] builtin/push.c: Add `--notes` option
Date: Fri, 20 Sep 2013 14:20:08 +0200
Message-ID: <1379679608-72475-1-git-send-email-rodolphe.belouin@gmail.com>
Cc: Rodolphe Belouin <rodolphe.belouin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 20 14:20:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMzhV-0008Nl-IB
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 14:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585Ab3ITMUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 08:20:41 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:61097 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab3ITMUk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 08:20:40 -0400
Received: by mail-wi0-f175.google.com with SMTP id ez12so9399482wid.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2013 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=P1B1OePXQdyw7qfNBcU0tZ5GB/p7wAVc4qwLPVjJdj0=;
        b=qBrAaHc/tza6rkZm/rUMQBa8RJ4TEVVGLw1iDN0zvCV38nFMVf4vhewZveDjUQS70Y
         5Nu85PhG+6MHrs8C9Ps7jJNs52Acypxs45WKv0r4qpCa7rhzHWUWBKfwi0ZYyNPnQawN
         pYYP4AwcxyazJjEPK4xthjLk+O+KSNTRNMBH7ibfKKtOSkgPbECOsA32KmhM5sQT55uA
         6FMJ19muOxV1+6vuDmEZdN4r12HUipdqIvc1sX1XDSgP+5h7XvjRyTiQ1iRSUTlxs+Mh
         8U+C0TtM/gwqF8NMOnNh22fGj5g2KEY+cvgJYdGQrqnEeyv7iWi54rbaGTn1nzt4iEeX
         BavA==
X-Received: by 10.180.74.164 with SMTP id u4mr2530368wiv.17.1379679639544;
        Fri, 20 Sep 2013 05:20:39 -0700 (PDT)
Received: from localhost.localdomain (office.clever-cloud.com. [78.233.124.92])
        by mx.google.com with ESMTPSA id l9sm4059572wif.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 05:20:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.412.g79e46c9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235066>

Make the user able to call `git push --notes` instead of
`git push refs/notes/*`

Signed-off-by: Rodolphe Belouin <rodolphe.belouin@gmail.com>
---
 Documentation/git-push.txt | 9 +++++++--
 builtin/push.c             | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 9eec740..2502dbd 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags | --notes] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
@@ -30,7 +30,7 @@ current branch is consulted to determine where to push.  If the
 configuration is missing, it defaults to 'origin'.
 
 When the command line does not specify what to push with `<refspec>...`
-arguments or `--all`, `--mirror`, `--tags` options, the command finds
+arguments or `--all`, `--mirror`, `--tags`, `--notes` options, the command finds
 the default `<refspec>` by consulting `remote.*.push` configuration,
 and if it is not found, honors `push.default` configuration to decide
 what to push (See gitlink:git-config[1] for the meaning of `push.default`).
@@ -124,6 +124,11 @@ already exists on the remote side.
 	from the remote but are pointing at commit-ish that are
 	reachable from the refs being pushed.
 
+--notes::
+	All refs under `refs/notes` are pushed, in
+	addition to refspecs explicitly listed on the command
+	line.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index 7b1b66c..c407ccc 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -445,6 +445,7 @@ static int option_parse_recurse_submodules(const struct option *opt,
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
+	int notes = 0;
 	int tags = 0;
 	int rc;
 	const char *repo = NULL;	/* default repository */
@@ -455,6 +456,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "mirror", &flags, N_("mirror all refs"),
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
 		OPT_BOOL( 0, "delete", &deleterefs, N_("delete refs")),
+		OPT_BOOL( 0 , "notes", &notes, N_("push notes (can't be used with --all or --mirror)")),
 		OPT_BOOL( 0 , "tags", &tags, N_("push tags (can't be used with --all or --mirror)")),
 		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
@@ -484,14 +486,17 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
-	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
-		die(_("--delete is incompatible with --all, --mirror and --tags"));
+	if (deleterefs && (tags || notes || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
+		die(_("--delete is incompatible with --all, --mirror, --tags and --notes"));
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
 
 	if (tags)
 		add_refspec("refs/tags/*");
 
+	if (notes)
+		add_refspec("refs/notes/*");
+
 	if (argc > 0) {
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1);
-- 
1.8.4.412.g79e46c9.dirty
