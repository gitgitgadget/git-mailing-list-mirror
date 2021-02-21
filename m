Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF2AC433DB
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 13:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3324960295
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 13:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBUNYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 08:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhBUNYm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 08:24:42 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DE1C061574
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 05:24:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h98so11381092wrh.11
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 05:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/1jTpePSU1qj5xOJXQFqX06rXNu7EEsBKvJskSdADnc=;
        b=LBePNMX4X0mjWhb3h7ag8WoSJP0P5i+bTc/34CT27iy66yjLy4Lx3TnlY+t8GV+1S/
         pJnuCTalixeQ6SUcg4r5FiAk8FPVTp48SHkX4+R6oijCDmaakd9byBNm6vlfD5H4hzaD
         8g3tDRLMhkXpiimSe1T+onnzpaJwAyyp0tv5Xfgi6yeOsAf7ecIhI5B60vdyDKLOz/G6
         Y5ROMo07qOVvSVMQE7FRfJa47bixHGzlt2GZODe0NIIjoS7JtQ9E2Vbhbzl3pGZ4D5zJ
         G6ujDPINUX/jHeIdaH+ed9UOD3sPtb+beaYKMzRpgIrnnOFen8560Lg6Emwii2xMg1aY
         HfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/1jTpePSU1qj5xOJXQFqX06rXNu7EEsBKvJskSdADnc=;
        b=JoAECzL3oOqusZCTjiq1fUK8zg3aHr+dmcV+T0dZ1fL8oBKbqtpxnt5vZ+KD4+6+m9
         e365kxvACPbkpG2fsW+fgtoywTRrxJ4qneyGnLeHxwsfOZF4Hpz4rvC2vZt4+15muDxA
         XEmYQC5QYlRcgfXJ9R67XvFvWl/aIuUoVFRL/uUZvTxgVys8Ache+xgiX8FxD33FHOVl
         kvNfJr9thjTGVNsUBr2joQ34e55+AZbp41Rd1HmPMwFc+cK/gUAS5gwl7TYCkOLgp+5N
         lU3VCj6090ttxFnWwJqBpondDGjklyknU+sLOdQ7Gx7SRBC0bthBfeZtfwnHFviuccZq
         UEYg==
X-Gm-Message-State: AOAM531L7kPhTZhcxLzyGAEgj0hZuiD031eZtY6tQHSW9hizapGqa2xE
        A8IexAzODeMuPEkusZFAPgbSMFWrxQQ=
X-Google-Smtp-Source: ABdhPJzpx1oIPnRKI0sQXo4G+VAgz07ouutJhXaATHJtSjsBmR+46yfDdj4ZaMJNfNPnxQZCq7larA==
X-Received: by 2002:a5d:4c49:: with SMTP id n9mr4370891wrt.168.1613913839249;
        Sun, 21 Feb 2021 05:23:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14sm24863379wrt.89.2021.02.21.05.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 05:23:58 -0800 (PST)
Message-Id: <pull.872.v2.git.1613913838248.gitgitgadget@gmail.com>
In-Reply-To: <pull.872.git.1612897624121.gitgitgadget@gmail.com>
References: <pull.872.git.1612897624121.gitgitgadget@gmail.com>
From:   "Christian Walther via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Feb 2021 13:23:57 +0000
Subject: [PATCH v2] doc: mention bigFileThreshold for packing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Walther <cwalther@gmx.ch>,
        Christian Walther <cwalther@gmx.ch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Walther <cwalther@gmx.ch>

Knowing about the core.bigFileThreshold configuration variable is
helpful when examining pack file size differences between repositories.
Add a reference to it to the manpages a user is likely to read in this
situation.

Capitalize CONFIGURATION for consistency with other pages having such a
section.

Signed-off-by: Christian Walther <cwalther@gmx.ch>
---
    doc: mention bigFileThreshold for packing
    
    I recently spent a lot of time trying to figure out why git repack would
    create huge packs on some clones of my repository and small ones on
    others, until I found out about the existence of the
    core.bigFileThreshold configuration variable, which happened to be set
    on some and not on others. It would have saved me a lot of time if that
    variable had been mentioned in the relevant manpages that I was reading,
    git-repack and git-pack-objects. So this patch adds that.
    
    Changes in v2:
    
     * Move additions to the CONFIGURATION section at the bottom.
     * Reword a little after realizing that there are more configuration
       variables affecting packing.
     * Capitalize CONFIGURATION for consistency with other pages having such
       a section.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-872%2Fcwalther%2Fdeltadoc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-872/cwalther/deltadoc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/872

Range-diff vs v1:

 1:  20b9a56d94b7 < -:  ------------ doc: mention bigFileThreshold for packing
 -:  ------------ > 1:  027d1038fbb1 doc: mention bigFileThreshold for packing


 Documentation/git-pack-objects.txt | 11 +++++++++++
 Documentation/git-repack.txt       |  9 ++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 54d715ead137..f85cb7ea934c 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -400,6 +400,17 @@ Note that we pick a single island for each regex to go into, using "last
 one wins" ordering (which allows repo-specific config to take precedence
 over user-wide config, and so forth).
 
+
+CONFIGURATION
+-------------
+
+Various configuration variables affect packing, see
+linkgit:git-config[1] (search for "pack" and "delta").
+
+Notably, delta compression is not used on objects larger than the
+`core.bigFileThreshold` configuration variable and on files with the
+attribute `delta` set to false.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 92f146d27dc3..fbd4b4ae0677 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -165,9 +165,12 @@ depth is 4095.
 	Pass the `--delta-islands` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
 
-Configuration
+CONFIGURATION
 -------------
 
+Various configuration variables affect packing, see
+linkgit:git-config[1] (search for "pack" and "delta").
+
 By default, the command passes `--delta-base-offset` option to
 'git pack-objects'; this typically results in slightly smaller packs,
 but the generated packs are incompatible with versions of Git older than
@@ -178,6 +181,10 @@ need to set the configuration variable `repack.UseDeltaBaseOffset` to
 is unaffected by this option as the conversion is performed on the fly
 as needed in that case.
 
+Delta compression is not used on objects larger than the
+`core.bigFileThreshold` configuration variable and on files with the
+attribute `delta` set to false.
+
 SEE ALSO
 --------
 linkgit:git-pack-objects[1]

base-commit: 2283e0e9af55689215afa39c03beb2315ce18e83
-- 
gitgitgadget
