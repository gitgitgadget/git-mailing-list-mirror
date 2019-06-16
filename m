Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1907C1F462
	for <e@80x24.org>; Sun, 16 Jun 2019 18:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfFPSx4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 14:53:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60164 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726926AbfFPSx4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Jun 2019 14:53:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:159e:486:c87b:cfd7])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6DFAE6073E;
        Sun, 16 Jun 2019 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560711234;
        bh=axlbtRUpZ5RiLIVlbfzPVAE+a73AC2bmKrWScyFgNEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VRENODSNHUCOKx8UQNG8tQamvbHOyym4uVgbNohldzx/FrnO0zJZ2t7FhKSTtJoGF
         N0xWa8gzi5s0ii/rdE12lJgN8JqyjIi985BiBLPkJj145A4uZ07UkgcUg7QnlHogYS
         eXs5b0o731am8t9sgP9iS3X2RBRss3dHq6fipckwTx6oD9mO7q3mpMO4cDqYp14Pnd
         mV+rZQfQuVJ2zqLMa80gtDDXkvq6xDLoJS6ynXZIW8rNrxqma26DJX7TEnPw7VYzEi
         mMmoMuay76BiFZwa4kDiLu6rebRbn54wSuVkdmEubVawMdZBRb8jPq4X5FuVSBzBmJ
         YxieyA8PAzEE/TqFlgfSIJHSxO7+tVosXeoEguJGCjXdYrtDPZYZaKf2KwWWPqiwkt
         yF+DHqUKMAZEjsdMq/ZPplKujnuwmdC3MjrhGP8jHBBt1YeNmCU6gOaVn6Chu/D27f
         p/WLwL+dEhqDCpc9rzl16oNZnkxJm/vGv3+o8hTjSU8lLnf/3a9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/10] t5000: make hash independent
Date:   Sun, 16 Jun 2019 18:53:24 +0000
Message-Id: <20190616185330.549436-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5
In-Reply-To: <20190616185330.549436-1-sandals@crustytoothpaste.net>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test uses a stub of a very large (64 GB) object to test our
generation of tar archives.  In doing so, it uses the object ID of the
object so it can insert it into the database properly.  Look up these
values using test_oid.  Restructure the test slightly to use
test_oid_in_path.

Since we care about the object, not how it is named in a particular hash
algorithm, rename it to "huge-object", which is shorter and more
descriptive.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5000-tar-tree.sh                             |  16 +++++++++++-----
 ...5a8938e6999cb59b3ff66739902a => huge-object} | Bin
 2 files changed, 11 insertions(+), 5 deletions(-)
 rename t/t5000/{19f9c8273ec45a8938e6999cb59b3ff66739902a => huge-object} (100%)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 602bfd9574..37655a237c 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -94,6 +94,13 @@ check_tar() {
 	'
 }
 
+test_expect_success 'setup' '
+	test_oid_cache <<-EOF
+	obj sha1:19f9c8273ec45a8938e6999cb59b3ff66739902a
+	obj sha256:3c666f798798601571f5cec0adb57ce4aba8546875e7693177e0535f34d2c49b
+	EOF
+'
+
 test_expect_success \
     'populate workdir' \
     'mkdir a &&
@@ -369,11 +376,10 @@ test_lazy_prereq TAR_HUGE '
 '
 
 test_expect_success LONG_IS_64BIT 'set up repository with huge blob' '
-	obj_d=19 &&
-	obj_f=f9c8273ec45a8938e6999cb59b3ff66739902a &&
-	obj=${obj_d}${obj_f} &&
-	mkdir -p .git/objects/$obj_d &&
-	cp "$TEST_DIRECTORY"/t5000/$obj .git/objects/$obj_d/$obj_f &&
+	obj=$(test_oid obj) &&
+	path=$(test_oid_to_path $obj) &&
+	mkdir -p .git/objects/$(dirname $path) &&
+	cp "$TEST_DIRECTORY"/t5000/huge-object .git/objects/$path &&
 	rm -f .git/index &&
 	git update-index --add --cacheinfo 100644,$obj,huge &&
 	git commit -m huge
diff --git a/t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a b/t/t5000/huge-object
similarity index 100%
rename from t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a
rename to t/t5000/huge-object
