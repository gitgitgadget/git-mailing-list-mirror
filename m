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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4B5C6379D
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9250020872
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itgOo3Ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbgKXNat (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 08:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbgKXNas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 08:30:48 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C3BC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:46 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 92so16248359otd.5
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+qUZvG5cVmpBLeKyUiG5isfp33kmjrbi203XrgYD3U=;
        b=itgOo3KaoalK6J4YOI4lfTJ6CpyjuihZWG5HDH84KCkNWzdXg8QJ22FMevlCTAdYJQ
         G+HAQk1/MOMMNlO7+VWWLHaLsJgaME5B++Gfqrs8FPGsJOJwtpmUgVW/o4nAkXhX46Bd
         FecXiTtq3zutmAnfM4nAGc7xM6g//kzxzfXVdcEsoEVwKktGx2FBjag0D/WWLcLVIOwP
         m6ipYgbJhR/PjSv8Jb8Ff7IChusaMnoDMvz2OTMDTNOCQyDNCgcao5DDuqCIBjLtwUhD
         TjnNiRyd3Fu14tSsmy10Om0OnlywlaVpLl1mAGB0DeTSotIr7+9jhgYbIKqEK8wHmBMF
         ujww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+qUZvG5cVmpBLeKyUiG5isfp33kmjrbi203XrgYD3U=;
        b=jtSqrnw84wxaPP8U1eNm49wpKOO9mu2T0BaO9ZYIN0Se7+xzJtcxJHcIlUIdeLgsi8
         UFlhI2i5576Zrdrk2lq5Ibebw9O1AvWCr8AIKxVKVsTookcjRgH302C5pJGVK7PXKZy9
         H4n5dXJxYKUIVNbjz6om8XI39/NeYgYA3kQlNDEvw488cfl0ak/c7HAvdoDGlZL/qjO6
         mxePKlym6Z4Hl5n1FQsIot3Jy0VEGYsjDwjZ5A04UKtwtnaJlopz660kljkWYoIEDLRg
         xNKKunwjOAtEIxLGSwD9dmeQOysbQ6TzntVROzilZ2LALXsIa+6RVV0Z0XJ8uV9RjPew
         cCig==
X-Gm-Message-State: AOAM5312Nac0bGj8ZeVPCq496joS677BKZr9yXXVBaLnQXkYqWSXaDS1
        7sjovL75gq+va1HJ83RE0rGDMe+P0e1mQw==
X-Google-Smtp-Source: ABdhPJzkzjsk+vtVkkvkmHp20Ob1lHrT9vrrg0+7no3MWJd8yNIQIa2bjcNTuC++e3M7qSFHr3go3w==
X-Received: by 2002:a05:6830:2368:: with SMTP id r8mr3338275oth.75.1606224645296;
        Tue, 24 Nov 2020 05:30:45 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g3sm9399985oif.26.2020.11.24.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 05:30:44 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/6] pull: trivial cleanup
Date:   Tue, 24 Nov 2020 07:30:34 -0600
Message-Id: <20201124133037.89949-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124133037.89949-1-felipe.contreras@gmail.com>
References: <20201124133037.89949-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to store ran_ff. Now it's obvious from the conditionals.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index eaa268c559..121b9fb0e1 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1023,19 +1023,18 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	if (opt_rebase) {
 		int ret = 0;
-		int ran_ff = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
+
 		if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
-			ran_ff = 1;
 			ret = run_merge();
-		}
-		if (!ran_ff)
+		} else {
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
+		}
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
-- 
2.29.2

