Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1588A1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 22:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933734AbeFTWdA (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 18:33:00 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:33205 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbeFTWc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 18:32:59 -0400
Received: by mail-qk0-f202.google.com with SMTP id x186-v6so969848qkb.0
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 15:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=H/MD9VqbukO0dSrjEgFGP/tx2QF/oRMUBjH3JIuntTE=;
        b=ZRv0j6U9T+ell5dYDBFyTx3SPShw5oSjNpq4PZPhhNwYY1p1UQL89i+VZQM0aQ/bej
         HROyY+kaJ7ORha/5T3rd543CmqiiYIgTAEKscjYKPut7v3K+nb2ptFHfNNcKE1mDKOzY
         Evv5L32fgcxhV5qN4Leoa0YXc5EmBTOicFmc1JzVwlTkas63m/LycRD6RGvNaRDxfQWS
         XOv1GyduBxaBhv2zOc7/tNnBp4WFS9nIKbjEeQgFrX6C6CbMw6TgqVXkX9oAEL9HD2Fd
         PMfgmNOwRquYh3MoyF7TLhwJGshyfx4jt2QW4aEEV5RxOuhVl8BcVkXh0VndW0kDPnu8
         Fuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=H/MD9VqbukO0dSrjEgFGP/tx2QF/oRMUBjH3JIuntTE=;
        b=Vt+nkqThk8BurvbMtIuNWOqHfypKeJ0y0sVh6XzELfF3sRz1Eg7oRW3nFa4ynhY7EE
         BXi7HNPvIfWNwu8Jz9L+mHPKe+A0mocm3oLUxg414qbZo8dr8aWb/OoSfvIBY7rO95tK
         aJMRJw0xvIy7dIfb6KuQ+NK7SZ//bDkMk28hkoMbuK3bXwXSj5ZHw/WFw6zXImmbZb1L
         Z2sMQRXQpeq7eiB0+4brgrOtvgB4aJdOBauwphP38P1hZM89VPGk2U/BbbHHZ2xCt2Fo
         O+GStT7QTBPNmPaCabcWppTsrNqn5E/4h/ZRkf7VTrqyUYvsyL3XzSUxDc/x2o5ZoB5S
         w30Q==
X-Gm-Message-State: APt69E3MoUvq/JkySlohQhqhvxgNeS0GAvbSoYzN9uHIQlAJnGZpJx4F
        H5UQF3Eko7F6yWFl9oYYGL/nkqi9RVUqNPG5xCAh0MDycphbhC34Y1aZ4b2u+osLmx3KBuLHEIe
        NNjOeV0hDPy6qQHi5yfctvROyltnY5uZe2gy5bqLciHiXolNT3DJoLgvWnvCb
X-Google-Smtp-Source: ADUXVKJJa3FGZMTmBeKZ0j3ZR4hJpfiDFVlepGk9zuJWn2S61KbqxDDmlzPhvT8SpFQfcJUHnYmwPqlpoaDC
MIME-Version: 1.0
X-Received: by 2002:a0c:93ca:: with SMTP id g10-v6mr12761029qvg.30.1529533978462;
 Wed, 20 Jun 2018 15:32:58 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:32:53 -0700
Message-Id: <20180620223253.226092-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH] submodule.c: report the submodule that an error occurs in
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an error occurs in updating the working tree of a submodule in
submodule_move_head, tell the user which submodule the error occurred in.

The call to read-tree contains a super-prefix, such that the read-tree
will correctly report any path related issues, but some error messages
do not contain a path, for example:

  ~/gerrit$ git checkout --recurse-submodules origin/master
  ~/gerrit$ fatal: failed to unpack tree object 07672f31880ba80300b38492df9d0acfcd6ee00a

Give the hint which submodule has a problem.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               | 2 +-
 t/lib-submodule-update.sh | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 939d6870ecd..ebd092a14fd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1668,7 +1668,7 @@ int submodule_move_head(const char *path,
 	argv_array_push(&cp.args, new_head ? new_head : empty_tree_oid_hex());
 
 	if (run_command(&cp)) {
-		ret = -1;
+		ret = error(_("Submodule '%s' could not be updated."), path);
 		goto out;
 	}
 
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 1f38a85371a..e27f5d8541d 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -781,7 +781,8 @@ test_submodule_recursing_with_args_common() {
 		(
 			cd submodule_update &&
 			git branch -t invalid_sub1 origin/invalid_sub1 &&
-			test_must_fail $command invalid_sub1 &&
+			test_must_fail $command invalid_sub1 2>err &&
+			grep sub1 err &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
-- 
2.18.0.rc2.346.g013aa6912e-goog

