Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7A2C433FE
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AD261152
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbhJFKEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbhJFKEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:04:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E89CC06176D
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:02:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so7121984wrg.5
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcMg4o2t3Otw5CSbZ32t8hz2/CYKOuXHAAVMlElPLl0=;
        b=HZMqt5HI7VNH++IcLiX8E8ZAagwsMJsgcnG+BWIpSZiDNkzCxTJH/kBvS0CPITB2b+
         xeh14eZIPVjpTzrlX6Ulg0g5iKMTseuWrQ7MYa/pUxnP6/34Y56O8shWOPWKpZaXJgCY
         Uan8iCYeoNvteOQ6VPTDL86skpbvCF/vAEuMFOwmf4UMk2R5lTADlqHzQ4FWIaHHxB4h
         6vBumQySn/uhEEDs9mAZ7Zy6pfHWVlQR2QqktX9taCpmMyvhs0yHQ8xquxKfy79Rqg4n
         SLH+vuoR9wa5/kLM+yF2+UV8YJjbzv8BuP9jN4CMknT8jr6AuARqMFqq9PuKGKXeznSj
         Kj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcMg4o2t3Otw5CSbZ32t8hz2/CYKOuXHAAVMlElPLl0=;
        b=Nhinr0JosKDwB8+whHaO7obwWEHM/AzvEEByPSoA7ma3SACjL+SN8p63LA5e8cPpuD
         ZOaU7OmkxeFCK+b8gZSbp/ESodx8XPDmFwC4qtFlOsZU7OxofjLdRPhWpSQU7VNsUKHY
         hFf+7YIOPiNqX3lZ2K7i38z+wBehLioN+PkNGJqQVEPY0wx7D09ZLqDmBuTpV99oZNCK
         OR8PH+iO0SGT44AwWA9Ri9ajzlB1iCiOYd+Fq894TL1I9S5UfZF0qofHCQiSTqDhS+Es
         wWDEZieHMLZ2Ch1QRRkGCfe/M9RipiBxARsPQPz2Dk/7A6t0Nbu+ojmoY++bKrS4V/eN
         9A3Q==
X-Gm-Message-State: AOAM532R3b/TExs2eaMtex/iYn4Dv8MWqSo+cyzvp2wMDUFPwQ4OrsjG
        NgiXLZh0V7ec3ARhxlMXw0TqOqcGUPC7PQ==
X-Google-Smtp-Source: ABdhPJxV+1+EApbWiyGrUQJYwWUwmt6W3RdQQkQTR0DstJGrMlXHk5+m/bxNsZf4DaFTRGPdcIgVRg==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr26379313wrc.209.1633514554822;
        Wed, 06 Oct 2021 03:02:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h18sm5515279wmq.23.2021.10.06.03.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:02:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/7] merge: add missing strbuf_release()
Date:   Wed,  6 Oct 2021 12:02:25 +0200
Message-Id: <patch-7.7-d7c94fa2851-20211006T095426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
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
index b4bdba2faf6..cd0f0b9e3f2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1579,6 +1579,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		finish(head_commit, remoteheads, &commit->object.oid, msg.buf);
 		remove_merge_branch_state(the_repository);
+		strbuf_release(&msg);
 		goto done;
 	} else if (!remoteheads->next && common->next)
 		;
@@ -1749,6 +1750,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
2.33.0.1441.gbbcdb4c3c66

