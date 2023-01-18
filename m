Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D17C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjARQO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjARQNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:13:37 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ADB34563
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:33 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id kt14so25531860ejc.3
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIouauJ2l3wS+CHYUGO5vLZVZ8kJhEC0ypzbVS08p1g=;
        b=bGhrNZ3MGZ+SR4jp6FWtwBD/X3G81xQXX71WbmTPjiOqKG0T4QFKyiHG7eLHHQLTmq
         vZbVrHTHi81x4tTZiWBKnTo4YUgPBaU3nWZsBuVLpx6YJUTxB/r6lbfvWDeaPg/hGMaO
         RgTcCwuGLYg8WfErobNqUFSUMwYWwAMa9KIhPfkee/u+PTQ/KOYyCrIOujFLU/n5GDNn
         6G7Z/q22TbVgWcIlKkDe3Pfm7swI1bhD5nU1IXgmNTlsPQOCEExY1t9oJBQujgSYe/Qh
         NaFdjkjOqYJRCqNWuw0qBQxrMMYO6gmLlLiwXSWbuSFnqANvhDL4+0i/im6t+BDAG2cE
         D+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIouauJ2l3wS+CHYUGO5vLZVZ8kJhEC0ypzbVS08p1g=;
        b=gXFCrpVLwdmXRLV5omcThAS11s7mmB6BeI1FGqMVcy/UH47+SgYAYkL2Z/D6Ho/UKE
         6VaX2/5bo0fquhg+Lvvr7wNtnHo3lQAXtu2I7eug5rY3r7N9NZhDo1RW52AVq3l1MYrg
         m1BcVb6OWCPf+WLm9VLTj3gnsKnOJPpLLLYjhc9JmBVdpRiXjglKIiD2iNx1HbVpZaWZ
         Cs2e68Fl/gCiVfQbAVZau7zUvqFPl1zy3U4Yu6qfWqywsUQkmXulikGi2l0mD4IyVwGm
         RdRLRe/GdhIJoN4BRPcnHrmHitVpKy74d6RhrJCBEJj8lrTTD899nJx6vdI2GOCySfr2
         n9pQ==
X-Gm-Message-State: AFqh2kpM5fhsEEoEGKd8+uJ9Z5RXbCs0hN6WQ1faOGPdPY/yv/4p+Dd3
        3iiRSpGZ53rqZAek/jdDWrWPD4jCJfC32g==
X-Google-Smtp-Source: AMrXdXuAgwRtlJVOeaT4Ln23s6yF0WUArYmRju9OnN8X7ocQsxcN6ia1KThUac6edoE4wTo3F54t7w==
X-Received: by 2002:a17:907:1110:b0:872:bb39:a6e1 with SMTP id qu16-20020a170907111000b00872bb39a6e1mr6964715ejb.52.1674058171411;
        Wed, 18 Jan 2023 08:09:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b0084bfd56fb3bsm14778202ejc.162.2023.01.18.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:09:30 -0800 (PST)
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
Subject: [PATCH v3 7/8] builtin/rebase.c: free() "options.strategy_opts"
Date:   Wed, 18 Jan 2023 17:09:15 +0100
Message-Id: <patch-v3-7.8-ee8262ab22a-20230118T160600Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "strategy_opts" member was added in ba1905a5fef (builtin
rebase: add support for custom merge strategies, 2018-09-04) the
corresponding free() for it at the end of cmd_rebase() wasn't added,
let's do so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5c474fb6edd..611c1d20ddf 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1835,6 +1835,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.gpg_sign_opt);
 	free(options.cmd);
 	free(options.strategy);
+	free(options.strategy_opts);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
 	free(keep_base_onto_name);
-- 
2.39.0.1225.g30a3d88132d

