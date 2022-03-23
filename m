Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC89C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbiCWUe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344733AbiCWUeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A7A8CCD4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d7so3777755wrb.7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ebbH/g3PqFMEd/42SvN1Jg5dW7uDvc3NXH88FnzN8M=;
        b=lIlrq2WC9yeOPFrNc4YPET6fUo4h439bgfH0xbqZZ2vmo+fOecRNdOCg+okzfTmkf6
         hJ25ev2hGsC9Zp19gr8t/RR1nfIN+a0p7UiKPYIdtd8V2F47vDfdsk+kcvdyIrdsoXvA
         oNdavIa9vpblNIE6RLPA0xqdsabZk5zWHuHyf3KXv+zS5g96IuQabGyTBoqNPYeqsbRq
         Zxc4uDnIcqxeSmpCe06gkYGfm6W1cgfNwRNpm2kkdNyJzFT/mlTOTdvkQg30+vRL706j
         ONY8v1SsBwZ5kzC1xSwYb2AF1xCv8atZE/pkbokDYKfnWuiTO5wtOpuVz9lcT0rBbK3N
         UG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ebbH/g3PqFMEd/42SvN1Jg5dW7uDvc3NXH88FnzN8M=;
        b=BgyVWryJiRYgOWVDQaIIG5h0ydJjRDHiNS8NJeVvM+BESVlCWWQjogT4P0LoCycKZG
         GMEG9L/S/Rl9nngYxdgnmhusat18wT3FbzI+7zKEvnju495aw5Ed6C4LDEDGntMDmSj0
         0O3lBr8Z9imWeiHFvoMhn4M+/mdkX4eT7B29I3OkQYzVbAw0C8sePCzau5P6RMNKk/K2
         hJ/j2rVS4f0QLXLgbv1zKqfw9akKyj1lA0hzcNHmT8jo79ZkR+BJ2SUkxzMie+bUldvK
         gf1YcP5dkDlnr9XPDL0EA1U7Vc8b7kzTQvEBO2+E65opNxWdwvUs5jGtbN2dq4q3y9ka
         Hnnw==
X-Gm-Message-State: AOAM5339/VxjfCUgt6p47sxl6CIZUs9X/chzdxtKTzvtjWVm1qwZsrZL
        NMWuN2VLqEm8CapNFJw9mJBSr6FgCMVb9g==
X-Google-Smtp-Source: ABdhPJxzc9dAE++yXDsSrle7Kw52q15WcolxEpUjf5zrMrDtBomReU0u0qxq5uMdaYiM2MZxJ/zQ3g==
X-Received: by 2002:a5d:5846:0:b0:204:1a79:f1ab with SMTP id i6-20020a5d5846000000b002041a79f1abmr1535170wrf.520.1648067556432;
        Wed, 23 Mar 2022 13:32:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/27] revisions API users: use release_revisions() in http-push.c
Date:   Wed, 23 Mar 2022 21:32:01 +0100
Message-Id: <patch-v2-11.27-6fb2caf4d17-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case of cmd_main() in http-push.c we need to move the
deceleration of the "struct rev-list" into the loop over the
"remote_refs" when adding a release_revisions().

We'd previously set up the "revs" for each remote, but would
potentially leak memory on each one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index f0c044dcf76..01e7c2ac5c8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1689,7 +1689,6 @@ int cmd_main(int argc, const char **argv)
 	struct refspec rs = REFSPEC_INIT_PUSH;
 	struct remote_lock *ref_lock = NULL;
 	struct remote_lock *info_ref_lock = NULL;
-	struct rev_info revs;
 	int delete_branch = 0;
 	int force_delete = 0;
 	int objects_to_send;
@@ -1825,6 +1824,7 @@ int cmd_main(int argc, const char **argv)
 
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
+		struct rev_info revs;
 		struct strvec commit_argv = STRVEC_INIT;
 
 		if (!ref->peer_ref)
@@ -1941,6 +1941,7 @@ int cmd_main(int argc, const char **argv)
 		unlock_remote(ref_lock);
 		check_locks();
 		strvec_clear(&commit_argv);
+		release_revisions(&revs);
 	}
 
 	/* Update remote server info if appropriate */
-- 
2.35.1.1452.ga7cfc89151f

