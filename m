Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6F2C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiKCRH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiKCRHP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5035C2633
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q9so7171583ejd.0
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6g9bUgDaES50yDgFrRi9UtbjtOEIZ0zG9vBOTCO/EGI=;
        b=XWGB3Pq094ILypNejdeTRj2pAPl/tCMoiEvD7vo0FK3nzab/HZ2kTl1/PG3V8jF4WL
         uZkH+plnVTRW5lf7+e1GTQcF4dJFC0saovg3NmI+yPG/bb+cYRCHZTmSaVh+68POHrV7
         VDs7xdelooIHvkb+anHfkVTeTghn1swgqUwdk8pMBARGLgE7cfW6dHBF3HCgLfYh8oDr
         tjgSQ8qwGfJl8V8tkqJ4Jse3L5MPzl4G5H+bYvmWzlBkK+d48neP836SVV2ox3QT/aKn
         1Q1dm88VaKlkaHL49wvqXbsfb9Hyrsy6GUZNZrsnsjymBRZrw9cV/Np3CMiQDhTbg3s8
         KdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6g9bUgDaES50yDgFrRi9UtbjtOEIZ0zG9vBOTCO/EGI=;
        b=DIOkM+DIj00O6vr/bcwpAL1Q4Wyo8eDMKA+V/A0p1wc6xL/FRNyJcz+X7uZ3Hnphza
         6i7s2LeRud7dEnG9H3QDA11E3CgJc/noGnVHBWgYS1mPyy4z0UXWFat2kiHC/JP6zyJk
         MsW4Ll7tTh0P6SK+2Yek5u6KyMQ52+jjXJVHrxPfKhXhCIHUvHD2aVYC1mIhP4FFcEP/
         ffSjsf9/8LYHhbDKnL9ewklRHvjLR63If3uehgnQ/fCP/OgpPyMPFLOSpqX1d15XJb1B
         PfwjJPYecD/iRdkGLdf0ts7Ag805iEtyDoiPFE7n9ckv/ARdZQp6aX9XkqgdkKvrOapa
         Hnyg==
X-Gm-Message-State: ACrzQf3hVKe0ItfsDl/UxVgtNGpBWN8/GFwX27wGhD6NRwnYwFDYKEd+
        eglmSAbaFQ3UncQsPOvFjTh5swGXXJJHYQ==
X-Google-Smtp-Source: AMsMyM7INRRUdKghE48zf67BS41Fmsiq1Dw1EQqN0mlK9zb+Nl+Ulsv/HtLwGMXUMoaGjSjBx93+QQ==
X-Received: by 2002:a17:907:608d:b0:7a2:b93e:a765 with SMTP id ht13-20020a170907608d00b007a2b93ea765mr30621551ejc.273.1667495191593;
        Thu, 03 Nov 2022 10:06:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:31 -0700 (PDT)
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
Subject: [PATCH 13/17] rebase: don't leak on "--abort"
Date:   Thu,  3 Nov 2022 18:06:12 +0100
Message-Id: <patch-13.17-fda9914b558-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in the recent 6159e7add49 (rebase --abort: improve reflog
message, 2022-10-12). Before that commit we'd strbuf_release() the
reflog message we were formatting, but when that code was refactored
to use "ropts.head_msg" the strbuf_release() was omitted.

Ideally the three users of "ropts" in cmd_rebase() should use
different "ropts" variables, in practice they're completely separate,
as this and the other user in the "switch" statement will "goto
cleanup", which won't touch "ropts".

The third caller after the "switch" is then unreachable if we take
these two branches, so all of them are getting a "{ 0 }" init'd
"ropts".

So it's OK that we're leaving a stale pointer in "ropts.head_msg",
cleaning it up was our responsibility, and it won't be used again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c          | 1 +
 t/t7517-per-repo-email.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 64aed11c85d..8a8b5e34786 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1320,6 +1320,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (reset_head(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head->object.oid));
+		strbuf_release(&head_msg);
 		remove_branch_state(the_repository, 0);
 		ret = finish_rebase(&options);
 		goto cleanup;
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index 163ae804685..efc6496e2b2 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -9,6 +9,7 @@ test_description='per-repo forced setting of email address'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a likely user.useConfigOnly use case' '
-- 
2.38.0.1451.g86b35f4140a

