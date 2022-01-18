Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BB3C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 18:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347837AbiARSzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 13:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348482AbiARSzE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 13:55:04 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2090EC06173F
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 10:55:04 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id c75-20020a63354e000000b003408e4153d1so21028pga.9
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 10:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kBbByrNFRfyeFLe4U8KRGl9oHeldlad0vXOAejrxrTo=;
        b=KSaGjWdUtfA68lLvd61OtG2OnetTiUU+GKshAtQX9Vwzx/5tIlOedWCZrlqssmEnPP
         hV7Yr4XhKIQNqtdiln5qHUR2oQQjSiFGsFag0JBod/hkab0DWK7IYdbBBjeE4/I0v8Jh
         Z4nIcpUFldId4SGO9tN8AARXTwLLltkg9v+NJwa+V1ec2Afyj7z0TqPgb/D8AiOnncPu
         XYDg3q4ohgGCbE1Bxrd4f3iqCAwHhkqYl1O1nGLXaNNXYpJ7i3jISuJr8M3ZnBsfp61d
         aEYjLChWteLoI6HvxPZPSJs1r08LaGPgrzPuUeE/PctpkiBkSYRy+ojv70JTKpp5Dg6j
         6S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kBbByrNFRfyeFLe4U8KRGl9oHeldlad0vXOAejrxrTo=;
        b=VsXncVy275hr0btmV1x/MTSKm7UqkTXBE+7OLKuFnsyByPikq963JVGIEsxfgt/7PZ
         YiXnbkn4FboG+gc9IqwXubv56jbuFTqBbodlfeVHYalIMIi1eUj0G85lbmPZ+0FOBRYx
         9MPGI7SynmbrLTm3/YtvPkCwsnTldZSoXv+elnpq19iVgs3EL3i7lEvB74zDw/hJydql
         Q/73fFiLOi9C+3AYQKUAnzfBw1e1xSymV3NIwRLcqdzPwK4NIwapmIiYaDcNTD9x2eUQ
         WZek/CK4Q73h+X+20rkrX0YqbwM25CKVWICGEmMv+1idag9OObshue11YEv31f86/O5K
         SfHQ==
X-Gm-Message-State: AOAM532h9qXu/swsUY+q0ev2jzHUPgBeLmSskb+qyX/0HMP1CQRVHNnS
        +J1w+5j+2UMih9nnP0JYrrfLLp3kRMqWbKEOYQL+s04o4K0/0LYCUj2kGbhGhdgZgT0GcufOJvm
        dSgJ8F1R4Uk7Jz43mjzlqV1tvo6nHPTK+6Ukiha0P+8Q5RM0rjDwqTnD0Rbp7huc=
X-Google-Smtp-Source: ABdhPJx52yk0hBGQdmrMrzP6a0pTHyKCgWUIBloBkZ/fjOSSVZI4Zn1l64DgxJLyddIcvLxiKaOlCIWbVArbyA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1a4a:b0:4c3:18c8:3595 with SMTP
 id h10-20020a056a001a4a00b004c318c83595mr17807873pfv.61.1642532103488; Tue,
 18 Jan 2022 10:55:03 -0800 (PST)
Date:   Tue, 18 Jan 2022 10:54:52 -0800
In-Reply-To: <20220118185453.33710-1-chooglen@google.com>
Message-Id: <20220118185453.33710-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220113004501.78822-1-chooglen@google.com> <20220118185453.33710-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v5 2/3] fetch: skip tasks related to fetching objects
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_fetch() does the following with the assumption that objects are
fetched:

* Run gc
* Write commit graphs (if enabled by fetch.writeCommitGraph=true)

However, neither of these tasks makes sense if objects are not fetched
e.g. `git fetch --negotiate-only` never fetches objects.

Speed up cmd_fetch() by bailing out early if we know for certain that
objects will not be fetched. cmd_fetch() can bail out early whenever
objects are not fetched, but for now this only considers
--negotiate-only.

The same optimization does not apply to `git fetch --dry-run` because
that actually fetches objects; the dry run refers to not updating refs.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fetch.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0a625cb137..7bbff5a029 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2152,6 +2152,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		strvec_clear(&options);
 	}
 
+	/*
+	 * Skip irrelevant tasks because we know objects were not
+	 * fetched.
+	 *
+	 * NEEDSWORK: as a future optimization, we can return early
+	 * whenever objects were not fetched e.g. if we already have all
+	 * of them.
+	 */
+	if (negotiate_only)
+		goto cleanup;
+
 	prepare_repo_settings(the_repository);
 	if (fetch_write_commit_graph > 0 ||
 	    (fetch_write_commit_graph < 0 &&
-- 
2.33.GIT

