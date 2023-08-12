Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FADC001B0
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 00:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjHLAAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 20:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbjHLAAi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 20:00:38 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED831719
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:37 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bd3317144fso829795a34.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691798436; x=1692403236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZxoPxNblmOwSetYVOqsVtOz24b+OzDiRmBwJUcA1PU=;
        b=pO5bMR+THwZpj240bKMqdO5Q0INaC7cvNbWS9GVCFeI1FPogakyiVv/ExZ/s6DHzfB
         GCxABbxxhKwlCuQW1GZ4Bi8YaNgxs5Eq8oTtbjOGaavMjIiP6D1XpWUAROLG4Rz4sia4
         OQCAupOyc5Q0i70BD2wicVM3sEY87Hk/klMhXtdDuIxPFk9MtQQAkBT1GgzONRuDgA/2
         AXACwpJUVh5jNQ7575zaaGP49eXgEvkkF8ExMoyz3VfUqO0tBDl+R35OPCiWXa2abc/H
         nxeJgYsoPEDLb7/QosUVKJUfe+9+90NX0WPf1jg4OvLw/JJx2ERUgwbgvbEzQMBy/Cmh
         4XyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691798436; x=1692403236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZxoPxNblmOwSetYVOqsVtOz24b+OzDiRmBwJUcA1PU=;
        b=ZClsQc8oVObgh9996pDRp1iJ6Elg/pVaV4E7LxoaW4k9PPjJWqO9MiyOty+mCUiZ0W
         TK2909NWfRHmfTaL5aw373GQx1/qSrzDf6mXZRJm8VNLkoClp4XuKuZxdT8oMy5Aa7xw
         WBnTssvw8bHafDAtp9kqPUmzHzmH+KN9OQ+NrDVjrgVijAteHZkhH5VRGqQ3tkc6pT4N
         HOhXJEy0LHrXkTpykwnVdVg5xNjLR+YHpGlCUfm8HJvNyzVWFZFQ2uWuCHR0sa+CdT0W
         6ZYSSpH0Ogd9KPy92f0t+bKl5/we1e/L/HglfvyEYiDIcy8CvDmhDEouJEB08ghbGnir
         8hKQ==
X-Gm-Message-State: AOJu0YzM5Q6KbHB5rtIoGdrU9wmA9pmpH9yTiQx431vioT9cwTDesatU
        WasHgaHbQZKvF+cJ6/zAFSmn6elmU5cPIg==
X-Google-Smtp-Source: AGHT+IFoq5RhV56m3wF+fRThKHI8u+LQF7CCm3rLbyg5lOO9u8Ah4a+nYqOGPtFDwmIv816k+lOXyQ==
X-Received: by 2002:a05:6830:1e4e:b0:6b9:b67e:ea8a with SMTP id e14-20020a0568301e4e00b006b9b67eea8amr3233246otj.14.1691798436321;
        Fri, 11 Aug 2023 17:00:36 -0700 (PDT)
Received: from christian-Precision-5550.. ([129.126.215.52])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709028f8500b001b8a7e1b116sm4478308plo.191.2023.08.11.17.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:00:35 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 1/8] pack-objects: allow `--filter` without `--stdout`
Date:   Sat, 12 Aug 2023 02:00:04 +0200
Message-ID: <20230812000011.1227371-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc1.8.ga52e3a71db
In-Reply-To: <20230812000011.1227371-1-christian.couder@gmail.com>
References: <20230808082608.582319-1-christian.couder@gmail.com>
 <20230812000011.1227371-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
taught `git pack-objects` to use `--filter`, but required the use of
`--stdout` since a partial clone mechanism was not yet in place to
handle missing objects. Since then, changes like 9e27beaa23
(promisor-remote: implement promisor_remote_get_direct(), 2019-06-25)
and others added support to dynamically fetch objects that were missing.

Even without a promisor remote, filtering out objects can also be useful
if we can put the filtered out objects in a separate pack, and in this
case it also makes sense for pack-objects to write the packfile directly
to an actual file rather than on stdout.

Remove the `--stdout` requirement when using `--filter`, so that in a
follow-up commit, repack can pass `--filter` to pack-objects to omit
certain objects from the resulting packfile.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-pack-objects.txt     | 4 ++--
 builtin/pack-objects.c                 | 8 ++------
 t/t5317-pack-objects-filter-objects.sh | 8 ++++++++
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index a9995a932c..583270a85f 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -298,8 +298,8 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	nevertheless.
 
 --filter=<filter-spec>::
-	Requires `--stdout`.  Omits certain objects (usually blobs) from
-	the resulting packfile.  See linkgit:git-rev-list[1] for valid
+	Omits certain objects (usually blobs) from the resulting
+	packfile.  See linkgit:git-rev-list[1] for valid
 	`<filter-spec>` forms.
 
 --no-filter::
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d2a162d528..000ebec7ab 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4400,12 +4400,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (filter_options.choice) {
-		if (!pack_to_stdout)
-			die(_("cannot use --filter without --stdout"));
-		if (stdin_packs)
-			die(_("cannot use --filter with --stdin-packs"));
-	}
+	if (stdin_packs && filter_options.choice)
+		die(_("cannot use --filter with --stdin-packs"));
 
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index b26d476c64..2ff3eef9a3 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -53,6 +53,14 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 	! grep blob verify_result
 '
 
+test_expect_success 'verify blob:none packfile without --stdout' '
+	git -C r1 pack-objects --revs --filter=blob:none mypackname >packhash <<-EOF &&
+	HEAD
+	EOF
+	git -C r1 verify-pack -v "mypackname-$(cat packhash).pack" >verify_result &&
+	! grep blob verify_result
+'
+
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
 	git -C r1 verify-pack -v ../all.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-- 
2.42.0.rc1.8.ga52e3a71db

