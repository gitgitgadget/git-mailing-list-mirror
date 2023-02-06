Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAFEC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBFTJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBFTIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:08:51 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1C42A9AB
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:08:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o36so9416470wms.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClUqrbfN1lOqJ3dDeEBpj0/8tmeSGIP4zG14gW9ffek=;
        b=SnooZAKNs2RAKHL6c0o0cdC38LVWpWSA3EVUwaaNABIAmMmb06rKLJo1vxQy6VJQAW
         PqGzE+5WJDj9qmUa29VNpRDhRKGeDZ5ACXWaFynogxAIDPaw4jvBuAo6rb3HvzhgiNCG
         46GZ8mWB8vowA4QtZ7a9OllxdsG5zv2v2bwNorRveMY8gaEyKBTDOuXJ0bMy7lG1DU7T
         w8r2+Ktn444dM4+0kJO+658h0okv6rglQbPmZAmm9R9VbObH3EBODPbbT96Cu/1TAwzw
         IQQXarQPWx4nls0xQaeny1h9o11ApPhcFUjGABqxOHpcfwY8rNTyyYhH1+0nFwykU/ZQ
         kkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClUqrbfN1lOqJ3dDeEBpj0/8tmeSGIP4zG14gW9ffek=;
        b=lrZIGDC/XjDI6tkm/jIdgtR4dN4ePt/zb48QbtCKUWEAbrkXBCUi9VwIOdvK8vpacI
         0wvqv9Svc+Hf8HUu38GwPnZDevVdmYQnpj9GEWq+74cfO21x7YwUByFOX7qCaWlXDztE
         odsFz4TiGSFOLVD+VuiGCkUMyqWi2SepJwyFJFLA8gijcT80XVDjB3kWH1fIgOhFrL1z
         4F5xGtTBB3hEadCQUgSui4qP4jATNESVt21tq9SQ7whRHIomMiMc1dFWi8D//AnPUAYK
         +Wtby/SbXSWYU47krjPRaOF7m0nakSsE/eVvcUlUVFRhCKCZsPa9sAHEymRIVfzjlwkm
         0Xjg==
X-Gm-Message-State: AO0yUKVaV6AvfJyINj/AyYdDKRwRVBjC3aksGUuB+5ecU6CIhkcUmSeA
        zYrCPdkvdDAIyChlCrxCjgYQQgNR4hBjj11P
X-Google-Smtp-Source: AK7set/zZEOpMUmAmWS1yY7Ea/BJAa/f5Bw+RG9RtxWa/jMmFH0GJw6s/QAleZk7mXOe5aopwJctpw==
X-Received: by 2002:a05:600c:43c4:b0:3dd:1b76:347f with SMTP id f4-20020a05600c43c400b003dd1b76347fmr731934wmn.18.1675710529403;
        Mon, 06 Feb 2023 11:08:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003dc4ecfc4d7sm12538595wmq.29.2023.02.06.11.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:08:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/8] builtin/rebase.c: fix "options.onto_name" leak
Date:   Mon,  6 Feb 2023 20:08:10 +0100
Message-Id: <patch-v4-5.8-f9c4d17fe70-20230206T190346Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.ge02fe682bd8
In-Reply-To: <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
References: <patch-v3-7.8-ee8262ab22a-20230118T160600Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the existing "squash_onto_name" added in [1] we need to
free() the xstrdup()'d "options.onto.name" added for "--keep-base" in
[2]..

1. 9dba809a69a (builtin rebase: support --root, 2018-09-04)
2. 414d924beb4 (rebase: teach rebase --keep-base, 2019-08-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c                 | 4 +++-
 t/t3416-rebase-onto-threedots.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2ec3ae0b42e..41e96f0eb5a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1039,6 +1039,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
+	char *keep_base_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
 	int preserve_merges_selected = 0;
@@ -1675,7 +1676,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&buf, options.upstream_name);
 		strbuf_addstr(&buf, "...");
 		strbuf_addstr(&buf, branch_name);
-		options.onto_name = xstrdup(buf.buf);
+		options.onto_name = keep_base_onto_name = xstrdup(buf.buf);
 	} else if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
@@ -1851,6 +1852,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.strategy);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
+	free(keep_base_onto_name);
 	string_list_clear(&strategy_options, 0);
 	return !!ret;
 }
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index ea501f2b42b..f8c4ed78c9e 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -5,6 +5,7 @@ test_description='git rebase --onto A...B'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 
-- 
2.39.1.1425.ge02fe682bd8

