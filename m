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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0FFC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 11:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A10D60BD3
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 11:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhG2LDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbhG2LC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 07:02:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A09C0613CF
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 04:02:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p21so7591533edi.9
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdeBlvQkVlriuJKnKDsspYyaeNK1dYQ7pPL/h49czeo=;
        b=cLU57bnAdLIeyhDfLCa8FtyX1S104RqPsb4xVrc7We+KiPw7DlLTIItgAOkd/pkNFL
         AwLI3/g9XFS1wDV8ozXIAX0ke8f7e2g63xZVuOSGf3gTUdpphrIvaJC/rASqNEeRq5A2
         NVUFqt0ojFK6BCpcsMRM2alxoKwiT1PLZMggL1Q8cv7KHavJBBM1+0gnajnnJB7ZJpFv
         0boTYAVveucB8Vqu+1qQt+armXJ2vHq/K7Xvwc0ns8H5VDwAQZchWrebiRgXzfkm+5i0
         3o8V2aqqlAXBO3ElazCII3h2Xf3UIfEj8mLZgb+C64PUVx8nwBpVXBAQfAR4oky5/dYF
         wcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdeBlvQkVlriuJKnKDsspYyaeNK1dYQ7pPL/h49czeo=;
        b=N7o/N2Zu7Xp3BaWrEunpntsc3j0InnpTYpsssT3/S6LduP41yB144gX0maJNdolqx4
         Q4IdZD/+CuUiFJS4LJpsqTWjWwjRknWQXSkrfSWRXPkA70VDbojSH7Flr0U4p1QkrHJi
         17dT5xgry28zgF5tEaJmXEgFUlRZKBOvvBFkmz1tvkLQ8BRUW4+MMTSOG53LuW89egx9
         yn/5nTB0FkmC4LirGEX6xnApuySa3hiuRJjtJ8JUPwuEVwN9U+joBS5FMG1YaNqioh4G
         llkioYfKYEQJLhrue9hDZs3LxS/uOlJ3C7yof/ueP84HaLAePAbHOQmOOK2JDfSBs7OT
         hXKw==
X-Gm-Message-State: AOAM530jq9JAJPXqNmRCagMrB0Kdu+lvh1wFpcvCD/EYCauv/nCoT8Dz
        mmSP9Gfa91P+Tw1oDooyfUe3Y/9fmeo=
X-Google-Smtp-Source: ABdhPJwPAdbvYhjneDEgEsmdxPQ8my/Nuf8FOvMHevcVuk6EcB6WxvRDth+We3ydtcdiihkc3MkTqQ==
X-Received: by 2002:a05:6402:430b:: with SMTP id m11mr5370864edc.55.1627556575112;
        Thu, 29 Jul 2021 04:02:55 -0700 (PDT)
Received: from localhost.localdomain ([212.102.57.4])
        by smtp.gmail.com with ESMTPSA id o3sm1034356edt.61.2021.07.29.04.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 04:02:54 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Ackermann <th.acker@arcor.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation: render special characters correctly
Date:   Thu, 29 Jul 2021 13:02:52 +0200
Message-Id: <20210729110252.116214-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three hyphens are rendered verbatim, so "--" has to be used to produce a
dash.  There is no double arrow ("<->" is rendered as "<→"), so a left
and right arrow "<-->" have to be combined for that.

So fix asciidoc output for special characters.  This is similar to fixes
in commit de82095a95 (doc hash-function-transition: fix asciidoc output,
2021-02-05).

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/git-fetch.txt   | 2 +-
 Documentation/gittutorial.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 9067c2079e..550c16ca61 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -133,7 +133,7 @@ remember to run that, set `fetch.prune` globally, or
 linkgit:git-config[1].
 
 Here's where things get tricky and more specific. The pruning feature
-doesn't actually care about branches, instead it'll prune local <->
+doesn't actually care about branches, instead it'll prune local <-->
 remote-references as a function of the refspec of the remote (see
 `<refspec>` and <<CRTB,CONFIGURED REMOTE-TRACKING BRANCHES>> above).
 
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 59ef5cef1f..0e0b863105 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -322,7 +322,7 @@ initiating this "pull".  If Bob's work conflicts with what Alice did since
 their histories forked, Alice will use her working tree and the index to
 resolve conflicts, and existing local changes will interfere with the
 conflict resolution process (Git will still perform the fetch but will
-refuse to merge --- Alice will have to get rid of her local changes in
+refuse to merge -- Alice will have to get rid of her local changes in
 some way and pull again when this happens).
 
 Alice can peek at what Bob did without merging first, using the "fetch"
-- 
2.32.0

