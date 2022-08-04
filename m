Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE87C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiHDQ25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiHDQ24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:28:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670B767146
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:28:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z12so292695wrs.9
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mVO0e4aHsroLeXtF9aVhChsVHWCDtP0LkQanrcPKUhU=;
        b=IHURgDH8cWrB8MAoDRxe2z4FH0EEI4w8LPy1kll2PdqW7jV/42yDY+8G3RgasK4Yrh
         /YD7cqWEWhrgTFYLhOcodtsU1xUx7Ent3LDJpbk3h6GrcEYcqO5GGont8iweIgHVimAH
         keGepnAjM7CwUSZa7Jw3JeQ4F6iOYwObXp14PUwmF4XZu2JH9ISBSlEw2uXZ5GCxj7ma
         UFqqagnKvoSj6Nqq9vIkjnk20nqfI5LVxTkIVkpWMRSlP7O84wjoWooL1iUmN6e/NCOP
         6vY/oLSk9FCRp6AlnyrKlv/A0BExhndeLvVS41xUaC0kfWNwglL1aCLsWAU4b8ddAH0R
         KoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mVO0e4aHsroLeXtF9aVhChsVHWCDtP0LkQanrcPKUhU=;
        b=ZInnmlS72AcL4UbP+z9FLVGjKadENngP3g75PmE3pnHY1iZ/u2y3H7EqllFwn4Uj50
         OkMMPkED5D9ZoAIB1zQuRh2XAp7yqAOSoYCUe+7VcFXNl+Bckt1uxDGPp2wg4mQGBh0T
         rZsDd3+fhlrNpmYTqusjLdK9micLZQ6gXiC/Jr7Bi1IIVFjtOBRGWxZIovAmDgewh6bH
         6qWriSXhOmYjlwx6DsGisSDLA4FdGv91Wby4vL6Bw35G1hIiQYzzzRHWPzeltOAfy60Y
         3hyfceTvMxOCDl5RTpE/9mxIFC5mw7nmPJxPwvfwvCwJ/kJ3M7fJ/6xFfTAhwBt5Z3Wq
         Z4jw==
X-Gm-Message-State: ACgBeo3NPeG9esxjNV6SvPJ0jVo0JPFcLO67LuA/1B3rHQaSQPMVK7ym
        +3QKBFZiMYLUHZj/Zqy1WxkS+iseKXo=
X-Google-Smtp-Source: AA6agR7PpvGC0wJdBmfPs4tdGovJLUhFszMGzG6Ry6I4Am2K0pwqdPOXJhGT/mFY2RRu8h9HHxIl7A==
X-Received: by 2002:a5d:6d84:0:b0:220:5dda:a0e8 with SMTP id l4-20020a5d6d84000000b002205ddaa0e8mr1937331wrs.493.1659630533687;
        Thu, 04 Aug 2022 09:28:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a513ee7830sm1868063wme.27.2022.08.04.09.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:28:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 01/12] help.c: refactor drop_prefix() to use a "switch" statement"
Date:   Thu,  4 Aug 2022 18:28:30 +0200
Message-Id: <patch-v8-01.12-8ae30ce2e80-20220804T162138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.g61622908797
In-Reply-To: <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com> <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the drop_prefix() function in in help.c to make it easier to
strip prefixes from categories that aren't "CAT_guide". There are no
functional changes here, by doing this we make a subsequent functional
change's diff smaller.

As before we first try to strip "git-" unconditionally, if that works
we'll return the stripped string. Then we'll strip "git" if the
command is in "CAT_guide".

This means that we'd in principle strip "git-foo" down to "foo" if
it's in CAT_guide. That doesn't make much sense, and we don't have
such an entry in command-list.txt, but let's preserve that behavior
for now.

While we're at it remove a stray newline that had been added after the
"return name;" statement.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 help.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 41c41c2aa11..7e594d291b0 100644
--- a/help.c
+++ b/help.c
@@ -44,13 +44,19 @@ static struct category_description main_categories[] = {
 static const char *drop_prefix(const char *name, uint32_t category)
 {
 	const char *new_name;
+	const char *prefix = NULL;
 
 	if (skip_prefix(name, "git-", &new_name))
 		return new_name;
-	if (category == CAT_guide && skip_prefix(name, "git", &new_name))
+	switch (category) {
+	case CAT_guide:
+		prefix = "git";
+		break;
+	}
+	if (prefix && skip_prefix(name, prefix, &new_name))
 		return new_name;
-	return name;
 
+	return name;
 }
 
 static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
-- 
2.37.1.1233.g61622908797

