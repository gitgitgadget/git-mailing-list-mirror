Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22129C433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 00:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BDC20775
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 00:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhPTTQkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgFIAXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731516AbgFIAXr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 20:23:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419EFC03E969
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 17:23:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y17so19324404wrn.11
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 17:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yU/twC6SmMSAnH2hoMtMALpdRvC9YeUeuM69L1DilzU=;
        b=BhPTTQkWG8TMCeIaffDqGsnGVy/TnjhU5Xub5Cz+TalycmQ+gxn4NJV70dk80eM4is
         Q02xczO0ZUckEaUBD3GtPl058yTMW+JPTt0lCaSSxC+8Yb8RJRFW0Ck7xYmOrzjbOwfQ
         1TL6h7NU4VJofFM6uzJalOtvy+EPv5TQWlv9gW7ZzecM1AUKQwu9LdE4NByBdGhIL/Wn
         gTO260+AwFTNDhGQdxBJ6h6X4WP5sC2tKsMX9rClu9fUXAVi4Mh0oU4jxkGLwosJWIID
         XprCNJqjyeYaaqCRqVwvnN1HkOSIOgz1LRxzOZi92QCXkjnqQt07pN40kVPUzThJ/ylD
         Oheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yU/twC6SmMSAnH2hoMtMALpdRvC9YeUeuM69L1DilzU=;
        b=H/r4PgsJnz3dv8Kw0SYQGDXO+gl+/eZ8lDYuCPnJ3muiz13q/AzcpgqBn0pIVqKVkg
         XTMqhWDMZmB276wP81+32sOHo7I2UpVT2g8JA0g8SjBi51hNWikcFQvatwZr3/WV3EUH
         voexD7VBDNg68G6IRTkNfH9bkQv9tl0YAdKgHQPE4Mt9nxBirGWwtIAi9eE6aVJUM4WI
         Hll/G94rJDt/gP8ezBavkhLcOLVHHV0uvSPpP07QxL46esJV3g7vScOtknpooj4NChGv
         ULaQvFq4SbhkCynaq/jyTt94PbuJWqOGMDUeOVh7W/eQ5z8CLicIza2zPApSwPa9G08O
         P9hw==
X-Gm-Message-State: AOAM532XOSp3Hvh2pN88c5uJ1fLFt12Z+N+hbCNPRihrp/I7cecc8SPI
        b0GhiH0y1iFduWnkjMImJ6Ygj6If
X-Google-Smtp-Source: ABdhPJyozf65F8LPO0Sl+pkTZfutsgoPCFDglsJgpIn2w9hTlFaxLiXdADMeq2cs0CbcK924WZqtIQ==
X-Received: by 2002:a05:6000:100e:: with SMTP id a14mr1319156wrx.349.1591662225854;
        Mon, 08 Jun 2020 17:23:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k64sm1093943wmf.34.2020.06.08.17.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 17:23:45 -0700 (PDT)
Message-Id: <pull.652.v2.git.1591662224566.gitgitgadget@gmail.com>
In-Reply-To: <pull.652.git.1591581739031.gitgitgadget@gmail.com>
References: <pull.652.git.1591581739031.gitgitgadget@gmail.com>
From:   "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 00:23:44 +0000
Subject: [PATCH v2] gc: recommend `git gc --prune=now` instead of `git prune`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Lin <johnlinp@gmail.com>, John Lin <johnlinp@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Lin <johnlinp@gmail.com>

`git prune` is a plumbing command and should not be run directly by
users. The corresponding porcelain command is `git gc`, which is
mentioned in the man page of `git prune`.

Signed-off-by: John Lin <johnlinp@gmail.com>
---
    Recommend "git gc --prune=now" instead of "git prune"
    
    Signed-off-by: John Lin johnlinp@gmail.com [johnlinp@gmail.com]
    
    Fix according to #642.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-652%2Fjohnlinp%2Ffix-git-gc-warning-message-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-652/johnlinp/fix-git-gc-warning-message-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/652

Range-diff vs v1:

 1:  83b7137abfd ! 1:  42aa6380067 Recommend "git gc --prune=now" instead of "git prune"
     @@ Metadata
      Author: John Lin <johnlinp@gmail.com>
      
       ## Commit message ##
     -    Recommend "git gc --prune=now" instead of "git prune"
     +    gc: recommend `git gc --prune=now` instead of `git prune`
     +
     +    `git prune` is a plumbing command and should not be run directly by
     +    users. The corresponding porcelain command is `git gc`, which is
     +    mentioned in the man page of `git prune`.
      
          Signed-off-by: John Lin <johnlinp@gmail.com>
      


 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8e0b9cf41b3..74185eac917 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -692,7 +692,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
-			"run 'git prune' to remove them."));
+			"run 'git gc --prune=now' to remove them."));
 
 	if (!daemonized)
 		unlink(git_path("gc.log"));

base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
-- 
gitgitgadget
