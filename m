Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E6EC2D0C5
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A06A22464
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm1kp6od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLJUAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44554 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfLJUAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:00:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so21512083wrm.11
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 12:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xbAMdwUoczvFExTFmHXxzR/2/texrkL36eKuhAIvlbk=;
        b=Zm1kp6od8k/PTUGlhnBZRXbX+fPM2LUCh6w6ZzLkbIds16Jy/eypmlY43xViRDSBye
         fx690S/kdp0NceEAgoBBzvtu2KsOYvPJs7vMF20ZOjN/lpvZaaUCcF1RJdouUGcO5rJC
         5YaPKRejDTs0QBHCkQ3uiEz6aBJnVT4TCNys4kdXmFpYf0ohYJSDp/tUFQORrm+ncdZp
         wtfib8qdj2bpykeBLk/Z+yVVMhXekuvd9XbDucfR69Dg0+wqm/cz5kGqfRK7LIb2NFyJ
         rLoegMLhDlEPvQEV5WnWKqRqev+0rQtQ72WApbGMihXRo2F3/Y4mGAbXn4JP7INPjRhp
         3cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xbAMdwUoczvFExTFmHXxzR/2/texrkL36eKuhAIvlbk=;
        b=NPjXjkfo7tKzJSkb8Z7hM/d9HEGk5fepJ5in1rcQosFbzzs6DAaKb+5WoDZRCN4A/6
         urwm218ELye8cBs0t2EF00aIjMiQLCMU3IIWUyiVPDZib1fdJQ1t3g2xR3DtELK5b8HX
         oVbcxykSYGQHWI2/Uoozp3TktxDguFnbL0xGCADWNltkguyHYCdBEvGf0YXwRIR39Brt
         zAEHmR/zaAGZ202HpqZRhrn6Xl9gFmuEqkwYHH6ERrwUJK5O9bxwd1NjwSzZe5fNFcvl
         sM6VcA7Vo1xZqtUNMlV/2b7s/FlqN7TymJJ8OoeHwuZiniirn36rsNGgdjgdkl/Q/Sxu
         nM4Q==
X-Gm-Message-State: APjAAAWpYXy3Uw98JrBIuADU7vaj+zhEFHyVgJFDKXX83G8gLaPBzi6W
        X40Jd37iMq8I/3d8VYzpYeC7USpq
X-Google-Smtp-Source: APXvYqxaUtYzMwBZQRRHCa9/QP6WLY0RIxzn0P6ViodAIt5RwLUvPSfb+RmO434P0XcOd2GM3noIYA==
X-Received: by 2002:adf:ec48:: with SMTP id w8mr5313469wrn.19.1576008032492;
        Tue, 10 Dec 2019 12:00:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm4480990wrv.66.2019.12.10.12.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:00:32 -0800 (PST)
Message-Id: <8d2d98eec3c620c55100a322087ef83e4f51c8cf.1576008027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
        <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 20:00:23 +0000
Subject: [PATCH v2 4/8] dir: exit before wildcard fall-through if there is no
 wildcard
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The DO_MATCH_LEADING_PATHSPEC had a fall-through case for if there was a
wildcard, noting that we don't yet have enough information to determine
if a further paths under the current directory might match due to the
presence of wildcards.  But if we have no wildcards in our pathspec,
then we shouldn't get to that fall-through case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                                              | 7 +++++++
 t/t3011-common-prefixes-and-directory-traversal.sh | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 5dacacd469..517a569e10 100644
--- a/dir.c
+++ b/dir.c
@@ -379,6 +379,13 @@ static int match_pathspec_item(const struct index_state *istate,
 			       item->nowildcard_len - prefix))
 			return 0;
 
+		/*
+		 * name has no wildcard, and it didn't match as a leading
+		 * pathspec so return.
+		 */
+		if (item->nowildcard_len == item->len)
+			return 0;
+
 		/*
 		 * Here is where we would perform a wildmatch to check if
 		 * "name" can be matched as a directory (or a prefix) against
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index 54f80c62b8..d6e161ddd8 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -92,7 +92,7 @@ test_expect_failure 'git ls-files -o untracked_repo/ does not recurse' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
+test_expect_success 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
 	cat <<-EOF >expect &&
 	untracked_dir/empty
 	untracked_repo/
@@ -110,7 +110,7 @@ test_expect_success 'git ls-files -o untracked_dir/ untracked_repo/ recurses int
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
+test_expect_success 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
 	cat <<-EOF >expect &&
 	untracked_dir/
 	untracked_repo/
-- 
gitgitgadget

