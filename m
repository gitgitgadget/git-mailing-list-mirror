Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB6C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiDEFWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiDEFWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBAA203
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p8so11053815pfh.8
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TGSvFkAXH9tGqO4RDzpiOdb/LjAKqIyU7jw+pplVEPc=;
        b=QRXQTMLrifnCVnbMoHVH7dhm9pi8UjW1/JclUFlCQcYnN7rotSen11paPV6+p7ITUp
         ly7yWK7RMAkQJAbWmV1oaBA1XQj/TRGjH8VLDe4c1V+YuZHak8VC/A5LehhxyAOqizL+
         sx0tJbMt7DTX0ubaYgz/koTfSA64aeg0fwIaOu6HnNcPmWcyhBY5435uxTPpdvnelb7r
         FlblwmP/Nxj+YONIqo9sNfkpiIri/yO8MPFLXgNYcyoqWHT19D8FLp4pkEjAW5JagfRB
         S+Zh/3c/4hBhjpzCA5gcYDnJrjnMeeUDuLO98oIBd/fR3Ig2XqNZGd4Vzj8GXfVyVwNy
         KHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TGSvFkAXH9tGqO4RDzpiOdb/LjAKqIyU7jw+pplVEPc=;
        b=yZq3LPH9VrplGYil9rIPhnZ8Br0hjRZ2nPt3iUVTMGspTWt9rEHpeAUzGrRKIQsYM3
         t/19KsrNAdyQmkmq/TeZwXPckRLCl+sEWAELEf9zaYF9Pqs+wv/Vn1oGhUq0NsAFM4sw
         wLHrDtxt082C16v0ONnz6nclPhSR7kxZG/2PyXcZt/GZwD67bXESR/Pi3n4dwve3MDP/
         5Jc0azAtS9EfMCk56sVm7PcRecZ2KllewkOT2U8dJCxe0wYxwOzfCWjnDtd7um2USuqG
         YdOZxMSeESETQucai0BOy370I/X16TyqiR0HBcaSFFcGCmEhHR49tJxnO8iJ1ILDVsOw
         mJfg==
X-Gm-Message-State: AOAM533lLjl4W5pGyXhevJA0+QxzBbskJWVaN3UuId9zY1PxW9ihw1G1
        DN4rq3qCNNyEfjbPAfkKlZZBlPUMo6q2sg==
X-Google-Smtp-Source: ABdhPJxRkluBYhDxiYKeDA1HUSgy+MlV1hGPzar4kx0tzZ5fR6XTfQnriEXpkeYtSVVhojnIa5jTlQ==
X-Received: by 2002:aa7:88d6:0:b0:4fa:ba98:4f5d with SMTP id k22-20020aa788d6000000b004faba984f5dmr1827107pff.5.1649136033992;
        Mon, 04 Apr 2022 22:20:33 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:33 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 09/12] test-lib-functions: add parsing helpers for ls-files and ls-tree
Date:   Mon,  4 Apr 2022 22:20:15 -0700
Message-Id: <20220405052018.11247-10-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Several tests use awk to parse OIDs from the output of 'git ls-files
--stage' and 'git ls-tree'. Introduce helpers to centralize these uses
of awk.

Update t5317-pack-objects-filter-objects.sh to use the new ls-files
helper so that it has some usages to review. Other updates are left for
the future.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/t5317-pack-objects-filter-objects.sh | 91 +++++++++++++-------------
 t/test-lib-functions.sh                | 10 +++
 2 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 33b740ce628..bb633c9b099 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -10,9 +10,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 # Test blob:none filter.
 
 test_expect_success 'setup r1' '
-	echo "{print \$1}" >print_1.awk &&
-	echo "{print \$2}" >print_2.awk &&
-
 	git init r1 &&
 	for n in 1 2 3 4 5
 	do
@@ -22,10 +19,13 @@ test_expect_success 'setup r1' '
 	done
 '
 
+parse_verify_pack_blob_oid () {
+	awk '{print $1}' -
+}
+
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r1 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -35,7 +35,7 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r1 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -54,12 +54,12 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
 	git -C r1 verify-pack -v ../all.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >expected &&
 
 	git -C r1 verify-pack -v ../filter.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -123,8 +123,8 @@ test_expect_success 'setup r2' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -134,7 +134,7 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r2 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -161,8 +161,8 @@ test_expect_success 'verify blob:limit=1000' '
 '
 
 test_expect_success 'verify blob:limit=1001' '
-	git -C r2 ls-files -s large.1000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1001 >filter.pack <<-EOF &&
@@ -172,15 +172,15 @@ test_expect_success 'verify blob:limit=1001' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=10001' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=10001 >filter.pack <<-EOF &&
@@ -190,15 +190,15 @@ test_expect_success 'verify blob:limit=10001' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1k' '
-	git -C r2 ls-files -s large.1000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
@@ -208,15 +208,15 @@ test_expect_success 'verify blob:limit=1k' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify explicitly specifying oversized blob in input' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	echo HEAD >objects &&
@@ -226,15 +226,15 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1m' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1m >filter.pack <<-EOF &&
@@ -244,7 +244,7 @@ test_expect_success 'verify blob:limit=1m' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -253,12 +253,12 @@ test_expect_success 'verify blob:limit=1m' '
 test_expect_success 'verify normal and blob:limit packfiles have same commits/trees' '
 	git -C r2 verify-pack -v ../all.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >expected &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -289,9 +289,8 @@ test_expect_success 'setup r3' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r3 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -301,7 +300,7 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r3 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -342,9 +341,8 @@ test_expect_success 'setup r4' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r4 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -354,19 +352,19 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r4 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:oid=OID' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r4 ls-files -s pattern >staged &&
-	oid=$(awk -f print_2.awk staged) &&
+	oid=$(test_parse_ls_files_stage_oids <staged) &&
 	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
 	HEAD
 	EOF
@@ -374,15 +372,15 @@ test_expect_success 'verify sparse:oid=OID' '
 
 	git -C r4 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:oid=oid-ish' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=main:pattern >filter.pack <<-EOF &&
@@ -392,7 +390,7 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 
 	git -C r4 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -402,9 +400,8 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 # This models previously omitted objects that we did not receive.
 
 test_expect_success 'setup r1 - delete loose blobs' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	for id in `cat expected | sed "s|..|&/|"`
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 93c03380d44..50970d3e03e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1782,6 +1782,16 @@ test_oid_to_path () {
 	echo "${1%$basename}/$basename"
 }
 
+# Parse oids from git ls-files --staged output
+test_parse_ls_files_stage_oids () {
+	awk '{print $2}' -
+}
+
+# Parse oids from git ls-tree output
+test_parse_ls_tree_oids () {
+	awk '{print $3}' -
+}
+
 # Choose a port number based on the test script's number and store it in
 # the given variable name, unless that variable already contains a number.
 test_set_port () {
-- 
2.34.1.78.g86e39b8f8d

