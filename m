Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4F8C2D0C3
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 00:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E44206C3
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 00:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="Nhqxs/sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLVAbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 19:31:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36549 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLVAbd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 19:31:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so4959656plm.3
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 16:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWenhBghHtBOrw1rkmz/LlYiIfIcGKg35r0LrerSTNQ=;
        b=Nhqxs/spxKNFK0i287rv80ZdteID5Cs0MLqK/HlLTa75KTOM+ClTpSVuvgT6fFhUPH
         DmeipZeL1WRHmHhnYb18Q30EXxmKmgsX1aQvTSOoNX8k3Xr280NpvAPbK6nI+1zGeKke
         E5vECTz3RnFNJAEHZZy1p1NK05K9JxAcXJBTALmRVe1T95AFzzGzpt+a98XEBLt1FzSS
         20tX7D6qkaKm4E9Q4sl05EQB8ZYCmMCKJZjpoLR9qHvrNa5u1n82xbiLJHUD2sUMl22b
         qMFwzfTn5hVCG+VjeL/Aceaf9qnR6Uzw6GOhL79ZBljDWKXtoUkHy0M7hqk1yGt0jMcP
         1ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWenhBghHtBOrw1rkmz/LlYiIfIcGKg35r0LrerSTNQ=;
        b=MV8fj8IvopOCaeSw0LBvFofsH45gNO617yJL/uWp6fzfeGp7KTDKFKkH7s6K/7YRp8
         stV74krJJPwkGOdyj9dceHvtWSDFe88rzxpDHBLVMgthgQ+Og9tb4D4iFpE1rccXJr92
         Wa6EQnJ18fVrr5ur3T9cMJxHWWJoPNOxPrrbn9Y9Adhq59h3k5l2bPqLa77GltwAwai8
         2wpvf/yQ5dasC3eAFRf8E0sATpwJrhl/SWaOIc8ukowBBIMpTzwWU/ZP2WgYw5MZcjjm
         CYTkCIgh5tzT1DrO6vTaghpItxcCpHVUqalTd+V0/nbVF08kp8sc2XdU5QsoawN5AZSH
         60ng==
X-Gm-Message-State: APjAAAX+hwjXXIlTXf+TNLGxgevS9YHL3VfvrzVIImQ4nMjjPR/pAT9r
        01KBtmwXKmMYKKCh+9y+GDjB/4CiHJg=
X-Google-Smtp-Source: APXvYqz4eSTDptv/Tcb+qk0p3kUXMykq14k+OlGjh0nn8B97gmZJ1Mcnhpw6raX7qOxMeiNbs7faEg==
X-Received: by 2002:a17:902:b90c:: with SMTP id bf12mr23031853plb.286.1576974691529;
        Sat, 21 Dec 2019 16:31:31 -0800 (PST)
Received: from localhost ([203.144.80.234])
        by smtp.gmail.com with ESMTPSA id k21sm4642486pfa.63.2019.12.21.16.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 16:31:31 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v2 1/1] gpg-interface: add minTrustLevel as a configuration option
Date:   Sun, 22 Dec 2019 00:31:23 +0000
Message-Id: <20191222003123.10555-2-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191222003123.10555-1-hji@dyntopia.com>
References: <20191219000140.9056-1-hji@dyntopia.com>
 <20191222003123.10555-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, signature verification for merge and pull operations checked
if the key had a trust-level of either TRUST_NEVER or TRUST_UNDEFINED in
verify_merge_signature().  If that was the case, the process die()d.

The other code paths that did signature verification relied entirely on
the return code from check_commit_signature().  And signatures made with
a good key, irregardless of its trust level, was considered valid by
check_commit_signature().

This difference in behavior might induce users to erroneously assume
that the trust level of a key in their keyring is always considered by
Git, even for operations where it is not (e.g. during a verify-commit or
verify-tag).

The way it worked was by gpg-interface.c storing the result from the
key/signature status *and* the lowest-two trust levels in the `result`
member of the signature_check structure (the last of these status lines
that were encountered got written to `result`).  These are documented in
GPG under the subsection `General status codes` and `Key related`,
respectively [1].

The GPG documentation says the following on the TRUST_ status codes [1]:

    """
    These are several similar status codes:

    - TRUST_UNDEFINED <error_token>
    - TRUST_NEVER     <error_token>
    - TRUST_MARGINAL  [0  [<validation_model>]]
    - TRUST_FULLY     [0  [<validation_model>]]
    - TRUST_ULTIMATE  [0  [<validation_model>]]

    For good signatures one of these status lines are emitted to
    indicate the validity of the key used to create the signature.
    The error token values are currently only emitted by gpgsm.
    """

My interpretation is that the trust level is conceptionally different
from the validity of the key and/or signature.  That seems to also have
been the assumption of the old code in check_signature() where a result
of 'G' (as in GOODSIG) and 'U' (as in TRUST_NEVER or TRUST_UNDEFINED)
were both considered a success.

The two cases where a result of 'U' had special meaning were in
verify_merge_signature() (where this caused git to die()) and in
format_commit_one() (where it affected the output of the %G? format
specifier).

I think it makes sense to refactor the processing of TRUST_ status lines
such that users can configure a minimum trust level that is enforced
globally, rather than have individual parts of git (e.g. merge) do it
themselves (except for a grace period with backward compatibility).

I also think it makes sense to not store the trust level in the same
struct member as the key/signature status.  While the presence of a
TRUST_ status code does imply that the signature is good (see the first
paragraph in the included snippet above), as far as I can tell, the
order of the status lines from GPG isn't well-defined; thus it would
seem plausible that the trust level could be overwritten with the
key/signature status if they were stored in the same member of the
signature_check structure.

This patch introduces a new configuration option: gpg.minTrustLevel.  It
consolidates trust-level verification to gpg-interface.c and adds a new
`trust_level` member to the signature_check structure.

Backward-compatibility is maintained by introducing a special case in
verify_merge_signature() such that if no user-configurable
gpg.minTrustLevel is set, then the old behavior of rejecting
TRUST_UNDEFINED and TRUST_NEVER is enforced.  If, on the other hand,
gpg.minTrustLevel is set, then that value overrides the old behavior.

Similarly, the %G? format specifier will continue show 'U' for
signatures made with a key that has a trust level of TRUST_UNDEFINED or
TRUST_NEVER, even though the 'U' character no longer exist in the
`result` member of the signature_check structure.  A new format
specifier, %GT, is also introduced for users that want to show all
possible trust levels for a signature.

Another approach would have been to simply drop the trust-level
requirement in verify_merge_signature().  This would also have made the
behavior consistent with other parts of git that perform signature
verification.  However, requiring a minimum trust level for signing keys
does seem to have a real-world use-case.  For example, the build system
used by the Qubes OS project currently parses the raw output from
verify-tag in order to assert a minimum trust level for keys used to
sign git tags [2].

[1] https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/doc/DETAILS;h=bd00006e933ac56719b1edd2478ecd79273eae72;hb=refs/heads/master
[2] https://github.com/QubesOS/qubes-builder/blob/9674c1991deef45b1a1b1c71fddfab14ba50dccf/scripts/verify-git-tag#L43

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 Documentation/config/gpg.txt       | 15 +++++
 Documentation/pretty-formats.txt   |  1 +
 builtin/merge.c                    |  9 ++-
 builtin/pull.c                     | 13 ++++-
 commit.c                           | 12 ++--
 commit.h                           | 12 +++-
 gpg-interface.c                    | 93 ++++++++++++++++++++++++++----
 gpg-interface.h                    | 10 +++-
 pretty.c                           | 30 +++++++++-
 t/t5573-pull-verify-signatures.sh  | 64 ++++++++++++++++++++
 t/t7030-verify-tag.sh              | 24 ++++++++
 t/t7510-signed-commit.sh           | 39 +++++++++++++
 t/t7612-merge-verify-signatures.sh | 22 +++++++
 13 files changed, 321 insertions(+), 23 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index cce2c89245..d94025cb36 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -18,3 +18,18 @@ gpg.<format>.program::
 	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
 	be used as a legacy synonym for `gpg.openpgp.program`. The default
 	value for `gpg.x509.program` is "gpgsm".
+
+gpg.minTrustLevel::
+	Specifies a minimum trust level for signature verification.  If
+	this option is unset, then signature verification for merge
+	operations require a key with at least `marginal` trust.  Other
+	operations that perform signature verification require a key
+	with at least `undefined` trust.  Setting this option overrides
+	the required trust-level for all operations.  Supported values,
+	in increasing order of significance:
++
+* `undefined`
+* `never`
+* `marginal`
+* `fully`
+* `ultimate`
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1a7212ce5a..a4b6f49186 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -226,6 +226,7 @@ endif::git-rev-list[]
 '%GF':: show the fingerprint of the key used to sign a signed commit
 '%GP':: show the fingerprint of the primary key whose subkey was used
 	to sign a signed commit
+'%GT':: show the trust level for the key used to sign a signed commit
 '%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
 	minutes ago}`; the format follows the rules described for the
 	`-g` option. The portion before the `@` is the refname as
diff --git a/builtin/merge.c b/builtin/merge.c
index 062e911441..d127d2225f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -62,6 +62,7 @@ static int show_diffstat = 1, shortlog_len = -1, squash;
 static int option_commit = -1;
 static int option_edit = -1;
 static int allow_trivial = 1, have_message, verify_signatures;
+static int check_trust_level = 1;
 static int overwrite_ignore = 1;
 static struct strbuf merge_msg = STRBUF_INIT;
 static struct strategy **use_strategies;
@@ -631,6 +632,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	} else if (!strcmp(k, "commit.gpgsign")) {
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
+	} else if (!strcmp(k, "gpg.mintrustlevel")) {
+		check_trust_level = 0;
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
@@ -1397,7 +1400,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die(_("Can merge only exactly one commit into empty head"));
 
 		if (verify_signatures)
-			verify_merge_signature(remoteheads->item, verbosity);
+			verify_merge_signature(remoteheads->item, verbosity,
+					       check_trust_level);
 
 		remote_head_oid = &remoteheads->item->object.oid;
 		read_empty(remote_head_oid, 0);
@@ -1420,7 +1424,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (verify_signatures) {
 		for (p = remoteheads; p; p = p->next) {
-			verify_merge_signature(p->item, verbosity);
+			verify_merge_signature(p->item, verbosity,
+					       check_trust_level);
 		}
 	}
 
diff --git a/builtin/pull.c b/builtin/pull.c
index d25ff13a60..d4e3e77c8e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -107,6 +107,7 @@ static char *opt_ff;
 static char *opt_verify_signatures;
 static int opt_autostash = -1;
 static int config_autostash;
+static int check_trust_level = 1;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
 static char *opt_gpg_sign;
@@ -355,6 +356,8 @@ static enum rebase_type config_get_rebase(void)
  */
 static int git_pull_config(const char *var, const char *value, void *cb)
 {
+	int status;
+
 	if (!strcmp(var, "rebase.autostash")) {
 		config_autostash = git_config_bool(var, value);
 		return 0;
@@ -362,7 +365,14 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 		recurse_submodules = git_config_bool(var, value) ?
 			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
 		return 0;
+	} else if (!strcmp(var, "gpg.mintrustlevel")) {
+		check_trust_level = 0;
 	}
+
+	status = git_gpg_config(var, value, cb);
+	if (status)
+		return status;
+
 	return git_default_config(var, value, cb);
 }
 
@@ -587,7 +597,8 @@ static int pull_into_void(const struct object_id *merge_head,
 			die(_("unable to access commit %s"),
 			    oid_to_hex(merge_head));
 
-		verify_merge_signature(commit, opt_verbosity);
+		verify_merge_signature(commit, opt_verbosity,
+				       check_trust_level);
 	}
 
 	/*
diff --git a/commit.c b/commit.c
index 434ec030d6..3f91d3efc5 100644
--- a/commit.c
+++ b/commit.c
@@ -1136,21 +1136,23 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 	return ret;
 }
 
-void verify_merge_signature(struct commit *commit, int verbosity)
+void verify_merge_signature(struct commit *commit, int verbosity,
+			    int check_trust)
 {
 	char hex[GIT_MAX_HEXSZ + 1];
 	struct signature_check signature_check;
+	int ret;
 	memset(&signature_check, 0, sizeof(signature_check));
 
-	check_commit_signature(commit, &signature_check);
+	ret = check_commit_signature(commit, &signature_check);
 
 	find_unique_abbrev_r(hex, &commit->object.oid, DEFAULT_ABBREV);
 	switch (signature_check.result) {
 	case 'G':
+		if (ret || (check_trust && signature_check.trust_level < TRUST_MARGINAL))
+			die(_("Commit %s has an untrusted GPG signature, "
+			      "allegedly by %s."), hex, signature_check.signer);
 		break;
-	case 'U':
-		die(_("Commit %s has an untrusted GPG signature, "
-		      "allegedly by %s."), hex, signature_check.signer);
 	case 'B':
 		die(_("Commit %s has a bad GPG signature "
 		      "allegedly by %s."), hex, signature_check.signer);
diff --git a/commit.h b/commit.h
index 221cdaa34b..008a0fa4a0 100644
--- a/commit.h
+++ b/commit.h
@@ -383,8 +383,18 @@ int compare_commits_by_author_date(const void *a_, const void *b_, void *unused)
  * Verify a single commit with check_commit_signature() and die() if it is not
  * a good signature. This isn't really suitable for general use, but is a
  * helper to implement consistent logic for pull/merge --verify-signatures.
+ *
+ * The check_trust parameter is meant for backward-compatibility.  The GPG
+ * interface verifies key trust with a default trust level that is below the
+ * default trust level for merge operations.  Its value should be non-zero if
+ * the user hasn't set a minimum trust level explicitly in their configuration.
+ *
+ * If the user has set a minimum trust level, then that value should be obeyed
+ * and check_trust should be zero, even if the configured trust level is below
+ * the default trust level for merges.
  */
-void verify_merge_signature(struct commit *commit, int verbose);
+void verify_merge_signature(struct commit *commit, int verbose,
+			    int check_trust);
 
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
diff --git a/gpg-interface.c b/gpg-interface.c
index 5134ce2780..b7cd8bc073 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,6 +7,8 @@
 #include "tempfile.h"
 
 static char *configured_signing_key;
+static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
+
 struct gpg_format {
 	const char *name;
 	const char *program;
@@ -85,6 +87,8 @@ void signature_check_clear(struct signature_check *sigc)
 #define GPG_STATUS_UID		(1<<2)
 /* The status includes key fingerprints */
 #define GPG_STATUS_FINGERPRINT	(1<<3)
+/* The status includes trust level */
+#define GPG_STATUS_TRUST_LEVEL	(1<<4)
 
 /* Short-hand for standard exclusive *SIG status with keyid & UID */
 #define GPG_STATUS_STDSIG	(GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID|GPG_STATUS_UID)
@@ -96,13 +100,23 @@ static struct {
 } sigcheck_gpg_status[] = {
 	{ 'G', "GOODSIG ", GPG_STATUS_STDSIG },
 	{ 'B', "BADSIG ", GPG_STATUS_STDSIG },
-	{ 'U', "TRUST_NEVER", 0 },
-	{ 'U', "TRUST_UNDEFINED", 0 },
 	{ 'E', "ERRSIG ", GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID },
 	{ 'X', "EXPSIG ", GPG_STATUS_STDSIG },
 	{ 'Y', "EXPKEYSIG ", GPG_STATUS_STDSIG },
 	{ 'R', "REVKEYSIG ", GPG_STATUS_STDSIG },
 	{ 0, "VALIDSIG ", GPG_STATUS_FINGERPRINT },
+	{ 0, "TRUST_", GPG_STATUS_TRUST_LEVEL },
+};
+
+static struct {
+	const char *key;
+	enum signature_trust_level value;
+} sigcheck_gpg_trust_level[] = {
+	{ "UNDEFINED", TRUST_UNDEFINED },
+	{ "NEVER", TRUST_NEVER },
+	{ "MARGINAL", TRUST_MARGINAL },
+	{ "FULLY", TRUST_FULLY },
+	{ "ULTIMATE", TRUST_ULTIMATE },
 };
 
 static void replace_cstring(char **field, const char *line, const char *next)
@@ -115,10 +129,25 @@ static void replace_cstring(char **field, const char *line, const char *next)
 		*field = NULL;
 }
 
+static int parse_gpg_trust_level(const char *level,
+				 enum signature_trust_level *res)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_trust_level); i++) {
+		if (!strcmp(sigcheck_gpg_trust_level[i].key, level)) {
+			*res = sigcheck_gpg_trust_level[i].value;
+			return 0;
+		}
+	}
+	return 1;
+}
+
 static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
 	const char *line, *next;
+	char *trust;
 	int i, j;
 	int seen_exclusive_status = 0;
 
@@ -136,9 +165,18 @@ static void parse_gpg_output(struct signature_check *sigc)
 		/* Iterate over all search strings */
 		for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 			if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
+				/*
+				 * GOODSIG, BADSIG etc. can occur only once for
+				 * each signature.  Therefore, if we had more
+				 * than one then we're dealing with multiple
+				 * signatures.  We don't support them
+				 * currently, and they're rather hard to
+				 * create, so something is likely fishy and we
+				 * should reject them altogether.
+				 */
 				if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE) {
 					if (seen_exclusive_status++)
-						goto found_duplicate_status;
+						goto error;
 				}
 
 				if (sigcheck_gpg_status[i].result)
@@ -154,6 +192,26 @@ static void parse_gpg_output(struct signature_check *sigc)
 						replace_cstring(&sigc->signer, line, next);
 					}
 				}
+
+				/* Do we have trust level? */
+				if (sigcheck_gpg_status[i].flags & GPG_STATUS_TRUST_LEVEL) {
+					/*
+					 * GPG v1 and v2 differs in how the
+					 * TRUST_ lines are written.  Some
+					 * trust lines contain no additional
+					 * space-separated information for v1.
+					 */
+					next = strchr(line, ' ');
+					if (!next)
+						next = strchrnul(line, '\n');
+					trust = xmemdupz(line, next - line);
+					if (parse_gpg_trust_level(trust, &sigc->trust_level)) {
+						free(trust);
+						goto error;
+					}
+					free(trust);
+				}
+
 				/* Do we have fingerprint? */
 				if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
 					const char *limit;
@@ -191,14 +249,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 	}
 	return;
 
-found_duplicate_status:
-	/*
-	 * GOODSIG, BADSIG etc. can occur only once for each signature.
-	 * Therefore, if we had more than one then we're dealing with multiple
-	 * signatures.  We don't support them currently, and they're rather
-	 * hard to create, so something is likely fishy and we should reject
-	 * them altogether.
-	 */
+error:
 	sigc->result = 'E';
 	/* Clear partial data to avoid confusion */
 	FREE_AND_NULL(sigc->primary_key_fingerprint);
@@ -264,6 +315,7 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 	int status;
 
 	sigc->result = 'N';
+	sigc->trust_level = -1;
 
 	status = verify_signed_buffer(payload, plen, signature, slen,
 				      &gpg_output, &gpg_status);
@@ -273,7 +325,8 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
 	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
 	parse_gpg_output(sigc);
-	status |= sigc->result != 'G' && sigc->result != 'U';
+	status |= sigc->result != 'G';
+	status |= sigc->trust_level < configured_min_trust_level;
 
  out:
 	strbuf_release(&gpg_status);
@@ -320,6 +373,8 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 {
 	struct gpg_format *fmt = NULL;
 	char *fmtname = NULL;
+	char *trust;
+	int ret;
 
 	if (!strcmp(var, "user.signingkey")) {
 		if (!value)
@@ -339,6 +394,20 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "gpg.mintrustlevel")) {
+		if (!value)
+			return config_error_nonbool(var);
+
+		trust = xstrdup_toupper(value);
+		ret = parse_gpg_trust_level(trust, &configured_min_trust_level);
+		free(trust);
+
+		if (ret)
+			return error("unsupported value for %s: %s", var,
+				     value);
+		return 0;
+	}
+
 	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
 		fmtname = "openpgp";
 
diff --git a/gpg-interface.h b/gpg-interface.h
index 93cc3aff5c..f4e9b4f371 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -7,6 +7,14 @@ struct strbuf;
 #define GPG_VERIFY_RAW			2
 #define GPG_VERIFY_OMIT_STATUS	4
 
+enum signature_trust_level {
+	TRUST_UNDEFINED,
+	TRUST_NEVER,
+	TRUST_MARGINAL,
+	TRUST_FULLY,
+	TRUST_ULTIMATE,
+};
+
 struct signature_check {
 	char *payload;
 	char *gpg_output;
@@ -16,7 +24,6 @@ struct signature_check {
 	 * possible "result":
 	 * 0 (not checked)
 	 * N (checked but no further result)
-	 * U (untrusted good)
 	 * G (good)
 	 * B (bad)
 	 */
@@ -25,6 +32,7 @@ struct signature_check {
 	char *key;
 	char *fingerprint;
 	char *primary_key_fingerprint;
+	enum signature_trust_level trust_level;
 };
 
 void signature_check_clear(struct signature_check *sigc);
diff --git a/pretty.c b/pretty.c
index 305e903192..f5fbbc5ffb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1311,9 +1311,18 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		case '?':
 			switch (c->signature_check.result) {
 			case 'G':
+				switch (c->signature_check.trust_level) {
+				case TRUST_UNDEFINED:
+				case TRUST_NEVER:
+					strbuf_addch(sb, 'U');
+					break;
+				default:
+					strbuf_addch(sb, 'G');
+					break;
+				}
+				break;
 			case 'B':
 			case 'E':
-			case 'U':
 			case 'N':
 			case 'X':
 			case 'Y':
@@ -1337,6 +1346,25 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			if (c->signature_check.primary_key_fingerprint)
 				strbuf_addstr(sb, c->signature_check.primary_key_fingerprint);
 			break;
+		case 'T':
+			switch (c->signature_check.trust_level) {
+			case TRUST_UNDEFINED:
+				strbuf_addstr(sb, "undefined");
+				break;
+			case TRUST_NEVER:
+				strbuf_addstr(sb, "never");
+				break;
+			case TRUST_MARGINAL:
+				strbuf_addstr(sb, "marginal");
+				break;
+			case TRUST_FULLY:
+				strbuf_addstr(sb, "fully");
+				break;
+			case TRUST_ULTIMATE:
+				strbuf_addstr(sb, "ultimate");
+				break;
+			}
+			break;
 		default:
 			return 0;
 		}
diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
index 3e9876e197..a53dd8550d 100755
--- a/t/t5573-pull-verify-signatures.sh
+++ b/t/t5573-pull-verify-signatures.sh
@@ -60,6 +60,27 @@ test_expect_success GPG 'pull commit with untrusted signature with --verify-sign
 	test_i18ngrep "has an untrusted GPG signature" pullerror
 '
 
+test_expect_success GPG 'pull commit with untrusted signature with --verify-signatures and minTrustLevel=ultimate' '
+	test_when_finished "git reset --hard && git checkout initial" &&
+	test_config gpg.minTrustLevel ultimate &&
+	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pullerror &&
+	test_i18ngrep "has an untrusted GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull commit with untrusted signature with --verify-signatures and minTrustLevel=marginal' '
+	test_when_finished "git reset --hard && git checkout initial" &&
+	test_config gpg.minTrustLevel marginal &&
+	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pullerror &&
+	test_i18ngrep "has an untrusted GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull commit with untrusted signature with --verify-signatures and minTrustLevel=undefined' '
+	test_when_finished "git reset --hard && git checkout initial" &&
+	test_config gpg.minTrustLevel undefined &&
+	git pull --ff-only --verify-signatures untrusted >pulloutput &&
+	test_i18ngrep "has a good GPG signature" pulloutput
+'
+
 test_expect_success GPG 'pull signed commit with --verify-signatures' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	git pull --verify-signatures signed >pulloutput &&
@@ -79,10 +100,53 @@ test_expect_success GPG 'pull commit with bad signature with --no-verify-signatu
 '
 
 test_expect_success GPG 'pull unsigned commit into unborn branch' '
+	test_when_finished "rm -rf empty-repo" &&
 	git init empty-repo &&
 	test_must_fail \
 		git -C empty-repo pull --verify-signatures ..  2>pullerror &&
 	test_i18ngrep "does not have a GPG signature" pullerror
 '
 
+test_expect_success GPG 'pull commit into unborn branch with bad signature and --verify-signatures' '
+	test_when_finished "rm -rf empty-repo" &&
+	git init empty-repo &&
+	test_must_fail \
+		git -C empty-repo pull --ff-only --verify-signatures ../bad 2>pullerror &&
+	test_i18ngrep "has a bad GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull commit into unborn branch with untrusted signature and --verify-signatures' '
+	test_when_finished "rm -rf empty-repo" &&
+	git init empty-repo &&
+	test_must_fail \
+		git -C empty-repo pull --ff-only --verify-signatures ../untrusted 2>pullerror &&
+	test_i18ngrep "has an untrusted GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull commit into unborn branch with untrusted signature and --verify-signatures and minTrustLevel=ultimate' '
+	test_when_finished "rm -rf empty-repo" &&
+	git init empty-repo &&
+	test_config_global gpg.minTrustLevel ultimate &&
+	test_must_fail \
+		git -C empty-repo pull --ff-only --verify-signatures ../untrusted 2>pullerror &&
+	test_i18ngrep "has an untrusted GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull commit into unborn branch with untrusted signature and --verify-signatures and minTrustLevel=marginal' '
+	test_when_finished "rm -rf empty-repo" &&
+	git init empty-repo &&
+	test_config_global gpg.minTrustLevel marginal &&
+	test_must_fail \
+		git -C empty-repo pull --ff-only --verify-signatures ../untrusted 2>pullerror &&
+	test_i18ngrep "has an untrusted GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull commit into unborn branch with untrusted signature and --verify-signatures and minTrustLevel=undefined' '
+	test_when_finished "rm -rf empty-repo" &&
+	git init empty-repo &&
+	test_config_global gpg.minTrustLevel undefined &&
+	git -C empty-repo pull --ff-only --verify-signatures ../untrusted >pulloutput &&
+	test_i18ngrep "has a good GPG signature" pulloutput
+'
+
 test_done
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 8f077bea60..5c5bc32ccb 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -86,6 +86,30 @@ test_expect_success GPGSM 'verify and show signatures x509' '
 	echo ninth-signed-x509 OK
 '
 
+test_expect_success GPGSM 'verify and show signatures x509 with low minTrustLevel' '
+	test_config gpg.minTrustLevel undefined &&
+	git verify-tag ninth-signed-x509 2>actual &&
+	grep "Good signature from" actual &&
+	! grep "BAD signature from" actual &&
+	echo ninth-signed-x509 OK
+'
+
+test_expect_success GPGSM 'verify and show signatures x509 with matching minTrustLevel' '
+	test_config gpg.minTrustLevel fully &&
+	git verify-tag ninth-signed-x509 2>actual &&
+	grep "Good signature from" actual &&
+	! grep "BAD signature from" actual &&
+	echo ninth-signed-x509 OK
+'
+
+test_expect_success GPGSM 'verify and show signatures x509 with high minTrustLevel' '
+	test_config gpg.minTrustLevel ultimate &&
+	test_must_fail git verify-tag ninth-signed-x509 2>actual &&
+	grep "Good signature from" actual &&
+	! grep "BAD signature from" actual &&
+	echo ninth-signed-x509 OK
+'
+
 test_expect_success GPG 'detect fudged signature' '
 	git cat-file tag seventh-signed >raw &&
 	sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 682b23a068..0c06d22a00 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -109,6 +109,21 @@ test_expect_success GPG 'verify-commit exits success on untrusted signature' '
 	grep "not certified" actual
 '
 
+test_expect_success GPG 'verify-commit exits success with matching minTrustLevel' '
+	test_config gpg.minTrustLevel ultimate &&
+	git verify-commit sixth-signed
+'
+
+test_expect_success GPG 'verify-commit exits success with low minTrustLevel' '
+	test_config gpg.minTrustLevel fully &&
+	git verify-commit sixth-signed
+'
+
+test_expect_success GPG 'verify-commit exits failure with high minTrustLevel' '
+	test_config gpg.minTrustLevel ultimate &&
+	test_must_fail git verify-commit eighth-signed-alt
+'
+
 test_expect_success GPG 'verify signatures with --raw' '
 	(
 		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
@@ -219,6 +234,30 @@ test_expect_success GPG 'show untrusted signature with custom format' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'show untrusted signature with undefined trust level' '
+	cat >expect <<-\EOF &&
+	undefined
+	65A0EEA02E30CAD7
+	Eris Discordia <discord@example.net>
+	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
+	D4BE22311AD3131E5EDA29A461092E85B7227189
+	EOF
+	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show untrusted signature with ultimate trust level' '
+	cat >expect <<-\EOF &&
+	ultimate
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	EOF
+	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'show unknown signature with custom format' '
 	cat >expect <<-\EOF &&
 	E
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index d99218a725..a426f3a89a 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -66,6 +66,20 @@ test_expect_success GPG 'merge commit with untrusted signature with verification
 	test_i18ngrep "has an untrusted GPG signature" mergeerror
 '
 
+test_expect_success GPG 'merge commit with untrusted signature with verification and high minTrustLevel' '
+	test_when_finished "git reset --hard && git checkout initial" &&
+	test_config gpg.minTrustLevel marginal &&
+	test_must_fail git merge --ff-only --verify-signatures side-untrusted 2>mergeerror &&
+	test_i18ngrep "has an untrusted GPG signature" mergeerror
+'
+
+test_expect_success GPG 'merge commit with untrusted signature with verification and low minTrustLevel' '
+	test_when_finished "git reset --hard && git checkout initial" &&
+	test_config gpg.minTrustLevel undefined &&
+	git merge --ff-only --verify-signatures side-untrusted >mergeoutput &&
+	test_i18ngrep "has a good GPG signature" mergeoutput
+'
+
 test_expect_success GPG 'merge commit with untrusted signature with merge.verifySignatures=true' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
@@ -73,6 +87,14 @@ test_expect_success GPG 'merge commit with untrusted signature with merge.verify
 	test_i18ngrep "has an untrusted GPG signature" mergeerror
 '
 
+test_expect_success GPG 'merge commit with untrusted signature with merge.verifySignatures=true and minTrustLevel' '
+	test_when_finished "git reset --hard && git checkout initial" &&
+	test_config merge.verifySignatures true &&
+	test_config gpg.minTrustLevel marginal &&
+	test_must_fail git merge --ff-only side-untrusted 2>mergeerror &&
+	test_i18ngrep "has an untrusted GPG signature" mergeerror
+'
+
 test_expect_success GPG 'merge signed commit with verification' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	git merge --verbose --ff-only --verify-signatures side-signed >mergeoutput &&
-- 
2.15.1.8615.g16a7d4acf3

