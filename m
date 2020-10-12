Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E639C43467
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01A82087D
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQYVhnam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404129AbgJLSJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404102AbgJLSJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 14:09:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C7C0613D1
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:09:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d3so18438027wma.4
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=StxlXjv+IFLEsxEMFtiDzQdyEg08Qv5k6leyyRrktjE=;
        b=lQYVhnam4dm/smmZ8dXpgHhlryyhKclnMPsLwslmsjUwO13dT9oJIO+zDdpw/bm3vT
         jta6Ba8gBHOD05J9EwyNMDmSvS/M4U+cTmAV7AXwbclkfFH/Lbg9uj2zdKEuxt7oBQ6P
         +GE3tjnF9C9Nqi1I80C7Ns54FGaWsxGhCQTxN7NRWYFIOUvoAwJ/bFrHG9NP9HSDJv0D
         4O82M8V3z5utp9ezK1UDNSpyljiver2831nyvSF7u3dUvUnn+cPcZs0K5YuDefPMv2kQ
         m/bMQSw0j+TR6es/9N2oz5dKkTq1pNqQPWCQVUZVE6ojo2dmLz+vBNb580uBLwX4q613
         dSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=StxlXjv+IFLEsxEMFtiDzQdyEg08Qv5k6leyyRrktjE=;
        b=QUTUEzkc52/5EeJa40InsGgFbTSCMA5ZLNEYW/CPswNm8LT/E4XCKbqaXmrCcrtGxt
         lFBaXgq6PlbMW7mPPnNzAaMTBKOGZVVO8dfsLyrfeFQXFbpCk6JZUSpYyrv3XeMRTbqs
         coiqckoNSZvsdlzQuGu5VlQ+ahSRUjyLI6LZL5DviPVSQV+DjwiBueto4sdhEyGV6vge
         5szxW3gBHXD217kdcjnzesLzqIv2j0AKr9f9BKXHNe/yrl7JUlxEzD+2Ou7eITIkSjR5
         4MWuCQUkBt4pjNhi7t7CCzRBrUFqsiZkJ9IvRTFCCTUHR/EJgyJPRjFfR0GdPToiTHfY
         Ghag==
X-Gm-Message-State: AOAM533J+8gh0wWD20DbGzJFzDYw4UuLx8IkjzngQFiYKFa6Luo+sUEL
        3FyJsFvTjoflx3GXZVts8r+6wRXepRU=
X-Google-Smtp-Source: ABdhPJwtBPf7AK1IJ7jbDNYjSZEoZ7RKSUlBVSOa3pltXO6mlLaw9tXJBBrWuwHGEK5vyikCQrMSnQ==
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr12401174wmf.104.1602526171525;
        Mon, 12 Oct 2020 11:09:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5sm24387338wmg.42.2020.10.12.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 11:09:31 -0700 (PDT)
Message-Id: <f17d182c3bf5e758490441801423cdb0da17060d.1602526169.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
        <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 18:09:27 +0000
Subject: [PATCH v3 1/3] t: add lib-crlf-messages.sh for messages containing
 CRLF
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

A following commit will fix a bug in the ref-filter API that causes
commit and tag messages containing CRLF to be incorrectly parsed and
displayed.

Add a test library (t/lib-crlf-messages.sh) that creates refs with such
commit messages, so that we can easily test that this bug does not
appear in other commands in the future.

The function `test_crlf_subject_body_and_contents` can be used to test
that the `--format` option of `branch`, `tag`, `for-each-ref` and
`log` correctly displays the subject, body and raw content of commits and
tag messages.

The commits are created using `commit-tree` such that the current branch
in the test repository is not affected when `test_create_crlf_refs` is
called in a test. This is done so that the CRLF tests can be inserted
anywhere in a test script, where it makes sense to do so, without having
to potentially modify further tests that depend on output that would be
modified if the current branch gained new commits.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/lib-crlf-messages.sh | 90 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 t/lib-crlf-messages.sh

diff --git a/t/lib-crlf-messages.sh b/t/lib-crlf-messages.sh
new file mode 100644
index 0000000000..10a2b57280
--- /dev/null
+++ b/t/lib-crlf-messages.sh
@@ -0,0 +1,90 @@
+# Setup refs with commit and tag messages containing CRLF
+
+LIB_CRLF_BRANCHES=""
+
+create_crlf_ref () {
+	message="$1" &&
+	subject="$2" &&
+	body="$3" &&
+	branch="$4" &&
+	printf "${message}" >.crlf-message-${branch}.txt &&
+	printf "${subject}" >.crlf-subject-${branch}.txt &&
+	printf "${body}" >.crlf-body-${branch}.txt &&
+	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}"
+	test_tick &&
+	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
+	git branch ${branch} ${hash} &&
+	git tag tag-${branch} ${branch} -F .crlf-message-${branch}.txt --cleanup=verbatim
+}
+
+create_crlf_refs () {
+	message="Subject first line\r\n\r\nBody first line\r\nBody second line\r\n" &&
+	body="Body first line\r\nBody second line\r\n" &&
+	subject="Subject first line" &&
+	branch="crlf" &&
+	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
+	message="Subject first line\r\n\r\n\r\nBody first line\r\nBody second line\r\n" &&
+	branch="crlf-empty-lines-after-subject" &&
+	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
+	message="Subject first line\r\nSubject second line\r\n\r\nBody first line\r\nBody second line\r\n" &&
+	subject="Subject first line Subject second line" &&
+	branch="crlf-two-line-subject" &&
+	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
+	message="Subject first line\r\nSubject second line" &&
+	subject="Subject first line Subject second line" &&
+	body="" &&
+	branch="crlf-two-line-subject-no-body" &&
+	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
+	message="Subject first line\r\nSubject second line\r\n" &&
+	branch="crlf-two-line-subject-no-body-trailing-newline" &&
+	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
+	message="Subject first line\r\nSubject second line\r\n\r" &&
+	branch="crlf-two-line-subject-no-body-trailing-newline2" &&
+	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}"
+}
+
+test_create_crlf_refs () {
+	test_expect_success 'setup refs with CRLF commit messages' '
+		create_crlf_refs
+	'
+}
+
+cleanup_crlf_refs () {
+	for branch in ${LIB_CRLF_BRANCHES}; do
+		git branch -D ${branch} &&
+		git tag -d tag-${branch} &&
+		rm .crlf-message-${branch}.txt &&
+		rm .crlf-subject-${branch}.txt &&
+		rm .crlf-body-${branch}.txt
+	done
+}
+
+test_cleanup_crlf_refs () {
+	test_expect_success 'cleanup refs with CRLF commit messages' '
+		cleanup_crlf_refs
+	'
+}
+
+test_crlf_subject_body_and_contents() {
+	command_and_args="$@" &&
+	command=$1 &&
+	if [ ${command} = "branch" ] || [ ${command} = "for-each-ref" ] || [ ${command} = "tag" ]; then
+		atoms="(contents:subject) (contents:body) (contents)"
+	elif [ ${command} = "log" ] || [ ${command} = "show" ]; then
+		atoms="s b B"
+	fi &&
+	files="subject body message" &&
+	while  [ -n "${atoms}" ]; do
+		set ${atoms} && atom=$1 && shift && atoms="$*" &&
+		set ${files} &&	file=$1 && shift && files="$*" &&
+		test_expect_success "${command}: --format='%${atom}' works with CRLF input" "
+			rm -f expect &&
+			for ref in ${LIB_CRLF_BRANCHES}; do
+				cat .crlf-${file}-\"\${ref}\".txt >>expect &&
+				printf \"\n\" >>expect
+			done &&
+			git $command_and_args --format=\"%${atom}\" >actual &&
+			test_cmp expect actual
+		"
+	done
+}
-- 
gitgitgadget

