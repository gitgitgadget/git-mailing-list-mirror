Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B446FC433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 11:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKELyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 07:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKELya (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 07:54:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB421D305
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 04:54:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so19272633ejb.13
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 04:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4bR8EszQxaoaHFkANATPxprjWEUMz3GHwIrWG6rwoA=;
        b=f1rL/jYdIKxRIKIhXt+Am65Ey25ycEnkNaZEzJkg0+/fG1tbaCEjfEznzs5EJvjqjB
         Y7MOQLRzaG7cjQB9XuDulUxJbEw9aXoG1lFrChkPm+/WNMYhqT22qPkE4BpkKOCFXGQ3
         c0sy9crE8LKFUHETO1tb0pJ/6WPvku5wlEh+NG4sqHV4HhAhGNNJqBby7LtCP1qf+in8
         fMoaGY1o54eI2lQQxaa1B3zG/PcbkO6stM/rzyeBEDrSUsquy3cpH9oYbbn0U79CdA56
         XowwlBGDlB6cVfXs4LjbK3QU1M5xoPdKoTWV3XqlQO8sqLYvkX8FNSCXZOZJXRPgliTi
         xxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4bR8EszQxaoaHFkANATPxprjWEUMz3GHwIrWG6rwoA=;
        b=5Tqgdn92dma8bClqrpInzLrRdXPhNPw/7+mlPoVKiUBWYFq7aE2oUKXwPyZh+4Jmst
         3E7jlZ3jE591wjAqfLi/PrsUGjUgTjif/rymAWxs0sIg1yem+YmGDxb5NHRKSb2Flgup
         cv1o3r+6IULTeo9G1WYMsS5YX/GH8vtR58PQcNYGrpQHFmePRs49xkMpG0cLEnYxP4KL
         RqTM+RA/44TTt23aZeu7KdWxnnI9mHXO713k0of6u6j6CZetDUWPjd/5T2C+OGfeYkbr
         gYQn8STalZ+Wqu94tOCdm2Cay3thqyW6/FQbTPnFhxMIkbmP8F9jmDx+ly4fpo7qcy9a
         tZsA==
X-Gm-Message-State: ANoB5pngo9sQ9BYUbqGi4bfGtyKKRO7lyzqyMvT1obdrVL1+JG7EYXyD
        FyA+7SMoe4bAPeLYYd49oLXYu0n+BvGIlw==
X-Google-Smtp-Source: AA0mqf7gCwvLrK44vcJVMUI8hSnRpRkcHHY520qfaiNlbEQ0zrqcyxvelQBQhDnoN17QKic/t47Vwg==
X-Received: by 2002:a17:906:8d0f:b0:7ae:5471:37a2 with SMTP id rv15-20020a1709068d0f00b007ae547137a2mr1012966ejc.317.1667649268136;
        Sat, 05 Nov 2022 04:54:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id kw6-20020a170907770600b00781e7d364ebsm829295ejc.144.2022.11.05.04.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 04:54:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] t7610: fix flaky timeout issue, don't clone from example.com
Date:   Sat,  5 Nov 2022 12:54:21 +0100
Message-Id: <patch-1.1-83eca7b5a7c-20221105T115420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When t7610-mergetool.sh runs without failures the git://example.com
submodule URLs will never be used. That's because we "git submodule
add" it, but then manually populate them so that subsequent "git
submodule update -N" won't attempt to clone it, only update it without
fetching.

But if we fail in an earlier test it'll have the knock-on effect of
having later tests hang on that "git submodule update -N" as we
attempt to clone this repository from example.com.

This can be reproduced on "master" by running the test with
SANITIZE=leak without "--immediate". With
"GIT_TEST_PASSING_SANITIZE_LEAK=true" (which the linux-leaks job uses)
we'll skip the test entirely. So we'll only run into this when running
it manually, or with the "GIT_TEST_PASSING_SANITIZE_LEAK=check" mode.

That's not because the failure has anything to do with leak detection
per-se. It just so happens that we have a leak that'll fail before
we've managed to fully set these up, and therefore "git submodule
update -N" ends up spawning "git clone".

Let's instead continue lying about the origin of this submodule by
providing a URL for it that doesn't work, but now one that *really*
doesn't work: /dev/null. If the test is passing we won't ever use
this, and if we have knock-on failures we'll fail early, instead of
waiting for a timeout.

The behavior of "-N" here might be surprising to some, since it's
explained as "[if you use -N we] don’t fetch new objects from the
remote site". But (perhaps counter-intuitively) it's only talking
about if it needs to do so via "git fetch". In this case we'll end up
spawning a "git clone", as we have no submodule set up.

See ff7f089ed10 (mergetool: Teach about submodules, 2011-04-13) for
the commit that implemented these "example.com" tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7610-mergetool.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 8cc64729adb..b1ba0d9a088 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -33,7 +33,7 @@ test_expect_success 'setup' '
 		git add foo &&
 		git commit -m "Add foo"
 	) &&
-	git submodule add git://example.com/submod submod &&
+	git submodule add /dev/null submod &&
 	git add file1 "spaced name" file1[1-4] subdir/file3 .gitmodules submod &&
 	git commit -m "add initial versions" &&
 
@@ -614,7 +614,7 @@ test_expect_success 'submodule in subdirectory' '
 		)
 	) &&
 	test_when_finished "rm -rf subdir/subdir_module" &&
-	git submodule add git://example.com/subsubmodule subdir/subdir_module &&
+	git submodule add /dev/null subdir/subdir_module &&
 	git add subdir/subdir_module &&
 	git commit -m "add submodule in subdirectory" &&
 
-- 
2.38.0.1452.g710f45c7951

