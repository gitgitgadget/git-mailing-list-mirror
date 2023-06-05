Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A118C7EE23
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 19:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjFETmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 15:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFETmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 15:42:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2B2F1
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 12:42:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f60e536250so45756125e9.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685994165; x=1688586165;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u7FMzpnZqI80sOd8srt8QbpIHLZwp5TuXmrRigmWges=;
        b=eLt7bhpTTVeUEFFxwWfskFNabx74IEXmtUT0A0MR52LQqFhMjNeoWzd8CfpTeXa99i
         +zuucSP6HOiYeK2sP9Xe28FrGixNSB2OAf5HWdqAym6SOhme70pYMZnhX0sy3jfIC8ek
         d3i7pf4PO95o9LERmoKVAaqH3rheL2dO7yfavEkMDJ4f/VQM/iE4NhZpPDgGQJGnUQ8Z
         GVk0xlGUhVC5tu3OadeH5/OqkV2qU90pPGur/zNB1B1Tnhbbi/HlAQ4Ay7/+iroz62dS
         fkUMwwh20TMBxQoIjHqi9iugCcT7aTNt3+4gqJRF24lIF8FlSo/HAESkdVOPshtWm3W3
         dX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994165; x=1688586165;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7FMzpnZqI80sOd8srt8QbpIHLZwp5TuXmrRigmWges=;
        b=SDqEremqSKx7miVdBmqzHinO8y/HZe/3KzlarQwlvrmc3pQEYz8ory3HIpIETUVxTQ
         opd3XgUa6GcQ+XbWDo08qJYEAUn/de5KVPOycmy2WG0zTAKhagnjEXrnKxRDVNaHyK9N
         Q6Ic0QPFSZzKaYor3N+qb4JCYNWIeYM7gZzc7p3mbU5ZHH2VNYhAm+aBohOTCVpN0IMo
         B43Yr41cIrMI5H2VTRL0UgLNEjpKhW4EsIMFQT1pSw8oAvR/B1gZp2TkrcmRaoPQq9ll
         CjJ3JsQReLB1Tdf1zllntEllUOkVk8aXIFPEkZ3yE8cyENmiJ4KlxAWLao6pGKSYNy1x
         nQRg==
X-Gm-Message-State: AC+VfDw6NIWZOWWmJI4FNJwV/jY5fNQIkfYnE4M5SHwrELhNJzR7aEX5
        VTIZmXyJ2Jt7QePF7/szhKraiy2P5SQ=
X-Google-Smtp-Source: ACHHUZ5tPPvjxV15zrNGq+n+sby0o38qTnOghFG50YB3sbcuHLKp507+nFVsxGB3FTgL3VAR9IPSrw==
X-Received: by 2002:a05:600c:1f8d:b0:3f6:eae:7417 with SMTP id je13-20020a05600c1f8d00b003f60eae7417mr8757805wmb.1.1685994165012;
        Mon, 05 Jun 2023 12:42:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b003f42d8dd7d1sm15197005wmc.7.2023.06.05.12.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 12:42:44 -0700 (PDT)
Message-Id: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Jun 2023 19:42:43 +0000
Subject: [PATCH] add: check color.ui for interactive add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When 'git add -i' and 'git add -p' were converted to a builtin, they
introduced a color bug: the 'color.ui' config setting is ignored.

The included test demonstrates an example that is similar to the
previous test, which focuses on customizing colors. Here, we are
demonstrating that colors are not being used at all.

The fix is simple, to use git_color_default_config() as the fallback for
git_add_config(). A more robust change would instead encapsulate the
git_use_color_default global in methods that would check the config
setting if it has not been initialized yet. Some ideas are being
discussed on this front [1], but nothing has been finalized.

[1] https://lore.kernel.org/git/pull.1539.git.1685716420.gitgitgadget@gmail.com/

This test case naturally bisects down to 0527ccb1b55 (add -i: default to
the built-in implementation, 2021-11-30), but the fix makes it clear
that this would be broken even if we added the config to use the builtin
earlier than this.

Reported-by: Greg Alexander <gitgreg@galexander.org>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    add: check color.ui for interactive add
    
    This was reported by Greg Alexander gitgreg@galexander.org during Git
    IRC Standup [2].
    
    [2]
    https://colabti.org/irclogger/irclogger_log/git-devel?date=2023-06-05
    
    This is also a reoccurrence of the "config not loaded" bug from [3].
    
    [3]
    https://lore.kernel.org/git/pull.1530.git.1683745654800.gitgitgadget@gmail.com/
    
    I linked above to my RFC on lazy-loading global Git config, and these
    are the same "root cause" (not loading something early enough in the
    process) and my RFC proposes to fix this by changing our access
    patterns. By encapsulating these globals, we can make sure they are
    initialized from config before they are accessed.
    
    But that's a discussion for another thread. For now, fix the bug and
    we'll worry about the "better" (and bigger) thing to do another time.
    
    Thanks, -Stolee
    
    P.S. This fails the whitespace check due to the necessary left-padding
    spaces in the expected output in the test file.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1541%2Fderrickstolee%2Fadd-interactive-color-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1541/derrickstolee/add-interactive-color-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1541

 builtin/add.c              |  2 +-
 t/t3701-add-interactive.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 76cc026a68a..6137e7b4ad7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -365,7 +365,7 @@ static int add_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_color_default_config(var, value, cb);
 }
 
 static const char embedded_advice[] = N_(
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 3982b6b49dc..00081418ea2 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -734,6 +734,39 @@ test_expect_success 'colors can be overridden' '
 	test_cmp expect actual
 '
 
+test_expect_success 'colors can be skipped with color.ui=false' '
+	git reset --hard &&
+	test_when_finished "git rm -f color-test" &&
+	test_write_lines context old more-context >color-test &&
+	git add color-test &&
+	test_write_lines context new more-context another-one >color-test &&
+
+	test_write_lines help quit >input &&
+	force_color git \
+		-c color.ui=false \
+		add -i >actual.raw <input &&
+	test_decode_color <actual.raw >actual &&
+	cat >expect <<-\EOF &&
+	           staged     unstaged path
+	  1:        +3/-0        +2/-1 color-test
+
+	*** Commands ***
+	  1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
+	  5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
+	What now> status        - show paths with changes
+	update        - add working tree state to the staged set of changes
+	revert        - revert staged set of changes back to the HEAD version
+	patch         - pick hunks and update selectively
+	diff          - view diff between HEAD and index
+	add untracked - add contents of untracked files to the staged set of changes
+	*** Commands ***
+	  1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
+	  5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
+	What now> Bye.
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '
 	git reset --hard &&
 

base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
-- 
gitgitgadget
