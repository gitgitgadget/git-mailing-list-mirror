Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE47CC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08F560231
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhBWSxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 13:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbhBWSwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 13:52:46 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEE4C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 10:52:06 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p3so3430242wmc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 10:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PbvrbKrehyKWp9q+OqLUWw4a3N0hdAa0ZqmeqdSDUsQ=;
        b=nPjBcwtA+2BeeO0Sw+ix5CEaixPPrmoOWU8CQ5U7uFsAx71qC8XycCgOcret2SfSoy
         OsceN3caRgJLML5TCkWIRl4n6JyBXs54FvIyELTAiQIJD9IY1/22nftvxqXMQctAJwVt
         1qecqHow/kp1aelDkoQHnj+Z8G4eOZNRbx2y9LZQf6w93lxKhKbFhrjtZ6LLXskWKdyk
         FQopNUdPlRBfOe2tNYA3UzPVUZW2awUenVrp/e4VIc9rafcr7Elqyi6UrwRKPmB0VgKS
         f3Z9OsAEC2IJIEtdtQ6dg8Xmoqj+fVkTvV37l7Da5CDajokjBZsVBSICE9frAlHFefNH
         R2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PbvrbKrehyKWp9q+OqLUWw4a3N0hdAa0ZqmeqdSDUsQ=;
        b=l1jn3ucCAmxeCuW28nDmJgwLKRLJvPjxheXGEDXViC91fd4b4sNF2Bf4zkTkRImrOh
         SfLlwURwovwvW6zmF3l/oxTFbNst9KbDIeACdGO76ODq/tvoV4o2Nn8cjilehBhtB160
         RDmyXdErhwGC4QSSEMQN/pC0duMEJ0LPq6l9POI0A8S2IB1RxYzxsLx1SdazM/59nVDK
         ras02z+agMfjYp0ASGJ2pA8XR5BqF+Ufre7gWD2Yx31rwLwjR4M6gWsUoJ5CNibP3TUx
         7ltrH+Jz9PW0MmIbTMfOO9Tw0F1E6QRNDZ4uEvrTwMp58/eoNxeYKFAGfYK9vqheuymZ
         rj7A==
X-Gm-Message-State: AOAM530YsPOX05fuMz/IbQgfGMZ0xzBhRbKWtaWk0sAcckDwJx/Yn1F8
        UVN8EXhQ0LuU8kl4dxjgJ7kppGzcITc=
X-Google-Smtp-Source: ABdhPJzBCxzrpbnGNN9u5iOfC2FudEmlDdSxMSiIXNvpemrz8W79M4QN4dY752+hftROA2/aBOsoUw==
X-Received: by 2002:a05:600c:35c6:: with SMTP id r6mr134458wmq.83.1614106324921;
        Tue, 23 Feb 2021 10:52:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1sm33733260wrd.44.2021.02.23.10.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 10:52:03 -0800 (PST)
Message-Id: <pull.969.v2.git.git.1614106322760.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.git.git.1614101746491.gitgitgadget@gmail.com>
References: <pull.969.git.git.1614101746491.gitgitgadget@gmail.com>
From:   "Utku Gultopu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 18:52:02 +0000
Subject: [PATCH v2] doc: `--date` in `git-commit` accepts approxidates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Utku Gultopu <ugultopu@gmail.com>,
        Utku Gultopu <ugultopu@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Utku Gultopu <ugultopu@gmail.com>

Document the fact that the `--date` option in `git-commit` accepts any
date format that is accepted by the `approxidate_careful` function,
which is located in `date.c`.

Signed-off-by: Utku Gultopu <ugultopu@gmail.com>
---
    doc: --date in git-commit accepts approxidates
    
    Without the documentation, it is kind of a "hidden feature", which I was
    able to discover only through online forums.
    
    I guess this patch is not ideal, because instead of properly
    documenting, it refers the user to the code. However I wasn't able to
    find documentation about the "approxidates" which I can link to. Please
    let me know how I can improve it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-969%2Fugultopu%2Fdocument-approxidates-for-date-argument-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-969/ugultopu/document-approxidates-for-date-argument-v2
Pull-Request: https://github.com/git/git/pull/969

Range-diff vs v1:

 1:  9116ad67a0c6 ! 1:  e564d7d9af3d doc: `--date` in `git-commit` accepts approxidates
     @@ Commit message
      
       ## Documentation/date-formats.txt ##
      @@
     --DATE FORMATS
     --------------
     -+DATE FORMATS[[DATES]]
     -+---------------------
     + DATE FORMATS
     + ------------
       
      -The `GIT_AUTHOR_DATE`, `GIT_COMMITTER_DATE` environment variables
      -ifdef::git-commit[]
     @@ Documentation/date-formats.txt
       support the following date formats:
       
       Git internal format::
     -
     - ## Documentation/git-commit.txt ##
     -@@ Documentation/git-commit.txt: OPTIONS
     - 	the commit author is then copied from the first such commit found.
     - 
     - --date=<date>::
     --	Override the author date used in the commit.
     -+	Override the author date used in the commit. The '<date>' can be in
     -+	any format that is accepted by the `approxidate_careful` function
     -+	in `date.c` or the <<DATES, DATE FORMATS>> section below.
     - 
     - -m <msg>::
     - --message=<msg>::
     +@@ Documentation/date-formats.txt: ISO 8601::
     + +
     + NOTE: In addition, the date part is accepted in the following formats:
     + `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
     ++
     ++ifdef::git-commit[]
     ++In addition to recognizing all date formats above, the `--date` option
     ++will also try to make sense of other, more human-centric date formats,
     ++such as relative dates like "yesterday" or "last Friday at noon". For
     ++further details on what kind of formats are accepted, please refer to
     ++the `approxidate_careful` function in `date.c` file in Git source code.
     ++endif::git-commit[]


 Documentation/date-formats.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index f1097fac69a6..b86a5a25fe46 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -1,10 +1,7 @@
 DATE FORMATS
 ------------
 
-The `GIT_AUTHOR_DATE`, `GIT_COMMITTER_DATE` environment variables
-ifdef::git-commit[]
-and the `--date` option
-endif::git-commit[]
+The `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` environment variables
 support the following date formats:
 
 Git internal format::
@@ -26,3 +23,11 @@ ISO 8601::
 +
 NOTE: In addition, the date part is accepted in the following formats:
 `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
+
+ifdef::git-commit[]
+In addition to recognizing all date formats above, the `--date` option
+will also try to make sense of other, more human-centric date formats,
+such as relative dates like "yesterday" or "last Friday at noon". For
+further details on what kind of formats are accepted, please refer to
+the `approxidate_careful` function in `date.c` file in Git source code.
+endif::git-commit[]

base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
-- 
gitgitgadget
