Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD990C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC3561211
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhIUC71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239243AbhIUC0b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA5CC1E325F
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w29so32591775wra.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpCLv1vqXilM2NXE7LeVOwnEcRPTEblWhjWeEGaBwnU=;
        b=RRqfAwI1OH4myppROwRC1CAs2ZIsNlxzfcsZclyXKWiQPPp8T2uGMUWfiDmQ7o5Y3X
         9XjzQu4M5PJ9Cs54mNCDvSfWUzO9LIsL8hEZlTeHmdcjGMKLJxwfPF0B+4PHd7YJH8ME
         KClSUJjCTCZyhdPMwxfemUwIIOXpp3SkKKyOuaVc6iL7N9RsvrYJjQh3FknTh79JA1sv
         tSvk6UaJd/DlmXbBRzY06Jl/Akt8AOPfsEdP/XYJVpmnyU8HG0f46WpX4FIy/kxBHoCT
         7fw7f22lcnPJwgS4zS0keyHfTaUlkPObriyw1Cu0YmRmq6QSHh8GylTvjp5JwJDMpfAq
         +P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpCLv1vqXilM2NXE7LeVOwnEcRPTEblWhjWeEGaBwnU=;
        b=SsrwvFKgzJCieWkR02dzOPPB0496Gdfx2RHcO+EZREae12ZS579YmGJ/fc4h5rN78l
         optSqORRdoLSLuXWrIbhAP2T8kT5gyWaBCsX4mz1m8HcunDyuUvQyB0Q0Tpd7reCKIm3
         JofG9ZikjkKqABVKsgdc8AQCCYd24M0Sk+h7F6uxOQbWrcywU2sEM1fHrEZnQ2x+mQ3k
         MTYe6i/LZ32nsNQ4oBhzlmgLTHqT3bgIJzoNs6OMlZASq1qmbgNZv2nkzy2JQ7MyeLS7
         TtpzncKDlNvxCIExFxZKsPH4jL6wWY2JQkVX0lnAmuQcPL/6tYkLSsiDtt8a6Evyu7HY
         8uqg==
X-Gm-Message-State: AOAM5330nxx4lH3nBqIonB2+brM4U7y1gSFNzVNbWmVCdKDe5sq+gIop
        3zwZHxqt3QyseSZvMwCt5MtfeIez7oWqqg==
X-Google-Smtp-Source: ABdhPJxs7pCigIEU9OY4DImN+AxgWo32EisRAKFnB227nOl444h2Qh9x1h3WXvMburhTz7FvCHN3jA==
X-Received: by 2002:a05:600c:4fc7:: with SMTP id o7mr585670wmq.91.1632164667068;
        Mon, 20 Sep 2021 12:04:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 01/17] fsck tests: add test for fsck-ing an unknown type
Date:   Mon, 20 Sep 2021 21:04:05 +0200
Message-Id: <patch-v7-01.17-752cef556c2-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the fsck tests by checking what we do when we
encounter an unknown "garbage" type produced with hash-object's
--literally option.

This behavior needs to be improved, which'll be done in subsequent
patches, but for now let's test for the current behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5071ac63a5b..969bfbbdd8f 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -865,4 +865,21 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
+test_expect_success 'fsck hard errors on an invalid object type' '
+	git init --bare garbage-type &&
+	(
+		cd garbage-type &&
+
+		empty=$(git hash-object --stdin -w -t blob </dev/null) &&
+		garbage=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
+
+		cat >err.expect <<-\EOF &&
+		fatal: invalid object type
+		EOF
+		test_must_fail git fsck >out 2>err &&
+		test_cmp err.expect err &&
+		test_must_be_empty out
+	)
+'
+
 test_done
-- 
2.33.0.1098.g29a6526ae47

