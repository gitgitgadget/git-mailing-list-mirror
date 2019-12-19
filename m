Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22726C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C6D206D3
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OeBx7iij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfLSTWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:22:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60326 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfLSTWm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 14:22:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 730C7265E7;
        Thu, 19 Dec 2019 14:22:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fcQV9ra/QllJVE4T68cQd0062kw=; b=OeBx7i
        ijPgtr1ejax3sePKQwkpYQaVyvhNbgjjjKdVQykntCxaRwzLM/pDwcFUzWIUnznI
        vfzjr3J8PnLSPhqZANm/G4962/XqRoBqcVJH80wuNngC7qA1bkvnpHAFRWwCrZYh
        6/asVeic/OVSMyctyZUCxwfohcqcvJIjKV8bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a6Rub+4BqwaMB9/A8GU/rcURXLgOgVrc
        yOXaSzmV3ajVjgeAOUvIrmzchiPH1SgspvEgQ0gGhQ1DI0aRc37o9wbBggqSKmT4
        aREErnBw8+jr0GHKtmAQD/+O7thuMJ4v4L3b/X26d8r9dkHLVvXg16tsYp0EHxSL
        4jaac0YHzq4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BA38265E6;
        Thu, 19 Dec 2019 14:22:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA38A265DB;
        Thu, 19 Dec 2019 14:22:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 1/1] commit: display advice hints when commit fails
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
        <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
        <ebec2379207681152c6e5196a1418aca03da113a.1576746982.git.gitgitgadget@gmail.com>
        <xmqqfthgb01m.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 19 Dec 2019 11:22:38 -0800
In-Reply-To: <xmqqfthgb01m.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 19 Dec 2019 11:14:13 -0800")
Message-ID: <xmqqbls4aznl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC04A35A-2294-11EA-B7BE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This fix was about "we do not want to unconditionally drop the
> advice messages when we reject the attempt to commit and show the
> output like 'git status'", wasn't it?  The earlier single-liner fix
> in v1 that flips s->hints just before calling run_status() before
> rejecting the attempt to commit was a lot easier to reason about, as
> the fix was very focused and to the point.  Why are we seeing this
> many (seemingly unrelated) changes?

In any case, here is what I tentatively have in my tree (with heavy
rewrite to the proposed log message).

-- >8 --
From: Heba Waly <heba.waly@gmail.com>
Date: Tue, 17 Dec 2019 09:17:22 +0000
Subject: [PATCH] commit: honor advice.statusHints when rejecting an empty
 commit

In ea9882bfc4 (commit: disable status hints when writing to
COMMIT_EDITMSG, 2013-09-12) the intent was to disable status hints
when writing to COMMIT_EDITMSG, because giving the hints in the "git
status" like output in the commit message template are too late to
be useful (they say things like "'git add' to stage", but that is
only possible after aborting the current "git commit" session).

But there is one case that the hints can be useful: When the current
attempt to commit is rejected because no change is recorded in the
index.  The message is given and "git commit" errors out, so the
hints can immediately be followed by the user.  Teach the codepath
to honor the configuration variable.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c                          | 1 +
 t/t7500-commit-template-squash-signoff.sh | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index e588bc6ad3..0078faf117 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -944,6 +944,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	if (!committable && whence != FROM_MERGE && !allow_empty &&
 	    !(amend && is_a_merge(current_head))) {
+		s->hints = advice_status_hints;
 		s->display_comment_prefix = old_display_comment_prefix;
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 46a5cd4b73..a8179e4074 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -382,4 +382,13 @@ test_expect_success 'check commit with unstaged rename and copy' '
 	)
 '
 
+test_expect_success 'commit without staging files fails and displays hints' '
+	echo "initial" >>file &&
+	git add file &&
+	git commit -m initial &&
+	echo "changes" >>file &&
+	test_must_fail git commit -m update >actual &&
+	test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
+'
+
 test_done
-- 
2.24.1-732-ga9f9d4909c

