Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A9FC43600
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC55661057
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhCaTK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbhCaTJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:09:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47712C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x16so20705984wrn.4
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nu/VRbN05fYm6M2zES05dsR+mIF4pM5pYJjsogGZyqY=;
        b=Bb1OM2BFZLLnY7LOpiZB9YkRcfwFgFMh6TuND+Zh7JBtgla0iBKzyZG8iOpeQDBIse
         4TFnctIGSfSkwMLDO5SoNOPB3uq2PewtAkRiwpkTTuk8+VfrGwZyNBeg5DY/VfXzdfEs
         8cWFrcN2IyDgt7AIBqHwnv4QIGELEN+8HTJtk8lQZjl5DzBuwIcYPVx/EyyLzNzEAbOc
         yERZWi3CGdCxVJ18xcIcS+rJ/n26ihiKYp7ipeWFERGWVNejCNsjIB6S7vaI+3XhsbkB
         hKJkvkGD5foUUqtPCP+vs+s5MotrhQHGbFt9T6iL5UJbjiHjSsWFzX/AdUo29Q/ksyMd
         DqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nu/VRbN05fYm6M2zES05dsR+mIF4pM5pYJjsogGZyqY=;
        b=ZI1mRxlk+kwIiMTLZg5UCh765RWjH+V9OUPH6vxSszUvhGHuO/45mOhxJ/pa1jpiGf
         M1pGdFMAXaOf4JhlirNHaTM0lRIgP5L9IiRjgzLRXnUx3/c3z7HXtrim/w+ONz+U42ec
         rutK9LojrGZbhicWXJecP7smMswcK3fFBGtmoVzFPPPVrarPemi/7VO6RhJEy+t87a6z
         v7NXwIV2em+96794YVa3geu7T4VS1OLBIS1kd4I60YsQ8qNF5DTFD41ZJdw0MeEnyO5t
         SKdNRI9xEukW8PTWgk8QAQkbLpr3pnfS2ICEhJ/XvrcukPPVnmLBVL4iHj3tullwBRX7
         IfMg==
X-Gm-Message-State: AOAM5300lidhMcpNpYamLKez+26Zf/lDSGfZPFtrkY7ze+nNiqYOGAhb
        I8u8HwB0VD55cm1FnLVfTH1rtlkiu3RzUw==
X-Google-Smtp-Source: ABdhPJxb/zadAaeUUuGXSRphrThP25aKaSFW5omsWHIikzSCI79e0ByyrBAGjcNAbVq3E0nqPe/5Yw==
X-Received: by 2002:adf:ba87:: with SMTP id p7mr5433205wrg.298.1617217796775;
        Wed, 31 Mar 2021 12:09:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/18] blame: emit a better error on 'git blame directory'
Date:   Wed, 31 Mar 2021 21:09:36 +0200
Message-Id: <patch-08.19-3c2ca98716d-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an early check for non-blobs in verify_working_tree_path() to
let any such objects pass, and instead die shortly thereafter in the
fake_working_tree_commit() caller's type check.

Now e.g. doing "git blame t" in git.git emits:

    fatal: unsupported file type t

Instead of:

    fatal: no such path 't' in HEAD

The main point of this test is to assert that we're not doing
something uniquely bad when in a conflicted merge. See
cd8ae20195 (git-blame shouldn't crash if run in an unmerged tree,
2007-10-18) and 9aeaab6811 (blame: allow "blame file" in the middle of
a conflicted merge, 2012-09-11) for the bug the test was originally
meant to address.

But when extending it let's grep out the specific error message for
good measure. Having to change it in the future (e.g. as part of my
parallel series to improve such 'OID does not match type' messages) is
a small price for ensuring it doesn't regress.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blame.c                         |  3 +--
 t/t8004-blame-with-conflicts.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/blame.c b/blame.c
index 5018bb8fb2c..d1fa3821a08 100644
--- a/blame.c
+++ b/blame.c
@@ -103,8 +103,7 @@ static void verify_working_tree_path(struct repository *r,
 		struct object_id blob_oid;
 		unsigned short mode;
 
-		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode) &&
-		    oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
+		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode))
 			return;
 	}
 
diff --git a/t/t8004-blame-with-conflicts.sh b/t/t8004-blame-with-conflicts.sh
index 35414a53363..5e3dea35a50 100755
--- a/t/t8004-blame-with-conflicts.sh
+++ b/t/t8004-blame-with-conflicts.sh
@@ -73,4 +73,25 @@ test_expect_success 'blame does not crash with conflicted file in stages 1,3' '
 	git blame file1
 '
 
+test_expect_success 'setup second case' '
+	git merge --abort
+'
+
+test_expect_success 'blame on directory/file conflict' '
+	mkdir d &&
+	test_commit second &&
+	test_commit d/file &&
+	test_must_fail git blame d 2>expected &&
+	grep "unsupported file type d" expected &&
+
+	git reset --hard second &&
+	>d &&
+	git add d &&
+	git commit -m"a not-a-dir" &&
+	test_must_fail git merge d/file &&
+
+	test_must_fail git blame d 2>actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.31.1.474.g72d45d12706

