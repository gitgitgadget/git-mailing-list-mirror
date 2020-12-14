Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4058CC2BB48
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAF3221FC
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408602AbgLNTR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 14:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408563AbgLNTRu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 14:17:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F668C061793
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:17:10 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id q75so16289190wme.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7o3PgJluXiGPRBDHV2enoQNF+VJXBzfVcn7w8pM0YBM=;
        b=DV4XlND7fWpHtKVzR3zGZHMV13gQnJ995GwLQxlGPZUfrCdFov9uL0fT63wvMev+eq
         jodgVMo8F4u3LQ8Skl4EiM1WuVOBMng/xlSOf6braJ7iTwbYAMVcl/gWpY9bhEowvaRS
         KGTZNLHnIUqBaMjybi+51qP/KeOIRJcutWvqmhFD91KA/o7EBE29IZfnT+9xJLkpGJLB
         gjg/5HVqThXLJ96+eAIcxsxbAbPr+8MCuy7rgK5FPxFfTIQu9/+vGPOTEfRtjJirPiPm
         cDhQiqV9chTR0SqN1VTP8zqmiCqGqM38q4lNEWSRS9w+1lRA7YUHih8RPW2O6g2aw+Of
         RnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7o3PgJluXiGPRBDHV2enoQNF+VJXBzfVcn7w8pM0YBM=;
        b=PeaUk4Dbiz3br6WzCZivDaUgMHlZdK/BqubHu3WoyxvIFMmV+YT7rTeD5E4NGjnr7e
         35btoMXTlh+6wVTEarYmqCYBzuaxwPiX4Hnx5Oe9ci4Id0w2qJGu4PrDQRf/7ro22mT0
         gV4yOHfmFyse/axKW2f2yxBf9x1bXDBOoE4QkJ51jh1nKTovkUNj9Y3YX2zQcSRx4lGb
         Vsz0BQUf42CzCWX97wzcfl7reWZbUPo84YA/IA7UnuG+XGse/zfnNvmwdyqPCkQ2K5ze
         B2yTx2nVCRd9luvz1KAl/U+K84SbE/ks2lcWvzTGQuXqQSv2NrRfok0Am1hYkH9EkT3o
         XleQ==
X-Gm-Message-State: AOAM531KGvI+ubfA7C3SwxTtv0BOaZyWJzeDlQzM1LQWXXj3+Dsbkalj
        FD7IGmqKgpmVAhbY98zDmo08hEa8N2gT7Q==
X-Google-Smtp-Source: ABdhPJxD3qW4qMfCCf2afjrZ1DVvzVWEPa9TspkBdQgRAkYIjD32GehyM16XHHzgke3jE8PtHqgDWw==
X-Received: by 2002:a7b:c7d8:: with SMTP id z24mr29396480wmk.1.1607973429032;
        Mon, 14 Dec 2020 11:17:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm32078616wmj.28.2020.12.14.11.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:17:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] refs: warn on non-pseudoref looking .git/<file> refs
Date:   Mon, 14 Dec 2020 20:17:00 +0100
Message-Id: <20201214191700.16405-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201210125321.19456-2-avarab@gmail.com>
References: <20201210125321.19456-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The refs parsing machinery will first try to parse arbitrary
.git/<name> for a given <name>, before moving onto refs/<name>,
refs/tags/<name> etc. See "ref_rev_parse_rules" in refs.c. Things that
list references such as "for-each-ref" ignore these on the assumption
that they're pseudorefs such as "HEAD".

Thus if you end up in a repository that contains e.g. .git/master the
likes of "checkout" can emit seemingly nonsensical error
messages. E.g. I happened to have a .git/master with a non-commit
SHA-1:

    $ git checkout master
    fatal: Cannot switch branch to a non-commit 'master'

Running "for-each-ref" yields only commits that could match "master",
until I realized I'd ended up with a .git/master file. Before this
we'd ignore it under a general rule that tries to ignore .git/HEAD,
.git/MERGE_HEAD and other non-pseudoref looking refs at the top-level.

Let's help the user in this case by doing a very loose check for
whether the ref name looks like a special pseudoref such as
"HEAD" (i.e. only has upper case, dashes, underbars), and if not issue
a warning:

    $ git rev-parse master
    warning: matched ref .git/master doesn't look like a pseudoref
    c87c83a2e9eb6d309913a0f59389f808024a58f9

I think it's conservative enough to just turn this on by default, but
place it under a configurable option similar to the existing
core.warnAmbiguousRefs. Running the entire test suite with "die"
instead of "warning" passes with this approach.

Our own test suite makes use of a few refs in .git/ that aren't
produced by git itself, e.g. "FOO", "TESTSYMREFTWO" etc. External
tools probably rely on this as well, so I don't think it's viable to
e.g. have a whitelist of them. That list is quite large just fr
git.git, I counted 12 names used in the C code before I abandoned that
approach.

This approach of checking the case of e.g. "master" is not an issue on
case-insensitive filesystems, since we're not checking against the
fs's version of the name, but what the user provided to git on the
command-line.

We are going to match "git rev-parse master" to e.g. .git/MASTER on
those systems, but I think that's also a case the user would like to
be warned about. I once helped a user on OSX with an issue where they
couldn't repeat a merge command on Linux, and it turned out they'd
referred to "HEAD" as "head", which we'd happily resolve to .git/HEAD
without warning on that system. Now we'll warn about that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Modified-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/core.txt | 11 ++++++++++
 cache.h                       |  1 +
 config.c                      |  5 +++++
 environment.c                 |  1 +
 refs.c                        | 12 ++++++++++
 t/t1430-bad-ref-name.sh       | 41 +++++++++++++++++++++++++++++++++++
 6 files changed, 71 insertions(+)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 160aacad84b..ecc0757cc51 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -355,6 +355,17 @@ core.warnAmbiguousRefs::
 	If true, Git will warn you if the ref name you passed it is ambiguous
 	and might match multiple refs in the repository. True by default.
 
+core.warnNonPseudoRefs::
+	If true, Git will warn you if the `<ref>` you passed
+	unexpectedly resolves to a top-level ref stored in
+	`.git/<file>` but doesn't look like a pseudoref such as
+	`HEAD`, `MERGE_HEAD` etc. True by default.
++
+These references are ignored by linkgit:for-each-ref[1], but resolved
+by linkgit:git-show[1], linkgit:git-rev-parse[1] etc. So it can be
+confusing to have e.g. an errant `.git/mybranch` being confused with
+`.git/refs/heads/mybranch`.
+
 core.compression::
 	An integer -1..9, indicating a default compression level.
 	-1 is the zlib default. 0 means no compression,
diff --git a/cache.h b/cache.h
index 8d279bc1103..1a0cc5e38a3 100644
--- a/cache.h
+++ b/cache.h
@@ -920,6 +920,7 @@ extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int warn_ambiguous_refs;
+extern int warn_non_pseudo_refs;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
diff --git a/config.c b/config.c
index 1137bd73aff..6a589a770f4 100644
--- a/config.c
+++ b/config.c
@@ -1212,6 +1212,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.warnnonpseudorefs")) {
+		warn_non_pseudo_refs = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.abbrev")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/environment.c b/environment.c
index bb518c61cd2..85a84eceaf3 100644
--- a/environment.c
+++ b/environment.c
@@ -29,6 +29,7 @@ int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
+int warn_non_pseudo_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
diff --git a/refs.c b/refs.c
index 3ec5dcba0be..634ab64cc9e 100644
--- a/refs.c
+++ b/refs.c
@@ -649,12 +649,19 @@ static int is_main_pseudoref_syntax(const char *refname)
 		is_pseudoref_syntax(refname);
 }
 
+static int is_any_pseudoref_syntax(const char *refname)
+{
+	return is_main_pseudoref_syntax(refname) ||
+		is_pseudoref_syntax(refname);
+}
+
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
 	const char **p, *r;
 	int refs_found = 0;
 	struct strbuf fullref = STRBUF_INIT;
+	static int warned_on_non_pseudo_ref;
 
 	*ref = NULL;
 	for (p = ref_rev_parse_rules; *p; p++) {
@@ -669,6 +676,11 @@ int expand_ref(struct repository *repo, const char *str, int len,
 					    fullref.buf, RESOLVE_REF_READING,
 					    this_result, &flag);
 		if (r) {
+			if (warn_non_pseudo_refs &&
+			    !strchr(r, '/') &&
+			    !is_any_pseudoref_syntax(r) &&
+			    !warned_on_non_pseudo_ref++)
+				warning(_(".git/%s doesn't look like a pseudoref"), r);
 			if (!refs_found++)
 				*ref = xstrdup(r);
 			if (!warn_ambiguous_refs)
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index c7878a60edf..782c629e473 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -374,4 +374,45 @@ test_expect_success 'branch -m can rename refs/heads/-dash' '
 	git show-ref refs/heads/dash
 '
 
+test_expect_success 'warn on non-pseudoref syntax refs in .git/' '
+	test_when_finished "
+		rm -rf .git/mybranch \
+			.git/a-dir \
+			.git/MY-BRANCH_NAME \
+			.git/MY-branch_NAME
+	" &&
+
+	# Setup
+	git rev-parse HEAD >expect &&
+	mkdir .git/a-dir &&
+
+	# We ignore anything with slashes
+	cp expect .git/a-dir/mybranch &&
+	git rev-parse a-dir/mybranch >hash 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect hash &&
+
+	# We ignore upper-case
+	cp expect .git/MY-BRANCH_NAME &&
+	git rev-parse a-dir/mybranch >hash 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect hash &&
+
+	# We ignore mixed-case
+	cp expect .git/MY-branch_NAME &&
+	git rev-parse a-dir/mybranch >hash 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect hash &&
+
+	# We do not ignore lower-case
+	cp expect .git/mybranch &&
+	env GIT_TEST_GETTEXT_POISON=false \
+		git rev-parse mybranch >hash 2>err &&
+	test_cmp expect hash &&
+	grep "like a pseudoref" err &&
+	git -c core.warnNonPseudoRefs=false rev-parse mybranch >hash 2>err &&
+	test_cmp expect hash &&
+	test_must_be_empty err
+'
+
 test_done
-- 
2.29.2.222.g5d2a92d10f8

