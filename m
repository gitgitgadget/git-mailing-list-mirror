Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE82F20193
	for <e@80x24.org>; Thu, 11 Aug 2016 23:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbcHKXOQ (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 19:14:16 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36467 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbcHKXOP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 19:14:15 -0400
Received: by mail-pf0-f179.google.com with SMTP id h186so2868726pfg.3
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 16:14:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k+mej+6czByiklHdyzIyp6Y/vBXvAKx81NsNY2JxuJw=;
        b=Rt8eNQKCd7d7POuw282CQh6lDduiy/DgjoCkrkHTJik51+6jIoA7nqnuTDdK6U2U/0
         wjajCSJgW6gBEF8qzD7xGphIH8QoSlbPEtWCyIE8S+Nmx42GsqVd28Kcuah6NVZu5fkd
         qKorQkYrsWBbL40iK0O+CSNxg9UXfAc1M4hii/Xaktby6tW8GTOkqjpRIQCCiHoRflnc
         Jqd3euw3GxOOsl+jJypfJGJJXNdjNpHfI26av/VA397YN9Z/+olx1uIWnfucGLbBgnCO
         G70B1fy68/TLa9vpDncRQNBETFSQRgUIrvyw1EBupBxcv0Nmz2dsa1H4EKRc135x8fs0
         9gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k+mej+6czByiklHdyzIyp6Y/vBXvAKx81NsNY2JxuJw=;
        b=Z/BJFaxMq4ZWhMSRUrXy+9xhrXScGztcGoVXs67bXL2G4Y0LVMvMBiZ6dl+UIWa1Nw
         d2oXYD2d3Bmbxx+bok2vwPARIWuRZRWzdqbme2XCvCm3+5kEOpAonG+d2c0/i1jxJjAT
         QxbxPPFnh7CKLzrYBE6e5yXWrUqVmjj6FV4j1q0EdtDDyQJKlCINT8TIniL2cBcfkpNo
         rAx3O9Y0dVmilL01xIdV5YBiryKK+2mKjxLMKvkHMTRbKE5d4coB6nMkGwLJmyEX0OPl
         Uo1Tzh7kiwltvowQSK8gvLKwOolb8l68iYrTwOWuNl1QLxe2LWTXePxdKs5Elv5WU69r
         I7Mg==
X-Gm-Message-State: AEkoouvVMe9YElShf6+RJO3jxEEjTFUP/rpuT12tIyXBlIS5Pdeujeua+BCaOVDys8vKpgNl
X-Received: by 10.98.75.219 with SMTP id d88mr21859439pfj.91.1470957254073;
        Thu, 11 Aug 2016 16:14:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2879:1504:a6e4:e441])
        by smtp.gmail.com with ESMTPSA id m78sm7710589pfj.66.2016.08.11.16.14.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 16:14:13 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/8] t7408: merge short tests, factor out testing method
Date:	Thu, 11 Aug 2016 16:13:59 -0700
Message-Id: <20160811231405.17318-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.737.g4a14654
In-Reply-To: <20160811231405.17318-1-sbeller@google.com>
References: <20160811231405.17318-1-sbeller@google.com>
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
2.9.2.737.g4a14654

