Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E1B1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbcHOVxo (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:53:44 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35035 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbcHOVxn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:53:43 -0400
Received: by mail-pf0-f181.google.com with SMTP id x72so20400951pfd.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 14:53:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OYGhZRAnQ0ZhBr6CSQUljiZI4PQ14DZAodyViLuckZI=;
        b=mCnzGe9kPrw/MUZ6jVpJFJ+3aZC2a3bUJ3T+rfZzTGUQEOusrUIL7HpIUjcQdaxORI
         W715RBmO/K7emAJ3fycbMq1sJYMqX9PrllCHGZUWc2kwOGRF2JcIbvJNTAV9ONsLeaTB
         S5JqcEq6srbM5WcMiibN0OWy4O9S9cuQQsb+9M6rRd04h5d+itU2Xws2+6ZGI4TZCW7V
         vMIT4zoIXim5bdP1SApaLNwBOL70ToGBW9DZp+0rPRSlUIr1cLd1U0r04Ms7pIYaG917
         zYmZaPC+e80Jrk/Mn2mc7Fc4rNe0WgGNx5fImAY7ckCuqDI5igQcb4Jek0MKPOcrIlav
         5hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OYGhZRAnQ0ZhBr6CSQUljiZI4PQ14DZAodyViLuckZI=;
        b=CanX8RM78LgrDC06tHn6zsE751jEDOB7uWUccd+4/qZ1O92M90zSeLkswUz/7oB/9q
         bnM1YDXNeXheMnAXZkyhmBSMhn160P3O8eBOFLvTk6EWEFlHYrxcfmWKEYijlQupPQuM
         uXU1RNcP0Ihu5xhyFWNzf562zI8bc0up19DY9kbKqcZatwvNoeFJN0gFWocIJuRdqrXd
         grBBisRTBKV58WkrsMSG59dPIyCstBQFlf17084Djb/vRjxlD1xvVMlt8aBJFUS4TaQq
         Yb4j1jkgWnDaTFrOyRh+Q3ZPzKtKiTRxWliafAjudsP+khWNV2j7JAjrN7+x8mFvFFIh
         uIIA==
X-Gm-Message-State: AEkooutFbfvUu0zmIudPj8Ud8Mx5mpbV1R4V6Nskg60SIE9XATpPfpiawxleDwr/bZoWODIT
X-Received: by 10.98.104.71 with SMTP id d68mr3554399pfc.163.1471298022573;
        Mon, 15 Aug 2016 14:53:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fd0c:5bce:d30d:9f4d])
        by smtp.gmail.com with ESMTPSA id y3sm33665555pfd.65.2016.08.15.14.53.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 14:53:41 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 2/8] t7408: merge short tests, factor out testing method
Date:	Mon, 15 Aug 2016 14:53:21 -0700
Message-Id: <20160815215327.15682-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g525ad04.dirty
In-Reply-To: <20160815215327.15682-1-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Tests consisting of one line each can be consolidated to have fewer tests
to run as well as fewer lines of code.

When having just a few git commands, do not create a new shell but
use the -C flag in Git to execute in the correct directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7408-submodule-reference.sh | 48 ++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index b84c6748..dff47af 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -8,6 +8,15 @@ test_description='test clone --reference'
 
 base_dir=$(pwd)
 
+test_alternate_is_used () {
+	alternates_file="$1" &&
+	working_dir="$2" &&
+	test_line_count = 1 "$alternates_file" &&
+	echo "0 objects, 0 kilobytes" >expect &&
+	git -C "$working_dir" count-objects >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success 'preparing first repository' '
 	test_create_repo A &&
 	(
@@ -40,16 +49,14 @@ test_expect_success 'preparing superproject' '
 	)
 '
 
-test_expect_success 'submodule add --reference' '
+test_expect_success 'submodule add --reference uses alternates' '
 	(
 		cd super &&
 		git submodule add --reference ../B "file://$base_dir/A" sub &&
-		git commit -m B-super-added
-	)
-'
-
-test_expect_success 'after add: existence of info/alternates' '
-	test_line_count = 1 super/.git/modules/sub/objects/info/alternates
+		git commit -m B-super-added &&
+		git repack -ad
+	) &&
+	test_alternate_is_used super/.git/modules/sub/objects/info/alternates super/sub
 '
 
 test_expect_success 'that reference gets used with add' '
@@ -61,23 +68,18 @@ test_expect_success 'that reference gets used with add' '
 	)
 '
 
-test_expect_success 'cloning superproject' '
-	git clone super super-clone
-'
-
-test_expect_success 'update with reference' '
-	cd super-clone && git submodule update --init --reference ../B
-'
-
-test_expect_success 'after update: existence of info/alternates' '
-	test_line_count = 1 super-clone/.git/modules/sub/objects/info/alternates
-'
+# The tests up to this point, and repositories created by them
+# (A, B, super and super/sub), are about setting up the stage
+# for subsequent tests and meant to be kept throughout the
+# remainder of the test.
+# Tests from here on, if they create their own test repository,
+# are expected to clean after themselves.
 
-test_expect_success 'that reference gets used with update' '
-	cd super-clone/sub &&
-	echo "0 objects, 0 kilobytes" >expected &&
-	git count-objects >current &&
-	diff expected current
+test_expect_success 'updating superproject keeps alternates' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone super super-clone &&
+	git -C super-clone submodule update --init --reference ../B &&
+	test_alternate_is_used super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
 '
 
 test_done
-- 
2.9.2.730.g525ad04.dirty

