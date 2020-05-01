Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED9EC47257
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB57208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3CHNczL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgEAPan (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbgEAPaj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBDFC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so75773wmh.3
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DcoE8KB0972DswexnrzYY/B9E7L3WfC8HGEKwuLCuT8=;
        b=Y3CHNczL2qIOySxHvFMnAT+ykbwBFSGHwzk8eBo9v2wOqBdFZhenG6lFuQtbIdanGJ
         6k21nXtB8CzoO4JNfBMFuOlVJJIpqYykvQJHTx152/oH8v5d9tupzWpJxSoUIPvrzUf9
         LN3EZxGjepK6qwZ6A9v38n4Ik/KKcmaKlQmcp5k9OLt1AbSgeCPLEzOlP3S0ejcpqNl6
         A1rU6p7OpkZKVwoSMEySTlhrqqOijxW3dRSTZqCbjV+Xkd2TgktKx4P+T54F4Rglk+yT
         GvHyrOSbIopQ3KI/rsIkNQ+x6Im0kEetqhWvYDQGmVqgfAZJGFcqF9V4t7UhyTPng7O/
         K+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DcoE8KB0972DswexnrzYY/B9E7L3WfC8HGEKwuLCuT8=;
        b=RVhqrtex/+rUw7O8Ndn4oVaSL25BjUQHRGDubjBKyNfsZkNnwe52fLwqQt6iiNrX57
         +GILcZwpEaUPXIKN4qjq8iIr/nCoCdjMWXFa3Vam0CD4qMEZyWFHjNB3JgiRSysLIlhI
         sUX7CMmV1Dho38vtQdVLvgY9aB1BOYI1veDF0KjEBFxRFX5hYB3STAryAa9RdyGErwiu
         /nvKIEKH7lTo0JV2uZYEZOYgeCMNLrTqYc0j82YtQT87HOIMwO1WQa8+KSVANIhgFfLJ
         hJ15303krgGc3BAPb0F6CKh7yE8jRrilMDu74vfNXZ4kvUDCLmpy/cvthBfQ/KXvmnVg
         neuA==
X-Gm-Message-State: AGi0Pub7EIKtA301408gh8QazE8uX5tOY2pR0zDETHvROeRXJ2Q15UcL
        ILuks5qJC2EzIFAgkDGSfmK57byx
X-Google-Smtp-Source: APiQypK/s2+3pT792w1OGkvAnBrLDA1iPv1kx4aIpuoyejf4NoNYBze9BbzhiiKkpnLY17pm7A35pw==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr113438wmh.180.1588347037804;
        Fri, 01 May 2020 08:30:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a187sm56520wmh.40.2020.05.01.08.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:37 -0700 (PDT)
Message-Id: <4e3d7233095064de197c447cb31cf4652d42b775.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:26 +0000
Subject: [PATCH 09/12]  t4211-line-log: add tests for parent oids
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

