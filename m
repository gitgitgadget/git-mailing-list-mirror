Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4579C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FDA61370
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbhGNA5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbhGNA5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:57:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB6FC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so325846wmq.3
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tErMM66uwnUcqKAClY65bBInNBx/z3NreelbmQpG4w4=;
        b=R+YN10wGuFFdT9o+sC3L2Y9yTYSHQngFZhAXg2/pE6FQRB6APSYcZjI7vzzkEyiDFk
         Oa+1Y7DYc+NNhkCHrhHpfEcAWxTKyBTR4ctyYdrioQs8H1EUYYF69keH/Nar+pRyTPet
         zzKKrggZj2OfHKz6z331xR+rornjfha/ZmnmT+LDLyUH8FyO0agq5+EXiLHRhO3gS8oF
         cUULPa80Uz14DGU7+6f0jSbyMXzU+gh6RuV1eior1Ac2XJWXbnt8/u/YA6l7eM1Uluc4
         IA5cwyArHuXNCxzVdy0Nwf6Dl9fK7gAW5W5vXzIc/P+tx2hIFbNR0W++MhkkJQLFlbT9
         Y8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tErMM66uwnUcqKAClY65bBInNBx/z3NreelbmQpG4w4=;
        b=ZSj/O5RLq2IqsJysSITdmHFaR6E++1huc0AYLybUQpLyva9gI3zTFEO2GuPrQHTNhy
         TMYxOHOPoSTku2SxteJ3MzkP79lezjjRNvGn0jDdXJf0kNGI703ivZoa2UcNNIxNsgRO
         nuRW8TfEcjpnmDJOtJ2VqMNKdBzxzkfxWhziZW4niu0Y83cQYOTg/Dda3pdffjj9rI9E
         YRo/kkch8eEmO6RRUhFYYzLQvwc7wvP8imzS4/AjakKHmrnQz5FzwnduCkJwJpfEVHoo
         Qnv9ilrSRVtCUYJeAu1CTfCP0Q7aeA7c1I0z19uouKE9vKP42I3JLRcsgDVWijHzgbt6
         FQiw==
X-Gm-Message-State: AOAM531IqqxQuW151bLr8G8AVxBA/pqK4yS0yy8kq8I0iyji0JU+FaXS
        UAc5A+MmwMUaIaSXDX9HqBHQzdMF3fT98M8d
X-Google-Smtp-Source: ABdhPJwnWXbpw1XsZDBbpWFw8JD8IqC1FG9/AEQL8S/k1QLcFRZc/YX7xweg6dOn0iZBRV1ry0AtyQ==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr951724wmi.121.1626224048941;
        Tue, 13 Jul 2021 17:54:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm463315wru.95.2021.07.13.17.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:54:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/5] tests: replace [de]packetize() shell+perl test-tool pkt-line
Date:   Wed, 14 Jul 2021 02:54:03 +0200
Message-Id: <patch-3.5-92bfd8a87b-20210714T005115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.788.ge724008458
In-Reply-To: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com> <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shell+perl "[de]packetize()" helper functions were added in
4414a150025 (t/lib-git-daemon: add network-protocol helpers,
2018-01-24), and around the same time we added the "pkt-line" helper
in 74e70029615 (test-pkt-line: introduce a packet-line test helper,
2018-03-14).

For some reason it seems we've mostly used the shell+perl version
instead of the helper since then. There were discussions around
88124ab2636 (test-lib-functions: make packetize() more efficient,
2020-03-27) and cacae4329fa (test-lib-functions: simplify packetize()
stdin code, 2020-03-29) to improve them and make them more efficient.

Let's instead just use the test helper, I think this results in both
more legible code, and for anyone who cares about efficiency it'll be
faster.

The conversion away from extract_haves() in
t5410-receive-pack-alternates.sh and the "just pick out" logic in
t5570-git-daemon.sh isn't strictly required for this migration, but in
this case it's easy enough to test_cmp the whole output, so let's just
do that.

Similarly, there are cases here of changing "printf 0000" to a version
that'll emit a trailing newline after "0000", or where we can do away
with the "0000" trailer. Let's just always include, and include it in
the same way.

We can't convert all the users of packetize(), it has a feature the
test-tool is missing. This'll be addressed in the subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5410-receive-pack-alternates.sh     | 42 ++++++++++++++++++--------
 t/t5411/once-0010-report-status-v1.sh  | 16 +++++-----
 t/t5500-fetch-pack.sh                  | 15 +++++----
 t/t5530-upload-pack-error.sh           | 24 ++++++++-------
 t/t5562-http-backend-content-length.sh | 13 ++++----
 t/t5570-git-daemon.sh                  | 12 +++++---
 t/t5704-protocol-violations.sh         | 30 +++++++++---------
 7 files changed, 89 insertions(+), 63 deletions(-)

diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
index 0b28e4e452..d0053d95a4 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -16,10 +16,6 @@ test_expect_success 'setup' '
 	test_commit private
 '
 
-extract_haves () {
-	depacketize | perl -lne '/^(\S+) \.have/ and print $1'
-}
-
 test_expect_success 'with core.alternateRefsCommand' '
 	write_script fork/alternate-refs <<-\EOF &&
 		git --git-dir="$1" for-each-ref \
@@ -27,18 +23,40 @@ test_expect_success 'with core.alternateRefsCommand' '
 			refs/heads/public/
 	EOF
 	test_config -C fork core.alternateRefsCommand ./alternate-refs &&
-	git rev-parse public/branch >expect &&
-	printf "0000" | git receive-pack fork >actual &&
-	extract_haves <actual >actual.haves &&
-	test_cmp expect actual.haves
+
+	test-tool pkt-line pack >in <<-\EOF &&
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse main) refs/heads/main
+	$(git rev-parse base) refs/tags/base
+	$(git rev-parse public) .have
+	0000
+	EOF
+
+	git receive-pack fork >out <in &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'with core.alternateRefsPrefixes' '
 	test_config -C fork core.alternateRefsPrefixes "refs/heads/private" &&
-	git rev-parse private/branch >expect &&
-	printf "0000" | git receive-pack fork >actual &&
-	extract_haves <actual >actual.haves &&
-	test_cmp expect actual.haves
+
+	test-tool pkt-line pack >in <<-\EOF &&
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse main) refs/heads/main
+	$(git rev-parse base) refs/tags/base
+	$(git rev-parse private) .have
+	0000
+	EOF
+
+	git receive-pack fork >out <in &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
index 1233a46eac..ddf3da5a26 100644
--- a/t/t5411/once-0010-report-status-v1.sh
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -33,15 +33,13 @@ test_expect_success "proc-receive: report status v1" '
 			printf "%s %s refs/heads/main\0report-status object-format=$GIT_DEFAULT_HASH\n" \
 				$A $B | packetize
 		fi &&
-		printf "%s %s refs/for/main/topic1\n" \
-			$ZERO_OID $A | packetize &&
-		printf "%s %s refs/heads/foo\n" \
-			$ZERO_OID $A | packetize &&
-		printf "%s %s refs/for/next/topic\n" \
-			$ZERO_OID $A | packetize &&
-		printf "%s %s refs/for/main/topic2\n" \
-			$ZERO_OID $A | packetize &&
-		printf 0000 &&
+		test-tool pkt-line pack <<-EOF &&
+		$ZERO_OID $A refs/for/main/topic1
+		$ZERO_OID $A refs/heads/foo
+		$ZERO_OID $A refs/for/next/topic
+		$ZERO_OID $A refs/for/main/topic2
+		0000
+		EOF
 		printf "" | git -C "$upstream" pack-objects --stdout
 	} | git receive-pack "$upstream" --stateless-rpc \
 	>out 2>&1 &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 8a5d3492c7..ff0b7dd89f 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -872,14 +872,17 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	git commit-graph write --reachable &&
 	git config core.commitGraph true &&
 
-	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
-	0012command=fetch
-	$(echo "object-format=$(test_oid algo)" | packetize)
-	00010013deepen-since 1
-	$(echo "want $(git rev-parse other)" | packetize)
-	$(echo "have $(git rev-parse main)" | packetize)
+	test-tool pkt-line pack >in <<-EOF &&
+	command=fetch
+	object-format=$(test_oid algo)
+	0001
+	deepen-since 1
+	want $(git rev-parse other)
+	have $(git rev-parse main)
 	0000
 	EOF
+
+	GIT_PROTOCOL=version=2 git upload-pack . <in >/dev/null
 	)
 '
 
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 7c1460eaa9..8ccaae1047 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -90,18 +90,20 @@ test_expect_success 'upload-pack fails due to error in pack-objects enumeration'
 
 test_expect_success 'upload-pack tolerates EOF just after stateless client wants' '
 	test_commit initial &&
-	head=$(git rev-parse HEAD) &&
-
-	{
-		packetize "want $head" &&
-		packetize "shallow $head" &&
-		packetize "deepen 1" &&
-		printf "0000"
-	} >request &&
 
-	printf "0000" >expect &&
-
-	git upload-pack --stateless-rpc . <request >actual &&
+	head=$(git rev-parse HEAD) &&
+	test-tool pkt-line pack >request <<-EOF &&
+	want $head
+	shallow $head
+	deepen 1
+	0000
+	EOF
+
+	cat >expect <<-\EOF &&
+	0000
+	EOF
+	git upload-pack --stateless-rpc . <request >out &&
+	test-tool pkt-line unpack <out >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index e5d3d15ba8..e6c8338b64 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -53,12 +53,13 @@ test_expect_success 'setup' '
 	test_commit c1 &&
 	hash_head=$(git rev-parse HEAD) &&
 	hash_prev=$(git rev-parse HEAD~1) &&
-	{
-		packetize "want $hash_head" &&
-		printf 0000 &&
-		packetize "have $hash_prev" &&
-		packetize "done"
-	} >fetch_body &&
+	test-tool pkt-line pack >fetch_body <<-EOF &&
+	want $hash_head
+	0000
+	have $hash_prev
+	done
+	0000
+	EOF
 	test_copy_bytes 10 <fetch_body >fetch_body.trunc &&
 	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
 	{
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 82c31ab6cd..2dde034881 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -198,12 +198,14 @@ test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
 		printf "0000"
 	} >input &&
 	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
-	depacketize <output >output.raw &&
+	test-tool pkt-line unpack <output >actual &&
+
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD) HEAD
+	$(git rev-parse refs/heads/main) refs/heads/main
+	0000
+	EOF
 
-	# just pick out the value of main, which avoids any protocol
-	# particulars
-	perl -lne "print \$1 if m{^(\\S+) refs/heads/main}" <output.raw >actual &&
-	git -C "$repo" rev-parse main >expect &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 038fffd3d0..44e2c0d3de 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -7,13 +7,14 @@ making sure that we do not segfault or otherwise behave badly.'
 . ./test-lib.sh
 
 test_expect_success 'extra delim packet in v2 ls-refs args' '
-	{
-		packetize command=ls-refs &&
-		packetize "object-format=$(test_oid algo)" &&
-		printf 0001 &&
-		# protocol expects 0000 flush here
-		printf 0001
-	} >input &&
+	# protocol expects 0000 flush after the 0001
+	test-tool pkt-line pack >input <<-EOF &&
+	command=ls-refs
+	object-format=$(test_oid algo)
+	0001
+	0001
+	EOF
+
 	cat >err.expect <<-\EOF &&
 	fatal: expected flush after ls-refs arguments
 	EOF
@@ -23,13 +24,14 @@ test_expect_success 'extra delim packet in v2 ls-refs args' '
 '
 
 test_expect_success 'extra delim packet in v2 fetch args' '
-	{
-		packetize command=fetch &&
-		packetize "object-format=$(test_oid algo)" &&
-		printf 0001 &&
-		# protocol expects 0000 flush here
-		printf 0001
-	} >input &&
+	# protocol expects 0000 flush after the 0001
+	test-tool pkt-line pack >input <<-EOF &&
+	command=fetch
+	object-format=$(test_oid algo)
+	0001
+	0001
+	EOF
+
 	cat >err.expect <<-\EOF &&
 	fatal: expected flush after fetch arguments
 	EOF
-- 
2.32.0.788.ge724008458

