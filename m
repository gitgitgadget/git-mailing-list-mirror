Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D8C55178
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 12:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646772076B
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 12:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUgZ5zr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgJ2Mse (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ2Msd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 08:48:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0434EC0613D2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 05:48:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b8so2659059wrn.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0IUZw8WISCun1chNdvLNvDoqC3+7Qelqg4Brhfvd8nE=;
        b=BUgZ5zr2AjVmXB2f9o66eDktccVCjVIv7WeaHsQWp0hc/vuLqmSIWfCRDTVD+AztGj
         sjooT9P1DHYyUEuSJOGNR5lai+3tz8hrjNuKIMPbdY401+eC1xrPl/HsXCR+RldmCTY+
         oYk+IF4s0z85L+h4HeH2QIb8yptpUGhoNR1G1iisWb0+dV3vVA1qXLW4Hm6sxJqSCFnd
         77KytRLOY0b0iUXQyZ7H/YZEIDRzfnUwNyLZ1olxTm16Kz2PLDIYU00LdVuHVfH7hGrC
         5NniVmwlXmC5wQaIDAUf0et2LEcKaSHpEYiqs9721U/6ksaf3AwyjRZLL+29DPt6GLw8
         1Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0IUZw8WISCun1chNdvLNvDoqC3+7Qelqg4Brhfvd8nE=;
        b=JYMzPk3hSFHXLo050azIf/dvgCbDklzam1RdmyjnHWO+KOulDHo9smd0zP0dqZ3Z+C
         hGntRohV01UHyFrthanENRKLbzcgje61kzu43qoNusha9P4wh74DV90gFQRRv/TRP0o8
         AgSmb6rJn1s/oitb9x8zbu3RT0kSr4bB9dytUN2tRnLMO0nXpL+swoeWnKEXdLsCA9An
         HmOQCDreqkJA0q7trgwwTRug0HwiRCyOQSsu4tUdk/eHE6wIZYhGOk5GAiMauX/cspou
         wVTzR79luWWEJ4z3pjxZRuVI2YFWBiNBkZTTgiQkq4iN9OcecR3v8Gw57D/kgp5nngpe
         wEbg==
X-Gm-Message-State: AOAM532M0xNk1ZafWd/s55hKhDnVFnXk9ROTm9sfBGvF1DYj1dsTikoV
        kcB9rLsrj3xHmCJpTJQPWmmMKaoeQ3E=
X-Google-Smtp-Source: ABdhPJwYobbaXl/5L+TIwrPLF2wcCOzUAZyWSy7QJ/ppe0vrU/8Rm6x+FLZbURv6DMJ1pwy1WYkySQ==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr5889235wrc.276.1603975711538;
        Thu, 29 Oct 2020 05:48:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm5021545wrh.0.2020.10.29.05.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:48:30 -0700 (PDT)
Message-Id: <06231c315ff6e5a1065b5a77350d7cdc307f760b.1603975709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.v5.git.1603975709.gitgitgadget@gmail.com>
References: <pull.576.v4.git.1603335680.gitgitgadget@gmail.com>
        <pull.576.v5.git.1603975709.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Oct 2020 12:48:28 +0000
Subject: [PATCH v5 1/2] ref-filter: handle CRLF at end-of-line more gracefully
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The ref-filter code does not correctly handle commit or tag messages
that use CRLF as the line terminator. Such messages can be created with
the `--cleanup=verbatim` option of `git commit` and `git tag`, or by
using `git commit-tree` directly.

The function `find_subpos` in ref-filter.c looks for two consecutive
LFs to find the end of the subject line, a sequence which is absent in
messages using CRLF. This results in the whole message being parsed as
the subject line (`%(contents:subject)`), and the body of the message
(`%(contents:body)`) being empty.

Moreover, in `copy_subject`, which wants to return the subject as a
single line, '\n' is replaced by space, but '\r' is
untouched.

This impacts the output of `git branch`, `git tag` and `git
for-each-ref`.

This behaviour is a regression for `git branch --verbose`, which
bisects down to 949af0684c (branch: use ref-filter printing APIs,
2017-01-10).

Adjust the ref-filter code to be more lenient by hardening the logic in
`copy_subject` and `find_subpos` to correctly parse messages containing
CRLF.

Add a new test script, 't3920-crlf-messages.sh', to test the behaviour
of commands using either the ref-filter or the pretty APIs with messages
using CRLF line endings. The function `test_crlf_subject_body_and_contents`
can be used to test that the `--format` option of `branch`, `tag`,
`for-each-ref`, `log` and `show` correctly displays the subject, body
and raw content of commit and tag messages using CRLF. Test the
output of `branch`, `tag` and `for-each-ref` with such commits.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 ref-filter.c             |  36 ++++++++-----
 t/t3920-crlf-messages.sh | 108 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 14 deletions(-)
 create mode 100755 t/t3920-crlf-messages.sh

diff --git a/ref-filter.c b/ref-filter.c
index c62f6b4822..6476686fea 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1097,14 +1097,19 @@ static const char *copy_email(const char *buf, struct used_atom *atom)
 
 static char *copy_subject(const char *buf, unsigned long len)
 {
-	char *r = xmemdupz(buf, len);
+	struct strbuf sb = STRBUF_INIT;
 	int i;
 
-	for (i = 0; i < len; i++)
-		if (r[i] == '\n')
-			r[i] = ' ';
+	for (i = 0; i < len; i++) {
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
@@ -1228,20 +1233,23 @@ static void find_subpos(const char *buf,
 
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
+	while (*sublen && ((*sub)[*sublen - 1] == '\n' ||
+			   (*sub)[*sublen - 1] == '\r'))
 		*sublen -= 1;
 
 	/* skip any empty lines */
-	while (*buf == '\n')
+	while (*buf == '\n' || *buf == '\r')
 		buf++;
 	*body = buf;
 	*bodylen = strlen(buf);
diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
new file mode 100755
index 0000000000..3f0ce02c3f
--- /dev/null
+++ b/t/t3920-crlf-messages.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+
+test_description='Test ref-filter and pretty APIs for commit and tag messages using CRLF'
+. ./test-lib.sh
+
+LIB_CRLF_BRANCHES=""
+
+create_crlf_ref () {
+	branch="$1" &&
+	cat >.crlf-orig-$branch.txt &&
+	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
+	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | tr -d '\n' >.crlf-subject-$branch.txt &&
+	grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true &&
+	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}" &&
+	test_tick &&
+	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
+	git branch ${branch} ${hash} &&
+	git tag tag-${branch} ${branch} -F .crlf-message-${branch}.txt --cleanup=verbatim
+}
+
+create_crlf_refs () {
+	create_crlf_ref crlf <<-\EOF &&
+	Subject first line
+
+	Body first line
+	Body second line
+	EOF
+	create_crlf_ref crlf-empty-lines-after-subject <<-\EOF &&
+	Subject first line
+
+
+	Body first line
+	Body second line
+	EOF
+	create_crlf_ref crlf-two-line-subject <<-\EOF &&
+	Subject first line
+	Subject second line
+
+	Body first line
+	Body second line
+	EOF
+	create_crlf_ref crlf-two-line-subject-no-body <<-\EOF &&
+	Subject first line
+	Subject second line
+	EOF
+	create_crlf_ref crlf-two-line-subject-no-body-trailing-newline <<-\EOF
+	Subject first line
+	Subject second line
+
+	EOF
+}
+
+test_crlf_subject_body_and_contents() {
+	command_and_args="$@" &&
+	command=$1 &&
+	if test ${command} = "branch" || test ${command} = "for-each-ref" || test ${command} = "tag"
+	then
+		atoms="(contents:subject) (contents:body) (contents)"
+	elif test ${command} = "log" || test ${command} = "show"
+	then
+		atoms="s b B"
+	fi &&
+	files="subject body message" &&
+	while test -n "${atoms}"
+	do
+		set ${atoms} && atom=$1 && shift && atoms="$*" &&
+		set ${files} &&	file=$1 && shift && files="$*" &&
+		test_expect_success "${command}: --format='%${atom}' works with messages using CRLF" "
+			rm -f expect &&
+			for ref in ${LIB_CRLF_BRANCHES}
+			do
+				cat .crlf-${file}-\"\${ref}\".txt >>expect &&
+				printf \"\n\" >>expect
+			done &&
+			git $command_and_args --format=\"%${atom}\" >actual &&
+			test_cmp expect actual
+		"
+	done
+}
+
+
+test_expect_success 'Setup refs with commit and tag messages using CRLF' '
+	test_commit inital &&
+	create_crlf_refs
+'
+
+test_expect_success 'branch: --verbose works with messages using CRLF' '
+	rm -f expect &&
+	for branch in $LIB_CRLF_BRANCHES
+	do
+		printf "  " >>expect &&
+		cat .crlf-subject-${branch}.txt >>expect &&
+		printf "\n" >>expect
+	done &&
+	git branch -v >tmp &&
+	# Remove first two columns, and the line for the currently checked out branch
+	current=$(git branch --show-current) &&
+	grep -v $current <tmp | awk "{\$1=\$2=\"\"}1"  >actual &&
+	test_cmp expect actual
+'
+
+test_crlf_subject_body_and_contents branch --list crlf*
+
+test_crlf_subject_body_and_contents tag --list tag-crlf*
+
+test_crlf_subject_body_and_contents for-each-ref refs/heads/crlf*
+
+test_done
-- 
gitgitgadget

