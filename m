Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A359C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8FF2087E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUZUCLfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404133AbgJLSJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404081AbgJLSJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 14:09:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC1BC0613D2
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:09:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k18so18445644wmj.5
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=crw7wFyhVpLM/nhBWkvGBwsUW/OLL8IFmNn1ibYgiMI=;
        b=LUZUCLfTbrjo8c7BopnJwtIjD20C9TQ30SH8NupcD3INFHTS3BURAtMnK87RwGAbk7
         NhPe3XciIMPX/9adnfQfy46yswLKcVbWRIpEs7WCrRN9ggL/fI3I1up94af1Pq8TFvlr
         D3OXM2OWvE5qjTuVm//xgnTlRGbdf7fh1E9ytCO0n5aWpQX9IhtAiJ1q0PFDD+1qRftH
         SVubPv2L454wGhks750n0ZSrahoE8qP3BMkkctbkTqQyz3SqqTeh5C1Ezk3kQHZsePUB
         xVmLfKzX26iF1CynwO/FeHYAyunkDCi6hx55Zjw092AUnZrI6Hwfo10wz9O7K6JeADOZ
         AZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=crw7wFyhVpLM/nhBWkvGBwsUW/OLL8IFmNn1ibYgiMI=;
        b=d6enP3HUtokPFOabMMdStdgTAJ8jg74//XtRYNAA9YktBuaQ1bVBFFPSodFBjvDyjp
         oH+iv4omHTZXkU8JLM1moxJTX0Z8PObj9hsAHDDK0TuNrAXfaGbsXBsWd1UWw/PIuJsc
         WG5oxn3p1RoOAOvRVSw63A5gUqsStF8y+1RUUH0Q7zE8GCGvPYEa+0p45VVsmyox4vaI
         6Nd4GwdgLIUynyY0EHyPdkDRA4yKoyjl9UOiYm+cO88pc7Lr31s0KKVD7r4yfBJWqe+8
         Lt45efF9VKH3eW6emwb1rvZng+dWbMRDJKVtof+fUe92QpaOlj6LXSacMbfyd6zgpauf
         XzKQ==
X-Gm-Message-State: AOAM533Xdu3znplR4Qy/97b6X6nMwUUlZ4VsoITj0HmKSOGI1ksrQ8E/
        eHdv3CkHFAqItf4uqj/aaXTqozcGslM=
X-Google-Smtp-Source: ABdhPJyyfIHC6HEjhSid/1zq3mes2YJI9kYpUTXmOrXcXmfD/dmr7VrqTTGQkivVrDrmWI1KODW2Qg==
X-Received: by 2002:a1c:b78a:: with SMTP id h132mr11999359wmf.172.1602526172355;
        Mon, 12 Oct 2020 11:09:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c21sm23899970wme.36.2020.10.12.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 11:09:31 -0700 (PDT)
Message-Id: <11d044a4f7feccdf20da6364a1f9bbe934e9981f.1602526169.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
        <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 18:09:28 +0000
Subject: [PATCH v3 2/3] ref-filter: handle CRLF at end-of-line more gracefully
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The ref-filter code does not correctly handle commit or tag messages that
use CRLF as the line terminator. Such messages can be created with the
`--verbatim` option of `git commit` and `git tag`, or by using `git
commit-tree` directly.

The function `find_subpos` in ref-filter.c looks for two consecutive
LFs to find the end of the subject line, a sequence which is absent in
messages using CRLF. This results in the whole message being parsed as
the subject line (`%(contents:subject)`), and the body of the message
(`%(contents:body)`)  being empty.

Moreover, in `copy_subject`, which wants to return the subject as a
single line, '\n' is replaced by space, but '\r' is
untouched.

This impacts the output of `git branch`, `git tag` and `git
for-each-ref`.

This bug is a regression for `git branch --verbose`, which
bisects down to 949af0684c (branch: use ref-filter printing APIs,
2017-01-10).

Fix this bug in ref-filter by hardening the logic in `copy_subject` and
`find_subpos` to correctly parse messages containing CRLF.

Add tests for `branch`, `tag` and `for-each-ref` using
lib-crlf-messages.sh.

The 'make commits' test at the beginning of t3203-branch-output.sh does
not use `test_tick` and thus the commit hashes are not reproducible. For
simplicity, use `test_commit` to create the commits, as the content and
name of the files created in this setup test are irrelevant to the rest
of the test script.

Use `test_cleanup_crlf_refs` in t3203-branch-output.sh and t7004-tag.sh
to avoid having to modify the expected output in later tests.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 ref-filter.c             | 36 +++++++++++++++++++++---------------
 t/t3203-branch-output.sh | 31 ++++++++++++++++++++++++++-----
 t/t6300-for-each-ref.sh  |  5 +++++
 t/t7004-tag.sh           |  7 +++++++
 4 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index c62f6b4822..92d8ca5340 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1097,14 +1097,18 @@ static const char *copy_email(const char *buf, struct used_atom *atom)
 
 static char *copy_subject(const char *buf, unsigned long len)
 {
-	char *r = xmemdupz(buf, len);
-	int i;
+	struct strbuf sb = STRBUF_INIT;
 
-	for (i = 0; i < len; i++)
-		if (r[i] == '\n')
-			r[i] = ' ';
+	for (int i = 0; i < len; i++) {
+		if (buf[i] == '\r' && i + 1 < len && buf[i + 1] == '\n')
+			continue; /* ignore CR in CRLF */
 
-	return r;
+		if (buf[i] == '\n')
+			strbuf_addch(&sb, ' ');
+		else
+			strbuf_addch(&sb, buf[i]);
+	}
+	return strbuf_detach(&sb, NULL);
 }
 
 static void grab_date(const char *buf, struct atom_value *v, const char *atomname)
@@ -1228,20 +1232,22 @@ static void find_subpos(const char *buf,
 
 	/* subject is first non-empty line */
 	*sub = buf;
-	/* subject goes to first empty line */
-	while (buf < *sig && *buf && *buf != '\n') {
-		eol = strchrnul(buf, '\n');
-		if (*eol)
-			eol++;
-		buf = eol;
-	}
+	/* subject goes to first empty line before signature begins */
+	if ((eol = strstr(*sub, "\n\n"))) {
+		eol = eol < *sig ? eol : *sig;
+	/* check if message uses CRLF */
+	} else if (! (eol = strstr(*sub, "\r\n\r\n"))) {
+		/* treat whole message as subject */
+		eol = strrchr(*sub, '\0');
+	}
+	buf = eol;
 	*sublen = buf - *sub;
 	/* drop trailing newline, if present */
-	if (*sublen && (*sub)[*sublen - 1] == '\n')
+	while (*sublen && ((*sub)[*sublen - 1] == '\n' || (*sub)[*sublen - 1] == '\r'))
 		*sublen -= 1;
 
 	/* skip any empty lines */
-	while (*buf == '\n')
+	while (*buf == '\n' || *buf == '\r')
 		buf++;
 	*body = buf;
 	*bodylen = strlen(buf);
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 71818b90f0..c06eca774f 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -3,13 +3,11 @@
 test_description='git branch display tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
+. "$TEST_DIRECTORY"/lib-crlf-messages.sh
 
 test_expect_success 'make commits' '
-	echo content >file &&
-	git add file &&
-	git commit -m one &&
-	echo content >>file &&
-	git commit -a -m two
+	test_commit one &&
+	test_commit two
 '
 
 test_expect_success 'make branches' '
@@ -95,6 +93,29 @@ test_expect_success 'git branch --ignore-case --list -v pattern shows branch sum
 	awk "{print \$NF}" <tmp >actual &&
 	test_cmp expect actual
 '
+test_create_crlf_refs
+
+test_expect_success 'git branch -v works with CRLF input' '
+	cat >expect <<-EOF &&
+	  two
+	  one
+	  Subject first line
+	  Subject first line
+	  Subject first line Subject second line
+	  Subject first line Subject second line
+	  Subject first line Subject second line
+	  Subject first line Subject second line
+	EOF
+	git branch -v >tmp &&
+	# Remove first two columns, and the line for the currently checked out branch
+	current=$(git branch --show-current) &&
+	grep -v $current <tmp | awk "{\$1=\$2=\"\"}1"  >actual &&
+	test_cmp expect actual
+'
+
+test_crlf_subject_body_and_contents branch --list crlf*
+
+test_cleanup_crlf_refs
 
 test_expect_success 'git branch -v pattern does not show branch summaries' '
 	test_must_fail git branch -v branch*
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b359023189..c30940cf7a 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -8,6 +8,7 @@ test_description='for-each-ref test'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
+. "$TEST_DIRECTORY"/lib-crlf-messages.sh
 
 # Mon Jul 3 23:18:43 2006 +0000
 datestamp=1151968723
@@ -1030,4 +1031,8 @@ test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
 	test_cmp expect actual
 '
 
+test_create_crlf_refs
+
+test_crlf_subject_body_and_contents for-each-ref refs/heads/crlf*
+
 test_done
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 05f411c821..cda735dab4 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -10,6 +10,7 @@ Tests for operations with tags.'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
+. "$TEST_DIRECTORY"/lib-crlf-messages.sh
 
 # creating and listing lightweight tags:
 
@@ -1970,6 +1971,12 @@ test_expect_success '--format should list tags as per format given' '
 	test_cmp expect actual
 '
 
+test_create_crlf_refs
+
+test_crlf_subject_body_and_contents tag --list tag-crlf*
+
+test_cleanup_crlf_refs
+
 test_expect_success "set up color tests" '
 	echo "<RED>v1.0<RESET>" >expect.color &&
 	echo "v1.0" >expect.bare &&
-- 
gitgitgadget

