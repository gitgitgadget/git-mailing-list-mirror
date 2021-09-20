Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52260C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DCB760FF2
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhITHjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 03:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhITHj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 03:39:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D6C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:38:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q26so27137968wrc.7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DbsyjA8QR9KbATV+SknUQTTpw7s14Sg+lie/TA6nxO0=;
        b=QY/qMpC1lbBGx8RydVV+KBD2jtu7BnYEssR9QSHMthveuPVMhYO4MJA+zU3dk1nBVi
         aKvZ5Aky8kDls6a/FQl9NCJOXHGWx6BCVKKC0bNh3aMrpbFAAWt7K/QBL5lvQ1vcjP25
         c9hQreVnbkUmjl1f7JyeEAsIm3RFR+elBwF/GfAhifoY+frKjdXJcY8fvU6edgH2ay9d
         2/5qSmF0Hpm30BNMmSqf4cN7aw8M5tGTfJC85NW6va9ykHognvVet7QDyAoUlMFX9ydy
         mWMf96lqoZt0Kq/j5uRv+VD1UsJjLIP4bUD3jBpSNhOTZiDfBqr9uSjFHdziJERQqsTM
         v+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DbsyjA8QR9KbATV+SknUQTTpw7s14Sg+lie/TA6nxO0=;
        b=czxhJ7sr+luey26fXiO6S8J8H0rtz4E/FZuDSzshRR22NQrv80f8j50Oyn+f3+HxAk
         r7EjuEp+2MECskDXXMbkImscXDIe571orBIrv9k66liCBIjj2VmMfB+EFOmM5mm+6Eev
         6JuZ3kpFS3wLNCKZfL0Qt2KrOohsDvNuf+3YxbNRLg3TLZuVST2tHu3aO16Fpnhs8t2s
         3bs/5OawP9HBi0iO4fRK489+t8gjh+soC5N9pCGsBZr48DcQWrFo+NGHtGoC5Vz123uG
         0Vs9GwdsJKEYhIUxvBq1iN5K7hoFiX39oUJMDdz4x/UbpTSYj8WPkYNPNI12C/9Sy10D
         TbfQ==
X-Gm-Message-State: AOAM5324Ncy1yK00oAsAdjT1+VLhviQoRjqLLtKtGvXm+W3gOHBMJhcA
        gH0S5giBswJfZKfKLgjcUNaB1q+ksJw=
X-Google-Smtp-Source: ABdhPJzSG1Cs0Wxqx2uxXNslpXRhAIFgvKErB/HtVnIketI2AyBhm1BQZ7cKlWvnNxcZMlLXk//c4g==
X-Received: by 2002:a05:6000:144d:: with SMTP id v13mr19197170wrx.303.1632123480954;
        Mon, 20 Sep 2021 00:38:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z19sm22525314wma.0.2021.09.20.00.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:38:00 -0700 (PDT)
Message-Id: <d4e77765a8f5478c360fe78e72eb556ecdc326a5.1632123476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1042.git.1632123476.gitgitgadget@gmail.com>
References: <pull.1042.git.1632123476.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 07:37:56 +0000
Subject: [PATCH 4/4] ref-filter: let tag verify use %(refname:lstrip=2) by
 default
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Because git verify-tag or git tag --verify are using command line
parameters we pass as the %(refname) output (e.g. `git verify-tag
--format="verify: %(refname)" c06b72d02` will output
"verify: c06b72d02"). This is an design error, but it is widely
used by some scripts.

After we fix the bug that git verify_tag and git tag --verify
cannot use %(symref) correctly, we still need to make %(refname)
keep the same output as in the past. So add special_tag_verify to
ref_array_item and ref_format, when this flag is setted and we
are using refname atom default output formats such as %(refname),
%(symref), modify the attribute of the atom corresponding to
%(refname) in get_refname() and get_symref() and
fill_remote_ref_details(), which let show_ref() output something
like %(refname:lstrip=2). After show_ref() completes, restore the
atom attribute as their origin state.

We can set special_tag_verify flag directly in tag.c, but in
verify_tag.c, if we didn't get a refname from repo_dwim_ref(), we
don’t need to set special_tag_verify of ref_format and change its
output form, otherwise, set it.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/tag.c         |  1 +
 builtin/verify-tag.c  |  5 ++++-
 ref-filter.c          | 44 +++++++++++++++++++++++++++++++++----------
 ref-filter.h          |  2 ++
 t/t7030-verify-tag.sh | 23 ++++++++++++++++++++++
 5 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index ce5678d179f..bf2acb9f832 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -149,6 +149,7 @@ static int verify_tag(const char *name, const char *ref,
 	int flags;
 	struct ref_format *format = cb_data;
 	flags = GPG_VERIFY_VERBOSE;
+	format->special_tag_verify = 1;
 
 	if (format->format)
 		flags = GPG_VERIFY_OMIT_STATUS;
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index efc8282782a..dd2ff94eac9 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -61,6 +61,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		const char *name = argv[i++];
 		char *refname;
 		int ref_flags;
+		format.special_tag_verify = 0;
 
 		if (get_oid(name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
@@ -72,8 +73,10 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (repo_dwim_ref(the_repository, name, strlen(name), &oid, &refname, 0, &ref_flags, 1))
+		if (repo_dwim_ref(the_repository, name, strlen(name), &oid, &refname, 0, &ref_flags, 1)) {
 			name = refname;
+			format.special_tag_verify = 1;
+		}
 		if (format.format)
 			pretty_print_ref(name, &oid, &format, ref_flags);
 	}
diff --git a/ref-filter.c b/ref-filter.c
index 6c51ef25136..c7c3182ab5b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1640,12 +1640,19 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
 }
 
 static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
-				    struct branch *branch, const char **s)
+				    struct branch *branch, const char **s, struct ref_array_item *ref)
 {
 	int num_ours, num_theirs;
-	if (atom->u.remote_ref.option == RR_REF)
-		*s = show_ref(&atom->u.remote_ref.refname, refname);
-	else if (atom->u.remote_ref.option == RR_TRACK) {
+	if (atom->u.remote_ref.option == RR_REF) {
+		if (ref->special_tag_verify && atom->u.remote_ref.refname.option == R_NORMAL) {
+			atom->u.remote_ref.refname.option = R_LSTRIP;
+			atom->u.remote_ref.refname.lstrip = 2;
+			*s = show_ref(&atom->u.remote_ref.refname, refname);
+			atom->u.remote_ref.refname.option = R_NORMAL;
+		} else {
+			*s = show_ref(&atom->u.remote_ref.refname, refname);
+		}
+	} else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
 				       NULL, atom->u.remote_ref.push,
 				       AHEAD_BEHIND_FULL) < 0) {
@@ -1726,17 +1733,33 @@ char *get_head_description(void)
 
 static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref)
 {
-	if (!ref->symref)
+	if (!ref->symref) {
 		return xstrdup("");
-	else
+	} else if (ref->special_tag_verify && atom->u.refname.option == R_NORMAL) {
+		atom->u.refname.option = R_LSTRIP;
+		atom->u.refname.lstrip = 2;
+		return show_ref(&atom->u.refname, ref->symref);
+		atom->u.refname.option = R_NORMAL;
+	} else {
 		return show_ref(&atom->u.refname, ref->symref);
+	}
 }
 
 static const char *get_refname(struct used_atom *atom, struct ref_array_item *ref)
 {
-	if (ref->kind & FILTER_REFS_DETACHED_HEAD)
+	if (ref->kind & FILTER_REFS_DETACHED_HEAD) {
 		return get_head_description();
-	return show_ref(&atom->u.refname, ref->refname);
+	} else if (ref->special_tag_verify && atom->u.refname.option == R_NORMAL) {
+		const char * refname;
+
+		atom->u.refname.option = R_LSTRIP;
+		atom->u.refname.lstrip = 2;
+		refname = show_ref(&atom->u.refname, ref->refname);
+		atom->u.refname.option = R_NORMAL;
+		return refname;
+	} else {
+		return show_ref(&atom->u.refname, ref->refname);
+	}
 }
 
 static int get_object(struct ref_array_item *ref, int deref, struct object **obj,
@@ -1878,7 +1901,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 			refname = branch_get_upstream(branch, NULL);
 			if (refname)
-				fill_remote_ref_details(atom, refname, branch, &v->s);
+				fill_remote_ref_details(atom, refname, branch, &v->s, ref);
 			else
 				v->s = xstrdup("");
 			continue;
@@ -1899,7 +1922,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			}
 			/* We will definitely re-init v->s on the next line. */
 			free((char *)v->s);
-			fill_remote_ref_details(atom, refname, branch, &v->s);
+			fill_remote_ref_details(atom, refname, branch, &v->s, ref);
 			continue;
 		} else if (atom_type == ATOM_COLOR) {
 			v->s = xstrdup(atom->u.color);
@@ -2641,6 +2664,7 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
 	ref_item = new_ref_array_item(name, oid);
 	ref_item->kind = ref_kind_from_refname(name);
 	ref_item->flag = ref_flags;
+	ref_item->special_tag_verify = format->special_tag_verify;
 	if (format_ref_array_item(ref_item, format, &output, &err))
 		die("%s", err.buf);
 	fwrite(output.buf, 1, output.len, stdout);
diff --git a/ref-filter.h b/ref-filter.h
index edd9a3b6652..63c8d24a6fc 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -42,6 +42,7 @@ struct ref_array_item {
 	int flag;
 	unsigned int kind;
 	const char *symref;
+	int special_tag_verify;
 	struct commit *commit;
 	struct atom_value *value;
 	char refname[FLEX_ARRAY];
@@ -84,6 +85,7 @@ struct ref_format {
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
+	int special_tag_verify;
 };
 
 #define REF_FORMAT_INIT { .use_color = -1 }
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 10faa645157..85e2a653ed8 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -194,6 +194,29 @@ test_expect_success GPG 'verifying tag with --format' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'verifying tag with --format="%(refname) %(symref)"' '
+	git tag -s -m bar annotated &&
+	git symbolic-ref refs/tags/symref refs/tags/annotated &&
+	sha=$(git rev-parse symref) &&
+	SP=" " &&
+	cat >expect <<-EOF &&
+	verify: annotated$SP
+	verify: symref annotated
+	verify: $sha$SP
+	EOF
+	git verify-tag --format="verify: %(refname) %(symref)" annotated symref $sha >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'tag verify with --format="%(refname) %(symref)"' '
+	cat >expect <<-EOF &&
+	verify: annotated$SP
+	verify: symref annotated
+	EOF
+	git tag --verify --format="verify: %(refname) %(symref)" annotated symref >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'verifying tag with --format="%(rest)" must fail' '
 	test_must_fail git verify-tag --format="%(rest)" "fourth-signed"
 '
-- 
gitgitgadget
