Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C20C433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC5061A50
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354529AbhJAObN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbhJAObK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D800AC06177C
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t16-20020a1c7710000000b003049690d882so11377215wmi.5
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHUAGWbOwAxV/v3khiE3WXmu57lfY2Ws+KVBwTNVTPg=;
        b=ZRIrwApH6TGqXI9+tH8opSvpec9UfVV3iZhBGLqgxy1ckKiLdJuFawk4kffT6ahBQC
         iwEO8DyH7pSD5ValXbo+45CyECtTVx6uccyZwqytcgOL8Do0NyST6QJnbFGP+axuj0xc
         3bifElQfb0ajdhl4EBFcZ/AvE44Mf79sueevSKWaMIuAvRPkimNpueWNI/DzZJ+OxyiX
         qqEJUOj0uGNgc2aiKB+2Uq+PHX0FmQtHhFgbxNAdAVdUzH7Dsa1fQirLqlN1d1bE01+c
         BXBJ8/04ux6EDSzvUkyTNVoK8i8qStPuSCKNYUMwgvtKy7KjNokzuItEOH+zR+cU2MCC
         aJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHUAGWbOwAxV/v3khiE3WXmu57lfY2Ws+KVBwTNVTPg=;
        b=NEeQFVCe/uBHWgcf20p8ZWYhtdEoUlW6CcmortInmTveHS/Xlr+U0c7y0Q757KHzXs
         ptWqYvd18xKSNgbLA+IzMaUHH19IOTFqtrTwItDqqdaOCh64y9L5mCG7dyyuDPnLqaLh
         rk8KhY3Ogm8Lr1kfDB3ndR9AI0phPGzxD7w0B4nAwxgEmD+yR9WelnYkPnRDls6zZdwO
         3lLE9p1QJKV9uKrgOP/BdqraUz3Pyd0NJ21L4lqIJtCX03C51icMrfJ/TXpSVTmgZ8Oi
         zr3nmYViVPkl6lJS3p2epoo1pXBjROMU/p0u7FlJSp5CKIoYM9BPF1TNa7LC+8ox1IqX
         +wYQ==
X-Gm-Message-State: AOAM531GuvBqzoKAIfVCFpYRd9ZsU5y12+bKGgPaYZJKfE+CrkbHBksh
        I7Xc5/XK7lv1Rqbq08PwXKWLpg9H9Ffikw==
X-Google-Smtp-Source: ABdhPJy8JaPAHtJu+ORTsUlcdbSlJge3eLTNvinFdhQdNSO5kmJm0aGK09VWzrQnrHITXfPt/dO+jQ==
X-Received: by 2002:a1c:28b:: with SMTP id 133mr4810476wmc.15.1633098564121;
        Fri, 01 Oct 2021 07:29:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/11] parse-options.c: use exhaustive "case" arms for "enum parse_opt_result"
Date:   Fri,  1 Oct 2021 16:29:10 +0200
Message-Id: <patch-v2-04.11-a253db7a60d-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "default" case in parse_options() that handles the return
value of parse_options_step() to simply have a "case" arm for
PARSE_OPT_UNKNOWN, instead of leaving it to a comment. This means the
compiler can warn us about any missing case arms.

This adjusts code added in ff43ec3e2d2 (parse-opt: create
parse_options_step., 2008-06-23), given its age it may pre-date the
existence (or widespread use) of this coding style, which we've since
adopted more widely.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index f718242096c..e33700d6e71 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -866,7 +866,7 @@ enum parse_opt_result parse_options(int argc, const char **argv,
 	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
 		break;
-	default: /* PARSE_OPT_UNKNOWN */
+	case PARSE_OPT_UNKNOWN:
 		if (ctx.argv[0][1] == '-') {
 			error(_("unknown option `%s'"), ctx.argv[0] + 2);
 		} else if (isascii(*ctx.opt)) {
-- 
2.33.0.1374.gc8f4fa74caf

