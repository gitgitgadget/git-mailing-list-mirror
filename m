Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286A6C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 10:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D62613C1
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 10:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhD2KZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 06:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhD2KZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 06:25:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BDAC06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 03:24:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m9so53581644wrx.3
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=eb//ld+O6vJP0XjZxZNvHUYxxYJmL4h01Ps81b5Bez0=;
        b=V474zAKuiAB7sD0f6swKjGLkuHbMr9cQA3zzcXWBS9U8C8eve3N1HfBWLrXyS2f+RX
         0YWSFXXdXdJFyf53E2xBUMg7ahra6suyO7qoshfa7HvBePyUSP5FDaxYrPwbez6f6tNn
         5CJuSXdl0vuyVLB8JubDxCM0l7snMDxp54XNNOIzc8rcg1Xkw6cCAsCWlysRhjLO1gOu
         OOYP+nNLqd3shCUL4Cd0UQuTHKO4tTnu/rLD0sqbus9vjF/8DDS1LIVvZXec6x++EpCC
         tozKqnKD9nVR8ucydLXBPLiZ3cUlERhLCuVjj3lVz2FI7ZTx82lm8jYesajSLA9zi0zr
         e1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eb//ld+O6vJP0XjZxZNvHUYxxYJmL4h01Ps81b5Bez0=;
        b=pMYZ74d6X8dSydigHwR9xAlwwfldH9ryJDyXbpbdhJfjZL8PapydNnvNKN9uQBiSF/
         PUxwNbdw1d8hJpqK2Lq9RHAJLDTanzqY95Mqd097u6RAJggukl9OKGGgCLhnWPlM44j7
         fzThaSn3AxeSo6ZmVL033/K6PxkOPi5BkPgfjnOYDQUWddaT3tZf0+uLu1tYRzSz7fLy
         WWZYhS8zRFXxSyFAjmkKtnK3IyxkZQslRZ06Ro3T0XqKX4VVgmt1uJY7T3/NvQE9fzO/
         ASmrSP/yXp15gRLfbJbfIbPdTQrlNCxlS9YodPx+hOc817y1faFfwQH/cVAiWkeozKXS
         HXrg==
X-Gm-Message-State: AOAM5301S16/3UbgLAPu6WPZgjqi43Xup/sMpq44oz6TrJlYg/zTXlIx
        Zq9QROb6+IZsY6NcqEAB+m+yS7ahtZU=
X-Google-Smtp-Source: ABdhPJyGmkm6TtsMaWsYyIwlOdCaD/nLGoBNIbb43zNfyl9pJ+8o9tDG59wNwxhWFA5sbD0BNQKgzw==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr42653535wrs.94.1619691881889;
        Thu, 29 Apr 2021 03:24:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g197sm10645805wme.43.2021.04.29.03.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 03:24:41 -0700 (PDT)
Message-Id: <pull.944.git.1619691880696.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 10:24:40 +0000
Subject: [PATCH] [GSOC] ref-filter: add %(notes) format atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Note that `--pretty="%N"` can view notes related
to the commit. So add `%(notes)` to ref-filter
seem is a good choice. This atom `%(notes)` view
the notes associated with the ref, and support
dereference.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] ref-filter: add %(notes) format atom
    
    An important step in the GSOC project Use ref-filter formats in git
    cat-file is to integrate different format atoms into the ref-filter.
    Olga and Hariom have also made a lot of efforts in this area.
    
    Currently, I noticed that there may be some format atoms in "pretty.c"
    that have not been migrated to ref-filter, such as --pretty="%N",
    --pretty="%(describe)".
    
    So in this patch, I tried to migrate --pretty=%N to --format=%(notes).
    
    Hope this will be hopeful !!!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-944%2Fadlternative%2Fformat-notes-atom-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-944/adlternative/format-notes-atom-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/944

 Documentation/git-for-each-ref.txt |  4 ++++
 ref-filter.c                       | 31 ++++++++++++++++++++++++++++--
 t/t6300-for-each-ref.sh            | 10 ++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2ae2478de706..07f037a16e13 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -139,6 +139,9 @@ deltabase::
 	given object, if it is stored as a delta.  Otherwise it
 	expands to the null object name (all zeroes).
 
+notes::
+	The notes associated with the ref.
+
 upstream::
 	The name of a local ref which can be considered ``upstream''
 	from the displayed ref. Respects `:short`, `:lstrip` and
@@ -302,6 +305,7 @@ git for-each-ref --count=3 --sort='-*authordate' \
 Subject: %(*subject)
 Date: %(*authordate)
 Ref: %(*refname)
+Notes: %(*notes)
 
 %(*body)
 ' 'refs/tags'
diff --git a/ref-filter.c b/ref-filter.c
index a0adb4551d87..42a5608a3056 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -23,6 +23,7 @@
 #include "worktree.h"
 #include "hashmap.h"
 #include "strvec.h"
+#include "run-command.h"
 
 static struct ref_msg {
 	const char *gone;
@@ -506,6 +507,7 @@ static struct {
 	{ "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
 	{ "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
 	{ "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
+	{ "notes", SOURCE_OTHER, FIELD_STR },
 	{ "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
 	{ "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
 	{ "numparent", SOURCE_OBJ, FIELD_ULONG },
@@ -953,6 +955,24 @@ static int grab_oid(const char *name, const char *field, const struct object_id
 	return 0;
 }
 
+static int grab_notes(const struct object_id *oid, struct atom_value *v)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	const char *args[] = { "notes", "show", NULL };
+	int ret;
+
+	cmd.git_cmd = 1;
+	strvec_pushv(&cmd.args, args);
+	strvec_push(&cmd.args, oid_to_hex(oid));
+	ret = pipe_command(&cmd, NULL, 0, &out, 0, &err, 0);
+	strbuf_trim_trailing_newline(&out);
+	v->s = strbuf_detach(&out, NULL);
+	strbuf_release(&err);
+	return ret;
+}
+
 /* See grab_values */
 static void grab_common_values(struct atom_value *val, int deref, struct expand_data *oi)
 {
@@ -975,8 +995,12 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 			v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
 		} else if (!strcmp(name, "deltabase"))
 			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
-		else if (deref)
-			grab_oid(name, "objectname", &oi->oid, v, &used_atom[i]);
+		else if (deref) {
+			if (!strcmp(name, "notes"))
+				grab_notes(&oi->oid, v);
+			else
+				grab_oid(name, "objectname", &oi->oid, v, &used_atom[i]);
+		}
 	}
 }
 
@@ -1767,6 +1791,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			continue;
 		} else if (!deref && grab_oid(name, "objectname", &ref->objectname, v, atom)) {
 			continue;
+		} else if (!deref && !strcmp(name, "notes")) {
+			grab_notes(&ref->objectname, v);
+			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
 				v->s = xstrdup("*");
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9e0214076b4d..61cdbeb696ff 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -32,8 +32,10 @@ test_expect_success setup '
 	git add one &&
 	git commit -m "Initial" &&
 	git branch -M main &&
+	git notes add -m "commit-notes" HEAD &&
 	setdate_and_increment &&
 	git tag -a -m "Tagging at $datestamp" testtag &&
+	git notes add -m "tag-notes" testtag &&
 	git update-ref refs/remotes/origin/main main &&
 	git remote add origin nowhere &&
 	git config branch.main.remote origin &&
@@ -162,6 +164,7 @@ test_atom head contents:signature ''
 test_atom head contents 'Initial
 '
 test_atom head HEAD '*'
+test_atom head notes $(git notes show refs/heads/main)
 
 test_atom tag refname refs/tags/testtag
 test_atom tag refname:short testtag
@@ -220,6 +223,8 @@ test_atom tag contents:signature ''
 test_atom tag contents 'Tagging at 1151968727
 '
 test_atom tag HEAD ' '
+test_atom tag notes $(git notes show refs/tags/testtag)
+test_atom tag "*notes" $(git notes show refs/heads/main)
 
 test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
@@ -380,6 +385,7 @@ test_expect_success 'exercise strftime with odd fields' '
 
 cat >expected <<\EOF
 refs/heads/main
+refs/notes/commits
 refs/remotes/origin/main
 refs/tags/testtag
 EOF
@@ -393,6 +399,7 @@ test_expect_success 'Verify ascending sort' '
 cat >expected <<\EOF
 refs/tags/testtag
 refs/remotes/origin/main
+refs/notes/commits
 refs/heads/main
 EOF
 
@@ -429,6 +436,7 @@ test_expect_success 'exercise glob patterns with prefixes' '
 
 cat >expected <<\EOF
 'refs/heads/main'
+'refs/notes/commits'
 'refs/remotes/origin/main'
 'refs/tags/testtag'
 EOF
@@ -450,6 +458,7 @@ test_expect_success 'Quoting style: python' '
 
 cat >expected <<\EOF
 "refs/heads/main"
+"refs/notes/commits"
 "refs/remotes/origin/main"
 "refs/tags/testtag"
 EOF
@@ -509,6 +518,7 @@ test_expect_success 'Check for invalid refname format' '
 test_expect_success 'set up color tests' '
 	cat >expected.color <<-EOF &&
 	$(git rev-parse --short refs/heads/main) <GREEN>main<RESET>
+	$(git rev-parse --short refs/notes/commits) <GREEN>notes/commits<RESET>
 	$(git rev-parse --short refs/remotes/myfork/main) <GREEN>myfork/main<RESET>
 	$(git rev-parse --short refs/remotes/origin/main) <GREEN>origin/main<RESET>
 	$(git rev-parse --short refs/tags/testtag) <GREEN>testtag<RESET>

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
gitgitgadget
