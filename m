Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF6C433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DB960F38
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhKMDhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 22:37:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54531 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232113AbhKMDhO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 22:37:14 -0500
Received: from localhost ([38.30.8.235])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AD3Y3Nb004966
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 22:34:05 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v6 1/8] fetch: lowercase error messages
Date:   Fri, 12 Nov 2021 19:33:51 -0800
Message-Id: <20211113033358.2179376-2-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211113033358.2179376-1-andersk@mit.edu>
References: <20211113033358.2179376-1-andersk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation/CodingGuidelines says “do not end error messages with a
full stop” and “do not capitalize the first word”.  Reviewers requested
updating the existing messages to comply with these guidelines prior to
the following patches.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin/fetch.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e064687dbd..e5971fa6e5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -552,7 +552,7 @@ static struct ref *get_ref_map(struct remote *remote,
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
 	} else if (refmap.nr) {
-		die("--refmap option is only meaningful with command-line refspec(s).");
+		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
 		/* Use the defaults */
 		struct branch *branch = branch_get(NULL);
@@ -583,7 +583,7 @@ static struct ref *get_ref_map(struct remote *remote,
 		} else if (!prefetch) {
 			ref_map = get_remote_ref(remote_refs, "HEAD");
 			if (!ref_map)
-				die(_("Couldn't find remote ref HEAD"));
+				die(_("couldn't find remote ref HEAD"));
 			ref_map->fetch_head_status = FETCH_HEAD_MERGE;
 			tail = &ref_map->next;
 		}
@@ -1062,13 +1062,13 @@ static void close_fetch_head(struct fetch_head *fetch_head)
 }
 
 static const char warn_show_forced_updates[] =
-N_("Fetch normally indicates which branches had a forced update,\n"
-   "but that check has been disabled. To re-enable, use '--show-forced-updates'\n"
-   "flag or run 'git config fetch.showForcedUpdates true'.");
+N_("fetch normally indicates which branches had a forced update,\n"
+   "but that check has been disabled; to re-enable, use '--show-forced-updates'\n"
+   "flag or run 'git config fetch.showForcedUpdates true'");
 static const char warn_time_show_forced_updates[] =
-N_("It took %.2f seconds to check forced updates. You can use\n"
+N_("it took %.2f seconds to check forced updates; you can use\n"
    "'--no-show-forced-updates' or run 'git config fetch.showForcedUpdates false'\n"
-   " to avoid this check.\n");
+   " to avoid this check\n");
 
 static int store_updated_refs(const char *raw_url, const char *remote_name,
 			      int connectivity_checked, struct ref *ref_map)
@@ -1381,8 +1381,9 @@ static void check_not_current_branch(struct ref *ref_map)
 	for (; ref_map; ref_map = ref_map->next)
 		if (ref_map->peer_ref && !strcmp(current_branch->refname,
 					ref_map->peer_ref->name))
-			die(_("Refusing to fetch into current branch %s "
-			    "of non-bare repository"), current_branch->refname);
+			die(_("refusing to fetch into current branch %s "
+			      "of non-bare repository"),
+			    current_branch->refname);
 }
 
 static int truncate_fetch_head(void)
@@ -1400,10 +1401,10 @@ static void set_option(struct transport *transport, const char *name, const char
 {
 	int r = transport_set_option(transport, name, value);
 	if (r < 0)
-		die(_("Option \"%s\" value \"%s\" is not valid for %s"),
+		die(_("option \"%s\" value \"%s\" is not valid for %s"),
 		    name, value, transport->url);
 	if (r > 0)
-		warning(_("Option \"%s\" is ignored for %s\n"),
+		warning(_("option \"%s\" is ignored for %s\n"),
 			name, transport->url);
 }
 
@@ -1437,7 +1438,7 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 		old_nr = oids->nr;
 		for_each_glob_ref(add_oid, s, oids);
 		if (old_nr == oids->nr)
-			warning("Ignoring --negotiation-tip=%s because it does not match any refs",
+			warning("ignoring --negotiation-tip=%s because it does not match any refs",
 				s);
 	}
 	smart_options->negotiation_tips = oids;
@@ -1475,7 +1476,7 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		if (transport->smart_options)
 			add_negotiation_tips(transport->smart_options);
 		else
-			warning("Ignoring --negotiation-tip because the protocol does not support it.");
+			warning("ignoring --negotiation-tip because the protocol does not support it");
 	}
 	return transport;
 }
@@ -1638,8 +1639,8 @@ static int do_fetch(struct transport *transport,
 			else
 				warning(_("unknown branch type"));
 		} else {
-			warning(_("no source branch found.\n"
-				"you need to specify exactly one branch with the --set-upstream option."));
+			warning(_("no source branch found;\n"
+				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
  skip:
@@ -1893,8 +1894,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	int remote_via_config = remote_is_configured(remote, 0);
 
 	if (!remote)
-		die(_("No remote repository specified.  Please, specify either a URL or a\n"
-		    "remote name from which new revisions should be fetched."));
+		die(_("no remote repository specified; please specify either a URL or a\n"
+		      "remote name from which new revisions should be fetched"));
 
 	gtransport = prepare_transport(remote, 1);
 
@@ -1929,7 +1930,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 		if (!strcmp(argv[i], "tag")) {
 			i++;
 			if (i >= argc)
-				die(_("You need to specify a tag name."));
+				die(_("you need to specify a tag name"));
 
 			refspec_appendf(&rs, "refs/tags/%s:refs/tags/%s",
 					argv[i], argv[i]);
@@ -1997,7 +1998,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	if (deepen_relative) {
 		if (deepen_relative < 0)
-			die(_("Negative depth in --deepen is not supported"));
+			die(_("negative depth in --deepen is not supported"));
 		if (depth)
 			die(_("--deepen and --depth are mutually exclusive"));
 		depth = xstrfmt("%d", deepen_relative);
@@ -2034,14 +2035,15 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		/* All arguments are assumed to be remotes or groups */
 		for (i = 0; i < argc; i++)
 			if (!add_remote_or_group(argv[i], &list))
-				die(_("No such remote or remote group: %s"), argv[i]);
+				die(_("no such remote or remote group: %s"),
+				    argv[i]);
 	} else {
 		/* Single remote or group */
 		(void) add_remote_or_group(argv[0], &list);
 		if (list.nr > 1) {
 			/* More than one remote */
 			if (argc > 1)
-				die(_("Fetching a group and specifying refspecs does not make sense"));
+				die(_("fetching a group and specifying refspecs does not make sense"));
 		} else {
 			/* Zero or one remotes */
 			remote = remote_get(argv[0]);
@@ -2062,7 +2064,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		if (gtransport->smart_options) {
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
-			warning(_("Protocol does not support --negotiate-only, exiting."));
+			warning(_("protocol does not support --negotiate-only, exiting"));
 			return 1;
 		}
 		if (server_options.nr)
-- 
2.33.1

