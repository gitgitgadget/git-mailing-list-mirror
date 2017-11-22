Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6629A20954
	for <e@80x24.org>; Wed, 22 Nov 2017 21:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbdKVV2V (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 16:28:21 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36092 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbdKVV2T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 16:28:19 -0500
Received: by mail-pl0-f67.google.com with SMTP id b12so1459824plm.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 13:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=evsedx7mek22PGC/QQhiBjClUeKVorEG2Yz9G+EATbc=;
        b=lkN0IOoqTpl3uJXp4EqMiOJO/dTw8nBHHVJsJ28+l4Vu6+1dKAEdJkrDc/R8JBg+3c
         +crADgpGh/oAYe1lLVmxHy2Vow4bX5CKPEmQL6zz2H/G7WXtKwM6694KnHr7aPS2S7Zk
         st+xRYAcyd4esk+eLcwiU9dul2VWtU1WALRCQXbma3TmTmJW9thvpBp/AqDpV1UMjEoW
         pu/KofLX6LEaA4KZyjTwZKn+P0udAypLE64qTS83URT0MgSnEGptCLFycaDx8g99uTFK
         +UpZ5moqYn/RjV7lK5AeSMlmkQMgrRWVGQ9gPQ82swY2Sl1CSQ7I8sl54L2zFzJCKRVx
         KVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=evsedx7mek22PGC/QQhiBjClUeKVorEG2Yz9G+EATbc=;
        b=s5N3YGSSK4fVcdfSZ8ksEjcXb4qcCys3P/eNMR73Bd173TnpDc9vPZFtFn9NcVynzO
         +SXlv1VvXF0hx6NESXuGMmY2jhl6UjiNN/m0CRH3Hz1Cj5TsOxarRPJvweStA+zEAHcb
         vzEMFPZzjWeWLhHJUf8a24AmMc44FtTRMs4gbSysm8u/d45m0Bc9QLmKs0GX+bP+bb7u
         BMvkaB/cEhAaBs4X2u73d4lxiiDhkbq84P4RWgG1AMUW+Bu0cL13fmFXmnrHyi8iqd7P
         pSwHuszooyGtsZa9rdXbT7YQIffmWCu6gKBhrKLADOWnr5s3CWczrpZQ/Co4VonT2TBN
         0oJA==
X-Gm-Message-State: AJaThX4Mb6IfRDWkEGAvs+nr/9srtOLYZNxP/X+SJd2/SY3Ovkbnt1a3
        vn/sWrwrf7bwlqPzoVKxE2E3fbrF
X-Google-Smtp-Source: AGs4zMYJREJtUWR4chymZIrtItTOaCwxjwCIvgtYQVwA0Q2dDODh394uVs2i4J+iHZlXzSTm2Hs/Qw==
X-Received: by 10.159.252.198 with SMTP id o6mr22359489pls.390.1511386098581;
        Wed, 22 Nov 2017 13:28:18 -0800 (PST)
Received: from phord-x1.purestorage.com ([64.84.68.252])
        by smtp.gmail.com with ESMTPSA id f7sm29082492pfa.133.2017.11.22.13.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 13:28:16 -0800 (PST)
From:   Phil Hord <phil.hord@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     David Turner <dturner@twopensource.com>,
        Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v2 2/2] stash-store: add failing test for same-ref
Date:   Wed, 22 Nov 2017 13:28:02 -0800
Message-Id: <20171122212802.7068-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.15.0.471.g17a719cfe.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

stash-store cannot create a new stash with the same ref as stash@{0}. No
error is returned even though no new stash log is created. Add a failing
test to track.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 t/t3903-stash.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 279e31717..7d511afd3 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -813,6 +813,17 @@ test_expect_success 'push -m also works without space' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'store same ref twice' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create) &&
+	git stash store -m "original message" $STASH_ID &&
+	git stash store -m "custom message" $STASH_ID &&
+	echo "stash@{0}: custom message" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'store -m foo shows right message' '
 	>foo &&
 	git add foo &&
-- 
2.15.0.471.g17a719cfe.dirty

