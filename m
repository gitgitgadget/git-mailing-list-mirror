Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391F6C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B59E2080A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6Wpq1mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgAGMmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:42:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35508 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGMmV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 07:42:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id z76so42830721qka.2
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 04:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OK/sjyzLgsiT2DnpBwH8iP3Ez6dfHVaIoDRcXRwiOBI=;
        b=E6Wpq1mgDyfqRw5BdJGecDQhAVakfX1VESgCSYbK6aqvCnEMa62ShqENZ9zWhNpVjL
         Xv43FgNXP+XqxPCvSSmVHP7rvQujlayEo0zVNyRmtLS+NYFXZPpD/tlJZp2NcJZU/JyE
         mcbNbgcL/70rPpDQmBZP8zZs2368qmAlKMFMS8Yde+RG0hX1nM/lXA/+JERYR3l7clcI
         uXFBanwgIl4aq47HEW7LMsBo7tnB6PaND8Kq3oqPV2sRhXibtX49isvX897lneW6Cddn
         s8blz1xO0FT3UX9sDWHKRlJTG9SqMJZkcOpm5K2bUEAWmAYtZcQan+eyhctXIsoBiWyP
         XL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OK/sjyzLgsiT2DnpBwH8iP3Ez6dfHVaIoDRcXRwiOBI=;
        b=bZDCcDqUxCcV4LwyL4oaZ7L1wFLK+7lN0AVwH+wL3F1wTJLcGIlk9MkU3fWww4HLvJ
         3EX2cXIRkgBQG+AFuID2t7Cfwb+390BGIHkSZQ5WBWRvIOo5DxkyXnkTnUummmSliblv
         7kMFUwexGS/lzwu5TrCHmHc0ldwur1TyXEa7Ln2JGCKDt2HO6hG5aJ2V8d8OIiMGix9y
         2aKNzm3RBiDLpznbxuEfgKbk7dgV+YfzLKUgWyJhhFRUe0Wes8G9B2ZcvM/kGTpbgol4
         3zfEQ0hHcDQLUPYvjvnf9byPU1P1Pwfm4dfw8FqDZUFB7c7tLHbTLFoaumybHJHMrmGL
         h5bA==
X-Gm-Message-State: APjAAAXsSa1eC4+b+RKC9LpSc/AOkw4H9dk0pGyMLVuAjArXHuOwrNeX
        wlR6mrLuRh6CrVKsKx7wJPG2+B37
X-Google-Smtp-Source: APXvYqz/w9gvZxaTdALIBa6zgXCkEH7Qc8OUKHlB/Hf9GThlheTAhl+X6dI4tdszDsCThaNm3p972A==
X-Received: by 2002:ae9:efcc:: with SMTP id d195mr82134078qkg.416.1578400940415;
        Tue, 07 Jan 2020 04:42:20 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:4018:daf7:6551:6995? ([2001:4898:a800:1012:f14b:daf7:6551:6995])
        by smtp.gmail.com with ESMTPSA id v2sm22371671qkj.29.2020.01.07.04.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 04:42:19 -0800 (PST)
Subject: Re: Assertion in git log graphing [regression in v2.25]
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>, Bradley Smith <brad@brad-smith.co.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>, git@vger.kernel.org
References: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
 <20200107114812.GE1073219@coredump.intra.peff.net>
 <d694a5b5-9c88-0a34-b9fd-050e5e02c312@gmail.com>
Message-ID: <fe1cd838-d390-96ab-d3b4-72df5aa61947@gmail.com>
Date:   Tue, 7 Jan 2020 07:42:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <d694a5b5-9c88-0a34-b9fd-050e5e02c312@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2020 7:22 AM, Derrick Stolee wrote:
> I'm also going to take a look this morning, starting by creating a test.

Here is a a patch that reproduces the test failure. It hits the
assert, so it definitely fails.

NOTE: The test may not actually pass after this bug is fixed, as
the output expectation may not match exactly. Thus, the test will
likely still fail after fixing the bug, but for a different reason.
I could use the output from v2.24.1, but the point of these changes
in graph.c was to have a compressed output in exactly these cases
of multiple edges moving to the left. In particular, the edges out
of 6_F will likely need updating.

If I manage to do the "right" fix, then I'll update this test
accordingly.

-Stolee

-->8--

From: Derrick Stolee <dstolee@microsoft.com>
Date: Tue, 7 Jan 2020 07:35:56 -0500
Subject: [PATCH] graph: add failing test that hits assert()

A failure was reported in "git log --graph --all" with the new
graph-rendering logic. Create a test case that matches the
topology of that example and uses an explicit ref ordering instead
of the "--all" option. The test fails with the following error:

	graph.c:1228: graph_output_collapsing_line: Assertion
		      `graph->mapping[i - 3] == target' failed.

Reported-by: Bradley Smith <brad@brad-smith.co.uk>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t4215-log-skewed-merges.sh | 43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 18709a723e..bab8a7ed56 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -240,4 +240,47 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
 	EOF
 '
 
+test_expect_failure 'log --graph with multiple tips' '
+	git checkout --orphan 6_1 &&
+	test_commit 6_A &&
+	git branch 6_2 &&
+	git branch 6_4 &&
+	test_commit 6_B &&
+	git branch 6_3 &&
+	test_commit 6_C &&
+	git checkout 6_2 && test_commit 6_D &&
+	git checkout 6_3 && test_commit 6_E &&
+	git checkout -b 6_5 6_1 &&
+	git merge --no-ff 6_2 -m 6_F &&
+	git checkout 6_4 && test_commit 6_G &&
+	git checkout 6_3 &&
+	git merge --no-ff 6_4 -m 6_H &&
+	git checkout 6_1 &&
+	git merge --no-ff 6_2 -m 6_I &&
+
+	check_graph 6_1 6_3 6_5 <<-\EOF
+	* 6_I
+	|\
+	| | * 6_H
+	| | |\
+	| | | * 6_G
+	| | * | 6_E
+	| | | | *   6_F
+	| | | | |\
+	| |_|_|/ /
+	|/| | | /
+	| | |_|/
+	| |/| |
+	| * | | 6_D
+	| | |/
+	| |/|
+	* | | 6_C
+	| |/
+	|/|
+	* | 6_B
+	|/
+	* 6_A
+	EOF
+'
+
 test_done
-- 
2.24.1.vfs.1.1.12.gccc87aa318


