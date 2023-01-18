Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB09BC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjARQOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjARQNl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:13:41 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3713B0FE
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id v6so41421169ejg.6
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+IjleXLUY2FD//iM8u3pY5k/TMt0rdAo/whUNXopwM=;
        b=aKeuDl2/a3LpOKCy3iCNt4+Vs3b3XPMMeKvN0QewzIaPJRjSok8XvCOw5svreT8BcY
         ZTsR4AmtYopVsUorT1vx8cQZbdq7xUCxjpyG7LeWH6BGRgKEDosbvQNXEjlMluY4jisI
         rTf9wuzLm1Cgioz3XF2rKxMqdkbpcYHPPj172yUCSfnvdqOLaLKRds9u0CBAq53GPEr6
         mp7qZxdOZvQTuFqiKqi+wr2Sjm8NBIc185x89cwg6ERiaYRMzZKxmcH5j1SPJ/9zf4Zz
         iLo+hllkSh16PKXO7zV7CHycmDPQMI87qepLo4gn+JZYX7BvCD1w4F+iZRrRWys2lFlb
         P2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+IjleXLUY2FD//iM8u3pY5k/TMt0rdAo/whUNXopwM=;
        b=pASJ19hrVSMl8fdC8zzgy6mxaxzYeIQFUeGhicFbfBmzZhG4AKW73W7vmawihXAhW1
         paEQ8acLYIwp8JqUdKyGpU+iocm1FC3+4s1tXFz4K/yHWScW/LN9Xx3SvZtBTPpKRix+
         AZvb0sctwBDTfWL+2kRxP79AGRGDNuCsmly4q/OmymsJ0FXLHNuibjmnD9UyE85T5ru9
         O8sGXi0GXe1rLXsi6sRpKCE3Gyry5eXAP38yrQ0WbTxZHUFfkPKDSFE721eEJhikBiJd
         YATjP0i5whco2eaA2lalrFsNgkDtS14Mii16ZkGGtVnjcAoP+mu4ej9Jy5nDUhwr1QPv
         fRSQ==
X-Gm-Message-State: AFqh2kpAMVryT2rBdVaNGXEImBRB/XOoHqWs/TdATW0vfUmGM0KxRxmD
        4NGwJ8Qw6EPKIWSR8ZLs2Rqo1z+QHm2IJA==
X-Google-Smtp-Source: AMrXdXuAb8zwvNb8/MiiQhRCF7nF+rF2HI/HYqdvRyoaAwc3QQlPZzgGXgldZloE4H2kLzhbOO7hZg==
X-Received: by 2002:a17:906:60d0:b0:877:612e:516e with SMTP id f16-20020a17090660d000b00877612e516emr4128422ejk.61.1674058169842;
        Wed, 18 Jan 2023 08:09:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b0084bfd56fb3bsm14778202ejc.162.2023.01.18.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:09:29 -0800 (PST)
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
Subject: [PATCH v3 5/8] builtin/rebase.c: fix "options.onto_name" leak
Date:   Wed, 18 Jan 2023 17:09:13 +0100
Message-Id: <patch-v3-5.8-3d5c3152f69-20230118T160600Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
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
index 5859a5387d8..5c474fb6edd 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1037,6 +1037,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
+	char *keep_base_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
 	int preserve_merges_selected = 0;
@@ -1660,7 +1661,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&buf, options.upstream_name);
 		strbuf_addstr(&buf, "...");
 		strbuf_addstr(&buf, branch_name);
-		options.onto_name = xstrdup(buf.buf);
+		options.onto_name = keep_base_onto_name = xstrdup(buf.buf);
 	} else if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
@@ -1836,6 +1837,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.strategy);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
+	free(keep_base_onto_name);
 	string_list_clear(&exec, 0);
 	string_list_clear(&strategy_options, 0);
 	return !!ret;
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
2.39.0.1225.g30a3d88132d

