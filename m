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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D160C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7236C61159
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbhITXkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbhITXih (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:38:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCF9C0EFE42
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w29so32029580wra.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nh2RD3Yg/rudV33Lfw2h4WjGPfRbyKyvhLRmZNtCiNE=;
        b=qgiNNR9AsuRpB0xfat+tKNXTirFs4kJh0qH0zd7H7gxEJiEkeQWPSJtfgf9dAGNlKC
         KeVsCPdqZXhpqNvXVY1kJDPw9GOjGkdBIxBqAhsqZr86Y9f5VPfvcxdMAheibMRkVeKp
         R+1SvyOEtAOX2B/z/aNNcQuX9ttr5NTCmrbaOj6jjT5lWF3N0nZ9dytjNgyo4Lg+j/Wp
         np18N9S5qajfsJh6VC+SgG7CUhLxad89yoO8t4CJAb6Bw0on0Rb7EcHnfwe1LjkzFRkO
         N4V1mK4I4reeZYthMLme1RQQqv25jS3+rb3M3CiXOWGuEBqPuJ+Ghgfr3FVvs8T1OmJP
         84Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nh2RD3Yg/rudV33Lfw2h4WjGPfRbyKyvhLRmZNtCiNE=;
        b=3IvAb2I0XC/GBeWg4JSXyY2A6+9PYsOVcUVmfj/ETyiTu1QFYkQBHdN35/2+WJJjG6
         3r9W9kir72weZCjUlXRtibCZTcoYUq0DQYAcjdZIgsARTuQ5NONnJ1EXuX3oKNJvF5VY
         JQ8VGovQjmbGKpQSyVPYe8Fft5rZDWnfuHZZbH97PFGU+w6GLNEEbCgp0bLm7xnMZ9Z7
         OJ9m0C4pBHSEVHFxYVf62p36XeZsRqlG96AhQJU39HkC1Llc8tPolOmk0bvh5I93Oucc
         F+9vfIXwhLr+iIwjud/CT/EJnH3KTDlQsT1s7IXIypax45P2xp/GiBFMuNCOedUgENwK
         lIeQ==
X-Gm-Message-State: AOAM533onZpngiAOvqIBX5ULJc+cmniNhWvVdmdYkEwnQ/CHLO9xYsxS
        845+Z0AsqETwNOwg7/o38SIjLvJRhpo=
X-Google-Smtp-Source: ABdhPJwSVZH+WF6ZrmrsgZ5BbBjf/ZTfGHjWfvmcsxLvVQPTgnXBm41xhxkW93m5ozmmUz9EsWR42Q==
X-Received: by 2002:a5d:6545:: with SMTP id z5mr30032369wrv.51.1632159946768;
        Mon, 20 Sep 2021 10:45:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm191157wmq.23.2021.09.20.10.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:46 -0700 (PDT)
Message-Id: <cc25ce171627f60896d3f70800f207fa630aec22.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:35 +0000
Subject: [PATCH v3 12/14] rm: skip sparse paths with missing SKIP_WORKTREE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a path does not match the sparse-checkout cone but is somehow missing
the SKIP_WORKTREE bit, then 'git rm' currently succeeds in removing the
file. One reason a user might be in this situation is a merge conflict
outside of the sparse-checkout cone. Removing such a file might be
problematic for users who are not sure what they are doing.

Add a check to path_in_sparse_checkout() when 'git rm' is checking if a
path should be considered for deletion. Of course, this check is ignored
if the '--sparse' option is specified, allowing users who accept the
risks to continue with the removal.

This also removes a confusing behavior where a user asks for a directory
to be removed, but only the entries that are within the sparse-checkout
definition are removed. Now, 'git rm <dir>' will fail without '--sparse'
and will succeed in removing all contained paths with '--sparse'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/rm.c                  |  4 +++-
 t/t3602-rm-sparse-checkout.sh | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4208f3f9a5f..a6da03da2be 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -301,7 +301,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
-		if (!include_sparse && ce_skip_worktree(ce))
+		if (!include_sparse &&
+		    (ce_skip_worktree(ce) ||
+		     !path_in_sparse_checkout(ce->name, &the_index)))
 			continue;
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
 			continue;
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 493c8f636b8..5f92b60a56a 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -37,9 +37,13 @@ done
 test_expect_success 'recursive rm does not remove sparse entries' '
 	git reset --hard &&
 	git sparse-checkout set sub/dir &&
-	git rm -r sub &&
+	test_must_fail git rm -r sub &&
+	git rm --sparse -r sub &&
 	git status --porcelain -uno >actual &&
-	echo "D  sub/dir/e" >expected &&
+	cat >expected <<-\EOF &&
+	D  sub/d
+	D  sub/dir/e
+	EOF
 	test_cmp expected actual
 '
 
@@ -87,4 +91,15 @@ test_expect_success 'do not warn about sparse entries with --ignore-unmatch' '
 	git ls-files --error-unmatch b
 '
 
+test_expect_success 'refuse to rm a non-skip-worktree path outside sparse cone' '
+	git reset --hard &&
+	git sparse-checkout set a &&
+	git update-index --no-skip-worktree b &&
+	test_must_fail git rm b 2>stderr &&
+	test_cmp b_error_and_hint stderr &&
+	git rm --sparse b 2>stderr &&
+	test_must_be_empty stderr &&
+	test_path_is_missing b
+'
+
 test_done
-- 
gitgitgadget

