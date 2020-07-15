Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022BC433DF
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 22:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9370D2065D
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 22:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPyogKNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGOWbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGOWbT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 18:31:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA6EC061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 15:31:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u12so4844436ybj.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 15:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AoJrpDvgX5UJvaTGUxm5/Of5Zm4zAvKpNOnwyNLWNP4=;
        b=mPyogKNqXhAZw+wMQ+AlDWDKKIDn8F556gEdR8zlhNF6aY0/V18gjsnebOUbuADXTK
         MGP8I/0tUpkk0qSJkI0aox3m0DLHcYHEU4RXg2O/lKdY0TxrddL4syols95v9PDMoItu
         Nk7RoEBFyjLiP8vbm7/7Fb/pRbt/MZ2XKYB9ndyijtSX3Szi/vZEOx1Jld4jFdCW3OVl
         tIOSDvBoYrog9M6YVM9iO06pHB3FKLL1kp8kikPamWkXN9lmv8XuZaOWJolq1QviWuK9
         YR0zMiw/dtmv2ZotQViIZwHnZURjYFRWB9Fhh0s65j8hs83v4ia+lla1THrY6aLeCVYB
         nuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AoJrpDvgX5UJvaTGUxm5/Of5Zm4zAvKpNOnwyNLWNP4=;
        b=NtSJsPakk0zZUqPbL3A5GMBQ0k8ICP0Wcda8KI6uScvUmIQswTRXMy/wi6eZkW5ChW
         +LObCtQfL8nGD1SBynSkIuprOkYZjQmesbf32JT+QtgWFS7+fUjZopNynWwwhdQOifeT
         ggzFVHBEBS7kSmZh43vQ2YM0l7XLpmrJ4VTVDRWsBnvGl8PizH07dsUV+RFeyat/4i8t
         kTKOyr+oqQkJhn0TY4GOlXBSrUj5/Pjm82MPWX7M2cnVmjMRl3KgKeyFPqVe8lFSPp2y
         VfRgHsFBeRoB2GpRQIFaPjodz/lLYaQBX6xtAAunHkkkTMoJO3h5ays9A6SEM605yuou
         jZYw==
X-Gm-Message-State: AOAM5311FulMuKz/pd1vWz3in1NG5OxuEMZUzPklZ29eUmrxDNLKBvu2
        nQmAYa3Xr/w80WV0Ln7KZ8EspgWRxk0nhFFeRV5pjjy8Zmt6WzI2rh2nJURO0dNdM572Bq6KoRP
        B+2GdpuMHkW0IgackLb3fZ5iM/3YCSDm9aUgDSA9BGBIgx4id08a0hgfwgEUD3C0i2WPPMZw65q
        nK
X-Google-Smtp-Source: ABdhPJyprv0O+VQ2p3bbm8cdzp48PgBAPFaGSN8pnI0bYKuQdUYUrM9eaV0OfMBTDYjC2zrS54lgE+2i9rJA8eH4PXJ8
X-Received: by 2002:a25:818c:: with SMTP id p12mr1726035ybk.199.1594852278062;
 Wed, 15 Jul 2020 15:31:18 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:31:12 -0700
Message-Id: <20200715223112.2018556-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH] upload-pack: do not lazy-fetch "have" objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When upload-pack receives a request containing "have" hashes, it (among
other things) checks if the served repository has the corresponding
objects. However, it does not do so with the
OBJECT_INFO_SKIP_FETCH_OBJECT flag, so if serving a partial clone, a
lazy fetch will be triggered first.

This was discovered at $DAYJOB when a user fetched from a partial clone
(into another partial clone - although this would also happen if the
repo to be fetched into is not a partial clone).

Therefore, whenever "have" hashes are checked for existence, pass the
OBJECT_INFO_SKIP_FETCH_OBJECT flag.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
There is also the greater issue that if a lazy fetch fails, the fetch is
usually fatal (and possibly always fatal - I haven't checked all the
code paths) when the calling code could just as easily continue without
the object (which is the case for upload-pack when checking "have"s),
but I haven't addressed that here.
---
 t/t5616-partial-clone.sh | 38 ++++++++++++++++++++++++++++++++++++++
 upload-pack.c            |  5 +++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8a27452a51..37de0afb02 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -422,6 +422,44 @@ test_expect_success 'single-branch tag following respects partial clone' '
 	test_must_fail git -C single rev-parse --verify refs/tags/C
 '
 
+test_expect_success 'fetch from a partial clone, protocol v0' '
+	rm -rf server client trace &&
+
+	# Pretend that the server is a partial clone
+	git init server &&
+	git -C server remote add a_remote "file://$(pwd)/" &&
+	test_config -C server core.repositoryformatversion 1 &&
+	test_config -C server extensions.partialclone a_remote &&
+	test_config -C server protocol.version 0 &&
+	test_commit -C server foo &&
+
+	# Fetch from the server
+	git init client &&
+	test_config -C client protocol.version 0 &&
+	test_commit -C client bar &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "file://$(pwd)/server" &&
+	! grep "version 2" trace
+'
+
+test_expect_success 'fetch from a partial clone, protocol v2' '
+	rm -rf server client trace &&
+
+	# Pretend that the server is a partial clone
+	git init server &&
+	git -C server remote add a_remote "file://$(pwd)/" &&
+	test_config -C server core.repositoryformatversion 1 &&
+	test_config -C server extensions.partialclone a_remote &&
+	test_config -C server protocol.version 2 &&
+	test_commit -C server foo &&
+
+	# Fetch from the server
+	git init client &&
+	test_config -C client protocol.version 2 &&
+	test_commit -C client bar &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "file://$(pwd)/server" &&
+	grep "version 2" trace
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/upload-pack.c b/upload-pack.c
index 951a2b23aa..af9d621755 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -482,7 +482,7 @@ static int got_oid(struct upload_pack_data *data,
 {
 	if (get_oid_hex(hex, oid))
 		die("git upload-pack: expected SHA1 object, got '%s'", hex);
-	if (!has_object_file(oid))
+	if (!has_object_file_with_flags(oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
 		return -1;
 	return do_got_oid(data, oid);
 }
@@ -1423,7 +1423,8 @@ static int process_haves(struct upload_pack_data *data, struct oid_array *common
 	for (i = 0; i < data->haves.nr; i++) {
 		const struct object_id *oid = &data->haves.oid[i];
 
-		if (!has_object_file(oid))
+		if (!has_object_file_with_flags(oid,
+						OBJECT_INFO_SKIP_FETCH_OBJECT))
 			continue;
 
 		oid_array_append(common, oid);
-- 
2.27.0.389.gc38d7665816-goog

