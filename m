Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDE4C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 14:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C1520736
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 14:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKNgqAFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgDXOUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727853AbgDXOUM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 10:20:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8D7C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 07:20:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k13so11045831wrw.7
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2ju28tZUdkt1qflRc/lD6Cn3XqfRGn8rlj2LgOqnK/g=;
        b=BKNgqAFO6vyCwMQj96K9mnoWiulmtvhe+tXqAgEm6CH8kp78muyUoJ7ihKbGCKDgCn
         YwfNgT+Jpdf7jrrhGgacbjK5c7WEGuAWjii9HoPFfsyX+42t+U1raWwIc3zhRjyL1ySw
         1kheUSRmjTSCYAohabAKB7ABQO3x4R+brnfpAisM8tsQof7Wz0SGF8F9FeXbFaQV/EJA
         vagbxxSUOkdNp0mjan8Y3ylyijr0/U0hoUtX4Dy8IIeOedLRbAx5FzGnaL3E6lygoJKM
         DoLikuA5Z4KPxN1DFb+4PM8/3NSstdNvgedi4N3PU5LrkiZoMpD7KFc+idU6DtFf/sol
         qesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2ju28tZUdkt1qflRc/lD6Cn3XqfRGn8rlj2LgOqnK/g=;
        b=r9z7kB+8S0fyhUtp6ZP/ZfsCKJaTGa9gwaYz/59+Fsh3eFVbH6EPjXKLJPCe4t35HC
         sSedr3HgDmGy6WRx0/DSOzmRrdyskz1xDXLBeW09N72IIZOz4pquMR2GTYuV+8rVUfaU
         DjsRQrU1glb2lozDH20zE5Hdpykj6R8C1sUFcFVuR9mIkhoQyOJtjK6+a8gu6Qp6o5fy
         ekeRLrXInR7HhaPH0T15nUFQlunoMDB/a+ajhVWv6Wjpf4QtZ6CRv5F0qGc1c27+Hp9p
         JiQ5hKwMOj3phKfSIk5aH82YBGRl7TFIbb+Y2FN51qD1fVbCDEJbB7mZPHLPFuvFgEuH
         tcRg==
X-Gm-Message-State: AGi0PuY1xR/qF/qQEAH9fFsRzESBCrjGOYFBEN41HcnVCVDIf/waKDgA
        +2J/WLgiJrXiFutXtMItXFLMilLs
X-Google-Smtp-Source: APiQypIUepHW9OJb/2Ox/paTvcjLlmpriysBjWX+zLl5eHgeRnyY5zamR1XqryRR3US4N6gTWq5m8w==
X-Received: by 2002:adf:f24c:: with SMTP id b12mr11431856wrp.359.1587738009423;
        Fri, 24 Apr 2020 07:20:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm9254297wrg.58.2020.04.24.07.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:20:08 -0700 (PDT)
Message-Id: <pull.618.git.1587738008248.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 14:20:08 +0000
Subject: [PATCH] push: anonymize URLs in error messages and warnings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like 47abd85ba0 (fetch: Strip usernames from url's before storing
them, 2009-04-17) and later 882d49ca5c (push: anonymize URL in status
output, 2016-07-13), and even later c1284b21f243 (curl: anonymize URLs
in error messages and warnings, 2019-03-04) this change anonymizes URLs
(read: strips them of user names and especially passwords) in
user-facing error messages and warnings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    push: anonymize URLs in error messages and warnings
    
    A token used by GitGitGadget was leaked by this bug. Thankfully, it
    seems nobody noticed, and I installed a patched Git on the self-hosted
    build agent so that this won't happen anymore.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-618%2Fdscho%2Fanonymize-push-url-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-618/dscho/anonymize-push-url-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/618

 builtin/push.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6dbf0f0bb71..bd2a2cbfbd7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -340,6 +340,7 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 {
 	int err;
 	unsigned int reject_reasons;
+	char *anon_url = transport_anonymize_url(transport->url);
 
 	transport_set_verbosity(transport, verbosity, progress);
 	transport->family = family;
@@ -364,11 +365,12 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 	trace2_region_leave("push", "transport_push", the_repository);
 	if (err != 0) {
 		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_ERROR));
-		error(_("failed to push some refs to '%s'"), transport->url);
+		error(_("failed to push some refs to '%s'"), anon_url);
 		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_RESET));
 	}
 
 	err |= transport_disconnect(transport);
+	free(anon_url);
 	if (!err)
 		return 0;
 

base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
-- 
gitgitgadget
