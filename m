Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A632C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B238610E6
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbhJGKD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 06:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240776AbhJGKDr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 06:03:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E1FC061760
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:01:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v25so17269323wra.2
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzFMSQqzoAGFMNjVhcT35IuyMOWnSj3q4N2fPk6d8hQ=;
        b=GpQZFenS+MKhgHvkFdyHbF8kKwfGgq2AwOJXQADl6qjNlrlro8tSheGyC7AGIwp3OG
         D8sjD6I53+1unoZh8a7CawsdogxaRargMEM6tTvtjWCfgdAPZXayT3Vns2Nus2w1C2hI
         WyBbLl/x1Ft6uRFQmTtozGNHd3csejjyavNGzlEHJFPF2Erk+G+Gjfe84+M1itNpmY+I
         0UYrjpodrHwCgBfx0kxtCPR4nMOK0taTuG9bOfcTAmCL/KnEniXRLxYetBjfXM0vXmq4
         Jm2al7tlMxMgTg+qWfFALfvWJB3nCK616wQBXE48qqnfuZ9nTKpyvNlWHFBdNzZ+JV2r
         bPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzFMSQqzoAGFMNjVhcT35IuyMOWnSj3q4N2fPk6d8hQ=;
        b=AcTScl/c1WDnQVUJIv7N3gFsSxB57vRFKNPT5d+ak5bTs8zJ6rmpZYebN4THrCZn9B
         3mPXOwdUByG1aCetyvcoo+g87gpKZnpvX4TmK0z1STlgJBaGeyr+8rzko0gIO3yRkQr8
         iSoopVqnBx5ap1e4N5mVfBh/jxL1svMy1gbu6PA/ZB8E3pKCfmvs8ZeEbt3QOAvKWoRT
         spfB2iLepzKwIFse1NPDBMIof+nEu1GhNG5sR2kBUGZptzr8Ci3/9BQaKPriPNP41TK6
         fwurcPhdfD7y2XxJsONHee2WNglt1vmZiagbO4mkFC6yWBDPSw45/2dSZSrgH2sLXa+M
         rGzA==
X-Gm-Message-State: AOAM531fSQDbd1CO1CGjcqVPiKr3AUG2zjaeE8BHHQ7U/J0w6ncyzhcU
        dREchbwVA6liXtLd2Oc/SxEWn6erNT6ysQ==
X-Google-Smtp-Source: ABdhPJxx13cBGM0csvj/pzxVvPbJikEI8lOOlCaXzQS8lI+TwxO6YsaTs/GSLQ8H1MITEUXpI4xEmg==
X-Received: by 2002:adf:a34b:: with SMTP id d11mr4199016wrb.107.1633600911350;
        Thu, 07 Oct 2021 03:01:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f16sm628559wrr.53.2021.10.07.03.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:01:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/7] merge: add missing strbuf_release()
Date:   Thu,  7 Oct 2021 12:01:37 +0200
Message-Id: <patch-v2-7.7-9942c084244-20211007T100014Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We strbuf_reset() this "struct strbuf" in a loop earlier, but never
freed it. Plugs a memory leak that's been here ever since this code
got introduced in 1c7b76be7d6 (Build in merge, 2008-07-07).

This takes us from 68 failed tests in "t7600-merge.sh" to 59 under
SANITIZE=leak, and makes "t7604-merge-custom-message.sh" pass!

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c                 | 2 ++
 t/t7604-merge-custom-message.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0ccd5e1ac83..84d76780f0d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1577,6 +1577,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		finish(head_commit, remoteheads, &commit->object.oid, msg.buf);
 		remove_merge_branch_state(the_repository);
+		strbuf_release(&msg);
 		goto done;
 	} else if (!remoteheads->next && common->next)
 		;
@@ -1747,6 +1748,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		ret = suggest_conflicts();
 
 done:
+	strbuf_release(&buf);
 	free(branch_to_free);
 	return ret;
 }
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index cd4f9607dc1..eca75551016 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -4,6 +4,7 @@ test_description='git merge
 
 Testing merge when using a custom message for the merge commit.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_merge_msgs() {
-- 
2.33.0.1446.g6af949f83bd

