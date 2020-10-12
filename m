Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274B1C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F78120776
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZHnk3rK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404130AbgJLSJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403994AbgJLSJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 14:09:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AA1C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:09:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j136so18449218wmj.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nWqcfW7IkLNzg5ke9obXc7jK+F6gla53bnfQ3VWCIp8=;
        b=uZHnk3rKcejNRSuwRSIaS++bmUoddHPA0T7ucxWu+E70ppfhJl1fs3SqQb02VGoaQT
         I7ZCYo5gFZoRg4zPLzn9ylRVMQ6sVVLlDyVno1lVfeC/JjJ4yiWgPFUClfqDPnEQsvUu
         7blS2TVMAfaTJ/QJAxzQQlzvtuo8BtFem0N3/WYcYBMrRBPKztDVtJKasW2MN0mhzDgt
         89p/f/nmqtOWWRxUvtru0KhTjorSTh2aMJf1LBYO+OELO3cnFfT93OY8CsWpqD4rS97Q
         jiC0StlqQtOfC3rMzEQruJAEc5GwFIPY3HuKoPkdqJWldNt5FxEuSMuxmOyUKp1MU/cd
         FD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nWqcfW7IkLNzg5ke9obXc7jK+F6gla53bnfQ3VWCIp8=;
        b=JEd2iS+6oBJUqajbwYg3WWAj2b6yBgC1ahzvllR9jjXxQbgU+zNdivretkFKZ6s6SQ
         eZppPsmXhr2gnyHGdJcyFPv+TmMNm+hEMEDuFuh0kM+IHpVIgxO6ncaSfvz5ngzqq1yu
         9D6yMOy+oqW0+cN9XriJFazv23spis6gTB1wvQl1FNljSCwRHzg1wNA9BIftS/z0i4Ty
         k6cyKAWqRWw7dG+R8JJoOf4hEVce3aJDAvlQvdEhYtb9pIcaAekdJwR7QrmnpyHiD10s
         OJMgUc3IsI9QceyQGqOwqIjZRSTXhEerzQDJL0vva2wKZciNC8dXlTKxEOk+LBRLArsu
         ufcQ==
X-Gm-Message-State: AOAM5302VlJCcAEMhjzlNKMfY/3Pry8hNMctX1pWr9mMm/v7P21GJBnn
        7d2fVpQI2Z+/j8q87HI7mr10uzDJThQ=
X-Google-Smtp-Source: ABdhPJxqVwb7dZu/8d1pT5SHkOGxZzrwM+eqCpMMXl5eLnDSQICASOz2lXQVWySPvPfRgbK16qw9HA==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr4188606wma.57.1602526170659;
        Mon, 12 Oct 2020 11:09:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o184sm3224208wmo.37.2020.10.12.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 11:09:30 -0700 (PDT)
Message-Id: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 18:09:26 +0000
Subject: [PATCH v3 0/3] ref-filter: handle CRLF at end-of-line more gracefully
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
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * in response to Junio's comments, improved the logic in 'find_subpos'. I
   tried to also simplify the code by using 'str*' functions, to make it
   more obvious what the code is actually looking for in the message. 
 * took Junio's suggestion for 'copy_subject'
 * in response to Junio's comments, tweaked the commit message for patch 2/3 
 * refactored 'lib-crlf-messages.sh' to reduce duplication (patch 1/3)
 * added tests for 'git show' in patch 3/3 
 * removed commit hashes in tests to make them hash-agnostic


----------------------------------------------------------------------------

The ref-filter code does not correctly handle commit or tag messages that
use CRLF as the line terminator. Such messages can be created with the
--verbatim option of git commit and git tag, or by using git commit-tree 
directly.

The function find_subpos in ref-filter.c looks for two consecutive '\n' to
find the end of the subject line, a sequence which is absent in messages
using CRLF. This results in the whole message being parsed as the subject
line (%(contents:subject)), and the body of the message (%(contents:body))
being empty.

Moreover, in copy_subject, '\n' is replaced by space, but '\r' is untouched.

This bug is a regression for git branch --verbose, which bisects down to
949af06 (branch: use ref-filter printing APIs, 2017-01-10).

The first patch in this series adds a new test library, 
t/lib-crlf-messages.sh, that contains functions to test this behaviour for
commands using either the ref-filter or the pretty API to display messages. 

The second patch fixes the bug in ref-filter.c and adds corresponding tests.

Finally, the third patch adds a test that checks the behaviour of git log 
andgit show in the presence of CRLF in messages, to prevent futur
regressions.


----------------------------------------------------------------------------

v2:

The ref-filter API does not correctly handle commit or tag messages that use
CRLF as the line terminator. Such messages can be created with the--verbatim 
option of git commit and git tag, or by using git commit-tree directly.

This impacts the output git branch, git tag and git for-each-refwhen used
with a --format argument containing the atoms%(contents:subject) or 
%(contents:body), as well as the output ofgit branch --verbose, which uses 
%(contents:subject) internally.

The function find_subpos in ref-filter.c looks for two consecutive '\n' to
find the end of the subject line, a sequence which is absent in messages
using CRLF. This results in the whole message being parsed as the subject
line (%(contents:subject)), and the body of the message (%(contents:body))
being empty.

Moreover, in copy_subject, '\n' is replaced by space, but '\r' is untouched,
resulting in the escape sequence '^M' being output verbatim in most terminal
emulators:

$ git branch --verbose
* crlf    2113b0e Subject first line^M ^M Body first line^M Body second line

This bug is a regression for git branch --verbose, which bisects down to
949af06 (branch: use ref-filter printing APIs, 2017-01-10).

The first patch in this series adds a new test library, 
t/lib-crlf-messages.sh, that contains functions to test this behaviour for
commands using either the ref-filter or the pretty API to display messages. 

The second patch fixes the bug in ref-filter.c and adds corresponding tests.

Finally, the third patch adds a test that checks the behaviour of git log in
the presence of CRLF in messages, to prevent futur regressions.

changes since v1:

 * improved the cover letter and the commit message of the 2nd patch to
   actually describe the bug this series is fixing


----------------------------------------------------------------------------

v1:

The ref-filter API does not correctly handle commit or tag messages that use
CRLF as the line terminator. Such messages can be created with the--verbatim 
option of git commit and git tag, or by using git commit-tree directly.

This impacts the output of git branch -v, and git branch, git tag and git
for-each-ref when used with a --format argument containing the atoms 
%(contents:subject) or %(contents:body).

The first patch in this series adds a new test library, 
t/lib-crlf-messages.sh, that contains functions to test this behaviour for
commands using either the ref-filter or the pretty API to display messages. 

The second patch fixes the bug in ref-filter.c and adds corresponding tests.

Finally, the third patch adds a test that checks the behaviour of git log in
the presence of CRLF in messages, to prevent futur regressions.

Philippe Blain (3):
  t: add lib-crlf-messages.sh for messages containing CRLF
  ref-filter: handle CRLF at end-of-line more gracefully
  log, show: add tests for messages containing CRLF

 ref-filter.c             | 36 +++++++++-------
 t/lib-crlf-messages.sh   | 90 ++++++++++++++++++++++++++++++++++++++++
 t/t3203-branch-output.sh | 31 +++++++++++---
 t/t4202-log.sh           | 18 ++++++++
 t/t6300-for-each-ref.sh  |  5 +++
 t/t7004-tag.sh           |  7 ++++
 t/t7007-show.sh          |  5 +++
 7 files changed, 172 insertions(+), 20 deletions(-)
 create mode 100644 t/lib-crlf-messages.sh


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-576%2Fphil-blain%2Ffix-branch-verbose-crlf-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-576/phil-blain/fix-branch-verbose-crlf-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/576

Range-diff vs v2:

 1:  b252113803 ! 1:  f17d182c3b t: add lib-crlf-messages.sh for messages containing CRLF
     @@ Commit message
          commit messages, so that we can easily test that this bug does not
          appear in other commands in the future.
      
     -    The function test_crlf_subject_body_and_contents can be used to test
     +    The function `test_crlf_subject_body_and_contents` can be used to test
          that the `--format` option of `branch`, `tag`, `for-each-ref` and
     -    `log` correctly displays the subject, body and raw body of commits and
     +    `log` correctly displays the subject, body and raw content of commits and
          tag messages.
      
          The commits are created using `commit-tree` such that the current branch
          in the test repository is not affected when `test_create_crlf_refs` is
     -    called in a test. This is to done so that the CRLF tests can be inserted
     -    anywhere in a test script where it makes sense to do so, without having
     -    to potentially modify further test that depend on output that would be
     +    called in a test. This is done so that the CRLF tests can be inserted
     +    anywhere in a test script, where it makes sense to do so, without having
     +    to potentially modify further tests that depend on output that would be
          modified if the current branch gained new commits.
      
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
     @@ t/lib-crlf-messages.sh (new)
      @@
      +# Setup refs with commit and tag messages containing CRLF
      +
     ++LIB_CRLF_BRANCHES=""
     ++
      +create_crlf_ref () {
      +	message="$1" &&
      +	subject="$2" &&
     @@ t/lib-crlf-messages.sh (new)
      +	printf "${message}" >.crlf-message-${branch}.txt &&
      +	printf "${subject}" >.crlf-subject-${branch}.txt &&
      +	printf "${body}" >.crlf-body-${branch}.txt &&
     -+    test_tick &&
     ++	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}"
     ++	test_tick &&
      +	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
      +	git branch ${branch} ${hash} &&
      +	git tag tag-${branch} ${branch} -F .crlf-message-${branch}.txt --cleanup=verbatim
     @@ t/lib-crlf-messages.sh (new)
      +	message="Subject first line\r\n\r\nBody first line\r\nBody second line\r\n" &&
      +	body="Body first line\r\nBody second line\r\n" &&
      +	subject="Subject first line" &&
     -+	create_crlf_ref "${message}" "${subject}" "${body}" "crlf" &&
     ++	branch="crlf" &&
     ++	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
      +	message="Subject first line\r\n\r\n\r\nBody first line\r\nBody second line\r\n" &&
     -+	create_crlf_ref "${message}" "${subject}" "${body}" "crlf-empty-lines-after-subject" &&
     ++	branch="crlf-empty-lines-after-subject" &&
     ++	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
      +	message="Subject first line\r\nSubject second line\r\n\r\nBody first line\r\nBody second line\r\n" &&
      +	subject="Subject first line Subject second line" &&
     -+	create_crlf_ref "${message}" "${subject}" "${body}" "crlf-two-line-subject"
     ++	branch="crlf-two-line-subject" &&
     ++	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
     ++	message="Subject first line\r\nSubject second line" &&
     ++	subject="Subject first line Subject second line" &&
     ++	body="" &&
     ++	branch="crlf-two-line-subject-no-body" &&
     ++	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
     ++	message="Subject first line\r\nSubject second line\r\n" &&
     ++	branch="crlf-two-line-subject-no-body-trailing-newline" &&
     ++	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
     ++	message="Subject first line\r\nSubject second line\r\n\r" &&
     ++	branch="crlf-two-line-subject-no-body-trailing-newline2" &&
     ++	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}"
      +}
      +
      +test_create_crlf_refs () {
     @@ t/lib-crlf-messages.sh (new)
      +}
      +
      +cleanup_crlf_refs () {
     -+	for branch in crlf crlf-empty-lines-after-subject crlf-two-line-subject; do
     ++	for branch in ${LIB_CRLF_BRANCHES}; do
      +		git branch -D ${branch} &&
      +		git tag -d tag-${branch} &&
      +		rm .crlf-message-${branch}.txt &&
     @@ t/lib-crlf-messages.sh (new)
      +}
      +
      +test_cleanup_crlf_refs () {
     -+	test_expect_success 'clenup refs with CRLF commit messages' '
     ++	test_expect_success 'cleanup refs with CRLF commit messages' '
      +		cleanup_crlf_refs
      +	'
      +}
     @@ t/lib-crlf-messages.sh (new)
      +	command=$1 &&
      +	if [ ${command} = "branch" ] || [ ${command} = "for-each-ref" ] || [ ${command} = "tag" ]; then
      +		atoms="(contents:subject) (contents:body) (contents)"
     -+	elif [ ${command} = "log" ]; then
     ++	elif [ ${command} = "log" ] || [ ${command} = "show" ]; then
      +		atoms="s b B"
      +	fi &&
      +	files="subject body message" &&
     @@ t/lib-crlf-messages.sh (new)
      +		set ${files} &&	file=$1 && shift && files="$*" &&
      +		test_expect_success "${command}: --format='%${atom}' works with CRLF input" "
      +			rm -f expect &&
     -+			for ref in crlf crlf-empty-lines-after-subject crlf-two-line-subject; do
     ++			for ref in ${LIB_CRLF_BRANCHES}; do
      +				cat .crlf-${file}-\"\${ref}\".txt >>expect &&
      +				printf \"\n\" >>expect
      +			done &&
 2:  aab1f45ba9 ! 2:  11d044a4f7 ref-filter: fix the API to correctly handle CRLF
     @@ Metadata
      Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Commit message ##
     -    ref-filter: fix the API to correctly handle CRLF
     +    ref-filter: handle CRLF at end-of-line more gracefully
      
     -    The ref-filter API does not correctly handle commit or tag messages that
     +    The ref-filter code does not correctly handle commit or tag messages that
          use CRLF as the line terminator. Such messages can be created with the
          `--verbatim` option of `git commit` and `git tag`, or by using `git
          commit-tree` directly.
      
     -    This impacts the output `git branch`, `git tag` and `git for-each-ref`
     -    when used with a `--format` argument containing the atoms
     -    `%(contents:subject)` or `%(contents:body)`, as well as the output of
     -    `git branch --verbose`, which uses `%(contents:subject)` internally.
     -
     -    The function find_subpos in ref-filter.c looks for two consecutive '\n'
     -    to find the end of the subject line, a sequence which is absent in
     +    The function `find_subpos` in ref-filter.c looks for two consecutive
     +    LFs to find the end of the subject line, a sequence which is absent in
          messages using CRLF. This results in the whole message being parsed as
          the subject line (`%(contents:subject)`), and the body of the message
          (`%(contents:body)`)  being empty.
      
     -    Moreover, in copy_subject, '\n' is replaced by space, but '\r' is
     -    untouched, resulting in the escape sequence '^M' being output verbatim
     -    in most terminal emulators:
     +    Moreover, in `copy_subject`, which wants to return the subject as a
     +    single line, '\n' is replaced by space, but '\r' is
     +    untouched.
      
     -        $ git branch --verbose
     -        * crlf    2113b0e Subject first line^M ^M Body first line^M Body second line
     +    This impacts the output of `git branch`, `git tag` and `git
     +    for-each-ref`.
      
          This bug is a regression for `git branch --verbose`, which
          bisects down to 949af0684c (branch: use ref-filter printing APIs,
          2017-01-10).
      
          Fix this bug in ref-filter by hardening the logic in `copy_subject` and
     -    `find_subpos` to correctly parse messages containing CRFL.
     +    `find_subpos` to correctly parse messages containing CRLF.
      
          Add tests for `branch`, `tag` and `for-each-ref` using
          lib-crlf-messages.sh.
      
     -    The 'make commits' test at the beginning of t3203-branch-output.sh needs
     -    to be modified since it did not use `test_tick` and thus the commit
     -    hashes were not reproducible. For simplicity, use `test_commit` as the
     -    content and name of the files created in this setup test are irrelevant
     -    to the rest of the test script.
     +    The 'make commits' test at the beginning of t3203-branch-output.sh does
     +    not use `test_tick` and thus the commit hashes are not reproducible. For
     +    simplicity, use `test_commit` to create the commits, as the content and
     +    name of the files created in this setup test are irrelevant to the rest
     +    of the test script.
      
     -    `test_cleanup_crlf_refs` is used in t3203-branch-output.sh and
     -    t7004-tag.sh to avoid having to modify the expected output in later
     -    tests.
     +    Use `test_cleanup_crlf_refs` in t3203-branch-output.sh and t7004-tag.sh
     +    to avoid having to modify the expected output in later tests.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## ref-filter.c ##
     -@@ ref-filter.c: static char *copy_subject(const char *buf, unsigned long len)
     +@@ ref-filter.c: static const char *copy_email(const char *buf, struct used_atom *atom)
     + 
     + static char *copy_subject(const char *buf, unsigned long len)
       {
     - 	char *r = xmemdupz(buf, len);
     - 	int i;
     +-	char *r = xmemdupz(buf, len);
     +-	int i;
      +	struct strbuf sb = STRBUF_INIT;
       
      -	for (i = 0; i < len; i++)
     -+	strbuf_attach(&sb, r, len, len + 1);
     -+	for (i = 0; i < sb.len; i++) {
     - 		if (r[i] == '\n')
     - 			r[i] = ' ';
     -+		if (r[i] == '\r') {
     -+			strbuf_remove(&sb, i, 1);
     -+			i -= 1;
     -+		}
     -+	}
     -+	strbuf_detach(&sb, NULL);
     +-		if (r[i] == '\n')
     +-			r[i] = ' ';
     ++	for (int i = 0; i < len; i++) {
     ++		if (buf[i] == '\r' && i + 1 < len && buf[i + 1] == '\n')
     ++			continue; /* ignore CR in CRLF */
       
     - 	return r;
     +-	return r;
     ++		if (buf[i] == '\n')
     ++			strbuf_addch(&sb, ' ');
     ++		else
     ++			strbuf_addch(&sb, buf[i]);
     ++	}
     ++	return strbuf_detach(&sb, NULL);
       }
     + 
     + static void grab_date(const char *buf, struct atom_value *v, const char *atomname)
      @@ ref-filter.c: static void find_subpos(const char *buf,
     - 		eol = strchrnul(buf, '\n');
     - 		if (*eol)
     - 			eol++;
     -+		/*  protect against messages that might contain \r\n */
     -+		if (*eol == '\r')
     -+			eol++;
     - 		buf = eol;
     - 	}
     + 
     + 	/* subject is first non-empty line */
     + 	*sub = buf;
     +-	/* subject goes to first empty line */
     +-	while (buf < *sig && *buf && *buf != '\n') {
     +-		eol = strchrnul(buf, '\n');
     +-		if (*eol)
     +-			eol++;
     +-		buf = eol;
     +-	}
     ++	/* subject goes to first empty line before signature begins */
     ++	if ((eol = strstr(*sub, "\n\n"))) {
     ++		eol = eol < *sig ? eol : *sig;
     ++	/* check if message uses CRLF */
     ++	} else if (! (eol = strstr(*sub, "\r\n\r\n"))) {
     ++		/* treat whole message as subject */
     ++		eol = strrchr(*sub, '\0');
     ++	}
     ++	buf = eol;
       	*sublen = buf - *sub;
       	/* drop trailing newline, if present */
     - 	if (*sublen && (*sub)[*sublen - 1] == '\n')
     +-	if (*sublen && (*sub)[*sublen - 1] == '\n')
     ++	while (*sublen && ((*sub)[*sublen - 1] == '\n' || (*sub)[*sublen - 1] == '\r'))
       		*sublen -= 1;
     -+	/*  protect against commit messages that might contain \r\n */
     -+	else if (*sublen && (*sub)[*sublen - 1] == '\r')
     -+		*sublen -= 3; /* drop '\r\n\r' */
       
       	/* skip any empty lines */
      -	while (*buf == '\n')
     -+	/* and protect against commit messages that might contain \r\n */
      +	while (*buf == '\n' || *buf == '\r')
       		buf++;
       	*body = buf;
     @@ t/t3203-branch-output.sh: test_expect_success 'git branch --ignore-case --list -
      +
      +test_expect_success 'git branch -v works with CRLF input' '
      +	cat >expect <<-EOF &&
     -+	  branch-one                     139b20d two
     -+	  branch-two                     d79ce16 one
     -+	  crlf                           2113b0e Subject first line
     -+	  crlf-empty-lines-after-subject 0a9530d Subject first line
     -+	  crlf-two-line-subject          f9ded1f Subject first line Subject second line
     -+	* master                         139b20d two
     ++	  two
     ++	  one
     ++	  Subject first line
     ++	  Subject first line
     ++	  Subject first line Subject second line
     ++	  Subject first line Subject second line
     ++	  Subject first line Subject second line
     ++	  Subject first line Subject second line
      +	EOF
     -+	git branch -v >actual &&
     ++	git branch -v >tmp &&
     ++	# Remove first two columns, and the line for the currently checked out branch
     ++	current=$(git branch --show-current) &&
     ++	grep -v $current <tmp | awk "{\$1=\$2=\"\"}1"  >actual &&
      +	test_cmp expect actual
      +'
      +
     @@ t/t6300-for-each-ref.sh: test_description='for-each-ref test'
       
       # Mon Jul 3 23:18:43 2006 +0000
       datestamp=1151968723
     -@@ t/t6300-for-each-ref.sh: test_expect_success 'for-each-ref --ignore-case ignores case' '
     +@@ t/t6300-for-each-ref.sh: test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
       	test_cmp expect actual
       '
       
 3:  c84092e457 ! 3:  59957d1391 log: add tests for messages containing CRLF to t4202
     @@ Metadata
      Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Commit message ##
     -    log: add tests for messages containing CRLF to t4202
     +    log, show: add tests for messages containing CRLF
      
     -    A previous commit fixed a bug in the ref-filter API causing messages
     +    A previous commit fixed a bug in ref-filter.c causing messages
          containing CRLF to be incorrectly parsed and displayed.
      
     -    Add a test to also check that `git log` correctly handles such messages,
     -    to prevent futur regressions.
     +    Add tests to also check that `git log` and `git show` correctly handle
     +    such messages, to prevent futur regressions if these commands are
     +    refactored to use the ref-filter API.
     +
     +    To prevent having to modify expected output in further tests, use
     +    'test_cleanup_crlf_refs' in t4202 to clean-up after the added tests.
      
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
     @@ t/t4202-log.sh: test_expect_success 'oneline' '
      +test_create_crlf_refs
      +
      +test_expect_success 'oneline with CRLF messages' '
     -+	echo "002093e Subject first line" >expect &&
     -+	git log --oneline -1 crlf >actual-branch &&
     -+	git log --oneline -1 tag-crlf >actual-tag &&
     -+	test_cmp expect actual-branch &&
     -+	test_cmp expect actual-tag &&
     -+	echo "6f814b0 Subject first line" >expect &&
     -+	git log --oneline -1 crlf-empty-lines-after-subject >actual-branch &&
     -+	git log --oneline -1 tag-crlf-empty-lines-after-subject >actual-tag &&
     -+	test_cmp expect actual-branch &&
     -+	test_cmp expect actual-tag &&
     -+	echo "8c58a85 Subject first line Subject second line" >expect &&
     -+	git log --oneline -1 crlf-two-line-subject >actual-branch &&
     -+	git log --oneline -1 tag-crlf-two-line-subject >actual-tag &&
     -+	test_cmp expect actual-branch &&
     -+	test_cmp expect actual-tag
     ++	for branch in $LIB_CLRF_BRANCHES; do
     ++		cat .crlf-subject-${branch}.txt >expect &&
     ++		git log --oneline -1 ${branch} >tmp-branch &&
     ++		git log --oneline -1 tag-${branch} >tmp-tag &&
     ++		awk "{print \$NF}" <tmp-branch >actual-branch &&
     ++		awk "{print \$NF}" <tmp-tag >actual-tag &&
     ++		test_cmp expect actual-branch &&
     ++		test_cmp expect actual-tag
     ++	done
      +'
      +test_crlf_subject_body_and_contents log --all --reverse --grep Subject
      +
     @@ t/t4202-log.sh: test_expect_success 'oneline' '
       test_expect_success 'diff-filter=A' '
       
       	git log --no-renames --pretty="format:%s" --diff-filter=A HEAD > actual &&
     +
     + ## t/t7007-show.sh ##
     +@@
     + test_description='git show'
     + 
     + . ./test-lib.sh
     ++. "$TEST_DIRECTORY/lib-crlf-messages.sh"
     + 
     + test_expect_success setup '
     + 	echo hello world >foo &&
     +@@ t/t7007-show.sh: test_expect_success 'show --graph is forbidden' '
     +   test_must_fail git show --graph HEAD
     + '
     + 
     ++test_create_crlf_refs
     ++
     ++test_crlf_subject_body_and_contents show $LIB_CRLF_BRANCHES
     ++
     + test_done

-- 
gitgitgadget
