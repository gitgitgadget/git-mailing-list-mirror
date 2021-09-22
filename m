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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F4C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E623610A0
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhIVLTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbhIVLTi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 07:19:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E59BC061760
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:18:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t4so1583870plo.0
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qic7iWF2pSIXBsh3LisKMqcBPdkKlUvtKcg+m+gWw14=;
        b=bDb10CAz16YVYqELII0Fb99RUirPGMzsPyu2sqEXpomx+fJbSreVW5aaxXI/Rcoyyn
         618MrYrOQTSoU1ktzR+a+5w736tYesY6TaLpiOUgu65zwl/o5wPp9iG6FXVZ1zsmFB18
         fMJl7J1K8VSi3b01x8dSo1nfsqYCSQHSzJ3vFR1hU66JKb9lcPxDHCHuRvkn6LK3C8k0
         o8aU8GAc1wAMtElxoSo1FEWG2ZLN6QUkwjtQfEYjIRMmJAfw/9GlRMf4xHolLg4m80bc
         drBdNLmZFJuf6501OK27CdoYHwyb4NREMpJUB/hYvWZ0/jnjIgFU//occTcNtnxJIy7V
         He9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qic7iWF2pSIXBsh3LisKMqcBPdkKlUvtKcg+m+gWw14=;
        b=Y0yG/L9d/32niGRXqR7sJ+cQJewc00N0hMmEDVM4Vjm5Q+ud4CLY3P8gPoOcPRg/Rt
         6X6KJ6uLzTKo0+jNUCpuoWmro0L/Yk5wGjHB92ONqqDni8cWD1hRMMQjzuNaBFH3wLUE
         r9zYWeCd9R+VGMPl7dmbAcv3wb4sLRyhUJqKDCDyOc9aRVFlLXleH/FF6i4ASmgAWX6U
         0PtNHY6fnBkw/RrdfkIrrm/wJy51gFXSq7PX0QOOqgHHY5JoOTmYptjeCfSKavvXFGHY
         lQG9jSUphEqqOO64kerAP6beSw2S3yHD2HI3MVLdQK73/s9+o514y38qHezrV8ElH92Y
         Cv8A==
X-Gm-Message-State: AOAM532renPb+aCc2r5PczCPeKTrElRRCjQ7te7S2GO3X7xa/f5ZwUJO
        swzGzHRX0egmj9Wy4Dhyjad/P3pxqYXj/w==
X-Google-Smtp-Source: ABdhPJyswa8fdND606PGWV3z6b0KwcvbmhV/KewHR9Y+Mn4HLqcNvOqlk5ikIIJ2oYjOtTVBioKObA==
X-Received: by 2002:a17:90b:1804:: with SMTP id lw4mr10713171pjb.234.1632309488377;
        Wed, 22 Sep 2021 04:18:08 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-89.three.co.id. [180.214.233.89])
        by smtp.gmail.com with ESMTPSA id y25sm2329653pfe.28.2021.09.22.04.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 04:18:08 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     wolf@oriole.systems, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] rev-parse: fix mismatch quoting of separator in the message
Date:   Wed, 22 Sep 2021 18:17:45 +0700
Message-Id: <20210922111744.675326-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a quoting mismatch quoting `--` separator in "no usage string
given...." message (`' instead of ``). Fix it.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 builtin/rev-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 22c4e1a4ff..a35dbad6c4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -439,7 +439,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		ALLOC_GROW(usage, unb + 1, usz);
 		if (!strcmp("--", sb.buf)) {
 			if (unb < 1)
-				die(_("no usage string given before the `--' separator"));
+				die(_("no usage string given before the `--` separator"));
 			usage[unb] = NULL;
 			break;
 		}

base-commit: 99c99ed8259bf070cd8ae7b51a94904b7cf5c161
-- 
2.25.1

