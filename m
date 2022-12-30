Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F16CC4167B
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 01:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiL3Bw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 20:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiL3Bw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 20:52:26 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FC316490
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 17:52:25 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso14399724wmb.0
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 17:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzsweyhcOdCMsl0xki3d57EDrNnQfpLVa2yQlzZDMVo=;
        b=Px7IkulJWnae17Q+Xl8TnuyGSt2fMfpI4v9XviT2WEJ+Q6aVIs4d5PtOiKM7VlmSyq
         tn+MKC3oDrk5oZn/S5K6E4Cq/9HcBoJxayG1Y7BPfF0Q4WHFkq6eqJ+ONFxVrd1hW4XX
         1DK3KRsjuYbAZ5MjmQ0CyVbye930q4ytKK4PPasshDIEQgnnK1Re1YUuTi1QgFlHfJAW
         Pvqs1BJUOT1+zMszGtPifuht6xpbDIpo4GOWXEjc7oWQtRnVjK597SWU+inO2wpBPJOC
         RxTvw2J46rKoUONhLT3mmwJzQZskg6csvxF/By58Sw3qz10/gZ53iD/KjlPfpbRScl/x
         FVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzsweyhcOdCMsl0xki3d57EDrNnQfpLVa2yQlzZDMVo=;
        b=PlDrVLPuaqeYuC0aq+ZeCLic4o8vt2deK+NB7Cq0Qa25SiSYqJmg8UuuL7p1xuImNK
         G32WR8sHRT6bl3CqnN9fMMFlnZC9HkwPmLPDyX783xRL51pjhGoqINWUtteObXDdOSq3
         39Y2wi8bO2nB8if2ONbpUZqf0J3WSK2rPoNm+RxV2u4LWr2TldvEFyKiTUf3wH36EAIw
         0jmyNceULPx0CzgP9u8T983MyeT0FPLe79Z4lFVjBRU6hxO77RTQPefuSlfg4PtYw5w9
         lT6bbImZNzvTPQzfn/v3WUKsKM0fSWn62OCrvKvLNs5NxJDXKFTmHKaNO7MMJksoAiay
         SC5Q==
X-Gm-Message-State: AFqh2kpsmvYYYF3f8+Wl2q+AVRa2zeCO6KYEKR4HRaCM8RvnhtHcZT6N
        F69A2VJL0yY0MiEPaXZtolAkpC/SFD4rDg==
X-Google-Smtp-Source: AMrXdXs5fvnGC5HaXFGhtteaBbnetaRWjb/EJ91O1gx6XP0SdR/5TEOU6aPtuSf0mCEAx2WN6jGNKg==
X-Received: by 2002:a05:600c:218f:b0:3d1:fbf9:3bd4 with SMTP id e15-20020a05600c218f00b003d1fbf93bd4mr21806297wme.10.1672365143656;
        Thu, 29 Dec 2022 17:52:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm26649298wmb.38.2022.12.29.17.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 17:52:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] tag: don't emit potentially incorrect "object is a X, not a Y"
Date:   Fri, 30 Dec 2022 02:52:16 +0100
Message-Id: <patch-v2-3.3-2493988c41c-20221230T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the preceding commit we weren't handling cases where we
see a reference to a bad "type" in a "tag", but then end up not fully
parsing the object.

In those cases let's only claim that we have a bad tag pointer, but
emit "is a %s, not a %s".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6102-rev-list-unexpected-objects.sh | 4 ++--
 tag.c                                  | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 590e2523d0c..98e36e73698 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -231,7 +231,7 @@ test_expect_success !SANITIZE_LEAK 'traverse unexpected non-tag tag (tree seen t
 '
 
 
-test_expect_failure !SANITIZE_LEAK 'traverse unexpected objects with for-each-ref' '
+test_expect_success !SANITIZE_LEAK 'traverse unexpected objects with for-each-ref' '
 	cat >expect <<-EOF &&
 	error: bad tag pointer to $tree in $tag_tag_tree
 	fatal: parse_object_buffer failed on $tag_tag_tree for refs/tags/tag_tag_tree
@@ -251,7 +251,7 @@ test_expect_success 'setup: unexpected objects with fsck' '
 
 while read oid type
 do
-	test_expect_failure "fsck knows unexpected object $oid is $type" '
+	test_expect_success "fsck knows unexpected object $oid is $type" '
 		git cat-file -t $oid >expect &&
 		echo $type >actual &&
 		test_cmp expect actual
diff --git a/tag.c b/tag.c
index 19453c2edbf..ad92cf89209 100644
--- a/tag.c
+++ b/tag.c
@@ -193,8 +193,9 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 	}
 
 	if (!item->tagged || strcmp(type_name(item->tagged->type), type)) {
-		error(_("object %s is a %s, not a %s"), oid_to_hex(&oid),
-		      type_name(item->tagged->type), type);
+		if (item->tagged && item->tagged->parsed)
+			error(_("object %s is a %s, not a %s"), oid_to_hex(&oid),
+			      type_name(item->tagged->type), type);
 		return error("bad tag pointer to %s in %s",
 			     oid_to_hex(&oid),
 			     oid_to_hex(&item->object.oid));
-- 
2.39.0.1153.g589e4efe9dc

