Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E93C6FD1C
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 21:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCKVHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 16:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKVHE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 16:07:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29163559C5
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 13:07:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so5545119wmq.2
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 13:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678568820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOEwSdUxIy+bVjcD4uYMtfp6WhKFF0NsFJ0SuI02ZUo=;
        b=JLfF8RgjC9Z+c1yurbqGt14XgR11A4klmFyawkOuR5O5Jf00RXglG1RcBRyxIV0Wpg
         cpZaCtKR32v1k/3VTDCT8sClA3FNV09IZyzUnIUKmcLgJEawQnkS1E4FpkeyOrvQIVkY
         AzEhjM8+PC4EBa+8Y9lpkl24z/JqyBaNRR5AQspQoZazUpLOGxaXCc58HqYiqAQQGag8
         dBnTsZFJ/2cGJ5cTcxSPmj4gAvp6obAlA7oOlpyPrM4NHbHdw+dztyLaCXb4EAGMo/zr
         ES7ju747tztHWE6wUVijUCnPhplHu1Jep1e9RVeerPDDVtiy4lYDZBdwLpQK7lebSSuK
         TU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678568820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOEwSdUxIy+bVjcD4uYMtfp6WhKFF0NsFJ0SuI02ZUo=;
        b=1YqZWCrd2P0d867diNDUsOuuf78wycWnTA2wd4nT8nz/PIqasRqvORAMjHQZiO8Ey1
         A4CVitZt73nDOufbQ1xqWzPbOU0nT5B5XigfUpdEZoLoUT6SyogXYSCXApX0VM1b0o4O
         YG+xGwAlVEpdpsLv9u6U4+ZH+PLqAovm+0PWMIpHU9dWdDH8slHBDymEw7WPrOYwxfZi
         LI3yOIq4xRSk+mtH/Bdpy3T/GuvNcGolWXMeNfiNQxoGc0j9qvHdReYQR/xu0WNaKLIZ
         nWA8oRx1pfyTR4hf00MPSNsZvw3dsWCP5NtKMTN7VKqld+Yrb9LjZr/FcTFj2/K4gtJK
         j9JQ==
X-Gm-Message-State: AO0yUKXBcQmD9yqhWTZE8liEHRaFgoqY5VFR8LZreYNgqeGv0iK5sNhQ
        fCZAwYNrptenbdwf/6q8R4fS4OOcm+zKOUGM
X-Google-Smtp-Source: AK7set9VlmKGwMnB7co8CZrVeqj20/KBqkTh6SGMOPy7uu1TvyvcIeRSCGo8XhU/CdL+5sxguDVSyQ==
X-Received: by 2002:a05:600c:3b11:b0:3eb:38b0:e757 with SMTP id m17-20020a05600c3b1100b003eb38b0e757mr5281510wms.10.1678568820169;
        Sat, 11 Mar 2023 13:07:00 -0800 (PST)
Received: from wilber4c.. ([197.239.13.29])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d608a000000b002c5493a17efsm3345137wrt.25.2023.03.11.13.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:06:59 -0800 (PST)
From:   Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
To:     git@vger.kernel.org
Cc:     Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 1/1] ref-filter: add new "signature" atom
Date:   Sat, 11 Mar 2023 16:06:07 -0500
Message-Id: <20230311210607.64927-2-nsengiyumvawilberforce@gmail.com>
X-Mailer: git-send-email 2.39.GIT
In-Reply-To: <20230311210607.64927-1-nsengiyumvawilberforce@gmail.com>
References: <20230116173814.11338-2-nsengiyumvawilberforce@gmail.com>
 <20230311210607.64927-1-nsengiyumvawilberforce@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit duplicates the code for `signature` atom from pretty.c
to ref-filter.c. This feature will help to get rid of current duplicate
implementation of `signature` atom when unifying implementations by
using ref-filter logic everywhere when ref-filter can do everything
pretty is doing.

Add "signature" atom with `grade`, `signer`, `key`,
`fingerprint`, `primarykeyfingerprint`, `trustlevel` as arguments.
This code and its documentation are inspired by how the %GG, %G?,
%GS, %GK, %GF, %GP, and %GT pretty formats were implemented.

Co-authored-by: Hariom Verma <hariom18599@gmail.com>
Co-authored-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
---
 Documentation/git-for-each-ref.txt |  27 ++++++
 ref-filter.c                       | 106 ++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 128 +++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6da899c629..9a0be85368 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -212,6 +212,33 @@ symref::
 	`:lstrip` and `:rstrip` options in the same way as `refname`
 	above.
 
+signature::
+	The GPG signature of a commit.
+
+signature:grade::
+	Show "G" for a good (valid) signature, "B" for a bad
+	signature, "U" for a good signature with unknown validity, "X"
+	for a good signature that has expired, "Y" for a good
+	signature made by an expired key, "R" for a good signature
+	made by a revoked key, "E" if the signature cannot be
+	checked (e.g. missing key) and "N" for no signature.
+
+signature:signer::
+	The signer of the GPG signature of a commit.
+
+signature:key::
+	The key of the GPG signature of a commit.
+
+signature:fingerprint::
+	The fingerprint of the GPG signature of a commit.
+
+signature:primarykeyfingerprint::
+	The Primary Key fingerprint of the GPG signature of a commit.
+
+signature:trustlevel::
+	The Trust level of the GPG signature of a commit. Possible
+	outputs are `ultimate`, `fully`, `marginal`, `never` and `undefined`.
+
 worktreepath::
 	The absolute path to the worktree in which the ref is checked
 	out, if it is checked out in any linked worktree. Empty string
diff --git a/ref-filter.c b/ref-filter.c
index a24324123e..2a5c5e9508 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -144,6 +144,7 @@ enum atom_type {
 	ATOM_BODY,
 	ATOM_TRAILERS,
 	ATOM_CONTENTS,
+	ATOM_SIGNATURE,
 	ATOM_RAW,
 	ATOM_UPSTREAM,
 	ATOM_PUSH,
@@ -208,6 +209,10 @@ static struct used_atom {
 		struct email_option {
 			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
 		} email_option;
+		struct {
+			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
+			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL} option;
+		} signature;
 		struct refname_atom refname;
 		char *head;
 	} u;
@@ -394,6 +399,34 @@ static int subject_atom_parser(struct ref_format *format, struct used_atom *atom
 	return 0;
 }
 
+static int parse_signature_option(const char *arg)
+{
+	if (!arg)
+		return S_BARE;
+	else if (!strcmp(arg, "signer"))
+		return S_SIGNER;
+	else if (!strcmp(arg, "grade"))
+		return S_GRADE;
+	else if (!strcmp(arg, "key"))
+		return S_KEY;
+	else if (!strcmp(arg, "fingerprint"))
+		return S_FINGERPRINT;
+	else if (!strcmp(arg, "primarykeyfingerprint"))
+		return S_PRI_KEY_FP;
+	else if (!strcmp(arg, "trustlevel"))
+		return S_TRUST_LEVEL;
+	return -1;
+}
+
+static int signature_atom_parser(struct ref_format *format UNUSED, struct used_atom *atom,
+			       const char *arg, struct strbuf *err){
+	int opt = parse_signature_option(arg);
+	if (opt < 0)
+		return err_bad_arg(err, "signature", arg);
+	atom->u.signature.option = opt;
+	return 0;
+}
+
 static int trailers_atom_parser(struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
@@ -631,6 +664,7 @@ static struct {
 	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
 	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
 	[ATOM_CONTENTS] = { "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
+	[ATOM_SIGNATURE] = { "signature", SOURCE_OBJ, FIELD_STR, signature_atom_parser },
 	[ATOM_RAW] = { "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
 	[ATOM_UPSTREAM] = { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	[ATOM_PUSH] = { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
@@ -1362,6 +1396,77 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 	}
 }
 
+static void grab_signature(struct atom_value *val, int deref, struct object *obj)
+{
+	int i;
+	struct commit *commit = (struct commit *) obj;
+	struct signature_check sigc = { 0 };
+	int signature_checked = 0;
+
+	for (i = 0; i < used_atom_cnt; i++) {
+		struct used_atom *atom = &used_atom[i];
+		const char *name = atom->name;
+		struct atom_value *v = &val[i];
+
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+
+		if (!skip_prefix(name, "signature", &name) || (*name &&
+			*name != ':'))
+			continue;
+		if (!*name)
+			name = NULL;
+		else
+			name++;
+		if (parse_signature_option(name) < 0)
+			continue;
+
+		if (!signature_checked) {
+			check_commit_signature(commit, &sigc);
+			signature_checked = 1;
+		}
+
+		if (atom->u.signature.option == S_BARE)
+			v->s = xstrdup(sigc.output ? sigc.output: "");
+		else if (atom->u.signature.option == S_SIGNER)
+			v->s = xstrdup(sigc.signer ? sigc.signer : "");
+		else if (atom->u.signature.option == S_GRADE) {
+			switch (sigc.result) {
+			case 'G':
+				switch (sigc.trust_level) {
+				case TRUST_UNDEFINED:
+				case TRUST_NEVER:
+					v->s = xstrfmt("%c", (char)'U');
+					break;
+				default:
+					v->s = xstrfmt("%c", (char)'G');
+					break;
+				}
+				break;
+			case 'B':
+			case 'E':
+			case 'N':
+			case 'X':
+			case 'Y':
+			case 'R':
+				v->s = xstrfmt("%c", (char)sigc.result);
+			}
+		}
+		else if (atom->u.signature.option == S_KEY)
+			v->s = xstrdup(sigc.key ? sigc.key : "");
+		else if (atom->u.signature.option == S_FINGERPRINT)
+			v->s = xstrdup(sigc.fingerprint ? sigc.fingerprint : "");
+		else if (atom->u.signature.option == S_PRI_KEY_FP)
+			v->s = xstrdup(sigc.primary_key_fingerprint ? sigc.primary_key_fingerprint : "");
+		else if (atom->u.signature.option == S_TRUST_LEVEL)
+			v->s = xstrdup(gpg_trust_level_to_str(sigc.trust_level));
+	}
+	if (signature_checked)
+		signature_check_clear(&sigc);
+}
+
 static void find_subpos(const char *buf,
 			const char **sub, size_t *sublen,
 			const char **body, size_t *bodylen,
@@ -1555,6 +1660,7 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_sub_body_contents(val, deref, data);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
+		grab_signature(val, deref, obj);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2ae1fc721b..c74e2ca169 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -6,6 +6,7 @@
 test_description='for-each-ref test'
 
 . ./test-lib.sh
+GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
@@ -1464,4 +1465,131 @@ sig_crlf="$(printf "%s" "$sig" | append_cr; echo dummy)"
 sig_crlf=${sig_crlf%dummy}
 test_atom refs/tags/fake-sig-crlf contents:signature "$sig_crlf"
 
+GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
+TRUSTLEVEL_FORMAT="%(signature:trustlevel)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
+
+test_expect_success GPG 'test bare signature atom' '
+	git checkout -b signed &&
+	echo 1 >file && git add file &&
+	test_tick && git commit -S -m initial &&
+	git verify-commit signed 2>out_orig &&
+	grep -v "checking the trustdb" out_orig >out &&
+	head -3 out >expected &&
+	tail -1 out >>expected &&
+	echo >>expected &&
+	git for-each-ref refs/heads/signed --format="%(signature)" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success GPG 'show good signature with custom format' '
+	echo 2 >file && git add file &&
+	test_tick && git commit -S -m initial &&
+	git verify-commit signed 2>out &&
+	cat >expect <<-\EOF &&
+	G
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	EOF
+	git for-each-ref refs/heads/signed --format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'test signature atom with grade option and bad signature' '
+	git config commit.gpgsign true &&
+	echo 3 >file && test_tick && git commit -a -m "third" --no-gpg-sign &&
+	git tag third-unsigned &&
+
+	test_tick && git rebase -f HEAD^^ && git tag second-signed HEAD^ &&
+	git tag third-signed &&
+
+	git cat-file commit third-signed >raw &&
+	sed -e "s/^third/3rd forged/" raw >forged1 &&
+	FORGED1=$(git hash-object -w -t commit forged1) &&
+	git update-ref refs/tags/third-signed "$FORGED1" &&
+	test_must_fail git verify-commit "$FORGED1" &&
+
+	cat >expect <<-\EOF &&
+	B
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+
+
+	EOF
+	git for-each-ref refs/tags/third-signed --format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show untrusted signature with custom format' '
+	echo 4 >file && test_tick && git commit -a -m fourth -SB7227189 &&
+	git tag signed-fourth &&
+	cat >expect <<-\EOF &&
+	U
+	65A0EEA02E30CAD7
+	Eris Discordia <discord@example.net>
+	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
+	D4BE22311AD3131E5EDA29A461092E85B7227189
+	EOF
+	git for-each-ref refs/tags/signed-fourth --format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show untrusted signature with undefined trust level' '
+	echo 5 >file && test_tick && git commit -a -m fifth -SB7227189 &&
+	git tag fifth-signed &&
+	cat >expect <<-\EOF &&
+	undefined
+	65A0EEA02E30CAD7
+	Eris Discordia <discord@example.net>
+	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
+	D4BE22311AD3131E5EDA29A461092E85B7227189
+	EOF
+	git for-each-ref refs/tags/fifth-signed --format="$TRUSTLEVEL_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show untrusted signature with ultimate trust level' '
+	echo 7 >file && test_tick && git commit -a -m "seventh" --no-gpg-sign &&
+	git tag seventh-unsigned &&
+
+	test_tick && git rebase -f HEAD^^ && git tag sixth-signed HEAD^ &&
+	git tag seventh-signed &&
+	cat >expect <<-\EOF &&
+	ultimate
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	EOF
+	git for-each-ref refs/tags/seventh-signed --format="$TRUSTLEVEL_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show unknown signature with custom format' '
+	cat >expect <<-\EOF &&
+	E
+	65A0EEA02E30CAD7
+
+
+
+	EOF
+	GNUPGHOME="$GNUPGHOME_NOT_USED" git for-each-ref refs/tags/fifth-signed --format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show lack of signature with custom format' '
+	echo 8 >file && test_tick && git commit -a -m "eigth unsigned" --no-gpg-sign &&
+	git tag eigth-unsigned &&
+	cat >expect <<-\EOF &&
+	N
+
+
+
+
+	EOF
+	git for-each-ref refs/tags/eigth-unsigned --format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.39.GIT

