Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0BC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243994AbiDBKvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiDBKvj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E3B1403E6
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qh7so695944ejb.11
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/ixYaUEFShIUcTGyng3YBJHseEtjibBuuiD9wmL/bw=;
        b=IsDe7tq+WaXCa2EgoKS0z7XpgGtS+uvkz2JK3SNo7pWaS8OdQST4Inzk5qKrs++bNk
         XFCcyIYdcBINRTWNjevh4sEqtjWEqLdqocQIWB+SZHRq6fDo0/ps/BcYWzJeyJpOC+td
         sKnerGDKFatbj1Dsk2H7p0aWuvXbE8nRQ6g/nDsnAdVsPVaySn/DRyJQdOwEIKQnbrzk
         PQlXO6f4xTDqxroe618Q1ZxFuYaNP4kw7eo352lFYeFhJ8wDF30TzJcDzlMFnZ285Zwx
         4u0BppVzr56xHJv89kGJGld3IVQdT4s6blBNqpo5qBfwb3WBvfoxv2LVVREINrDwTZ//
         N6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/ixYaUEFShIUcTGyng3YBJHseEtjibBuuiD9wmL/bw=;
        b=canYJ57GuTQXAlrndJC3o6hSg4SXtwJDZvid3qzy54fR6Wo9lDkLi3Izm/ZhjbkDYX
         GpUYQZY8gJmEqhK5NKpwqpTurZLsNx8H63sr2rFj+6y41va8ZRd7uBx56/rAXZ2JRaLP
         UJp+GpLUmYt6D52RWNt8eCbGAiHSWMp2lhKx/lbgmfYMlNH5YgWx8Wy47aZPV3KmBsyt
         3KU8Nw6/cQcpDWrOpWtYQu3qxqZHo+yDxBSSpBMXTUbSVijP3SiOdVgy6GWi900bev8a
         gSyVBIoXzSiXl8ZEczVAiEYQq4VhCgF7CRmJsKJCN5TkIdoG4/ZiWQfCFiv7vGBgYIrB
         uWNw==
X-Gm-Message-State: AOAM532s2LZSa6hMfOFzhtSJu3Gq2RR10PteGXio24oq2jz03m+tmGBh
        3bAib2pUtCcPw+Lcf6tDpqNsBV+pHvejiQ==
X-Google-Smtp-Source: ABdhPJykLpGQhN8Whw86sdnb7KZfUV0DdCzPWQOmfwHxYtOfGNhm/BPakpqmRPZG0r8jrbECcZE6iw==
X-Received: by 2002:a17:907:980d:b0:6d6:f910:513a with SMTP id ji13-20020a170907980d00b006d6f910513amr3157072ejc.643.1648896586111;
        Sat, 02 Apr 2022 03:49:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/27] t/helper/test-fast-rebase.c: don't leak "struct strbuf"
Date:   Sat,  2 Apr 2022 12:49:15 +0200
Message-Id: <patch-v5-01.27-e20f951a64c-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since f9500261e0a (fast-rebase:
write conflict state to working tree, index, and HEAD, 2021-05-20)
changed this code to move these strbuf_release() into an if/else
block.

We'll also add to "reflog_msg" in the "else" arm of the "if" block
being modified here, and we'll append to "branch_msg" in both
cases. But after f9500261e0a only the "if" block would free these two
"struct strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-fast-rebase.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index fc2d4609043..993b90eaedd 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -201,8 +201,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 		}
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
-		strbuf_release(&reflog_msg);
-		strbuf_release(&branch_name);
 
 		prime_cache_tree(the_repository, the_repository->index,
 				 result.tree);
@@ -221,5 +219,8 @@ int cmd__fast_rebase(int argc, const char **argv)
 	if (write_locked_index(&the_index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write %s"), get_index_file());
+
+	strbuf_release(&reflog_msg);
+	strbuf_release(&branch_name);
 	return (result.clean == 0);
 }
-- 
2.35.1.1585.gd85f8dcb745

