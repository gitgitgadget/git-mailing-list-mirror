Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA212C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925BA60F02
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbhHEKiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbhHEKhx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 06:37:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A594BC061798
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 03:37:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c9so5856263wri.8
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=piozFKr93/kXTBzcc9Aljkv4Wd/3p/FY6kbHHwm1ZuI=;
        b=O6Q8GjHyIUzXxGn44Y1vWNBh3pPj/DCBya5MjQ3JXP4SHiOuHxO9VqfweNGdbv76lx
         w/jnOnftW4pvglDcQTcb/5nas3nbj5X9s6FNh+tFJCWgS41wSDes89LYP8R8yTuCUUWB
         uNd62kSeIvb2oPSWAxPU76PnvZP7U5ASGHAJ76bYhNnh5E6UnJ+bc+Uk5CUNmB2NSDhe
         3W4rU576hMvgHeiORqcbGIeG7R8Caqk9/KdtxJRBw4Lcbcgwq++8z8us8nP+JCH/bKfm
         RtZ5OBChNB0i4itsFfkPK/0+D7eMsg/f7nCfVE5PBnmktVhqPBCHBziDR3FIc3KIqr8b
         xVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=piozFKr93/kXTBzcc9Aljkv4Wd/3p/FY6kbHHwm1ZuI=;
        b=Yfbk6BNjQRKkXPCOCBqWnRY4zSW8GFMpXMXZiAfi7DHTifcWK3JpCL4o3CyILkT1v8
         gX15+C5mBTSqGuUgydKk7urMrRym7CBuvuMEfsGcV/Ty8InW3L9jnhBUkDYC6UeOtJ5Y
         DlZFeAYXt/uoG1/TC74irtku9B075GlJ+p5k/sV7MxN150qunselUpucDOpFdOqM8FPL
         IvSc559+erlnN3JilsZRIWJU69yO6MHr9yrccOmX4WEiOvv+sgOfKO/TZvgj4kN5edo+
         Y9CbuqfyBCo+ehGI9IoIVuUw+UhIgi0EHs2eIqj8BpRCJL2Jo6LJ5APK3UuT6uSRlxZM
         NXpg==
X-Gm-Message-State: AOAM531Ulwzmek+vnmubzTJSzaTiFU51MsAuHFC9PvajgyeyU29EXRdG
        a+9sUYCwcGMVZj67jZN9a0BJW7AP8g5hVQ==
X-Google-Smtp-Source: ABdhPJzklnM9ej35/YdNLYPLhNNNtuIJbfL5Bt262NBck3u+9xD6/VF5qtWGDZXVG4wk3mwls+ecxw==
X-Received: by 2002:a5d:420c:: with SMTP id n12mr4480001wrq.58.1628159857059;
        Thu, 05 Aug 2021 03:37:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm5106152wme.6.2021.08.05.03.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:37:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/9] test-lib tests: assert no copy/pasted mock test code
Date:   Thu,  5 Aug 2021 12:37:25 +0200
Message-Id: <patch-v3-6.9-bc79b29f3c-20210805T103237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com> <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit we got rid of a bunch of copy/pasted test code
from t0000-basic.sh in favor of re-using earlier already set up tests.

Since copy/pasting the tests is likely to be something done by mistake
in the future, let's add an assertion that detects whether this has
happened.

Now that we don't provide a unique test_description="" to these tests
we can rely on the content written out being the same in this
case. Let's use the object store to hash it, and attempt to create a
"blob-<CONTENT_OID>" tag. If another test has already written out the
same content we'll fail, and the tag envelope will provide an error
message pointing us in the right direction..

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index cdbc2d9332..6857afdaa5 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -1,3 +1,34 @@
+_assert_unique_sub_test () {
+	name=$1 &&
+
+	# Alert about the copy/paste programming
+	hash=$(git hash-object -w "$name") &&
+	cat >tag.sig <<-EOF &&
+	object $hash
+	type blob
+	tag $hash
+	tagger . <> 0 +0000
+
+	duplicate script detected!
+
+	This test script was already written as:
+
+	$name
+
+	You can just re-use its test code with your own
+	run_sub_test_lib_test*()
+	EOF
+
+	tag=$(git mktag <tag.sig) &&
+	if ! git update-ref refs/tags/blob-$hash $tag $(test_oid zero) 2>/dev/null
+	then
+		msg=$(git for-each-ref refs/tags/blob-$hash \
+			--format='%(contents)' refs/tags/blob-$hash)
+		error "on write of $name: $msg"
+		return 1
+	fi
+}
+
 write_sub_test_lib_test () {
 	name="$1" # stdin is the body of the test code
 	mkdir "$name" &&
@@ -7,7 +38,8 @@ write_sub_test_lib_test () {
 	# Point to the t/test-lib.sh, which isn't in ../ as usual
 	. "\$TEST_DIRECTORY"/test-lib.sh
 	EOF
-	cat >>"$name/$name.sh"
+	cat >>"$name/$name.sh" &&
+	_assert_unique_sub_test "$name/$name.sh"
 }
 
 _run_sub_test_lib_test_common () {
-- 
2.33.0.rc0.635.g0ab9d6d3b5a

