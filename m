Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5803C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344698AbiCWUeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344660AbiCWUd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:33:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224A98C7F9
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u3so3797085wrg.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S57og1HEB75m0DiN3Bot4sL06k28rGesx+9zl7DDtGQ=;
        b=LHzXkmfIWmXLz6zpuGdnAmVBOLH7IAnTlXDJjQJXX+Sx9lAE69FlpI0OIXL4JwkxpN
         dzIgBJ76FJJniBgbd63FmlNb1ENiISoQiBRU+NYkhOlUVpV5ZBbp7448leQBIDW99Gv9
         29/LSgeQLPJdFItF60VnLwKjqN03cDD3WvN4gvBB4Mn8Fwr/TD9gd43lJXxVCvziI8Ed
         h6dbla0ksfu3HyFWRZbM0BtjYyG9KhiHr5cjswhxPi3zTKhMzPzeB7EyGibJHMsoDWKr
         63He6RgnWjpvFXxz4EHdOO9tNIEUZE7zKE+2fOU6xIZ+NcwzDAzEXPulrbvj2Xpsu46T
         y0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S57og1HEB75m0DiN3Bot4sL06k28rGesx+9zl7DDtGQ=;
        b=jvXyzoB/5PHx0W4Wkw2oKvie46oB7ZEfdKnOP1Vkn2Tb4m8UBXvtqcYGf2DESiopz5
         myY1LSc0WrG2VmSWlIBArD+dvvzwbq9v3MxRSf+KrKEwt5RDP6KQ0QQWGle2eRohyxhT
         RPo66yiSjlZcuXtXlM6n3P9AqvPtAiPlvSLCju43Y16G9wf7mlqvEt1fULdKJi1UGfrT
         bDCQ9oHzrVQ9Tsb1vUECfUKmjl7PTZOwROkWKRHYZbmoHUQr69LBBRSjOs6jnJiebqay
         JoLp8n46GkQe2YZnjbdqSDXI5rpFoF3CfO88FTf4u9BL52dklizQMUl2a88Wp61/IHeq
         eG9w==
X-Gm-Message-State: AOAM531zVTkFjRFa0+ASKbFnXqLDjwjh/U/RUQp91KpmqNEi2XPsMmg0
        ++qyK7ldsb0Au/a4ei4yL/uWWaN1zttXgg==
X-Google-Smtp-Source: ABdhPJwLKr2+Gbp6WTLAZxnwCVhVT6OiGbRitvCp9v2fqQG2V8lJTY4HITeAfuOVuXlOwv3JqbGuBg==
X-Received: by 2002:adf:ef86:0:b0:203:f8f5:efab with SMTP id d6-20020adfef86000000b00203f8f5efabmr1553335wro.671.1648067547303;
        Wed, 23 Mar 2022 13:32:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:26 -0700 (PDT)
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
Subject: [PATCH v2 01/27] t/helper/test-fast-rebase.c: don't leak "struct strbuf"
Date:   Wed, 23 Mar 2022 21:31:51 +0100
Message-Id: <patch-v2-01.27-8fbafe61053-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
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

This change is needed so that a subsequent addition of a "goto
cleanup" pattern when adding release_revisions() doesn't solve this
unrelated bug while it's at it.

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
2.35.1.1452.ga7cfc89151f

