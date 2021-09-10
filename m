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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C32CC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037C761153
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhIJKbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 06:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhIJKbL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 06:31:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5ACC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:30:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u16so1911646wrn.5
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ok6TYQi2cM3nzReNc3wNwPvRGAj0wRyKxeoDZMlUd1U=;
        b=Bi+jdqKexcJlcmb+lXZKG2sm5r7Y/yR5/6ubJLzDhe7q6x64x8v1KLopJg0gRF/bZr
         7RSRR6aCU5ZXaHL6GoBEsF3Fje1IQUVNEs1XZOpa15LdkULs/vGrCmBzjv34oLPOOQEd
         w+BrofbNtukwetKZHES9/V9463Cb7Y9tx8hK/zPY0Vty7dWFUZLNTLeGVRPt8fBktFOo
         SnI4nCxTnmPAbhVV4m1F6qdw6BEwGKE8k6yKsbJng2dQB0HVTVgmIpJhYEuMUGpvUSQc
         3fssfjrixu+JQY0ClbFx4X+VMPskA5Zz0gibBa0oaju1LzFx9gHZfMOUHFtaAO/67CD3
         /36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ok6TYQi2cM3nzReNc3wNwPvRGAj0wRyKxeoDZMlUd1U=;
        b=ieRX+R7jBPjst+8BlOO26oGoTC+9XyOmnjW676hl9u2cLyya0mvdkkxOnAfvtSUAPl
         F0/2y4hU/f66tASX1vOyPEjq1reUfaDMkIPBK5OXixGTNE7OWTrCN6g/AceqcVz/U6BL
         rp4E/yLkyDs97ESF7GHqoQoeF3Qjp3DUOQzYfrfdcRIfRTpPpolCKVs+dMV8NR9fhcd0
         wvrJ/Eo+mBC1m03yLKOoZJGIqjndSgsKcNG9/u3d7AjLC4nVpHP9BXhdapPtdgOwbvSQ
         NBjfq+yJTP1etjWME8SrTmul8KNA3NenQ70AHoMNi7WhPFjmh4TL+6j50xdnQ6RMcd6P
         1BYw==
X-Gm-Message-State: AOAM5314y3mFLBeo4lCYHT8msFWJDVP0uoLvQI7HpZoEhgIybT5xau8n
        eHZpTH2G6q1eu0qxvVwVC95M7NU9i7U=
X-Google-Smtp-Source: ABdhPJwAVvQTd6V8J+juo1aKalRyUxBR5v6GgjelZbnaSFn5E2U/h18+4XdNKJJ5neZW36zBrKtnlQ==
X-Received: by 2002:a5d:56cf:: with SMTP id m15mr8799082wrw.240.1631269798748;
        Fri, 10 Sep 2021 03:29:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm3784868wmc.24.2021.09.10.03.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 03:29:58 -0700 (PDT)
Message-Id: <5ddb70d332b73be88393ac3050cfc3fabdf3db95.1631269796.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1086.v2.git.git.1631269796.gitgitgadget@gmail.com>
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
        <pull.1086.v2.git.git.1631269796.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 10:29:54 +0000
Subject: [PATCH v2 1/3] t3903: document a pair of directory/file bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are three tests here, because the second bug is documented with
two tests: a file -> directory change and a directory -> file change.
The reason for the two tests is just to verify that both are indeed
broken but that both will be fixed by the same simple change (which will
be provided in a subsequent patch).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3903-stash.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 873aa56e359..7346f8d1037 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1307,4 +1307,62 @@ test_expect_success 'stash -c stash.useBuiltin=false warning ' '
 	test_must_be_empty err
 '
 
+test_expect_failure 'git stash succeeds despite directory/file change' '
+	test_create_repo directory_file_switch_v1 &&
+	(
+		cd directory_file_switch_v1 &&
+		test_commit init &&
+
+		test_write_lines this file has some words >filler &&
+		git add filler &&
+		git commit -m filler &&
+
+		git rm filler &&
+		mkdir filler &&
+		echo contents >filler/file &&
+		git stash push
+	)
+'
+
+test_expect_failure 'git stash can pop file -> directory saved changes' '
+	test_create_repo directory_file_switch_v2 &&
+	(
+		cd directory_file_switch_v2 &&
+		test_commit init &&
+
+		test_write_lines this file has some words >filler &&
+		git add filler &&
+		git commit -m filler &&
+
+		git rm filler &&
+		mkdir filler &&
+		echo contents >filler/file &&
+		cp filler/file expect &&
+		git stash push --include-untracked &&
+		git stash apply --index &&
+		test_cmp expect filler/file
+	)
+'
+
+test_expect_failure 'git stash can pop directory -> file saved changes' '
+	test_create_repo directory_file_switch_v3 &&
+	(
+		cd directory_file_switch_v3 &&
+		test_commit init &&
+
+		mkdir filler &&
+		test_write_lines some words >filler/file1 &&
+		test_write_lines and stuff >filler/file2 &&
+		git add filler &&
+		git commit -m filler &&
+
+		git rm -rf filler &&
+		echo contents >filler &&
+		cp filler expect &&
+		git stash push --include-untracked &&
+		git stash apply --index &&
+		test_cmp expect filler
+	)
+'
+
 test_done
-- 
gitgitgadget

