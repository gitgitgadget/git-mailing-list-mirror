Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A22C4332B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FAA64F7F
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhCPA4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbhCPA4e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:56:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32B5C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 18so7691749pfo.6
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEvvhoZQRkWT8560p3ZLxqNb7GqmbHEp+hd7wLHwOIM=;
        b=g6Ltig3hyar5kze2Wu+2ZJV6NZ7LnaxwfzImN4BeKq1RVpR26PIFWOA9eD/5OInDWx
         fnXSGynTXMsRQe57iuMZHndKqOjQ99LhFwrvzW0YYjgdoF1UAmnWYXOcdKtFZDi8Fqjn
         gcOi+dFG67b1y/wtPd588FZ7tEb5/okBQq5YbH6Ex6awgjsjBhmLIoCnUlMMpp7eZ8S7
         nreiyIwDinbqfFnVlklbgDQ3HTWr40SXD7m1QZgZ5tYuPhp0yKPXOzYm4PPxeHLarfVc
         0O1r7es5TbqbDqb5CczQkZlnyD0qzYjVlm3IAlQIYPR3p+Dm/2mwxvn4P4Zj78S6jtkh
         qQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEvvhoZQRkWT8560p3ZLxqNb7GqmbHEp+hd7wLHwOIM=;
        b=G3X6pukQiJ2TcXv/0EKH3LH7DY1iw1xHMRkGc7vSIA7eyaFCCPL59sR+GAfm4RtorT
         2RQ1r3UMTh55cUajurGZdCUk9SiwzaZXJ4BA01kbghCwFxYnVf20B7FVrHAeX/fIPchA
         EZ2wwujoxORSth+tLp4FIbTaNEd0FBWshXB7gr/xtRNeQ0zV95n+wZVKKAjBN0gIFcul
         htp2C9i7w3lCAB/DIHtvylrTj2D0B2aEEKnZMkGaa2lnAzEgp6La2OxnGxT8Qci9KfGl
         absSCi4xwEQrF5aQrJX7/MEV5Q/9y/7rJ4oZ+/fpGzv2Rw0Aix8CQs6Xhytt4zp8wtV3
         yBtA==
X-Gm-Message-State: AOAM530HiJyjwJ7xMZGKfr1AHh+PJksJbbxA3xNZb7n50rN48npNlkya
        qWBpGEZvw3FU8uExm3+mMJAZgIgHkQ4=
X-Google-Smtp-Source: ABdhPJy58LMExbT3fDmGPXxc56zk3imxt9NSGIV4MqLmbOz6/0iK92JHgUJ/B5WiJKMpG4Cs0gPM2w==
X-Received: by 2002:a65:4085:: with SMTP id t5mr1568689pgp.208.1615856193334;
        Mon, 15 Mar 2021 17:56:33 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id h186sm14670312pgc.38.2021.03.15.17.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:56:33 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/7] test-tool.h: ASCII-sort list of functions
Date:   Mon, 15 Mar 2021 17:56:23 -0700
Message-Id: <b817541c2754ec8fc4edc1ae774e460912e7c0a8.1615856156.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615856156.git.liu.denton@gmail.com>
References: <cover.1615856156.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The list of test-tool functions have, over time, gotten slightly out of
ASCII order. Sort this list to bring them back into order.

ASCII sorting was chosen over strict alphabetical order for the same
reason as 805d9eaf5e (Makefile: ASCII-sort += lists, 2020-03-21): the
purpose of maintaining the sorted list is to ensure line insertions are
deterministic. By using ASCII ordering, it is more easily mechanically
reproducible in the future, such as by using :sort in Vim.

This patch is best viewed with `--color-moved`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/helper/test-tool.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 28072c0ad5..9856e84149 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -22,14 +22,15 @@ int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
-int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
+int cmd__hashmap(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
 int cmd__json_writer(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
+int cmd__oid_array(int argc, const char **argv);
 int cmd__oidmap(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
@@ -52,7 +53,6 @@ int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
-int cmd__oid_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
@@ -62,8 +62,8 @@ int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
-int cmd__xml_encode(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
+int cmd__xml_encode(int argc, const char **argv);
 #ifdef GIT_WINDOWS_NATIVE
 int cmd__windows_named_pipe(int argc, const char **argv);
 #endif
-- 
2.31.0.rc2.261.g7f71774620

