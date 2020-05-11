Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33E5C54E4B
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC6F2075E
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boMzepGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgEKL4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729881AbgEKL4b (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:56:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57943C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so10581593wre.13
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DcoE8KB0972DswexnrzYY/B9E7L3WfC8HGEKwuLCuT8=;
        b=boMzepGcUrEKbRaOKNw4wGPogkQW0q2EMRdy+XwUS1/g8SWLdaA6zPKxq9fe26kuQb
         LkBuLjITpYGRMIj61hXmD65xoAnIh3yWyrmr9Yy5TLp2DoGFsCOhOKf92KsN5lfEVPnJ
         bp8vKzxzDlVixrj5ixwdYj9rR31aNERVOh4rg2iEE4AXHFoiWtBiRmVBGJLZ1WjfMGjG
         trUZLrYKE9vRSfi4SKl4tx9epc0HIGZbgi250mnQ8NsH8TJ+QsjhMiUVJGBV4yyidIXN
         A1FgfOzhFo0WYPD2parjVUMCfVaHKHVE3wIXtjgKbSX6TWEY6bCxHZu2ypIVk9uPpuGc
         4pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DcoE8KB0972DswexnrzYY/B9E7L3WfC8HGEKwuLCuT8=;
        b=lzpwu14TMGGEQooZYvJcwETI/pNn2G+99wQWE+mQom7N2WLKAYPynO+qSaeoHdAwuY
         Ave0bue1QHDujTqsX3YDqDIUW6zYmLobOv2CFErvP5Gd8mnClVYQF24p8DtNAa39NbH6
         EMT4+geD+2yToTo0K6sg3ymkfeHkwA7ScE6uU+QA1mb5Dt20rDqOISEr0kZPk/SFie8T
         cpdxbWr6OHaNxZ0FOW2Sa61nY8MjkbqwVqgt+yNcLC5oJesJKau9yYUogjrAELs20zo7
         G97Ly/ODO9Z07le9x1O9ZZYhZ4fqkXwDmnHG81/6RM6c4wzq/pwyFgidBYkV6REPCv6D
         MKKQ==
X-Gm-Message-State: AGi0PuZZDCTqYgOx/6pcyq/UIDX3EtKFPcoks5LZ+nkMYDHoCmpM8IDa
        fR86cPme1lJiybNFWpd91/+X64AS
X-Google-Smtp-Source: APiQypJIICvNxVewYbd5B11dGvPYNOT8qsd4368dxUutLTQQxAMsr3LGOYKjMO2p5o+47EhSOrC9Nw==
X-Received: by 2002:adf:814a:: with SMTP id 68mr18950691wrm.177.1589198188807;
        Mon, 11 May 2020 04:56:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c25sm25767688wmb.44.2020.05.11.04.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:56:28 -0700 (PDT)
Message-Id: <69c2c2f775fd873e5df8316e90e2d1a0df07e141.1589198180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
        <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 11:56:16 +0000
Subject: [PATCH v2 09/12] t4211-line-log: add tests for parent oids
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

None of the tests in 't4211-line-log.sh' really check which parent
object IDs are shown in the output, either implicitly as part of
"Merge: ..." lines [1] or explicitly via the '%p' or '%P' format
specifiers in a custom pretty format.

Add two tests to 't4211-line-log.sh' to check which parent object IDs
are shown, one without and one with explicitly requested parent
rewriting, IOW without and with the '--parents' option.

The test without '--parents' is marked as failing, because without
that option parent rewriting should not be performed, and thus the
parent object ID should be that of the immediate parent, just like in
case of a pathspec-limited history traversal without parent rewriting.
The current line-level log implementation, however, performs parent
rewriting unconditionally and without a possibility to turn it off,
and, consequently, it shows the object ID of the most recent ancestor
that modified the given line range.

In both of these new tests we only really care about the object IDs of
the listed commits and their parents, but not the diffs of the line
ranges; the diffs have already been thoroughly checked in the previous
tests.

[1] While one of the tests ('-M -L ':f:b.c' parallel-change') does
    list a merge commit, both of its parents happen to modify the
    given line range and are listed as well, so the implications of
    parent rewriting remained hidden and untested.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t4211-line-log.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index cda58186c2d..ea4a9398365 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -215,4 +215,72 @@ test_expect_success 'fancy rename following #2' '
 	test_cmp expect actual
 '
 
+# Create the following linear history, where each commit does what its
+# subject line promises:
+#
+#   * 66c6410 Modify func2() in file.c
+#   * 50834e5 Modify other-file
+#   * fe5851c Modify func1() in file.c
+#   * 8c7c7dd Add other-file
+#   * d5f4417 Add func1() and func2() in file.c
+test_expect_success 'setup for checking line-log and parent oids' '
+	git checkout --orphan parent-oids &&
+	git reset --hard &&
+
+	cat >file.c <<-\EOF &&
+	int func1()
+	{
+	    return F1;
+	}
+
+	int func2()
+	{
+	    return F2;
+	}
+	EOF
+	git add file.c &&
+	test_tick &&
+	git commit -m "Add func1() and func2() in file.c" &&
+
+	echo 1 >other-file &&
+	git add other-file &&
+	git commit -m "Add other-file" &&
+
+	sed -e "s/F1/F1 + 1/" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "Modify func1() in file.c" &&
+
+	echo 2 >other-file &&
+	git commit -a -m "Modify other-file" &&
+
+	sed -e "s/F2/F2 + 2/" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "Modify func2() in file.c" &&
+
+	head_oid=$(git rev-parse --short HEAD) &&
+	prev_oid=$(git rev-parse --short HEAD^) &&
+	root_oid=$(git rev-parse --short HEAD~4)
+'
+
+# Parent oid should be from immediate parent.
+test_expect_failure 'parent oids without parent rewriting' '
+	cat >expect <<-EOF &&
+	$head_oid $prev_oid Modify func2() in file.c
+	$root_oid  Add func1() and func2() in file.c
+	EOF
+	git log --format="%h %p %s" --no-patch -L:func2:file.c >actual &&
+	test_cmp expect actual
+'
+
+# Parent oid should be from the most recent ancestor touching func2(),
+# i.e. in this case from the root commit.
+test_expect_success 'parent oids with parent rewriting' '
+	cat >expect <<-EOF &&
+	$head_oid $root_oid Modify func2() in file.c
+	$root_oid  Add func1() and func2() in file.c
+	EOF
+	git log --format="%h %p %s" --no-patch -L:func2:file.c --parents >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

