Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D51DC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiKCRID (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiKCRHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C7638E
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t25so7000784ejb.8
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sknVs7wrRyty15m08jYExxnLqiDyaDrzpKzXN7vsA6o=;
        b=TTqWk/mU1nHQI7jflu+HJwvJjXG1NiNbnXDPTl8O4yBAEcTYVRM5SVIEYlGV+FW5jL
         k0AeYr0a8LErSPJVYGaj3YcL5dXkCeuQWQ/5rJiBJjnyys1GGlZA1WVJJFsCwNCMDwLJ
         UFM9ucxA0RYQTCh22VM6owrvpV0ca4Eq8qWBPehb5gOUiiXJny7ar6bUIShqlCdGjS75
         dUv3N2Zwe6Q0RaUHjT2PyMbXSGN5ts3/AE9uieOuKm2FgZc1rL5z5H33m0ZGn9e6CCmI
         5SbhgvJiUsopohz0UP03rTZeUErOGjV/4nvq2SoCkAodg8wn1/lKcUjFNEtWUapsq44l
         QAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sknVs7wrRyty15m08jYExxnLqiDyaDrzpKzXN7vsA6o=;
        b=1j3e4rc4eONCgXicd2/LnfUqYknAKyi9RRTRdXdlw0vBSKKrrfxLdbPMPcCtdsKesp
         zBsjTjXLSbDK2C8MLxLx4rSw0bs5TzAB9K8MeRIyvWVQ9G6xCYvputSPukw/v2SPEzd0
         Qap1POYfIHumowUJC/6GjK2c+kWnk1cYMWOCjtyUFgC8tjfmp6iySZJtRQ1vCMWTkxgZ
         CjCuy+hBvD15yR/LF5ZH5epNeaRPXGMOdYRtt+/hVJxosfWfKNKCoo+M3QFuNon79JID
         XNMWfEym5Ag+PsYWD2KUGpJTGrFwAtS5XK/6zQ+83mU4WfCteUWcnAuvp2Norp75g4fk
         /RuA==
X-Gm-Message-State: ACrzQf3U2aA17rJ6K2iSyiRGXie9P4rf/2BNPwlgDKUxQ2CpOvXAA/a0
        Fd9uT1b/6tG4TLL41NVl/kl4JBgOw2/xzg==
X-Google-Smtp-Source: AMsMyM6hc6z9joO86Z4LDlIN0OwdAxyamLLXwHnCD8KfcW3Ch3J9VJcAnE9NBeMPPcz/ElX3JIsqzA==
X-Received: by 2002:a17:907:980e:b0:78d:b6d8:f53c with SMTP id ji14-20020a170907980e00b0078db6d8f53cmr30349019ejc.70.1667495192367;
        Thu, 03 Nov 2022 10:06:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/17] sequencer.c: fix sequencer_continue() leak
Date:   Thu,  3 Nov 2022 18:06:13 +0100
Message-Id: <patch-14.17-02e1dddf149-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in the recent da1d63363f1 (rebase --merge: fix reflog when
continuing, 2022-10-12), per [1] the author was under the impression
that by calling "setenv()" the C library took possession of the
string, but we need to free() it.

As [1] also notes there's upcoming changes to do some larger rewrite
of these codepaths in sequencer.c, but let's first do this much
smaller and isolated leak fix.

1. https://lore.kernel.org/git/86699708-d631-fb49-482c-af27204a3570@dunelm.org.uk/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 14ca0af2ade..3095d0d2b3b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5069,10 +5069,12 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 		previous_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
 		setenv(GIT_REFLOG_ACTION, reflog_message(opts, "continue", NULL), 1);
 		if (commit_staged_changes(r, opts, &todo_list)) {
+			free(previous_reflog_action);
 			res = -1;
 			goto release_todo_list;
 		}
 		setenv(GIT_REFLOG_ACTION, previous_reflog_action, 1);
+		free(previous_reflog_action);
 	} else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick(r, opts);
 	else if ((res = read_populate_todo(r, &todo_list, opts)))
-- 
2.38.0.1451.g86b35f4140a

