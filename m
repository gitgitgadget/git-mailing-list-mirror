Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDBBC2D0C0
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 01:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78884206D3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 01:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekjx/qfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfLXBBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:01:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37176 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLXBBO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 20:01:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so9962887pfn.4
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 17:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RH4cVQrGBq8pTer3zt+mAyUZujiV0cR+bmvihh+SW2w=;
        b=ekjx/qfobFpotsLV+Ph0Tu0li6dwJ7AgrZptofqeIznDGs2gF/HrQkbyRtkoenZHUz
         g+F+vR/PiPdYbVBtKNtp/INKEP3JPyVg84MWIHwqvEFfpIFfzDWs4O9MtiuAICt96t2R
         7QXXTbL/dWcXQCUYCpqNJcrMxfES0K2dJIXRmZY+z207OYtyeUnNxlsJI52hWNERaPs1
         Y2Ogof0+gW9xA2b0lKKhxOsG3ZnkaaLJPalEV+8/gqKFr9b8xxtbPgrMSCfAdz/otalK
         syfGNIKxBR55Gss7QDT2uQkQGn6BNmDtrCmrtjJ3d69NL9oXrH+EB8Q2Ew3JN2kfKYzG
         M6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RH4cVQrGBq8pTer3zt+mAyUZujiV0cR+bmvihh+SW2w=;
        b=EgidCNgDM2O5kTMpnO5fEwKQZtLAW5iR9TE5TRO7SYFwGlxVoNvftl/d92gELdCsV2
         HkkQ2lwz03u5I56a9DUFZM3z7qYaZgxLYADE1pzIF+a4eKJDfy5NxGk4HRRXMiPiBWni
         zB9CjOnvrJivzrRL9ylsKbax6nbn1BPhJEuYDvZD2oSvXXkz+nTLdXH4g1dzJfg4ENf+
         SeHfx0IqFoJWVWDZ9E9tS3adj9BxQWWWVxAvMzgR1oxWo14HuoXBxArj+Y9VaSVBOiFK
         zhlDfT99Cx8wUEQf02H0wIyvv4C7m4OkEqFlfg7sOK/kQW8zCnwRttd0X5u9vnKWj6OT
         KK0g==
X-Gm-Message-State: APjAAAUIjtVrwkP+nQ0lJJE5EflPNeLvzTDDu6DNh8tVD08uGKkjIT/K
        cwcfDSeP0l1GjklNNI2Qu+2/NChf
X-Google-Smtp-Source: APXvYqzRLlWPo7/BaPix7+RpaDfo7xxC79wk3YRuePZTEXfI3PbMjT2d2FB3LV4s7gNZJn+K0SKkZQ==
X-Received: by 2002:a63:710:: with SMTP id 16mr34236097pgh.58.1577149272888;
        Mon, 23 Dec 2019 17:01:12 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id z30sm27118846pfq.154.2019.12.23.17.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 17:01:12 -0800 (PST)
Date:   Mon, 23 Dec 2019 17:01:10 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 3/5] test: request GIT_TEST_PROTOCOL_VERSION=0 when
 appropriate
Message-ID: <20191224010110.GF38316@google.com>
References: <20191224005816.GC38316@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224005816.GC38316@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 8cbeba0632 (tests: define GIT_TEST_PROTOCOL_VERSION,
2019-02-25), it has been possible to run tests with a newer protocol
version by setting the GIT_TEST_PROTOCOL_VERSION envvar to a version
number.  Tests that assume protocol v0 handle this by explicitly
setting

	GIT_TEST_PROTOCOL_VERSION=

or similar constructs like 'test -z "$GIT_TEST_PROTOCOL_VERSION" ||
return 0' to declare that they only handle the default (v0) protocol.

The emphasis there is a bit off: it would be clearer to specify
GIT_TEST_PROTOCOL_VERSION=0 to inform the reader that these tests are
specifically testing and relying on details of protocol v0.  Do so.

This way, a reader does not need to know what the default protocol
version is, and the tests can continue to work when the default
protocol version used by Git advances past v0.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t5400-send-pack.sh                 |  2 +-
 t/t5500-fetch-pack.sh                |  5 +++--
 t/t5512-ls-remote.sh                 | 10 +++++-----
 t/t5515-fetch-merge-logic.sh         |  3 ++-
 t/t5516-fetch-push.sh                | 12 ++++++------
 t/t5539-fetch-http-shallow.sh        |  2 +-
 t/t5541-http-push-smart.sh           |  4 ++--
 t/t5551-http-fetch-smart.sh          | 12 ++++++------
 t/t5552-skipping-fetch-negotiator.sh |  2 +-
 t/t5700-protocol-v1.sh               |  3 ++-
 t/t7406-submodule-update.sh          |  2 +-
 11 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 571d620aed..b84618c925 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -288,7 +288,7 @@ test_expect_success 'receive-pack de-dupes .have lines' '
 	$shared .have
 	EOF
 
-	GIT_TRACE_PACKET=$(pwd)/trace GIT_TEST_PROTOCOL_VERSION= \
+	GIT_TRACE_PACKET=$(pwd)/trace GIT_TEST_PROTOCOL_VERSION=0 \
 	    git push \
 		--receive-pack="unset GIT_TRACE_PACKET; git-receive-pack" \
 		fork HEAD:foo &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 964930b2d2..baa1a99f45 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -440,11 +440,12 @@ test_expect_success 'setup tests for the --stdin parameter' '
 '
 
 test_expect_success 'setup fetch refs from cmdline v[12]' '
+	cp -r client client0 &&
 	cp -r client client1 &&
 	cp -r client client2
 '
 
-for version in '' 1 2
+for version in '' 0 1 2
 do
 	test_expect_success "protocol.version=$version fetch refs from cmdline" "
 		(
@@ -638,7 +639,7 @@ test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised a
 	git init client &&
 	# Some protocol versions (e.g. 2) support fetching
 	# unadvertised objects, so restrict this test to v0.
-	test_must_fail env GIT_TEST_PROTOCOL_VERSION= git -C client fetch-pack ../server \
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -C client fetch-pack ../server \
 		$(git -C server rev-parse refs/heads/master^) 2>err &&
 	test_i18ngrep "Server does not allow request for unadvertised object" err
 '
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index d7b9f9078f..459d1fcddf 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -225,7 +225,7 @@ test_expect_success 'ls-remote --symref' '
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
-	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref >actual &&
+	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref >actual &&
 	test_cmp expect actual
 '
 
@@ -236,7 +236,7 @@ test_expect_success 'ls-remote with filtered symref (refname)' '
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
-	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref . HEAD >actual &&
+	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref . HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -249,7 +249,7 @@ test_expect_failure 'ls-remote with filtered symref (--heads)' '
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
-	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref --heads . >actual &&
+	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref --heads . >actual &&
 	test_cmp expect actual
 '
 
@@ -260,9 +260,9 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
-	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref --heads . >actual &&
+	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref --heads . >actual &&
 	test_cmp expect actual &&
-	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref . "refs/heads/*" >actual &&
+	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref . "refs/heads/*" >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 961eb35c99..a9a7d50d3e 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -8,7 +8,8 @@ test_description='Merge logic in fetch'
 
 # NEEDSWORK: If the overspecification of the expected result is reduced, we
 # might be able to run this test in all protocol versions.
-GIT_TEST_PROTOCOL_VERSION=
+GIT_TEST_PROTOCOL_VERSION=0
+export GIT_TEST_PROTOCOL_VERSION
 
 . ./test-lib.sh
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c81ca360ac..f12cbef097 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1151,7 +1151,7 @@ test_expect_success 'fetch exact SHA1' '
 		# unadvertised objects, so restrict this test to v0.
 
 		# fetching the hidden object should fail by default
-		test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+		test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
 			git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
 		test_i18ngrep "Server does not allow request for unadvertised object" err &&
 		test_must_fail git rev-parse --verify refs/heads/copy &&
@@ -1210,7 +1210,7 @@ do
 			cd shallow &&
 			# Some protocol versions (e.g. 2) support fetching
 			# unadvertised objects, so restrict this test to v0.
-			test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+			test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
 				git fetch --depth=1 ../testrepo/.git $SHA1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch --depth=1 ../testrepo/.git $SHA1 &&
@@ -1241,9 +1241,9 @@ do
 			cd shallow &&
 			# Some protocol versions (e.g. 2) support fetching
 			# unadvertised objects, so restrict this test to v0.
-			test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+			test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
 				git fetch ../testrepo/.git $SHA1_3 &&
-			test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+			test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
 				git fetch ../testrepo/.git $SHA1_1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch ../testrepo/.git $SHA1_1 &&
@@ -1251,7 +1251,7 @@ do
 			test_must_fail git cat-file commit $SHA1_2 &&
 			git fetch ../testrepo/.git $SHA1_2 &&
 			git cat-file commit $SHA1_2 &&
-			test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+			test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
 				git fetch ../testrepo/.git $SHA1_3 2>err &&
 			test_i18ngrep "remote error:.*not our ref.*$SHA1_3\$" err
 		)
@@ -1291,7 +1291,7 @@ test_expect_success 'peeled advertisements are not considered ref tips' '
 	git -C testrepo commit --allow-empty -m two &&
 	git -C testrepo tag -m foo mytag HEAD^ &&
 	oid=$(git -C testrepo rev-parse mytag^{commit}) &&
-	test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
 		git fetch testrepo $oid 2>err &&
 	test_i18ngrep "Server does not allow request for unadvertised object" err
 '
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index b4ad81f006..c0d02dee89 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -69,7 +69,7 @@ test_expect_success 'no shallow lines after receiving ACK ready' '
 		test_commit new-too &&
 		# NEEDSWORK: If the overspecification of the expected result is reduced, we
 		# might be able to run this test in all protocol versions.
-		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" GIT_TEST_PROTOCOL_VERSION= \
+		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" GIT_TEST_PROTOCOL_VERSION=0 \
 			git fetch --depth=2 &&
 		grep "fetch-pack< ACK .* ready" ../trace &&
 		! grep "fetch-pack> done" ../trace
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 4c970787b0..23be8ce92d 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -49,7 +49,7 @@ test_expect_success 'no empty path components' '
 
 	# NEEDSWORK: If the overspecification of the expected result is reduced, we
 	# might be able to run this test in all protocol versions.
-	if test -z "$GIT_TEST_PROTOCOL_VERSION"
+	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
 	then
 		check_access_log exp
 	fi
@@ -135,7 +135,7 @@ EOF
 test_expect_success 'used receive-pack service' '
 	# NEEDSWORK: If the overspecification of the expected result is reduced, we
 	# might be able to run this test in all protocol versions.
-	if test -z "$GIT_TEST_PROTOCOL_VERSION"
+	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
 	then
 		check_access_log exp
 	fi
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index e38e543867..6788aeface 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -43,7 +43,7 @@ test_expect_success 'clone http repository' '
 	< Cache-Control: no-cache, max-age=0, must-revalidate
 	< Content-Type: application/x-git-upload-pack-result
 	EOF
-	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION= \
+	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 \
 		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
@@ -84,7 +84,7 @@ test_expect_success 'clone http repository' '
 
 	# NEEDSWORK: If the overspecification of the expected result is reduced, we
 	# might be able to run this test in all protocol versions.
-	if test -z "$GIT_TEST_PROTOCOL_VERSION"
+	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
 	then
 		sed -e "s/^> Accept-Encoding: .*/> Accept-Encoding: ENCODINGS/" \
 				actual >actual.smudged &&
@@ -113,7 +113,7 @@ test_expect_success 'used upload-pack service' '
 
 	# NEEDSWORK: If the overspecification of the expected result is reduced, we
 	# might be able to run this test in all protocol versions.
-	if test -z "$GIT_TEST_PROTOCOL_VERSION"
+	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
 	then
 		check_access_log exp
 	fi
@@ -241,7 +241,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 
 	# NEEDSWORK: If the overspecification of the expected result is reduced, we
 	# might be able to run this test in all protocol versions.
-	if test -z "$GIT_TEST_PROTOCOL_VERSION"
+	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
 	then
 		tail -3 cookies.txt | sort >cookies_tail.txt &&
 		test_cmp expect_cookies.txt cookies_tail.txt
@@ -336,7 +336,7 @@ test_expect_success 'test allowreachablesha1inwant with unreachable' '
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
 	# Some protocol versions (e.g. 2) support fetching
 	# unadvertised objects, so restrict this test to v0.
-	test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
 		git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
 '
 
@@ -358,7 +358,7 @@ test_expect_success 'test allowanysha1inwant with unreachable' '
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
 	# Some protocol versions (e.g. 2) support fetching
 	# unadvertised objects, so restrict this test to v0.
-	test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
 		git -C test_reachable.git fetch origin "$(git rev-parse HEAD)" &&
 
 	git -C "$server" config uploadpack.allowanysha1inwant 1 &&
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index f70cbcc9ca..a2a5e0743f 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -107,7 +107,7 @@ test_expect_success 'use ref advertisement to filter out commits' '
 
 	# The ref advertisement itself is filtered when protocol v2 is used, so
 	# use v0.
-	GIT_TEST_PROTOCOL_VERSION= trace_fetch client origin to_fetch &&
+	GIT_TEST_PROTOCOL_VERSION=0 trace_fetch client origin to_fetch &&
 	have_sent c5 c4^ c2side &&
 	have_not_sent c4 c4^^ c4^^^
 '
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 2571eb90b7..022901b9eb 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -5,7 +5,8 @@ test_description='test git wire-protocol transition'
 TEST_NO_CREATE_REPO=1
 
 # This is a protocol-specific test.
-GIT_TEST_PROTOCOL_VERSION=
+GIT_TEST_PROTOCOL_VERSION=0
+export GIT_TEST_PROTOCOL_VERSION
 
 . ./test-lib.sh
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 7478f7ab7e..4fb447a143 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -960,7 +960,7 @@ test_expect_success 'submodule update clone shallow submodule outside of depth'
 		mv -f .gitmodules.tmp .gitmodules &&
 		# Some protocol versions (e.g. 2) support fetching
 		# unadvertised objects, so restrict this test to v0.
-		test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+		test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
 			git submodule update --init --depth=1 2>actual &&
 		test_i18ngrep "Direct fetching of that commit failed." actual &&
 		git -C ../submodule config uploadpack.allowReachableSHA1InWant true &&
-- 
2.24.1.735.g03f4e72817

