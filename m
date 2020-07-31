Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06A6C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE042245C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK0ZlWxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgGaP1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387505AbgGaP1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E89C061757
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a5so18401668wrm.6
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=74FdMbYcgt4JIg6CZSSX+jZTlOBPiX/Xtrklp+If7HE=;
        b=TK0ZlWxf5UGPilt040WCC7YTnis8tVA8EqSAFR+qETb+EXvkNcwmZScP4wxVYUVvqq
         JfLjENrdiH4UY8VNgWXQcoeHzyvEfl4NkfRXRHH97GiUBr6GlKJ64zoEpXyqr1HW6zfK
         sAS8re4DJXCc1Kb3wpZMjlImB6I+eo5GdppsBgMsKdtke0LWcahlizoqWzTZYg5FRjBr
         x1lL05baKR5BnLcO8yvm65DRp83gKlwvV1qZiFUyYHRfczN7e1Tqi3UiRakGTRTktwLi
         F+lj9VvXOdLMlQqKkoaI8j9ujZHIpiaKIgiL5UbVsGRuejUgIoaHRdr34HzqoUBYxZtc
         ar7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=74FdMbYcgt4JIg6CZSSX+jZTlOBPiX/Xtrklp+If7HE=;
        b=FhX0sIlZuUXWSGtiCr/TynCfokh9htf9VvXMYQp5lOu+IZ/f1mqDA4LQhuykeC9qLU
         c0kdkSLoxt8kvehG+hYzQ/fK7Fz0C+g9OOzhXuMf18oCJO2Bc5cSs+qp5giBkLrYZmHe
         vaI0UMV/DtAsbfV5gqAjyDcbQB1NzjwyDrKsWpO4xA/P3D4Umk+dVuK4LegPsW7urOL+
         0jhVn85lkbN/EmDmEHi2t8M2OG4UFbMN3MFrUNQhdGMdM39PqN8EIWmI03mtfjbCZmGj
         6MN2FPvJB+2nWyH4E3k9aRLWIJ8XTUTjGZuFZvaUU9vuvBbcvzm4cLMl6nNOJ47O7OkE
         ulzg==
X-Gm-Message-State: AOAM530dHaR3Z6tIyWRNapEqecn0dTsVCvx+P22fiNssXg5nN+7uYNMr
        OgZL7b5yDfiKQFgM67kW8X3L95xh
X-Google-Smtp-Source: ABdhPJwt3g6hK32pFskSTyud1GWOp1qkiTIKQMVKq+EpBSqFaH09CfOgYi7h/OSax28JRN31UgoGmQ==
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr3841631wrx.49.1596209262962;
        Fri, 31 Jul 2020 08:27:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm10289832wmf.43.2020.07.31.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:42 -0700 (PDT)
Message-Id: <539fa0935f96fb71a8e5e07ec88de8423accfcb7.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:17 +0000
Subject: [PATCH v20 21/21] Add "test-tool dump-reftable" command.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This command dumps individual tables or a stack of of tables.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 | 1 +
 t/helper/test-reftable.c | 5 +++++
 t/helper/test-tool.c     | 1 +
 t/helper/test-tool.h     | 1 +
 4 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 0948a3bb00..c22fd41662 100644
--- a/Makefile
+++ b/Makefile
@@ -2375,6 +2375,7 @@ REFTABLE_OBJS += reftable/writer.o
 REFTABLE_OBJS += reftable/zlib-compat.o
 
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/refname_test.o
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index def8883439..aff4fbccda 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -13,3 +13,8 @@ int cmd__reftable(int argc, const char **argv)
 	tree_test_main(argc, argv);
 	return 0;
 }
+
+int cmd__dump_reftable(int argc, const char **argv)
+{
+	return reftable_dump_main(argc, (char *const *)argv);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 10366b7b76..9e689f9d2b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -53,6 +53,7 @@ static struct test_cmd cmds[] = {
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "reftable", cmd__reftable },
+	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index d52ba2f5e5..bf833e01d4 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -17,6 +17,7 @@ int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_fsmonitor(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
+int cmd__dump_reftable(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
-- 
gitgitgadget
