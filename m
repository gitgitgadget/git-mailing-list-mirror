Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D46E20D0C
	for <e@80x24.org>; Fri, 16 Jun 2017 17:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbdFPRjM (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 13:39:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32984 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdFPRjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 13:39:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id x23so7262224wrb.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 10:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASWLZqJRDUS0shQ6P+aCmFdkaKqWO4Ge5rKxmDYvO9M=;
        b=rzH42YDuEZtpgQir2kkJw1aLO6gv5sd72vZJXwDr3UpNXUhupNWF3yRuwhyYXIX/AT
         rYaPzgQZyxoMiJl4P4IrvlZUJC/Os8S55bEQBFTIhFk6Nm7Wx+QkEX3XnFsmyZmAjIiX
         5OZYGPcMVqmHjFJ2bSP6sOkAHZkGbrDJBf/yDCktd6LvrXRt0YDgW896sMcIAKZzj49C
         YPirXW1SC9TI4p76A2LVzp0128rJfmqkEM5vSpAT9vi7A0nHwQHSKCkBx2u/GIDnvRVg
         sk80PSmI9ofTu55KkF0EeCGx/6boqhA6sBOeRXK4LOBFdhEvoCgQZpZdRu2F9W2e5xo9
         VJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASWLZqJRDUS0shQ6P+aCmFdkaKqWO4Ge5rKxmDYvO9M=;
        b=hjZt0h2gckG9DCff/E8n/qrTX9++bxPFRzlN9Dy/3mOxN/eg+Qr28Lp+d18dxdf610
         +hCaHmz+D+6rGfjxRbD/DsehmS8BkUJ+yXXnfP74b3hbIdT1XKMQiRmcC1ISJ+oBlqMY
         7KRvoaKVD9vPG5c3Fm3AM7B/aa77R2BEjkBQVWQggZeFVDMFV95t+ik+TyGQhLEBHD/7
         irQKrg+XcXrGUZPp9plzVGgrWuB+HPrVwzJiZJwIrs81oIRTz9qp1zmAhpVwxLuSbLkG
         lqSVzEEDdCUtJu4cKFFJXSFeyq3UOi/PBOY7LfYNQpq5OydMddjMcsAXNwnxqTJgiD9c
         ViCQ==
X-Gm-Message-State: AKS2vOz0V6OIs47TXkjtTBPbem/AUon2J2ELAjNJqK3NlDGZWoB8nWGh
        6Sm48yCSiCEigg==
X-Received: by 10.223.151.44 with SMTP id r41mr8119234wrb.6.1497634743083;
        Fri, 16 Jun 2017 10:39:03 -0700 (PDT)
Received: from localhost.localdomain (x4db0ef0e.dyn.telefonica.de. [77.176.239.14])
        by smtp.gmail.com with ESMTPSA id e14sm3785438wmi.16.2017.06.16.10.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 10:39:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv5 1/2] clone: respect additional configured fetch refspecs during initial fetch
Date:   Fri, 16 Jun 2017 19:38:48 +0200
Message-Id: <20170616173849.8071-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.1.505.g7cc9fcafb
In-Reply-To: <20170616173849.8071-1-szeder.dev@gmail.com>
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
 <20170616173849.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The initial fetch during a clone doesn't transfer refs matching
additional fetch refspecs given on the command line as configuration
variables.  This contradicts the documentation stating that
configuration variables specified via 'git clone -c <key>=<value> ...'
"take effect immediately after the repository is initialized, but
before the remote history is fetched" and the given example
specifically mentions "adding additional fetch refspecs to the origin
remote".  Furthermore, one-shot configuration variables specified via
'git -c <key>=<value> clone ...', though not written to the newly
created repository's config file, live during the lifetime of the
'clone' command, including the initial fetch.  All this implies that
any fetch refspecs specified this way should already be taken into
account during the initial fetch.

The reason for this is that the initial fetch is not a fully fledged
'git fetch' but a bunch of direct calls into the fetch/transport
machinery with clone's own refs-to-refspec matching logic, which
bypasses parts of 'git fetch' processing configured fetch refspecs.
This logic only considers a single default refspec, potentially
influenced by options like '--single-branch' and '--mirror'.  The
configured refspecs are, however, already read and parsed properly
when clone calls remote.c:remote_get(), but it never looks at the
parsed refspecs in the resulting 'struct remote'.

Modify clone to take the configured fetch refspecs into account to
retrieve all matching refs during the initial fetch.  Note that the
configuration at that point only includes the fetch refspecs specified
by the user, but it doesn't include the default fetch refspec.  Add a
function to the remote API which encapsulates adding a fetch refspec
to a 'struct remote' and parsing it, including all the necessary
memory management housekeeping as well.  Use this new function to add
clone's default fetch refspec to the other refspecs the user might
have specified.

Add tests to check that refspecs given both via 'git clone -c ...' and
'git -c ... clone' retrieve all refs matching either the default or
the additional refspecs, and that it works even when the user
specifies an alternative remote name via '--origin=<name>'.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/clone.c         | 36 +++++++++++++++++++-----------------
 remote.c                | 13 +++++++++++++
 remote.h                |  1 +
 t/t5611-clone-config.sh | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 17 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a35d62293..8a7edd4e5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -520,7 +520,7 @@ static struct ref *find_remote_branch(const struct ref *refs, const char *branch
 }
 
 static struct ref *wanted_peer_refs(const struct ref *refs,
-		struct refspec *refspec)
+		struct refspec *refspec, unsigned int refspec_nr)
 {
 	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
 	struct ref *local_refs = head;
@@ -541,13 +541,18 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 			warning(_("Could not find remote branch %s to clone."),
 				option_branch);
 		else {
-			get_fetch_map(remote_head, refspec, &tail, 0);
+			unsigned int i;
+			for (i = 0; i < refspec_nr; i++)
+				get_fetch_map(remote_head, &refspec[i], &tail, 0);
 
 			/* if --branch=tag, pull the requested tag explicitly */
 			get_fetch_map(remote_head, tag_refspec, &tail, 0);
 		}
-	} else
-		get_fetch_map(refs, refspec, &tail, 0);
+	} else {
+		unsigned int i;
+		for (i = 0; i < refspec_nr; i++)
+			get_fetch_map(refs, &refspec[i], &tail, 0);
+	}
 
 	if (!option_mirror && !option_single_branch)
 		get_fetch_map(refs, tag_refspec, &tail, 0);
@@ -848,16 +853,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *our_head_points_at;
 	struct ref *mapped_refs;
 	const struct ref *ref;
-	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
+	struct strbuf key = STRBUF_INIT;
+	struct strbuf default_refspec = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	const char *src_ref_prefix = "refs/heads/";
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
 
-	struct refspec *refspec;
-	const char *fetch_pattern;
-
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -975,7 +978,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -983,12 +985,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_reference.nr)
 		setup_reference();
 
-	fetch_pattern = value.buf;
-	refspec = parse_fetch_refspec(1, &fetch_pattern);
-
-	strbuf_reset(&value);
-
 	remote = remote_get(option_origin);
+	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
+		    branch_top.buf);
+	add_and_parse_fetch_refspec(remote,
+				    strbuf_detach(&default_refspec, NULL));
+
 	transport = transport_get(remote, remote->url[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
 	transport->family = family;
@@ -1029,7 +1031,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport);
 
 	if (refs) {
-		mapped_refs = wanted_peer_refs(refs, refspec);
+		mapped_refs = wanted_peer_refs(refs, remote->fetch,
+					       remote->fetch_refspec_nr);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
@@ -1107,9 +1110,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
-	strbuf_release(&value);
+	strbuf_release(&default_refspec);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	free(refspec);
 	return err;
 }
diff --git a/remote.c b/remote.c
index ad6c5424e..b8fd09dc9 100644
--- a/remote.c
+++ b/remote.c
@@ -626,6 +626,19 @@ struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
 	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
 }
 
+void add_and_parse_fetch_refspec(struct remote *remote, const char *refspec)
+{
+	struct refspec *rs;
+
+	add_fetch_refspec(remote, refspec);
+	rs = parse_fetch_refspec(1, &refspec);
+	REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr);
+	remote->fetch[remote->fetch_refspec_nr - 1] = *rs;
+
+	/* Not free_refspecs(), as we copied its pointers above */
+	free(rs);
+}
+
 static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 {
 	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
diff --git a/remote.h b/remote.h
index 924881169..9ad8c1085 100644
--- a/remote.h
+++ b/remote.h
@@ -164,6 +164,7 @@ struct ref *ref_remove_duplicates(struct ref *ref_map);
 
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
+void add_and_parse_fetch_refspec(struct remote *remote, const char *refspec);
 
 void free_refspec(int nr_refspec, struct refspec *refspec);
 
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index e4850b778..f240b22cc 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -37,6 +37,53 @@ test_expect_success 'clone -c config is available during clone' '
 	test_cmp expect child/file
 '
 
+test_expect_success 'clone -c remote.origin.fetch=<refspec> works' '
+	rm -rf child &&
+	git update-ref refs/grab/it refs/heads/master &&
+	git update-ref refs/leave/out refs/heads/master &&
+	git clone -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" . child &&
+	git -C child for-each-ref --format="%(refname)" >actual &&
+
+	cat >expect <<-\EOF &&
+	refs/grab/it
+	refs/heads/master
+	refs/remotes/origin/HEAD
+	refs/remotes/origin/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git -c remote.origin.fetch=<refspec> clone works' '
+	rm -rf child &&
+	git -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" clone . child &&
+	git -C child for-each-ref --format="%(refname)" >actual &&
+
+	cat >expect <<-\EOF &&
+	refs/grab/it
+	refs/heads/master
+	refs/remotes/origin/HEAD
+	refs/remotes/origin/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
+	rm -rf child &&
+	git clone --origin=upstream \
+		-c "remote.upstream.fetch=+refs/grab/*:refs/grab/*" \
+		-c "remote.origin.fetch=+refs/leave/*:refs/leave/*" \
+		. child &&
+	git -C child for-each-ref --format="%(refname)" >actual &&
+
+	cat >expect <<-\EOF &&
+	refs/grab/it
+	refs/heads/master
+	refs/remotes/upstream/HEAD
+	refs/remotes/upstream/master
+	EOF
+	test_cmp expect actual
+'
+
 # Tests for the hidden file attribute on windows
 is_hidden () {
 	# Use the output of `attrib`, ignore the absolute path
-- 
2.13.1.505.g7cc9fcafb

