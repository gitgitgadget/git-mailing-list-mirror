Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55487C56202
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 09:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B232467A
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 09:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H16DGsUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgKRJMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 04:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgKRJMW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 04:12:22 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F907C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 01:12:22 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id l206so1409548oif.12
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 01:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vc5DYiZdRgO5sVz0e7Ghg/OmDM7h3Ncde6PDmy/ZYBQ=;
        b=H16DGsUVq1yM5QH0MqC+21+AZXn6/kfguukU+XnFkngevB7i7RFWOtEWQf4uK2LNtX
         eBZc6yExH+bvSbY7Be03zVxWDU2yUI0lO3D6FKXWeqPwB/k9acc631mxKcmMFl8WeaaI
         nYO9Q96YDO2Ge/jDIAsNInj3sfE00x4UTKU/FPxJ+KqMd23oXUpDEwnefbb1Hyp0Cn7X
         34g/qSSXZ1J9LUrobQJ8Ag7LvtZ61tug9/yWcb315EOgP5zf6HS5hrtNOrP9NtJIg0/L
         2fsBdHIZU9B5jdwGog9hh4+R8mxkHiIT1ouctAXY9MuAxA+9nFyPGeGjWlJ8WtrDBZpf
         IgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vc5DYiZdRgO5sVz0e7Ghg/OmDM7h3Ncde6PDmy/ZYBQ=;
        b=ivloqJjeQf5ZzQXaFC/VRu5AvRcYqO2ZwF5d50W+CsPto1MgTXJUXGenxlKkoQHglG
         sweb/Y4XjqOT2sh54sUr9RDFbu41+cnHhVmUUq4IDEPlXDiVM/pCF//TXMl/G5CjeRrM
         DKOzsYlKEH20kroB9LSOpTT2ObxNFCwSKavhWx8vumGi82V590KY6Vsil5irv9YX/pw2
         XKHdZoM2lxa8h9/85nXUv5OM1t9H6FSDHdEbnnTVlEcJF/bft8hI++Zp/0YWg3Rf1KA6
         ivyEe3mlnu1vrDghkqjf45I5h86M9Fr5nyVecgph8cU+5DiBDfY0U3kSwQQzm8+oX4pB
         SYTg==
X-Gm-Message-State: AOAM530TNL4wSe0C2sSUjZhO0P4v5mFjIaCNv21VxVYwBvPpepxC3DgD
        aysCCvdLFctjXfEIWqsvGeCkd0vluYsIog==
X-Google-Smtp-Source: ABdhPJxDYNnC3O11AM2D6qzVBcKNdvUq6zxTTnSu+CuP0jNYNn4fPa1yGj9/SgC/LiHtgw5Q6qW72Q==
X-Received: by 2002:aca:5b85:: with SMTP id p127mr2180402oib.34.1605690741189;
        Wed, 18 Nov 2020 01:12:21 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e47sm7183769ote.50.2020.11.18.01.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 01:12:20 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH] Add fetch.updateHead option
Date:   Wed, 18 Nov 2020 03:12:19 -0600
Message-Id: <20201118091219.3341585-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users might change the behavior when running "git fetch" so that the
remote's HEAD symbolic ref is updated at certain point.

For example after running "git remote add" the remote HEAD is not
set like it is with "git clone".

Setting "fetch.updatehead = missing" would probably be a sensible
default that everyone would want, but for now the default behavior is to
never update HEAD, so there shouldn't be any functional changes.

For the next major version of Git, we might want to change this default.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This is just a RFC, the tests are missing.

 Documentation/config/fetch.txt  |  4 +++
 Documentation/config/remote.txt |  3 ++
 builtin/fetch.c                 | 53 ++++++++++++++++++++++++++++++++-
 remote.c                        | 21 +++++++++++++
 remote.h                        | 11 +++++++
 5 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 6af6f5edb2..93d6c59fac 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -94,3 +94,7 @@ fetch.writeCommitGraph::
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
 	`git push -f`, and `git log --graph`. Defaults to false.
+
+fetch.updateHead::
+  Defines when to update the remote HEAD symbolic ref. Values are 'never',
+  'missing' (update only when HEAD is missing), and 'always'.
diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index a8e6437a90..905661c7f7 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -84,3 +84,6 @@ remote.<name>.promisor::
 remote.<name>.partialclonefilter::
 	The filter that will be applied when fetching from this
 	promisor remote.
+
+remote.<name>.updateHead::
+  Defines when to update the remote HEAD symbolic ref. See `fetch.updateHead`.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f9c3c49f14..b47b06f001 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -55,6 +55,8 @@ static int fetch_prune_tags_config = -1; /* unspecified */
 static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
+static int fetch_update_head = FETCH_UPDATE_HEAD_DEFAULT;
+
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
 static int write_fetch_head = 1;
 static int verbosity, deepen_relative, set_upstream;
@@ -120,6 +122,9 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.updatehead"))
+		return parse_update_head(&fetch_update_head, k, v);
+
 	return git_default_config(k, v, cb);
 }
 
@@ -1342,6 +1347,38 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 	}
 }
 
+static void update_head(int config, const struct ref *head, const struct remote *remote)
+{
+	struct strbuf ref = STRBUF_INIT, target = STRBUF_INIT;
+	const char *r, *head_name = NULL;
+
+	if (!head || !head->symref || !remote)
+		return;
+
+	strbuf_addf(&ref, "refs/remotes/%s/HEAD", remote->name);
+	skip_prefix(head->symref, "refs/heads/", &head_name);
+	strbuf_addf(&target, "refs/remotes/%s/%s", remote->name, head_name);
+
+	r = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+		ref.buf, RESOLVE_REF_READING,
+		NULL, NULL);
+
+	if (r) {
+		if (config == FETCH_UPDATE_HEAD_MISSING)
+			/* already present */
+			return;
+		else if (config == FETCH_UPDATE_HEAD_ALWAYS && !strcmp(r, target.buf))
+			/* already up-to-date */
+			return;
+		else
+			/* should never happen */
+			return;
+	}
+
+	if (create_symref(ref.buf, target.buf, "remote update head"))
+		warning(_("could not set remote head"));
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs)
 {
@@ -1351,6 +1388,7 @@ static int do_fetch(struct transport *transport,
 	const struct ref *remote_refs;
 	struct strvec ref_prefixes = STRVEC_INIT;
 	int must_list_refs = 1;
+	int need_update_head = 0, update_head_config = 0;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1382,8 +1420,18 @@ static int do_fetch(struct transport *transport,
 				break;
 			}
 		}
-	} else if (transport->remote && transport->remote->fetch.nr)
+	} else if (transport->remote && transport->remote->fetch.nr) {
+		if (transport->remote->update_head)
+			update_head_config = transport->remote->update_head;
+		else
+			update_head_config = fetch_update_head;
+
+		need_update_head = update_head_config && update_head_config != FETCH_UPDATE_HEAD_NEVER;
+
+		if (need_update_head)
+			strvec_push(&ref_prefixes, "HEAD");
 		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
+	}
 
 	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
 		must_list_refs = 1;
@@ -1427,6 +1475,9 @@ static int do_fetch(struct transport *transport,
 		goto cleanup;
 	}
 
+	if (need_update_head)
+		update_head(update_head_config, find_ref_by_name(remote_refs, "HEAD"), transport->remote);
+
 	if (set_upstream) {
 		struct branch *branch = branch_get("HEAD");
 		struct ref *rm;
diff --git a/remote.c b/remote.c
index 8a6dbbb903..dad8062561 100644
--- a/remote.c
+++ b/remote.c
@@ -298,6 +298,25 @@ static void read_branches_file(struct remote *remote)
 	remote->fetch_tags = 1; /* always auto-follow */
 }
 
+int parse_update_head(int *r, const char *var, const char *value)
+{
+	if (!r)
+		return -1;
+	else if (!value)
+		return config_error_nonbool(var);
+	else if (!strcmp(value, "never"))
+		*r = FETCH_UPDATE_HEAD_NEVER;
+	else if (!strcmp(value, "missing"))
+		*r = FETCH_UPDATE_HEAD_MISSING;
+	else if (!strcmp(value, "always"))
+		*r = FETCH_UPDATE_HEAD_ALWAYS;
+	else {
+		error(_("malformed value for %s: %s"), var, value);
+		return error(_("must be one of never, missing, or always"));
+	}
+	return 0;
+}
+
 static int handle_config(const char *key, const char *value, void *cb)
 {
 	const char *name;
@@ -418,6 +437,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 					 key, value);
 	} else if (!strcmp(subkey, "vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
+	} else if (!strcmp(subkey, "updatehead")) {
+		return parse_update_head(&remote->update_head, key, value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 3211abdf05..c16a2d7b2e 100644
--- a/remote.h
+++ b/remote.h
@@ -21,6 +21,13 @@ enum {
 	REMOTE_BRANCHES
 };
 
+enum {
+	FETCH_UPDATE_HEAD_DEFAULT = 0,
+	FETCH_UPDATE_HEAD_NEVER,
+	FETCH_UPDATE_HEAD_MISSING,
+	FETCH_UPDATE_HEAD_ALWAYS,
+};
+
 struct remote {
 	struct hashmap_entry ent;
 
@@ -62,6 +69,8 @@ struct remote {
 	int prune;
 	int prune_tags;
 
+	int update_head;
+
 	/**
 	 * The configured helper programs to run on the remote side, for
 	 * Git-native protocols.
@@ -372,4 +381,6 @@ int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
 int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 
+int parse_update_head(int *r, const char *var, const char *value);
+
 #endif
-- 
2.29.2

