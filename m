Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B24AECAA25
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 17:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiHYRKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbiHYRJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 13:09:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389841022
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 10:09:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u14so25414567wrq.9
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=80NLdQwfsFqs6R8fWaKuHf65TsE/ur6dNgRE1+bxIEI=;
        b=OA5mGMK+yWyBbOz5soBuICIEy7pvAvaycs+NPa9LNu5ucujY05pJoar/KccIQBLOcb
         fRh3Ix7BmKgIhp8q07dCvmf6Uuy+au5z34ADGwWUlUAFANfI0CpCP67hMAhEX6PCtc43
         ayQu4NPEvXEJrrrf2IloSEDDz2RhHJRHRcDop9EwdVyUucO0/4uXbo8kBN1BwpgBMdts
         Rg3UgDwIVmEMXPkVXrG5GlV0wdexw9m7+fAnB9K6NaPGUZ0tDC9gUbgqbJQU9GQyWdqw
         SH+yqKQ1n2Pvq9d1dFx8775/xBw5wbLnW+HPImvdqHdQ6DSw6kBnzlmlrk1jLcAu1eyA
         /2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=80NLdQwfsFqs6R8fWaKuHf65TsE/ur6dNgRE1+bxIEI=;
        b=y3YIsFMc52Mw0Ym10ZAbKkv/YDu2gvZrCbQh8zoOHzpu42ErxZbH2n7uxrqe2grBiQ
         qr4Gv4n6TtTwcbr5qPpHCu2PRgz2IwXcWBtq+U6/gBUMLJpDYkc1fRq8+Nw68G6TFlGR
         MzbGMBn2+9dfFd9HpoUtOgrXbsa/MhosmLanYcHy8nS2+8J5T49WVrIYZBP+bzr/+Wol
         QEjgBC71olZOpmkPBBhTsWIN+u7C1RGNoe6kKPfUMe9DEhDYJ/en/1b9gRfMJT8j3BGX
         utxqcyapp+2eOhrJnE4THtvWKOulGuFBW95+fQvk0FqWohyezwJBK8sYUXrfkexU74f6
         47fQ==
X-Gm-Message-State: ACgBeo2/s/Z+cxq1bIHC3OxIXJfVM8TOUFEwUiz2A4NWPea4aParBwU4
        jLCenvRmRl9rcpPsPxzyH3JhyQC3SsthAA==
X-Google-Smtp-Source: AA6agR7u/GmdKHBl8ghYhU9vQlG/EJHRR7UOo12yGMcZuL+R3/6pIFqsA0hm4k+kOYFb4JK8R5cuIg==
X-Received: by 2002:adf:f20d:0:b0:225:2840:1eab with SMTP id p13-20020adff20d000000b0022528401eabmr3005709wro.51.1661447394231;
        Thu, 25 Aug 2022 10:09:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bt4-20020a056000080400b0022583786cd9sm1583810wrb.111.2022.08.25.10.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:09:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] git-compat-util.h: use "deprecated" for UNUSED variables
Date:   Thu, 25 Aug 2022 19:09:49 +0200
Message-Id: <patch-2.2-0f603594e5e-20220825T170709Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g8741a0e3ea3
In-Reply-To: <cover-0.2-00000000000-20220825T170709Z-avarab@gmail.com>
References: <xmqq1qt4486e.fsf@gitster.g> <cover-0.2-00000000000-20220825T170709Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the preceding commit our "UNUSED" macro was no longer
protecting against actual use of the "unused" variables, which it was
previously doing by renaming the variable.

Let's instead use the "deprecated" attribute to accomplish that
goal. As [1] rightly notes this has the drawback that compiling with
"-Wno-deprecated-declarations" will silence any such uses. I think the
trade-off is worth it as:

 * We can consider that a feature, as e.g. backporting certain patches
   might use a now "unused" parameter, and the person doing that might
   want to silence it with DEVOPTS=no-error.

 * This way we play nicely with coccinelle, and any other dumb(er)
   parser of C (such as syntax highlighters).

 * Not every single compilation of git needs to catch "used but
   declared unused" parameters. It's sufficient that the default "make
   DEVELOPER=1" will do so, and that the "static-analysis" CI job will
   catch it.

1. https://lore.kernel.org/git/YwCtkwjWdJVHHZV0@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5ea7be97493..71a004be409 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -190,7 +190,8 @@ struct strbuf;
 #define _SGI_SOURCE 1
 
 #if defined(__GNUC__)
-#define UNUSED __attribute__((unused))
+#define UNUSED __attribute__((unused)) \
+	__attribute__((deprecated ("parameter declared as UNUSED")))
 #else
 #define UNUSED
 #endif
-- 
2.37.2.1279.g8741a0e3ea3

