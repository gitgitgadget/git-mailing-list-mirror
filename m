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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94BCC433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 12:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8157623D57
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 12:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbgLJMyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 07:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbgLJMyV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 07:54:21 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09039C0613D6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 04:53:41 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e25so5199013wme.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/sfCrbK9xwPJXtS/ASylJcameraHGKJp80VTu/Fvqw0=;
        b=fk/JkqzdCEtAzqzoiKibCqw4efPBKBPPLCQ/4zs4rFoN51ogiKsMQUWY3CjACbu7go
         T1KMcyoF8QCoJ6kXz2fay+UJx+rW612kaG7i4yiOZylLFgEGZuuTdeQ2CdTMMTdPn2yI
         0tVFgAgwyCDiKawGGaJz5gKxDuSERK55NBzVMwP83LwRsD4e3y9yy7VEagmC8JJ//mmS
         9z8HaX8GgEp0nDsiIVMoD9ZJwbkkkxBtO/TqI5GGBZjS7MIVorTvnugiQCCAQa48P9YG
         tcooEp/LYMkmgl4MhgEl9ASC9QQjTBgu9XdfJB/OdUfXaIlxMqME3BPEwmzObBoqTpE+
         KU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sfCrbK9xwPJXtS/ASylJcameraHGKJp80VTu/Fvqw0=;
        b=ZSW+xtgJAJ1gHRr7Ua20yCdGA3KSLWhrBbqjZfDipZngo+BnHdR/rVVhg83MHqLKkB
         s07rCZw2JRFbiDhKESL+3NBP4s7tuqqml2+kbgDUUiwi+Ch3R5gaVM39S8Z5WWHguQMY
         UrMQuUKvwb72kAz+oe9xE5dwvWGPEcgHP8WeaRCDipyZv2iVZxujfYJhUKNOSqG1Div0
         aEUNwAc793hSN2l2SDD68UUz8FI+B8pSFdEF4QXNpgSYDxie4btZgJxoCCHIbZSLCp3g
         lO40nmYmdltU+9+VUGjTalxB52fpdASChPptR9pgpbjNYo2Cz+MQcDPuHYO1Iv7eDVhe
         qbAw==
X-Gm-Message-State: AOAM533kWP/LhJFNq1Lg7JRGHpEJy4lD2Q2eTv6jJCNZ4EWU/NpwxE8B
        O/ulqmIl9ofKkzKTxehgAHC4GxcS2gLjUg==
X-Google-Smtp-Source: ABdhPJzPh6x8lKDoFBbi8xq3DjJ+Ehd0+Y/FMrdpqGnoZYtL1ygqRnM+Z3ZY1nmSRcAdrX1iutxaXQ==
X-Received: by 2002:a1c:2d47:: with SMTP id t68mr8249997wmt.148.1607604819643;
        Thu, 10 Dec 2020 04:53:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w17sm9387583wru.82.2020.12.10.04.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 04:53:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] refs: warn on non-pseudoref looking .git/<file> refs
Date:   Thu, 10 Dec 2020 13:53:21 +0100
Message-Id: <20201210125321.19456-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201210125321.19456-1-avarab@gmail.com>
References: <20201210125321.19456-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The refs parsing machinery will first try to parse arbitrary
.git/<name> for a given <name>, before moving onto refs/<name>,
refs/tags/<name> etc. See "ref_rev_parse_rules" in refs.c, but
e.g. "for-each-ref" and other things that list references ignore these
ancient-style refs.

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
whether the ref name looks like a pseudoref such as "HEAD" (i.e. only
has upper case, dashes, underbars), and if not issue a warning:

    $ git rev-parse master
    warning: matched ref .git/master doesn't look like a pseudoref
    c87c83a2e9eb6d309913a0f59389f808024a58f9

I think it's conservative enough to just turn this on by default, but
place it under a configurable option similar to the existing
core.warnAmbiguousRefs. Running the entire test suite with "die"
instead of "warning" passes with this approach.

Our own test suite makes use of a few refs in .git/ that aren't
produced by git itself, e.g. "FOO", "TESTSYMREFTWO" etc, external
tools probably rely on this as well, so I don't think it's viable to
e.g. have a whitelist of "HEAD", "MERGE_HEAD" etc. As an aside that
list is quite large, I counted 12 names used in the C code before I
abandoned that approach.

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
---
 Documentation/config/core.txt | 11 ++++++++++
 cache.h                       |  1 +
 config.c                      |  5 +++++
 environment.c                 |  1 +
 refs.c                        | 20 +++++++++++++++++
 t/t1430-bad-ref-name.sh       | 41 +++++++++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 160aacad84b..535a7012156 100644
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
+confusing to have e.g. an errant `.git/master` being confused with
+`.git/refs/heads/master`.
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
index 3ec5dcba0be..0beeb3dded8 100644
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
@@ -669,6 +676,19 @@ int expand_ref(struct repository *repo, const char *str, int len,
 					    fullref.buf, RESOLVE_REF_READING,
 					    this_result, &flag);
 		if (r) {
+			if (warn_non_pseudo_refs &&
+			    !starts_with(fullref.buf, "refs/") &&
+			    !starts_with(r, "refs/") &&
+			    !strchr(r, '/') &&
+			    !is_any_pseudoref_syntax(r) &&
+			    !warned_on_non_pseudo_ref++) {
+				/*
+				 * TRANSLATORS: The 1st argument is
+				 * e.g. "master", and the 2nd can be
+				 * e.g. "master~10".
+				 */
+				warning(_("matched ref name .git/%s doesn't look like a pseudoref"), r);
+			}
 			if (!refs_found++)
 				*ref = xstrdup(r);
 			if (!warn_ambiguous_refs)
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index c7878a60edf..2c8c2c15c40 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -374,4 +374,45 @@ test_expect_success 'branch -m can rename refs/heads/-dash' '
 	git show-ref refs/heads/dash
 '
 
+test_expect_success 'warn on non-pseudoref syntax refs in .git/' '
+	test_when_finished "
+		rm -f .git/mybranch &&
+		rm -rf .git/a-dir &&
+		rm -rf .git/MY-BRANCH_NAME &&
+		rm -rf .git/MY-branch_NAME
+	" &&
+
+	# Setup
+	git rev-parse master >expect &&
+
+	# We ignore anything with slashes
+	mkdir .git/a-dir &&
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
+	git rev-parse mybranch >hash 2>err &&
+	test_cmp expect hash &&
+	GIT_TEST_GETTEXT_POISON=false grep "like a pseudoref" err &&
+	git -c core.warnNonPseudoRefs=false rev-parse mybranch >hash 2>err &&
+	test_cmp expect hash &&
+	test_must_be_empty err &&
+	rm .git/mybranch
+'
+
 test_done
-- 
2.29.2.222.g5d2a92d10f8

