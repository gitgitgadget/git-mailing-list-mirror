Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952F620281
	for <e@80x24.org>; Sun,  1 Oct 2017 07:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbdJAH3O (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 03:29:14 -0400
Received: from mout.web.de ([212.227.17.11]:62138 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbdJAH3N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 03:29:13 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LkPrz-1dSF0V2iKJ-00cSlz; Sun, 01
 Oct 2017 09:29:04 +0200
Subject: [PATCH 5/3] refs: pass NULL to resolve_refdup() if hash is not needed
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c18156ec-4c59-eb96-3177-0b1085b0a5c1@web.de>
Date:   Sun, 1 Oct 2017 09:29:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:lSRHLNUpgaOXu/UymGR6BsgyTQN1KpLe+KPdogPocFgOd1NlgSr
 DjXKiDNIburTJnuH1kM/k+AmkqHhPOVl9WaAysumxpkS7BGKWm+azjXM2qGu0zG1tPv7yUf
 TUlC+glLD1cBb9/aah2/qk8/zd/eKydPYSQm6382PY3P9sMntUI81gQSqevsPtWJbUnfnx0
 i402lTgayEfAfxrUnBuYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xFiAs+I/BuY=:WIXkQwYBCkx4J83/oqSUtp
 1Zzirh/epVbeSatL+sPjKX3mvMJ7CFjNDgt4YfkNfkThBezqeKJVpttfhdQtokLXPwkU4M0uz
 kKwUI4cImj/BKQYx0W+1ZKkylZOd8m8UlQsFhdgZVmYIp1lyRaf88JHW1lmBFYFWOWGeaNorM
 VhUvfxXQb+tTSB5qeHChYUO7Aykh4oZ45KQjH0Nr5ZQ3kTjQJbyNE7QrMsCY91U/NXp9pvdwY
 krCT8gfc3DsvdLs/0ln+C6cnfp+Bc32rANO5xKDAXgwAxAAEaCoFTP5P2QRsMYU488jjwbXW5
 JHN+agKHUsUgs94uwDmLcRF3Adm9tbOvkeEDT4ZxwM3x8DboiXMzvs/MsfL9N4XSTV5+riy+k
 Kk2OuqTRNI1oJMKIOYbA9hZlHc4yuqHBRjlWkAuJPCCthEEBxohZ1AO1SAsjWD7VX2U5ZB89a
 cTVfohs8DmPRfXJEXVjwKQEKOPmniq+o5DMThlx+Y6/SU8azdiTtbjWUxZ3nhrKeJvYqDGhsV
 2NWsw3ugNpjPmu+NO1fbT7pN+o2xLl2C/b/gjAZ2ly+sQcUySWzIS2m+bnFUozCVk0GzdsGe8
 lGr3W2kuThvqMoMa7N/34wvzcrl71vifQIEKJgtKbzM2op9RoLqzCziE1fhYktxJfte7ItaR1
 2RLNLGk4yVy0NGZwn70/oWjyLu0tvY+gaXFj3U6AQZDH3esEe2JnhmzMzlQYdW0jTrGDNU5oz
 A0Jaj/ydlMQTOBqjDN9jTdHYKypCp6LY/XEXLRcZelVdgLz07RymFDeF2VDQ0o+x70Gevb7Sq
 mo/9wQBx8kY3mVvCk3HU9cZsZCF/h2cqm8X3WEyz4mXY3s5Txs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows us to get rid of several write-only variables.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/checkout.c     | 3 +--
 builtin/receive-pack.c | 3 +--
 ref-filter.c           | 7 ++-----
 reflog-walk.c          | 6 ++----
 transport.c            | 3 +--
 wt-status.c            | 4 +---
 6 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3345a0d16f..10751585ea 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1124,9 +1124,8 @@ static int checkout_branch(struct checkout_opts *opts,
 
 	if (new->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
-		struct object_id oid;
 		int flag;
-		char *head_ref = resolve_refdup("HEAD", 0, oid.hash, &flag);
+		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
 		if (head_ref &&
 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
 			die_if_checked_out(new->path, 1);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 29a0f3b75f..cc48767405 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1458,7 +1458,6 @@ static void execute_commands(struct command *commands,
 {
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 	struct command *cmd;
-	struct object_id oid;
 	struct iterate_data data;
 	struct async muxer;
 	int err_fd = 0;
@@ -1515,7 +1514,7 @@ static void execute_commands(struct command *commands,
 	check_aliased_updates(commands);
 
 	free(head_name_to_free);
-	head_name = head_name_to_free = resolve_refdup("HEAD", 0, oid.hash, NULL);
+	head_name = head_name_to_free = resolve_refdup("HEAD", 0, NULL, NULL);
 
 	if (use_atomic)
 		execute_commands_atomic(commands, si);
diff --git a/ref-filter.c b/ref-filter.c
index bc591f4f3d..55323620ab 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -295,9 +295,7 @@ static void if_atom_parser(const struct ref_format *format, struct used_atom *at
 
 static void head_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
-	struct object_id unused;
-
-	atom->u.head = resolve_refdup("HEAD", RESOLVE_REF_READING, unused.hash, NULL);
+	atom->u.head = resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
 }
 
 static struct {
@@ -1317,9 +1315,8 @@ static void populate_value(struct ref_array_item *ref)
 	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
 
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
-		struct object_id unused1;
 		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
-					     unused1.hash, NULL);
+					     NULL, NULL);
 		if (!ref->symref)
 			ref->symref = "";
 	}
diff --git a/reflog-walk.c b/reflog-walk.c
index 74ebe5148f..842b2f77dc 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -61,11 +61,10 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 	reflogs->ref = xstrdup(ref);
 	for_each_reflog_ent(ref, read_one_reflog, reflogs);
 	if (reflogs->nr == 0) {
-		struct object_id oid;
 		const char *name;
 		void *name_to_free;
 		name = name_to_free = resolve_refdup(ref, RESOLVE_REF_READING,
-						     oid.hash, NULL);
+						     NULL, NULL);
 		if (name) {
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
 			free(name_to_free);
@@ -151,9 +150,8 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		reflogs = item->util;
 	else {
 		if (*branch == '\0') {
-			struct object_id oid;
 			free(branch);
-			branch = resolve_refdup("HEAD", 0, oid.hash, NULL);
+			branch = resolve_refdup("HEAD", 0, NULL, NULL);
 			if (!branch)
 				die ("No current branch");
 
diff --git a/transport.c b/transport.c
index fb8c01e57a..f1e2f61991 100644
--- a/transport.c
+++ b/transport.c
@@ -471,11 +471,10 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 {
 	struct ref *ref;
 	int n = 0;
-	struct object_id head_oid;
 	char *head;
 	int summary_width = transport_summary_width(refs);
 
-	head = resolve_refdup("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL);
+	head = resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
 
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
diff --git a/wt-status.c b/wt-status.c
index 6f730ee8f2..29bc64cc02 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -121,15 +121,13 @@ static void status_printf_more(struct wt_status *s, const char *color,
 
 void wt_status_prepare(struct wt_status *s)
 {
-	struct object_id oid;
-
 	memset(s, 0, sizeof(*s));
 	memcpy(s->color_palette, default_wt_status_colors,
 	       sizeof(default_wt_status_colors));
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color = -1;
 	s->relative_paths = 1;
-	s->branch = resolve_refdup("HEAD", 0, oid.hash, NULL);
+	s->branch = resolve_refdup("HEAD", 0, NULL, NULL);
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
-- 
2.14.2
