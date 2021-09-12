Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9A5C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76666113E
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhILARe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 20:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhILARZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 20:17:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7477DC061760
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x6so8442376wrv.13
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyJqPsdiKMDus6lT6ql8Ydda2ewa8+IzOGjDejEDM+E=;
        b=g1L0JbfijvMVFkoMf+uI9PVSAlStk5GzJWW7to33pZhoEQ2VIruP+TWsnldfYM7vyO
         +9ZebVtkPL2d50EXrzj+iM4pnLx1TWeOMsrQeAyGIYXysOsJql9ttxW1aELA3R6VXL+O
         i7Wq9AYpkrUkUj5U1pg8ZWHInb4WGppWLrTUJrNLFHjb/qnsfstoZySr8C1Ephd1vtiK
         OZwMlYdwGRzX6zkoqXu3iLrHJMN9DDfERrs7AvgoYLikQ05Ag41AG0vkhF+a0Cw52rib
         Wra9zRhPoWiUNRnTrz0v4MvDGjz9v9c8EHfeHbPt/wBUbz7iK8+hjkf1759NHsspEX6x
         Iysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyJqPsdiKMDus6lT6ql8Ydda2ewa8+IzOGjDejEDM+E=;
        b=zRJbW4KKc0Z++rsSMcWrFbU6O+hiHYYV/UTfHhOdnK8q+aM3FDFXCqPuq2m52/dPWs
         8NCdCuHnclldmuC8MBduMHWX0IqR3vZWgOEboHjyftMBc+8JOzgSzgfsb9FzkCthAKVa
         8gsHlaBsoJtipASkdvOOtwkG0pz31egUoajG8qtmYhupGHB+VIjMMFcHa/aPOyCFPlIr
         ffaJ+57Oa0RjlC987xuM6uyAoE9Wf06XgePGxeh9IzIdWeGkNVoyZnHJH1tCqN9WLLoR
         U2GTBdmKgAD4jpIbwZlZRPcYrVA17ZDzR5kAbGuqTiF1Q9uHdI61mLEKYlyV2g3s/7nh
         YDCQ==
X-Gm-Message-State: AOAM531ML8VvcZeke9+rbl69l5WKfXO+4Mvta/VdavR65iB5UtI7Kn7e
        T4aAcv1IqY7fSHodi9eD2lUqg07LRQaZ6w==
X-Google-Smtp-Source: ABdhPJx1VMRRmxueb2Il9uZFR501nyHSnFxjQDP8V39LLVpLE22Kr8Lma1YArFmDTQn2h10tOfaS2w==
X-Received: by 2002:adf:d209:: with SMTP id j9mr4304226wrh.97.1631405770744;
        Sat, 11 Sep 2021 17:16:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm3301078wrd.25.2021.09.11.17.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 17:16:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/7] strvec API users: change some "int" tracking "nr" to "size_t"
Date:   Sun, 12 Sep 2021 02:15:55 +0200
Message-Id: <patch-v2-7.7-2edd9708888-20210912T001420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.998.ga4d44345d43
In-Reply-To: <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email> <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the strvec.h "int nr" has been changed to "size_t nr" in the
preceding commit change various users of the API so that their local
tracking (usually for-loop iteration) of the number of items in the
array uses "size_t" as well.

These were found by changing the "nr" member to a pointer temporarily,
and manually looking at the codepaths that the compiler complained
about.

As argued in <YTIBnT8Ue1HZXs82@coredump.intra.peff.net>[1] these
changes are not strictly necessary as a follow-up, but let's do them
anyway so we don't need to wonder about the "size_t" v.s. "int"
inconsistency going forward.

As noted in <87v93i8svd.fsf@evledraar.gmail.com> in that thread we
have various things that interact with the "int argc" passed from
main() (e.g. setup_revisions()) and "struct strvec". Those things
could consistently use "int" before, but will now use some mixture of
"int" and "size_t". That's OK, but is the reason we're not converting
all API users to use "size_t" here for their own copies of "nr", or
when they pass that "nr" to other functions.

1. https://lore.kernel.org/git/YTIBnT8Ue1HZXs82@coredump.intra.peff.net/
2. https://lore.kernel.org/git/87v93i8svd.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 7 ++++---
 connect.c        | 8 ++++----
 fetch-pack.c     | 4 ++--
 ls-refs.c        | 2 +-
 remote-curl.c    | 2 +-
 sequencer.c      | 2 +-
 serve.c          | 2 +-
 submodule.c      | 2 +-
 8 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index dcd897fda9c..b96faaa7fea 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1424,7 +1424,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("apply all changes, even those already present upstream")),
 		OPT_END(),
 	};
-	int i;
+	size_t i;
+	unsigned int j;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_rebase_usage,
@@ -1654,8 +1655,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	for (i = 0; i < exec.nr; i++)
-		if (check_exec_cmd(exec.items[i].string))
+	for (j = 0; j < exec.nr; j++)
+		if (check_exec_cmd(exec.items[j].string))
 			exit(1);
 
 	if (!(options.flags & REBASE_NO_QUIET))
diff --git a/connect.c b/connect.c
index aff13a270e6..a54d4aa4d90 100644
--- a/connect.c
+++ b/connect.c
@@ -68,7 +68,7 @@ static NORETURN void die_initial_contact(int unexpected)
 /* Checks if the server supports the capability 'c' */
 int server_supports_v2(const char *c, int die_on_error)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
@@ -85,7 +85,7 @@ int server_supports_v2(const char *c, int die_on_error)
 
 int server_feature_v2(const char *c, const char **v)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
@@ -101,7 +101,7 @@ int server_feature_v2(const char *c, const char **v)
 int server_supports_feature(const char *c, const char *feature,
 			    int die_on_error)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
@@ -479,7 +479,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     const struct string_list *server_options,
 			     int stateless_rpc)
 {
-	int i;
+	size_t i;
 	const char *hash_name;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
diff --git a/fetch-pack.c b/fetch-pack.c
index 0bf7ed7e477..d20f9a046f7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -945,7 +945,7 @@ static int get_pack(struct fetch_pack_args *args,
 	}
 
 	if (index_pack_args) {
-		int i;
+		size_t i;
 
 		for (i = 0; i < cmd.args.nr; i++)
 			strvec_push(index_pack_args, cmd.args.v[i]);
@@ -1674,7 +1674,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	}
 
 	for (i = 0; i < packfile_uris.nr; i++) {
-		int j;
+		size_t j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
 		char packname[GIT_MAX_HEXSZ + 1];
 		const char *uri = packfile_uris.items[i].string +
diff --git a/ls-refs.c b/ls-refs.c
index 84021416ca5..9622bc46072 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -46,7 +46,7 @@ static void ensure_config_read(void)
  */
 static int ref_match(const struct strvec *prefixes, const char *refname)
 {
-	int i;
+	size_t i;
 
 	if (!prefixes->nr)
 		return 1; /* no restriction */
diff --git a/remote-curl.c b/remote-curl.c
index 1f177e86f11..682643bb842 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1288,7 +1288,7 @@ static int push_dav(struct strvec *specs)
 static int push_git(struct discovery *heads, struct strvec *specs)
 {
 	struct rpc_state rpc;
-	int i;
+	size_t i;
 	int err;
 	struct strvec args;
 	struct string_list_item *cas_option;
diff --git a/sequencer.c b/sequencer.c
index a4ba434f173..ca3ee2e4167 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -919,7 +919,7 @@ static char *get_author(const char *message)
 
 static const char *author_date_from_env_array(const struct strvec *env)
 {
-	int i;
+	size_t i;
 	const char *date;
 
 	for (i = 0; i < env->nr; i++)
diff --git a/serve.c b/serve.c
index f11c0e07c45..0271bf946cc 100644
--- a/serve.c
+++ b/serve.c
@@ -159,7 +159,7 @@ static int is_command(const char *key, struct protocol_capability **command)
 int has_capability(const struct strvec *keys, const char *capability,
 		   const char **value)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < keys->nr; i++) {
 		const char *out;
 		if (skip_prefix(keys->v[i], capability, &out) &&
diff --git a/submodule.c b/submodule.c
index 8e611fe1dbf..38ee56782c7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1606,7 +1606,7 @@ int fetch_populated_submodules(struct repository *r,
 			       int default_option,
 			       int quiet, int max_parallel_jobs)
 {
-	int i;
+	size_t i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
 
 	spf.r = r;
-- 
2.33.0.998.ga4d44345d43

