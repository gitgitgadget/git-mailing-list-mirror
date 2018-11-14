Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B773F1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 10:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeKNUtU (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 15:49:20 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35366 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNUtU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 15:49:20 -0500
Received: by mail-wr1-f48.google.com with SMTP id z16-v6so16744319wrv.2
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 02:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5X8F9UJbRmE/U9T2ivV+ZpJ3Rs8sPSfNqWHaXJeHptw=;
        b=WTfgT1Bb/WXscSIFgX4N8E142MClkrx0izkzadXyOjHzJXi3mj4nFgUlDeDMdayNz5
         WnTPfyFEzSjn6cb4mDI2U2yosX7AiBs423iVIGnJNZcq1VZnWxiIZ14rirPKTP64Lo4V
         PYeHjwsi4Ui1ETqAMX9YdUX0I3fwLk2NJpsZFsGtPCZXpzCuwriWUQ6swpQPKmnw10Yg
         RIqu1z6c70NxkfxmpdguG8dFwlgGDAUoC+o6Z43iBQBQN+tfx2uhudGliCMfB8GCEuGq
         ix5JfTerF8BwRkqLd1xvzfvzzOk7D0aiXCUYolIsE4TGqi8OQg3STqLNt6ysIHni4iYU
         L0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5X8F9UJbRmE/U9T2ivV+ZpJ3Rs8sPSfNqWHaXJeHptw=;
        b=o+5vmbMYm0GIYa2E3V9vPzn8CZsCtJWrWZjiX80PZtCGrK/X72G9Vg4jhM/PE5E8yh
         GiyF3I1KsIioLP2qmgvGOn+Ip6Qb7nhYyTJDUONfAJCwadoKtqwdL9CgCv91stJLkF0Z
         mH3KOgNXDfoYEWbgcYfS48C0LSikJl+75mhnSFG1iO3yaDPPWRa3P/uN1DjaHFUgMwEf
         u5rS1EtsyBX5GeYFL44G112SsIkc9vb1B9lAlkw6sIBVLRworNf7tARWJm7dlncAiBP8
         n5y3DszIGLUtvJyh5k89rqS4XFHvG4SA/lZIQolzqaO7gbN/CxBjj4DLxZ1XZgt8JRAI
         ZTpg==
X-Gm-Message-State: AGRZ1gJ1ujXDs2ex/jU6E+GNv9iawHpPJWl7ShxHxAAVMw336apr+Cbq
        P9S2DVHgE9EV/T/nRRO+p74=
X-Google-Smtp-Source: AJdET5fH1M5RJEeX0yesvOUSfc5berDjYAtdC5kw7clq63YYkVKzwyCXzbkT2PrKu6p+oxkKS2/RCg==
X-Received: by 2002:adf:84a4:: with SMTP id 33-v6mr1357503wrg.191.1542192394990;
        Wed, 14 Nov 2018 02:46:34 -0800 (PST)
Received: from localhost.localdomain (x4db1d05b.dyn.telefonica.de. [77.177.208.91])
        by smtp.gmail.com with ESMTPSA id p188-v6sm11274079wmp.31.2018.11.14.02.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 02:46:34 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] clone: respect additional configured fetch refspecs during initial fetch
Date:   Wed, 14 Nov 2018 11:46:19 +0100
Message-Id: <20181114104620.32478-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.gbfcc7ed3e6
In-Reply-To: <20181114104620.32478-1-szeder.dev@gmail.com>
References: <20181114104620.32478-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The initial fetch during a clone doesn't transfer refs matching
additional fetch refspecs given on the command line as configuration
variables, e.g. '-c remote.origin.fetch=<refspec>'.  This contradicts
the documentation stating that configuration variables specified via
'git clone -c <key>=<value> ...' "take effect immediately after the
repository is initialized, but before the remote history is fetched"
and the given example specifically mentions "adding additional fetch
refspecs to the origin remote".  Furthermore, one-shot configuration
variables specified via 'git -c <key>=<value> clone ...', though not
written to the newly created repository's config file, live during the
lifetime of the 'clone' command, including the initial fetch.  All
this implies that any fetch refspecs specified this way should already
be taken into account during the initial fetch.

The reason for this is that the initial fetch is not a fully fledged
'git fetch' but a bunch of direct calls into the fetch/transport
machinery with clone's own refs-to-refspec matching logic, which
bypasses parts of 'git fetch' processing configured fetch refspecs.
This logic only considers a single default refspec, potentially
influenced by options like '--single-branch' and '--mirror'.  The
configured refspecs are, however, already read and parsed properly
when clone calls remote.c:remote_get(), but it never looks at the
parsed refspecs in the resulting 'struct remote'.

Modify clone to take the remote's configured fetch refspecs into
account to retrieve all matching refs during the initial fetch.  Note
that we have to explicitly add the default fetch refspec to the
remote's refspecs, because at that point the remote only includes the
fetch refspecs specified on the command line.

Add tests to check that refspecs given both via 'git clone -c ...' and
'git -c ... clone' retrieve all refs matching either the default or
the additional refspecs, and that it works even when the user
specifies an alternative remote name via '--origin=<name>'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/clone.c         | 25 +++++++++++++---------
 t/t5611-clone-config.sh | 47 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ae1bf242c6..7c7f98c72c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -548,7 +548,7 @@ static struct ref *find_remote_branch(const struct ref *refs, const char *branch
 }
 
 static struct ref *wanted_peer_refs(const struct ref *refs,
-		struct refspec_item *refspec)
+		struct refspec *refspec)
 {
 	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
 	struct ref *local_refs = head;
@@ -569,13 +569,19 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 			warning(_("Could not find remote branch %s to clone."),
 				option_branch);
 		else {
-			get_fetch_map(remote_head, refspec, &tail, 0);
+			int i;
+			for (i = 0; i < refspec->nr; i++)
+				get_fetch_map(remote_head, &refspec->items[i],
+					      &tail, 0);
 
 			/* if --branch=tag, pull the requested tag explicitly */
 			get_fetch_map(remote_head, tag_refspec, &tail, 0);
 		}
-	} else
-		get_fetch_map(refs, refspec, &tail, 0);
+	} else {
+		int i;
+		for (i = 0; i < refspec->nr; i++)
+			get_fetch_map(refs, &refspec->items[i], &tail, 0);
+	}
 
 	if (!option_mirror && !option_single_branch && !option_no_tags)
 		get_fetch_map(refs, tag_refspec, &tail, 0);
@@ -899,7 +905,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
 
-	struct refspec rs = REFSPEC_INIT_FETCH;
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	fetch_if_missing = 0;
@@ -1081,11 +1086,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
+	remote = remote_get(option_origin);
+
 	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
 		    branch_top.buf);
-	refspec_append(&rs, default_refspec.buf);
+	refspec_append(&remote->fetch, default_refspec.buf);
 
-	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
 	transport->family = family;
@@ -1140,7 +1146,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 
 	argv_array_push(&ref_prefixes, "HEAD");
-	refspec_ref_prefixes(&rs, &ref_prefixes);
+	refspec_ref_prefixes(&remote->fetch, &ref_prefixes);
 	if (option_branch)
 		expand_ref_prefix(&ref_prefixes, option_branch);
 	if (!option_no_tags)
@@ -1149,7 +1155,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport, &ref_prefixes);
 
 	if (refs) {
-		mapped_refs = wanted_peer_refs(refs, &rs.items[0]);
+		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
@@ -1243,7 +1249,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&default_refspec);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	refspec_clear(&rs);
 	argv_array_clear(&ref_prefixes);
 	return err;
 }
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 39329eb7a8..60c1ba951b 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -45,6 +45,53 @@ test_expect_success 'clone -c config is available during clone' '
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
+		  -c "remote.upstream.fetch=+refs/grab/*:refs/grab/*" \
+		  -c "remote.origin.fetch=+refs/leave/*:refs/leave/*" \
+		  . child &&
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
2.19.1.1182.gbfcc7ed3e6

