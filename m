Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCD4C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C000D610CF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346104AbhIMRlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345273AbhIMRlM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 13:41:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5214C06179A
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q26so15927723wrc.7
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xa4pIlQfZnxCkkX3Ypij38tWKBvHdruyI+vWoy8HMMk=;
        b=UOeUO+D5tR9OgZmV/CMu/y0Nqb3kfW8GxkpArRJWLqVL4Hm07JsofSv5UiAz2q1vEE
         SAuPHFxhkbwbCMDDlt54R09Lj3aA1Quewkf0OzWHRFU2xc/pGNb8W8uYC6LX3l37Vkoc
         ow0mn089JIz7YtzUqSuG6CHbpAqstYkDPk/Tp1asLefom/n9iaGFatqjyRJ4dDjchyCO
         WBQ5EnPHZyohxINGdTRtBdIv15McEhDTqqE3HISRjxfFunoIWSeUwoKYFnKzbnYUZt4S
         2QOjoDzA1FF/J3606/HGMBTeiROH7HSa74w3kO7+yYD+dm65emFo+qEqWjFkMj7GsuEB
         jfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xa4pIlQfZnxCkkX3Ypij38tWKBvHdruyI+vWoy8HMMk=;
        b=jWSmN+EV2rz4nCeT5uRW+ex/1wvKXb1+6WgU976RzBkv/a4uJZnN6X9mQqWXtblqN/
         o+EuSumXRaLwhwVncYN56Uenm3gA7Jpu/bZ0SGcDVPsSY7okj4guXfMMJM91IS7toOrz
         F1EbmGzSISQqSfM5rTJhJd6ShowY/8mQFElgF5fm3a8Wy3fVW8BYPDww5WkFZwQOF/op
         /GJynv3Iq/OProupSQcFOQ7jZwLiWRCpdywZlok9vj9/shTZxZzFwZQTFcyD0j7Eeh5s
         1NHcoGG79qv3Y9RHA4LGEv1G2TfpfE/xm8raKYIRGX84xTPz3lzzsuBpAshkc16ZXu+s
         dteQ==
X-Gm-Message-State: AOAM531empxMzZ2kGNn+zPXkOKv+fFuFobAB6OK2dpt47T5mh49psv2S
        QO16b4FEYIPrSu2P1ScmJraDmqdVqMs=
X-Google-Smtp-Source: ABdhPJwQ1AfgCANNTjA7SswuYSzAyc4xpBfhd2HXn6MXvYkPmj5dprzj/aoNrCIzm1BpAld9GUUywg==
X-Received: by 2002:adf:e384:: with SMTP id e4mr13942757wrm.163.1631554757178;
        Mon, 13 Sep 2021 10:39:17 -0700 (PDT)
Received: from localhost.localdomain ([81.0.34.57])
        by smtp.gmail.com with ESMTPSA id u25sm4428959wmm.5.2021.09.13.10.39.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 10:39:16 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 6/6] bisect--helper: retire `--bisect-next-check` subcommand
Date:   Mon, 13 Sep 2021 19:39:04 +0200
Message-Id: <20210913173905.44438-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210913173905.44438-1-mirucam@gmail.com>
References: <20210913173905.44438-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After reimplementation of `git bisect run` in C,
`--bisect-next-check` subcommand is not needed anymore.

Let's remove it from options list and code.

Mentored by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ea966268df..bc210b23c8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
@@ -1230,12 +1229,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case BISECT_NEXT_CHECK:
-		if (argc != 2 && argc != 3)
-			return error(_("--bisect-next-check requires 2 or 3 arguments"));
-		set_terms(&terms, argv[1], argv[0]);
-		res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
-		break;
 	case BISECT_TERMS:
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
-- 
2.29.2

