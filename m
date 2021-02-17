Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE01C433E9
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CDD64E4A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhBQTov (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhBQTol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:44:41 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDBEC06178C
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id g5so20850271ejt.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bgtr3f/MeCnD/j7PjA4vMCRDeAni++W3VFiTwiq3ZM=;
        b=vQoDa2oF8aglYDqUQnV6PcoFhG89xxJsv9C+6mKVDcNVo5NhYwS7/ijHvg5JooeQQl
         dEgx4qr0WQwREGn9cSW+tmBb++M8iATenN5jzBLhWbnPR4eIiKCJMHiuIA1j00rG2G5q
         +3Vvx/7yYxQsDyCMZXzQAJ02kcNWrxsPea1U37GHFBr16cx9h81266plbxWPj6s4yUwM
         nRPFv1jS1E7FqWwuvVuPysZTaBgoGXR3BmxjaceIYDWc+ozmZgx6IVgvEHSOfq5hKhtm
         NV9qA7zK1ini1mKxIiVNfCfu0zREDMjgDxjW4e8yjeQJKKtov6kkm6sU8Bwa9nMxG9oy
         xlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bgtr3f/MeCnD/j7PjA4vMCRDeAni++W3VFiTwiq3ZM=;
        b=XO8LqOQQhDujO3TMgi/NYqt5k00t1U4z3yDyflDFz07+oJRL6vBEdTmV4IYc6qrjrj
         cS75H5x1kQExB3LA3acUmIKVh8ul6yj4k+s09S5lE3Shen8GjQ3kpuOIuo7qVTQaZzMM
         ofddRE/YkBl6NdJupsbM5S30/GoDDXvD+NDrKbE3f6r5cA9xOsSV2xtrAeoj3fCudOp5
         jIrf+NuHl9LPiWgKbS2B4nRRAeLTTVIMQLN//YBYVg5xtOFEGokNC3YLRhRKXayOZcZB
         +nv3ioUzv0yXEfe7pYXxBxge4dsetDJiUNwEDuuKtJ3PbVEB/fRSraxHdF2WIEsKhkvV
         XO/g==
X-Gm-Message-State: AOAM530xOR/NqH33s7zZg9JyYsHeQGrXy3oh4QSDSJsRkI4jhOr9nDv8
        z1bLsO9Z73RockBqShy5Wf+Ra6xMxqQAig==
X-Google-Smtp-Source: ABdhPJyDnG8TkVQJ3pILjKdoGTa3qK4JCzOms72BQll1tnlEvsH16/jY5XIie2uuOhEMiYRJQKCICA==
X-Received: by 2002:a17:907:3f13:: with SMTP id hq19mr578970ejc.142.1613590988889;
        Wed, 17 Feb 2021 11:43:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/14] fsck.c: call parse_msg_type() early in fsck_set_msg_type()
Date:   Wed, 17 Feb 2021 20:42:39 +0100
Message-Id: <20210217194246.25342-8-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no reason to defer the calling of parse_msg_type() until after
we've checked if the "id < 0". This is not a hot codepath, and
parse_msg_type() itself may die on invalid input.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 00e0fef21ca..7c53080ad48 100644
--- a/fsck.c
+++ b/fsck.c
@@ -203,11 +203,10 @@ void fsck_set_msg_type(struct fsck_options *options,
 		const char *msg_id_str, const char *msg_type_str)
 {
 	int msg_id = parse_msg_id(msg_id_str);
-	enum fsck_msg_type msg_type;
+	enum fsck_msg_type msg_type = parse_msg_type(msg_type_str);
 
 	if (msg_id < 0)
 		die("Unhandled message id: %s", msg_id_str);
-	msg_type = parse_msg_type(msg_type_str);
 
 	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
 		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
-- 
2.30.0.284.gd98b1dd5eaa7

