Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71152C76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 02:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbjDGCht (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 22:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbjDGChn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 22:37:43 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA05590
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 19:37:41 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-17aceccdcf6so44339556fac.9
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 19:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680835059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46UzkW225IOeJaWr7DGDDkzLC8QqCkNx343T12CC1b0=;
        b=JF7kIeGdb3R2cx1tH1hJsQI5g2yKR8NGodX9DWJHb/Ze35jQfAwhMt52XjymP1MXrE
         Re17oC+UEv4KM4OVbRg9OJMJBgW/d7qtBCSurnDHufnIZfth5AZLeZUdWh6fGZlgnuHa
         p/MWo0I/9arebHwxBQGPDGoGUlxeDqCw15MyHGRzqyshwkUydwhlpaBRkUaE372djZ35
         eyyf3yA3T1mmWEtmmF1aPC+aX7AJF5eBZkr608U5JkD/CFCXVdHemt7ObJc+H6JZmbJS
         8FETUuRUvcmdUfqDaPqNbqtV7y5IJpR4B4dz+a4J4w0Jg4Eq+N3kFf9v4sRexMqU9aG/
         5fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680835059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46UzkW225IOeJaWr7DGDDkzLC8QqCkNx343T12CC1b0=;
        b=obTHYJk0SRytk6fxDDlikBnVEdt11I85EH55Isi2+5xJQsOgCTgpneRbz+kJ7J1eVM
         wJjIpeZGbhAOGSp3hvHtoKQyET6aCHOUgyLRcb+/BJ0twNUYOfc7Ib2xRwFyJHmrqriJ
         YZtOwE+HC5dPLzwE7jEpkIveZM2wHS2l2/3+3nhfprc4XAnsQyBGxARC8D4pLKciDc+D
         h0NKPzZJyXAEEyfjry0Koh9DjC7RNfpTK/dkW503Msi7zVSnW5qifK34ky7l0QQtUnRb
         n6mwdQxVBD2llRKZiSdNm5l2cLSamlo5DnC8WCfUQ79Mac70Dbvo7VJynYQMGmhMoKPS
         kb8A==
X-Gm-Message-State: AAQBX9dCQv1l053ptXfY0DhTyWBqWFz6+0stT7Ds0X9rCuVMJQlLwYeH
        LjDDfoJWdaEVwPV7GClSYO29ay5z7dA=
X-Google-Smtp-Source: AKy350bSTv/x2u8Ku2GpTQe3N8pYVnZ08ybWPQ2NSPg6ugQHPxG8jB3Z/U98aWdhlXTpsaSNZYur5w==
X-Received: by 2002:a05:6871:726:b0:17f:cf1f:9d8f with SMTP id f38-20020a056871072600b0017fcf1f9d8fmr693587oap.8.1680835059163;
        Thu, 06 Apr 2023 19:37:39 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id ee50-20020a056870c83200b0017b0e3a5af0sm1261622oab.24.2023.04.06.19.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:37:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/2] Add fetch.updateHead option
Date:   Thu,  6 Apr 2023 20:37:35 -0600
Message-Id: <20230407023736.49190-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230407023736.49190-1-felipe.contreras@gmail.com>
References: <20230407023736.49190-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/fetch.txt  |  4 ++
 Documentation/config/remote.txt |  3 ++
 builtin/fetch.c                 | 71 ++++++++++++++++++++++++++++++++-
 remote.c                        | 20 ++++++++++
 remote.h                        | 12 ++++++
 t/t5510-fetch.sh                | 31 ++++++++++++++
 6 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 568f0f75b3..dc147ffb35 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -120,3 +120,7 @@ fetch.bundleCreationToken::
 The creation token values are chosen by the provider serving the specific
 bundle URI. If you modify the URI at `fetch.bundleURI`, then be sure to
 remove the value for the `fetch.bundleCreationToken` value before fetching.
+
+fetch.updateHead::
+	Defines when to update the remote HEAD symbolic ref. Values are 'never',
+	'missing' (update only when HEAD is missing), and 'always'.
diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 0678b4bcfe..9d739d2ed4 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -86,3 +86,6 @@ remote.<name>.partialclonefilter::
 	Changing or clearing this value will only affect fetches for new commits.
 	To fetch associated objects for commits already present in the local object
 	database, use the `--refetch` option of linkgit:git-fetch[1].
+
+remote.<name>.updateHead::
+	Defines when to update the remote HEAD symbolic ref. See `fetch.updateHead`.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7221e57f35..3f7b33ba78 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -59,6 +59,8 @@ static int fetch_prune_tags_config = -1; /* unspecified */
 static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
+static enum fetch_update_head fetch_update_head = FETCH_UPDATE_HEAD_DEFAULT;
+
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
 static int write_fetch_head = 1;
 static int verbosity, deepen_relative, set_upstream, refetch;
@@ -129,6 +131,9 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.updatehead"))
+		return parse_update_head(&fetch_update_head, k, v);
+
 	return git_default_config(k, v, cb);
 }
 
@@ -1579,6 +1584,44 @@ static int backfill_tags(struct transport *transport,
 	return retcode;
 }
 
+static void update_head(int fetch_missing, const struct ref *head,
+			struct remote *remote)
+{
+	char *ref, *target;
+	const char *r;
+	int flags;
+
+	if (!head || !head->symref || !remote)
+		return;
+
+	ref = apply_refspecs(&remote->fetch, "refs/heads/HEAD");
+	target = apply_refspecs(&remote->fetch, head->symref);
+
+	if (!ref || !target) {
+		warning(_("could not update remote head"));
+		return;
+	}
+
+	r = resolve_ref_unsafe(ref, 0, NULL, &flags);
+
+	if (r) {
+		if (!fetch_missing) {
+			if (!strcmp(r, target))
+				/* already up-to-date */
+				return;
+		} else if (flags & REF_ISSYMREF)
+			/* already present */
+			return;
+	}
+
+	if (!create_symref(ref, target, "remote update head")) {
+		if (verbosity >= 0)
+			printf(_("Updated remote '%s' HEAD\n"), remote->name);
+	} else {
+		warning(_("could not update remote head"));
+	}
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs)
 {
@@ -1592,6 +1635,7 @@ static int do_fetch(struct transport *transport,
 	int must_list_refs = 1;
 	struct fetch_head fetch_head = { 0 };
 	struct strbuf err = STRBUF_INIT;
+	enum fetch_update_head update_head_config = FETCH_UPDATE_HEAD_DEFAULT;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1626,9 +1670,24 @@ static int do_fetch(struct transport *transport,
 	} else {
 		struct branch *branch = branch_get(NULL);
 
-		if (transport->remote->fetch.nr)
+		if (transport->remote->fetch.nr) {
+
+			if (transport->remote->update_head)
+				update_head_config = transport->remote->update_head;
+			else
+				update_head_config = fetch_update_head;
+
+			switch (update_head_config) {
+			case FETCH_UPDATE_HEAD_MISSING:
+			case FETCH_UPDATE_HEAD_ALWAYS:
+				strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+			default:
+				break;
+			}
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
+		}
+
 		if (branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {
 			int i;
@@ -1737,6 +1796,16 @@ static int do_fetch(struct transport *transport,
 
 	commit_fetch_head(&fetch_head);
 
+	switch (update_head_config) {
+	case FETCH_UPDATE_HEAD_MISSING:
+	case FETCH_UPDATE_HEAD_ALWAYS:
+		update_head(update_head_config == FETCH_UPDATE_HEAD_MISSING,
+			    find_ref_by_name(remote_refs, "HEAD"),
+			    transport->remote);
+	default:
+		break;
+	}
+
 	if (set_upstream) {
 		struct branch *branch = branch_get("HEAD");
 		struct ref *rm;
diff --git a/remote.c b/remote.c
index 641b083d90..c833f1b143 100644
--- a/remote.c
+++ b/remote.c
@@ -344,6 +344,24 @@ static void read_branches_file(struct remote_state *remote_state,
 	remote->fetch_tags = 1; /* always auto-follow */
 }
 
+int parse_update_head(enum fetch_update_head *r, const char *var,
+		      const char *value)
+{
+	if (!value)
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
@@ -473,6 +491,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 					 key, value);
 	} else if (!strcmp(subkey, "vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
+	} else if (!strcmp(subkey, "updatehead")) {
+		return parse_update_head(&remote->update_head, key, value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 73638cefeb..0810f55294 100644
--- a/remote.h
+++ b/remote.h
@@ -22,6 +22,13 @@ enum {
 	REMOTE_BRANCHES
 };
 
+enum fetch_update_head {
+	FETCH_UPDATE_HEAD_DEFAULT = 0,
+	FETCH_UPDATE_HEAD_NEVER,
+	FETCH_UPDATE_HEAD_MISSING,
+	FETCH_UPDATE_HEAD_ALWAYS,
+};
+
 struct rewrite {
 	const char *base;
 	size_t baselen;
@@ -97,6 +104,8 @@ struct remote {
 	int prune;
 	int prune_tags;
 
+	enum fetch_update_head update_head;
+
 	/**
 	 * The configured helper programs to run on the remote side, for
 	 * Git-native protocols.
@@ -449,4 +458,7 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 char *relative_url(const char *remote_url, const char *url,
 		   const char *up_path);
 
+int parse_update_head(enum fetch_update_head *r, const char *var,
+		      const char *value);
+
 #endif
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index dc44da9c79..dbeb2928ae 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -814,6 +814,37 @@ test_expect_success 'fetch from multiple configured URLs in single remote' '
 	git fetch multipleurls
 '
 
+test_cmp_symbolic_ref () {
+	git symbolic-ref "$1" >actual &&
+	echo "$2" >expected &&
+	test_cmp expected actual
+}
+
+test_expect_success 'updatehead' '
+	test_when_finished "rm -rf updatehead" &&
+
+	git init updatehead &&
+	(
+		cd updatehead &&
+
+		git config fetch.updateHead never &&
+		git remote add origin .. &&
+		git fetch &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/HEAD &&
+
+		git config fetch.updateHead missing &&
+		git fetch &&
+		test_cmp_symbolic_ref refs/remotes/origin/HEAD refs/remotes/origin/main &&
+		git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/side &&
+		git fetch &&
+		test_cmp_symbolic_ref refs/remotes/origin/HEAD refs/remotes/origin/side &&
+
+		git config fetch.updateHead always &&
+		git fetch &&
+		test_cmp_symbolic_ref refs/remotes/origin/HEAD refs/remotes/origin/main
+	)
+'
+
 # configured prune tests
 
 set_config_tristate () {
-- 
2.40.0+fc1

