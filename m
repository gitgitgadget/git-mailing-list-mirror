Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77225C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiKCRHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKCRHO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B34D2644
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ud5so7061245ejc.4
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3k34f+IH+oIJ/EqVBg4YU92rleAY8UFAkliPg+cZO8=;
        b=Qromb0IodBkmix9ZY6JW6t09OAWg9U+hJ3dvsSg1CZe3+iH0EYJX8Ttx/KmONjcTus
         cWPM+DD4cUaqGGDd+SQH5D/Dg3N15rFWs666q6wBZM6ZeMIZc8dd4AS7mhR0qZDA+a2T
         wA+aO260fkzAeYyRgUS8XYH5PGgU6I97kEnPFSk9htfwOgeYfe08nJxguMWgMxLziW9A
         ZqVXh5ZoK4a9VFBWUs7pNag3VhaXlYrEHHfjiwxTxX6k689lnJGgYGkdQWKQ1xKUGfvc
         xAi4D87R+xtbXWC1CadsUmXoJsrw8FeSDTUfFFfYysTOX4inXbABFXgqV8X0Y0+SPMx9
         c3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3k34f+IH+oIJ/EqVBg4YU92rleAY8UFAkliPg+cZO8=;
        b=F17a6sDpUT3dO1TCH5WwLlR4iPLr7d0evQ+sYTGKj/5vwBSADfxiKabiKrVyKoMep2
         s8/OT68Lhi0SQ2HsAQtffdj2UyuEHxKS8U4SLB/X4mOV4GDnHvlj63wWD0eROwUn4sG3
         nVefSEP0CpJhF+oYqdCSrqqp5+hbAknu5LAaO+1qHaQXajqlrmIUV/l61jHPRvfQ63Pq
         QRdx19EMi/y1K6/i2c4PQ97p0GYWPBcRCq3Z9ZmZoMLNd8f+39abJZCPSNOvR7VJ3ker
         P5FIY6+uCP67PAv+oDUmCj3wBqXM3KoIW4BVR7B/SQw1Qbr/7p6+2/9581Ag75zKkreq
         wJ+g==
X-Gm-Message-State: ACrzQf3AX+D8GCmBwFRtwd0F/RMEDkFSyQm6PPDy7MUlofHw+wWguzoE
        Bfo4QDV9oZAJr0wmctyoG7tIu9q9e+7lNw==
X-Google-Smtp-Source: AMsMyM6sEthYeAvF+Ay5t5OkhaHwhcXNZ+ONRZO6H0Ese/nylp+z3Mor1qR6yjHtWW6Fg+C8pVa06g==
X-Received: by 2002:a17:906:3197:b0:73d:5e1a:44ac with SMTP id 23-20020a170906319700b0073d5e1a44acmr30073934ejy.512.1667495187098;
        Thu, 03 Nov 2022 10:06:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/17] revision API: call graph_clear() in release_revisions()
Date:   Thu,  3 Nov 2022 18:06:07 +0100
Message-Id: <patch-08.17-2944aaa3ddc-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call graph_clear() in release_revisions(), this will free memory
allocated by e.g. this command, which will now run without memory
leaks:

	git -P log -1 --graph --no-graph --graph

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c             | 1 +
 t/t4052-stat-output.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/revision.c b/revision.c
index 0760e78936e..650dd17599a 100644
--- a/revision.c
+++ b/revision.c
@@ -3020,6 +3020,7 @@ void release_revisions(struct rev_info *revs)
 	date_mode_release(&revs->date_mode);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
+	graph_clear(revs->graph);
 	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index b5c281edaa7..3ee27e277dc 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -8,6 +8,7 @@ test_description='test --stat output of various commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-- 
2.38.0.1451.g86b35f4140a

