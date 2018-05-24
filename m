Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4D4200B9
	for <e@80x24.org>; Thu, 24 May 2018 20:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969170AbeEXUri (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 16:47:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36389 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966945AbeEXUrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 16:47:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id w129-v6so1464442pfd.3
        for <git@vger.kernel.org>; Thu, 24 May 2018 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kaV3lJEudyOVwB9JBolBciwzbwgnDbF/s37LpEMqrpc=;
        b=o31HogVycM2QPacT1qifUFf2p/VVhmlkFirzJOF/TJf8PURAVBqiahg6cTBy51WORp
         4sLQuf92wqEz2quObngPCop0JO2as6Saz7vDurUdA8nuWQA4DMvY7ar9/jQRGCi4fDiO
         NQ6zEXDYtwFOkzSFB+Oj4oczDGhzhezKpQenCJBNKuEHDFtvN/LG6bFzYo0JiwExad7N
         zVCnX15K3R/9MNy4UVHlCP6xAR2FbGKV8IloHKnFUTREJXefKmWs3jP/YAIdEed1CF6n
         LlUfkOcvPQlMksrxDfvQ+xr+KZCNSbOObM8pcRDQbb8AO7utriErRe3KNkz4QfU6UFo2
         OXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kaV3lJEudyOVwB9JBolBciwzbwgnDbF/s37LpEMqrpc=;
        b=AOQg/cv3rRNmD6AltshGe/QwizwJ9qSbfKx7elcJ+SQwgh3vcnbg1GBac5x8RBtxAK
         CK8uCyymm2sJJFdvq3Esgip8B6gjVhiG7gkChqY8EkUYTW7o5iztBPuBOs49VRSFVjHH
         zsTyD5YbhzEQ2KV1aVDH2xlKKbW+7fipZsTYQEiPChnDvHzkhEHRbBWpnlkQfA/i0aOg
         xO9jASkoyv6YYbSDzj1AvLAaOw78A5mSpCBfRCGz4f0+X2cfOY9HXRTnaRLSnwNQHDxa
         95oDzG5MSxn4im6T+wo2Qnm0Y5KMDJL6MrbEEDSFAraLsdYYUnWpA9JEE8P98jcQ+emB
         QntA==
X-Gm-Message-State: ALKqPwfygeS55lfcT2OH625wTWL1Tw9rrYrA21DpbnKmAI/KUjeJm8Cc
        JQFylTZPI+/v+RwkDnPcX6conNofGLU=
X-Google-Smtp-Source: AB8JxZrxpfIjS3pc3dK2cqnrHY9D+FZE/Melf6XnIV+HSM7RZ/F5V7lCdc9aSluoeGlc+T+XIB5png==
X-Received: by 2002:a62:a111:: with SMTP id b17-v6mr8844466pff.132.1527194856213;
        Thu, 24 May 2018 13:47:36 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 69-v6sm51168195pfh.33.2018.05.24.13.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 13:47:34 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH] submodule: do not pass null OID to setup_revisions
Date:   Thu, 24 May 2018 13:47:29 -0700
Message-Id: <20180524204729.19896-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If "git pull --recurse-submodules --rebase" is invoked when the current
branch and its corresponding remote-tracking branch have no merge base,
a "bad object" fatal error occurs. This issue was introduced with commit
a6d7eb2c7a ("pull: optionally rebase submodules (remote submodule
changes only)", 2017-06-23), which also introduced this feature.

This is because cmd_pull() in builtin/pull.c thus invokes
submodule_touches_in_range() with a null OID as the first parameter.
Ensure that this case works, and document what happens in this case.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 submodule.c               |  6 ++++--
 submodule.h               |  5 ++++-
 t/t5572-pull-submodule.sh | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 74d35b2577..49def93dd9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1169,8 +1169,10 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 
 	argv_array_push(&args, "--"); /* args[0] program name */
 	argv_array_push(&args, oid_to_hex(incl_oid));
-	argv_array_push(&args, "--not");
-	argv_array_push(&args, oid_to_hex(excl_oid));
+	if (!is_null_oid(excl_oid)) {
+		argv_array_push(&args, "--not");
+		argv_array_push(&args, oid_to_hex(excl_oid));
+	}
 
 	collect_changed_submodules(&subs, &args);
 	ret = subs.nr;
diff --git a/submodule.h b/submodule.h
index e5526f6aaa..1fd7111f60 100644
--- a/submodule.h
+++ b/submodule.h
@@ -94,7 +94,10 @@ extern int merge_submodule(struct object_id *result, const char *path,
 			   const struct object_id *a,
 			   const struct object_id *b, int search);
 
-/* Checks if there are submodule changes in a..b. */
+/*
+ * Checks if there are submodule changes in a..b. If a is the null OID,
+ * checks b and all its ancestors instead.
+ */
 extern int submodule_touches_in_range(struct object_id *a,
 				      struct object_id *b);
 extern int find_unpushed_submodules(struct oid_array *commits,
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 321bd37deb..f916729a12 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -132,4 +132,25 @@ test_expect_success 'pull rebase recursing fails with conflicts' '
 	test_i18ngrep "locally recorded submodule modifications" err
 '
 
+test_expect_success 'branch has no merge base with remote-tracking counterpart' '
+	rm -rf parent child &&
+
+	test_create_repo a-submodule &&
+	test_commit -C a-submodule foo &&
+
+	test_create_repo parent &&
+	git -C parent submodule add "$(pwd)/a-submodule" &&
+	git -C parent commit -m foo &&
+
+	git clone parent child &&
+
+	# Reset master so that it has no merge base with
+	# refs/remotes/origin/master.
+	OTHER=$(git -C child commit-tree -m bar \
+		$(git -C child rev-parse HEAD^{tree})) &&
+	git -C child reset --hard "$OTHER" &&
+
+	git -C child pull --recurse-submodules --rebase
+'
+
 test_done
-- 
2.17.0.768.g1526ddbba1.dirty

