Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779152018E
	for <e@80x24.org>; Tue,  9 Aug 2016 04:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbcHIEIX (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:08:23 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35671 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbcHIEIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:08:21 -0400
Received: by mail-pa0-f53.google.com with SMTP id iw10so1184734pac.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:08:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M9PgmzkHMs4eKNd+Xj9vhCPO8JzIRT0POdtvOjgJDug=;
        b=ijHkUCFdm50XxGXcV3XXz9SYDqgd1gk16DBh4Xct5pr/B6zLh9fbh8ecPLWTWhz+9B
         abgDJ+vZejVFPpxJ99hpW1nD1qJTXJI8BgLUrA4sb8wWsQbiNJnCAIbbj3SkcXZjWTLJ
         KYODs2PDwywGcozWJlVpB07ArGWIVzIpdMbDKMcpYcKaA6C3SnDeYmnnqVtQHo0immU9
         MQRedijxLDHIsVFUI0M+4iXDizgvzsn2NS3h4HacBcfqJXoyQW+/IQyNxjDTiklcBxL1
         1q9iRM8hga24BA6BJKWGQ4sMJHuf6Tll/JZGelL6MIPMp2hXv20jb86DdDxHBcGYyLk5
         WFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M9PgmzkHMs4eKNd+Xj9vhCPO8JzIRT0POdtvOjgJDug=;
        b=M43gheOfSBOvcJWYmgP925Vkq/VxtjL833xX26FpSayga4uhzejenYW7Y3ohRLEWAq
         ICaJ39rOt0ThWd1OvNDzLN8FGiB1Xwquxhpr/oponGjPeYxYWuNKrmXNhpSUZJnsnSuk
         mcct7rfwtS+bddWoQFMctsMKCt/3KtACnIXusIlW6ARTtnFGnhrfq9YqfREYIjlyAodj
         uWUyw9WXfRya7jk8HrdOBKk3zIsEfdzO6s6SGqoKfNaahf/zou80oXE+3G5oY/VimhaF
         C0HPqu0mEF8HFmDCVCNGjZjwkvxmzEwryOj8gB4xPmRCEZs75+wIjlyX+pgpXrhUcWpe
         aOMQ==
X-Gm-Message-State: AEkoous3u5HKOqc9T7+89/jAVVCrD1mT5f/SzLLED/znIboU2xOR6EbtuAQIQKeZNuavJZ9Q
X-Received: by 10.66.72.10 with SMTP id z10mr70276553pau.63.1470715699380;
        Mon, 08 Aug 2016 21:08:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ad25:78d3:1e25:67ef])
        by smtp.gmail.com with ESMTPSA id p64sm51537382pfd.11.2016.08.08.21.08.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 21:08:18 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/9] t7408: merge short tests, factor out testing method
Date:	Mon,  8 Aug 2016 21:08:02 -0700
Message-Id: <20160809040811.21408-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
In-Reply-To: <20160809040811.21408-1-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com>
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
 t/t7408-submodule-reference.sh | 57 ++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index beee0bb..4a1b8f0 100755
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
@@ -40,44 +49,28 @@ test_expect_success 'preparing superproject' '
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
 
-test_expect_success 'that reference gets used with add' '
-	(
-		cd super/sub &&
-		echo "0 objects, 0 kilobytes" > expected &&
-		git count-objects > current &&
-		diff expected current
-	)
-'
-
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
+# forsubsequent tests and meant to be kept throughout the
+# remainder of the test.
+# Tests from here on, if they create their own test repository,
+# are expected to clean after themselves.
 
-test_expect_success 'that reference gets used with update' '
-	cd super-clone/sub &&
-	echo "0 objects, 0 kilobytes" > expected &&
-	git count-objects > current &&
-	diff expected current
+test_expect_success 'updating superproject keeps alternates' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone super super-clone &&
+	git -C super-clone submodule update --init --reference ../B &&
+	test_alternate_is_used super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
 '
 
 test_done
-- 
2.9.2.583.gd6329be.dirty

