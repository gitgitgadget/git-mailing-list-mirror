Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDFBC433FE
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344745AbiCWUeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344516AbiCWUeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8368C7F6
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h4so3750648wrc.13
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=465M5mMLgRJsEToe9qXLna6izXO5xeKVE+EBS4WmRHU=;
        b=VkMNZWC7/FHZgmkE4s0LGXs1O3nbKDQH1tFq/i6arEOcxBVV7bkG1TG/qIYUGlOWqa
         4QMJYBj4Se4Yn1WAw2QUPCVELN4tuBeR1nMjHuBekcW40EqUWqxB6F7K1/vW5gmzZcdW
         zjWtJb+SEWZl1MIru/bR4iRKTfwWcvlCiY++p9822/s+K+7Py3dIk31AicvL+O6yTcQ8
         5FsqPZYLzakbxkhpg9WbQGKnV9AH4jn5iXIP6lzxcZfjqHB0eyt8jh1cIWalBoo4pESI
         zY3Aq4RkjlmMKGquUrtt8avqpqXohd3cVGeG0/JDwDhe9C+nslMAP1+q1/Yn15Gn/FlT
         qIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=465M5mMLgRJsEToe9qXLna6izXO5xeKVE+EBS4WmRHU=;
        b=H8tfKgK7xFrFceKQiUmspX1cx+m45hQ9yeAyo3BzEdd8BsOXEK9sViRORBxpzk4SoZ
         z5VCMsHMchkir+xkrMrXhKr3NGY+CV8xKJ9dkTnIWEZ0dZ7NM/lyVOIQfa88HHcKDUq5
         1x3Ak4a4A0COurVa7P+kGax+u+ytkmhDbFUyN2afuFznfg0Q98U7SKSoYdBKWfYVrWBU
         gjAkiMETWuxdBeTIwFUZT0j7ExuspjGdp6SA6+5F8Lb3XN07OELUuGH6IZOx6WpS2UbY
         DDHEYqUhB+oq4JLRL4wy32oA1SGzoFPeKcZqNjqi3p/FeEViHy/cGPZg7yBlNJFC1u3s
         XCHA==
X-Gm-Message-State: AOAM531V5M6ukwbt4Xaeg8IrQlaAE3fBb2bn4odW02kTaVJkxzO6hpJ5
        pzOeGFvDG4B1+kWR044FDV1gEIkEvMgFdA==
X-Google-Smtp-Source: ABdhPJyvSbiDmIQBcD6k4sQhZyhGvlsbiMkdXPqvfnSFNWEGrcIAwmaVnNpe4UwDRw3PYx1NNouSpQ==
X-Received: by 2002:adf:e642:0:b0:203:d992:b8a3 with SMTP id b2-20020adfe642000000b00203d992b8a3mr1520846wrn.17.1648067558087;
        Wed, 23 Mar 2022 13:32:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/27] revisions API users: use release_revisions() with UNLEAK()
Date:   Wed, 23 Mar 2022 21:32:03 +0100
Message-Id: <patch-v2-13.27-8717e6e8471-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a release_revisions() with those "struct rev_list" users which
already "UNLEAK" the struct. It may seem odd to simultaneously attempt
to free() memory, but also to explicitly ignore whether we have memory
leaks in the same.

As explained in preceding commits this is being done to use the
built-in commands as a guinea pig for whether the release_revisions()
function works as expected, we'd like to test e.g. whether we segfault
as we change it. In subsequent commits we'll then remove these
UNLEAK() as the function is made to free the memory that caused us to
add them in the first place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-index.c | 4 +++-
 builtin/diff.c       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 5fd23ab5b6c..3a83183c312 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -71,5 +71,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	}
 	result = run_diff_index(&rev, option);
 	UNLEAK(rev);
-	return diff_result_code(&rev.diffopt, result);
+	result = diff_result_code(&rev.diffopt, result);
+	release_revisions(&rev);
+	return result;
 }
diff --git a/builtin/diff.c b/builtin/diff.c
index bb7fafca618..dd48336da56 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -595,6 +595,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
 	UNLEAK(rev);
+	release_revisions(&rev);
 	UNLEAK(ent);
 	UNLEAK(blob);
 	return result;
-- 
2.35.1.1452.ga7cfc89151f

