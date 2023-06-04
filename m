Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11052C7EE23
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 18:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjFDS7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 14:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjFDS7I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 14:59:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7740F109
        for <git@vger.kernel.org>; Sun,  4 Jun 2023 11:59:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2566f66190dso3470280a91.1
        for <git@vger.kernel.org>; Sun, 04 Jun 2023 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685905144; x=1688497144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKwHatP+AHG0x+lKZtW0s1oONwFdHDm/f7tXtTAMfbA=;
        b=fEFWEDXnsgLZS2woNqiTcrfoZdYR1BuS3US2mrpHuCHUORPbVx/jkumq7/7XmMQRoy
         m3qLp2hAKzf3aXRD7O46xbgL0pNmqdcHWPHQCxYpBmSeXoWZ2g/xiTtPUIT1yALDf0yC
         4R2pk2LN3gEaRDTMMygP0DfPYNmt1Evm5rDVUiZWIssXAe8KWb1i2W6N0kIs9Fj9bgI3
         vjbB2Z32HxeBvZDWgU88lUPe4ot5s41dVYfXcaZ3WASs/HBlk4x35ine4z/LPxTp3UCb
         mEJehSiEl4KizjDjlgg1s0ODNp4Zdvhgl1nPQPgATTx0raHeaWRkNB/ulGz5gXUBik65
         ObJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685905144; x=1688497144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKwHatP+AHG0x+lKZtW0s1oONwFdHDm/f7tXtTAMfbA=;
        b=Zkz3Nx1u+gtuUjuFTxL7wq53yMI+ilXfhxRni9F7qiqhfnKolOB4uObINX78sPsSD5
         k9I0OmxAefvdVKVssWt/Jq11DnZ9LD7+zGMRgbjbFDr7ZMDDRz++ceDzrFMXii0YT2Gl
         ZRCZry+hMlVSs6T/2mp/jFK/KlzLOSnBzZ9v3LkfcBNDSULH4NxenVJ30c9eeiYlocWb
         C/WY4ijYnwu3/7kr2EZ5M3/ls5+tXEM6DwYyKw1oGvCzEboyEqX6QArnv+U9sYhTsrf8
         SQtzh/X0r2y5OAIiFwcnUqLPWRvos+FY+iVpcsIdgTwHErl9CgZd2XZ8eMfwmukoBvjk
         yX/w==
X-Gm-Message-State: AC+VfDzvCoPlcRS0KVWtZ+oTe+SN592+q0OhoL29gPtDQ91NUpiiJlVW
        JZqvN1jvROdIW33tC/Jfpxty2PQzRYXeU5Gn
X-Google-Smtp-Source: ACHHUZ5CluZwEUMhTB3sbkOOdzIH8y4I/DZ9Ek/+uJds9eBvOgRFsCK9FxDI2XJZrgJeuPjCxl7FTA==
X-Received: by 2002:a17:90a:5105:b0:255:5bde:e6c2 with SMTP id t5-20020a17090a510500b002555bdee6c2mr5267417pjh.12.1685905143891;
        Sun, 04 Jun 2023 11:59:03 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.151.19])
        by smtp.gmail.com with ESMTPSA id mh12-20020a17090b4acc00b00256a4657519sm4495805pjb.15.2023.06.04.11.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 11:59:03 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Subject: [PATCH v3 2/2] ref-filter: add new "signature" atom
Date:   Sun,  4 Jun 2023 23:52:47 +0530
Message-ID: <20230604185815.15761-3-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230604185815.15761-1-five231003@gmail.com>
References: <20230602023105.17979-1-five231003@gmail.com>
 <20230604185815.15761-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duplicate the code for outputting the signature and its other
parameters for commits and tags in ref-filter from pretty. In the
future, this will help in getting rid of the current duplicate
implementations of such logic everywhere, when ref-filter can do
everything that pretty is doing.

The new atom "signature" and its friends are equivalent to the existing
pretty formats as follows:

	%(signature) = %GG
	%(signature:grade) = %G?
	%(siganture:signer) = %GS
	%(signature:key) = %GK
	%(signature:fingerprint) = %GF
	%(signature:primarykeyfingerprint) = %GP
	%(signature:trustlevel) = %GT

Co-authored-by: Hariom Verma <hariom18599@gmail.com>
Co-authored-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
Co-authored-by: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 Documentation/git-for-each-ref.txt |  27 ++++
 ref-filter.c                       | 126 ++++++++++++++++++-
 t/t6300-for-each-ref.sh            | 191 +++++++++++++++++++++++++++++
 3 files changed, 342 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 1e215d4e73..2e0318770b 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -221,6 +221,33 @@ symref::
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
+	The primary key fingerprint of the GPG signature of a commit.
+
+signature:trustlevel::
+	The trust level of the GPG signature of a commit. Possible
+	outputs are `ultimate`, `fully`, `marginal`, `never` and `undefined`.
+
 worktreepath::
 	The absolute path to the worktree in which the ref is checked
 	out, if it is checked out in any linked worktree. Empty string
diff --git a/ref-filter.c b/ref-filter.c
index 4991cd4f7a..5c6924b367 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -150,6 +150,7 @@ enum atom_type {
 	ATOM_BODY,
 	ATOM_TRAILERS,
 	ATOM_CONTENTS,
+	ATOM_SIGNATURE,
 	ATOM_RAW,
 	ATOM_UPSTREAM,
 	ATOM_PUSH,
@@ -215,6 +216,10 @@ static struct used_atom {
 		struct email_option {
 			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
 		} email_option;
+		struct {
+			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
+			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
+		} signature;
 		struct refname_atom refname;
 		char *head;
 	} u;
@@ -407,8 +412,37 @@ static int subject_atom_parser(struct ref_format *format UNUSED,
 	return 0;
 }
 
-static int trailers_atom_parser(struct ref_format *format UNUSED,
-				struct used_atom *atom,
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
+static int signature_atom_parser(struct ref_format *format UNUSED,
+				 struct used_atom *atom,
+				 const char *arg, struct strbuf *err)
+{
+	int opt = parse_signature_option(arg);
+	if (opt < 0)
+		return err_bad_arg(err, "signature", arg);
+	atom->u.signature.option = opt;
+	return 0;
+}
+
+static int trailers_atom_parser(struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
 	atom->u.contents.trailer_opts.no_divider = 1;
@@ -668,6 +702,7 @@ static struct {
 	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
 	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
 	[ATOM_CONTENTS] = { "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
+	[ATOM_SIGNATURE] = { "signature", SOURCE_OBJ, FIELD_STR, signature_atom_parser },
 	[ATOM_RAW] = { "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
 	[ATOM_UPSTREAM] = { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	[ATOM_PUSH] = { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
@@ -1405,6 +1440,92 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
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
+		int opt;
+
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+
+		if (!skip_prefix(name, "signature", &name) ||
+		    (*name && *name != ':'))
+			continue;
+		if (!*name)
+			name = NULL;
+		else
+			name++;
+
+		opt = parse_signature_option(name);
+		if (opt < 0)
+			continue;
+
+		if (!signature_checked) {
+			check_commit_signature(commit, &sigc);
+			signature_checked = 1;
+		}
+
+		switch (opt) {
+		case S_BARE:
+			v->s = xstrdup(sigc.output ? sigc.output: "");
+			break;
+		case S_SIGNER:
+			v->s = xstrdup(sigc.signer ? sigc.signer : "");
+			break;
+		case S_GRADE:
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
+				break;
+			}
+			break;
+		case S_KEY:
+			v->s = xstrdup(sigc.key ? sigc.key : "");
+			break;
+		case S_FINGERPRINT:
+			v->s = xstrdup(sigc.fingerprint ?
+				       sigc.fingerprint : "");
+			break;
+		case S_PRI_KEY_FP:
+			v->s = xstrdup(sigc.primary_key_fingerprint ?
+				       sigc.primary_key_fingerprint : "");
+			break;
+		case S_TRUST_LEVEL:
+			v->s = xstrdup(gpg_trust_level_to_str(sigc.trust_level));
+			break;
+		}
+	}
+
+	if (signature_checked)
+		signature_check_clear(&sigc);
+}
+
 static void find_subpos(const char *buf,
 			const char **sub, size_t *sublen,
 			const char **body, size_t *bodylen,
@@ -1598,6 +1719,7 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_sub_body_contents(val, deref, data);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
+		grab_signature(val, deref, obj);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5c00607608..6e6ec852b5 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -6,6 +6,7 @@
 test_description='for-each-ref test'
 
 . ./test-lib.sh
+GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
@@ -1522,4 +1523,194 @@ test_expect_success 'git for-each-ref with non-existing refs' '
 	test_must_be_empty actual
 '
 
+GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
+TRUSTLEVEL_FORMAT="%(signature:trustlevel)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
+
+test_expect_success GPG 'setup for signature atom using gpg' '
+	git checkout -b signed &&
+
+	test_when_finished "test_unconfig commit.gpgSign" &&
+
+	echo "1" >file &&
+	git add file &&
+	test_tick &&
+	git commit -S -m "file: 1" &&
+	git tag first-signed &&
+
+	echo "2" >file &&
+	test_tick &&
+	git commit -a -m "file: 2" &&
+	git tag second-unsigned &&
+
+	git config commit.gpgSign 1 &&
+	echo "3" >file &&
+	test_tick &&
+	git commit -a --no-gpg-sign -m "file: 3" &&
+	git tag third-unsigned &&
+
+	test_tick &&
+	git rebase -f HEAD^^ && git tag second-signed HEAD^ &&
+	git tag third-signed &&
+
+	echo "4" >file &&
+	test_tick &&
+	git commit -a -SB7227189 -m "file: 4" &&
+	git tag fourth-signed &&
+
+	echo "5" >file &&
+	test_tick &&
+	git commit -a --no-gpg-sign -m "file: 5" &&
+	git tag fifth-unsigned &&
+
+	echo "6" >file &&
+	test_tick &&
+	git commit -a --no-gpg-sign -m "file: 6" &&
+
+	test_tick &&
+	git rebase -f HEAD^^ &&
+	git tag fifth-signed HEAD^ &&
+	git tag sixth-signed &&
+
+	echo "7" >file &&
+	test_tick &&
+	git commit -a --no-gpg-sign -m "file: 7" &&
+	git tag seventh-unsigned
+'
+
+test_expect_success GPGSSH 'setup for signature atom using ssh' '
+	test_when_finished "test_unconfig gpg.format user.signingkey" &&
+
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+	echo "8" >file &&
+	test_tick &&
+	git commit -a -S -m "file: 8" &&
+	git tag eighth-signed-ssh
+'
+
+test_expect_success GPG2 'bare signature atom' '
+	git verify-commit first-signed 2>out.raw &&
+	grep -Ev "checking the trustdb|PGP trust model" out.raw >out &&
+	head -3 out >expect &&
+	tail -1 out >>expect &&
+	echo  >>expect &&
+	git for-each-ref refs/tags/first-signed \
+		--format="%(signature)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show good signature with custom format' '
+	git verify-commit first-signed &&
+	cat >expect <<-\EOF &&
+	G
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	EOF
+	git for-each-ref refs/tags/first-signed \
+		--format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+test_expect_success GPGSSH 'show good signature with custom format
+			    with ssh' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_PRIMARY}" | awk "{print \$2;}") &&
+	cat >expect.tmpl <<-\EOF &&
+	G
+	FINGERPRINT
+	principal with number 1
+	FINGERPRINT
+
+	EOF
+	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
+	git for-each-ref refs/tags/eighth-signed-ssh \
+		--format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'signature atom with grade option and bad signature' '
+	git cat-file commit third-signed >raw &&
+	sed -e "s/^file: 3/file: 3 forged/" raw >forged1 &&
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
+	git for-each-ref refs/tags/third-signed \
+		--format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show untrusted signature with custom format' '
+	cat >expect <<-\EOF &&
+	U
+	65A0EEA02E30CAD7
+	Eris Discordia <discord@example.net>
+	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
+	D4BE22311AD3131E5EDA29A461092E85B7227189
+	EOF
+	git for-each-ref refs/tags/fourth-signed \
+		--format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show untrusted signature with undefined trust level' '
+	cat >expect <<-\EOF &&
+	undefined
+	65A0EEA02E30CAD7
+	Eris Discordia <discord@example.net>
+	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
+	D4BE22311AD3131E5EDA29A461092E85B7227189
+	EOF
+	git for-each-ref refs/tags/fourth-signed \
+		--format="$TRUSTLEVEL_FORMAT" >actual &&
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
+	git for-each-ref refs/tags/sixth-signed \
+		--format="$TRUSTLEVEL_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show unknown signature with custom format' '
+	cat >expect <<-\EOF &&
+	E
+	13B6F51ECDDE430D
+
+
+
+	EOF
+	GNUPGHOME="$GNUPGHOME_NOT_USED" git for-each-ref \
+		refs/tags/sixth-signed --format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show lack of signature with custom format' '
+	cat >expect <<-\EOF &&
+	N
+
+
+
+
+	EOF
+	git for-each-ref refs/tags/seventh-unsigned \
+		--format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.41.0

