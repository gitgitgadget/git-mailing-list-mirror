Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5C7C2D0C5
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 09:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D787920733
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 09:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCIS77NV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLQJR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:17:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37182 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfLQJR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 04:17:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so10460817wru.4
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 01:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2yNpJOA4KG1rB3PNlAMOryaxrpnQYfs/UUdwuR2sMyo=;
        b=rCIS77NVaGq7Bjf1MSexroB80YjJ1BQRte0v7taBuMctRzchRvZ6wlaNvclG++UVA8
         5xlO06OjbyBe8UOnOSafUyvNwKDk2cPYwTRG8y9QCHKpoSCzyyEfiVPQKGRE18cFYCeV
         QhBQtIo9xdgJNJTPfeqwhzD15+FVIsmZ3kyCyv7VFoPa27zFLdOPn+1TxE/bGvYh6AeG
         fD5lvpiZE504L6MdN2uduQsKwpFxy3hTelF+m4se+PsqsOZA48fqWaDluJ/JSZTdmG+g
         y1JIrMqlv6c/9HArGPN4BJAeQH84u5ogeNWidQfMUD9Trai0IvoH4SpXVvsA1xUDnyMI
         XJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2yNpJOA4KG1rB3PNlAMOryaxrpnQYfs/UUdwuR2sMyo=;
        b=JzofF2e0BRI+LqND8rwAiRZG11kdhUPFVmOH8gpE7GVrctmO6BuaAZcw83k+Xv2nEK
         T2vd1cHdz81h0wjwmH6fGGAoRqg9zGsvT8+EqssMtXJsmcJGelzy70Qlp4WYfGQCMSiI
         m3JhqYXb8eAS2zwLMUsW0D75vws/AiEsVLZr/1P2b5lN1MBWGqAn9IKWd99EgZNWFNDQ
         i536Qv4z2B4oYe+SqArNo7GgVQq+Lu1Dq2XgWD7NaPwOPWtO6E+qIT9/j/NInSYEewm7
         EEaq0xwSxCaizyBGAYbAoNLJqIXI8VbAgIqlPYkH4F2+vLmg9L2Ou0G5OTkJBsl8fS6Z
         8T9g==
X-Gm-Message-State: APjAAAWZeVXC4kAlFJ9UFa0N264UxRN0Ic/byNJRuDO5ojG+IHoloMVf
        NxG119BCnDH6cVB+molj6WIWi9aI
X-Google-Smtp-Source: APXvYqz1hD9xR+XrthUyvX7WJ+3Nc84YYgRKq6K0XZot4RnPaRWm6bv6QyeQnffWjLwgvd9vHxj9xw==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr35319476wrj.261.1576574244922;
        Tue, 17 Dec 2019 01:17:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t81sm2312304wmg.6.2019.12.17.01.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 01:17:24 -0800 (PST)
Message-Id: <f23477c5a32e5d638310024194040146026972b8.1576574242.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.495.git.1576574242.gitgitgadget@gmail.com>
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 09:17:22 +0000
Subject: [PATCH 1/1] commit: display advice hints when commit fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Display hints to the user when trying to commit without staging the modified
files first (when advice.statusHints is set to true). Change the output of the
unsuccessful commit from e.g:

  # [...]
  # Changes not staged for commit:
  #   modified:   builtin/commit.c
  #
  # no changes added to commit

to:

  # [...]
  # Changes not staged for commit:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #   modified:   ../builtin/commit.c
  #
  # no changes added to commit (use "git add" and/or "git commit -a")

In ea9882bfc4 (commit: disable status hints when writing to COMMIT_EDITMSG,
2013-09-12) the intent was to disable status hints when writing to
COMMIT_EDITMSG, but in fact the implementation disabled status messages in
more locations, e.g in case the commit wasn't successful, status hints
will still be disabled and no hints will be displayed to the user although
advice.statusHints is set to true.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 builtin/commit.c                          | 1 +
 t/t7500-commit-template-squash-signoff.sh | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2db2ad0de4..4439666465 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -961,6 +961,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	if (!committable && whence != FROM_MERGE && !allow_empty &&
 	    !(amend && is_a_merge(current_head))) {
+		s->hints = advice_status_hints;
 		s->display_comment_prefix = old_display_comment_prefix;
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 46a5cd4b73..3d76e8ebbd 100755
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
+	test_must_fail git commit -m initial >actual &&
+	test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
+'
+
 test_done
-- 
gitgitgadget
