Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CF5C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjALMqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjALMqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:46:14 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC8E20D
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:12 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hw16so32606059ejc.10
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbXwRGMI4zVai4Ck+nY7RdVoSbqITBC+4sRXRy8BiMs=;
        b=Bv5Dz8MU4ft9pCJMxNCDA+TqBa+RNH/quxUVXsa+rlHkh12rYifasuTmjuvHWEXrL4
         nABzvl6DBWFCuTMS5GfM+nPXsVGhA1iKubt4Nc/soxXkHQfcDL7RYx4s78kieZRaWLyA
         RlAsz8iDZdXinGjhoOAWBKYfZUYwX8uN75VyttqV05TD4RNYm8paw+wum6ARAoxp1TCc
         37eXwsyjdIYgUmzZh5gr2EFgVvXlm0P8jlJWEZi0RecaKaBJhS1Mxo9zQPFlDsCrbl4s
         1T59s6+loTbYQoQx7aBoIhEhvppo3yg5YSmS5nc5htQgrL1OBkWh8d4j1Sfv28anUsw2
         zezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbXwRGMI4zVai4Ck+nY7RdVoSbqITBC+4sRXRy8BiMs=;
        b=A93zOGBRCgmtzXLXTbDY/qr7OMGvui2GIZ7IoIfve7gCuKO65bzSpCOSvyt5nbq20n
         XnQ7yBX5M0LM7AW+xqcBmAEYa7FcNEBYbusmR/FEnrmdDL/8cMFZrQYsq4vThwHmTvdK
         +BaMRpZqGqza0hsfh9kTVx/pfb+n4d1yvnTXc/NNC3GyErVD0YxvT6VG6pXq8sQ6JUO4
         CgGmyjsoaHDE1/SCyfmjmozZsawN1d+pPq9VwWkK64ZXdbekpRaafJZIdKn1A9i49ziF
         OAvMtWsGR8br/z6kxMhdFEZKMgX+xREJbwce4J4tlajsWEaxc014fT9jHwfFITbKnLmf
         5wmA==
X-Gm-Message-State: AFqh2kq33ShdLOWv9F2OhOMKa0o7pc7VJOtQ54o2PnNO0KXVRYlJEMfd
        7RuJMmYYOuVhIXShMNC8sAbWGEnb4eKaSw==
X-Google-Smtp-Source: AMrXdXtePZJWPN4AdOIcseX01SJB/HUjThmv0ZSDnuQ7EhRV8lv3W78Wwq/P4x70alTUX0QrQoquvA==
X-Received: by 2002:a17:907:8c82:b0:7c0:f7b2:b19a with SMTP id td2-20020a1709078c8200b007c0f7b2b19amr71239165ejc.27.1673527570893;
        Thu, 12 Jan 2023 04:46:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b007be301a1d51sm7373523ejd.211.2023.01.12.04.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:46:10 -0800 (PST)
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
Subject: [PATCH v2 6/9] builtin/rebase.c: fix "options.onto_name" leak
Date:   Thu, 12 Jan 2023 13:45:58 +0100
Message-Id: <patch-v2-6.9-898bb7698fc-20230112T124201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1] we started saving away the earlier xstrdup()'d
"options.onto_name" assignment to free() it, but when [2] added this
"keep_base" branch it didn't free() the already assigned value before
re-assigning to "options.onto_name". Let's do that, and fix the memory
leak.

1. 9dba809a69a (builtin rebase: support --root, 2018-09-04)
2. 414d924beb4 (rebase: teach rebase --keep-base, 2019-08-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c                 | 3 ++-
 t/t3416-rebase-onto-threedots.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0d8c050f6b3..b4857b89f19 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1660,7 +1660,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&buf, options.upstream_name);
 		strbuf_addstr(&buf, "...");
 		strbuf_addstr(&buf, branch_name);
-		options.onto_name = xstrdup(buf.buf);
+		free(to_free);
+		options.onto_name = to_free = xstrdup(buf.buf);
 	} else if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
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
2.39.0.1205.g2ca064edc27

