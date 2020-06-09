Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAA3C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 03:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4752078C
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 03:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlsoJI3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgFIDTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgFIDTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 23:19:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56878C03E969
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 20:19:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so19608106wru.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 20:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VOE7pYLGWGTSvf+fF5kbSYdJOLKLbB0VmxrdjcvSrRE=;
        b=qlsoJI3sS7TtqjVPPBKBKGYOPFeKiRqKE7Gi92E15Rp19u+yVXfCo/UYIltgZZ5eG8
         pPJewH27tgn16Kdzy59YFXXdsDXcPmAqekWFrFX8wlRH9MYbHrO58Gxy8G3MPN7kfIow
         84GF/5aiMxuYG20qsVEVk67k6g2rkDcb2d9AY6oT27zSI2BKOWPGoqlbDeTFBqsqrYZh
         REVSZ5TvhqUTLEEt8TA4UcR8CZS9X5fZVWbnf0w2rF9TLVZUnry4RFYl5FIOzG6BpnhY
         kGe6aVeUiSM7ZPkZL0BEszAit8uQH0UqTAH/oSikiNpS6nOyDfHcI5CqT+HxFwkbByVl
         ZE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VOE7pYLGWGTSvf+fF5kbSYdJOLKLbB0VmxrdjcvSrRE=;
        b=Q0qK+n8aceKOFXl99jGk3FiLbj0dpugdTCuQokCAtcTxuC3gXNc/XDTm08qGuhYBvT
         kUdIoYHKT9fSw4TcdPpnJPKowy7X1nz0QvCddpXakEyK7MQRLnyqEDcokL73kTYt3hG6
         4M/uValPkwwopftcDEMsLOMKhFfSpdmdBAtW0LOZYJFSXs6H2lt7TPkvpnd1Jnw9a2yq
         wlSC+wViZb7V5sWyQxKibOdBqffMhYShDJog8V3GNFgMCZspuCkoYs3eXDldKzM2AA0Q
         6EV9MBKkwDa7Rgc8ONsLJo+XHA2tumXaKcgFpc4o6m1rhVkL/7GqHjJxPQI91NYMVd46
         plCA==
X-Gm-Message-State: AOAM532vPwXwidJB2YWG3tJfG8hqPnhnZ79b7JRfZaF95SQiRkzLEd4c
        0gzVJrC0TZh/taLCYtm6GeWwmHSK
X-Google-Smtp-Source: ABdhPJxe+dfo0xRgoDWUpNIWLZ36pWyhZ0YasQANe+x5mO2GoDIPs1SKdkYHcbJL8WE2T/Y5PAZ/Pg==
X-Received: by 2002:a05:6000:1083:: with SMTP id y3mr1874261wrw.425.1591672754806;
        Mon, 08 Jun 2020 20:19:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3sm1385142wmg.44.2020.06.08.20.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 20:19:14 -0700 (PDT)
Message-Id: <pull.781.v2.git.git.1591672753363.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.git.git.1588901124066.gitgitgadget@gmail.com>
References: <pull.781.git.git.1588901124066.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 03:19:12 +0000
Subject: [PATCH v2] Enable auto-merge for meld to follow the vim-diff beharior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunlin <sunlin7@yahoo.com>, "lin.sun" <lin.sun@zoom.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "lin.sun" <lin.sun@zoom.us>

The mergetool "meld" does NOT merge the no-conflict changes, while the
mergetool "vimdiff" will merge the no-conflict parts and highlight the
conflict parts.
This patch will make the mergetool "meld" similar to "vimdiff",
auto-merge the no-conflict parts, highlight conflict parts.

Signed-off-by: Lin Sun <lin.sun@zoom.us>
---
    Enable auto-merge for meld to follow the vimdiff beharior
    
    Hi, the mergetool "meld" does NOT merge the no-conflict changes, while
    the mergetool "vimdiff" will merge the no-conflict changes and highlight
    the conflict parts. This patch will make the mergetool "meld" similar to
    "vimdiff", auto-merge the no-conflict changes, highlight conflict parts.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v2
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v1:

 1:  739e69e6631 ! 1:  6e98a10bfa9 Enable auto-merge for meld to follow the vim-diff beharior
     @@ Commit message
          This patch will make the mergetool "meld" similar to "vimdiff",
          auto-merge the no-conflict parts, highlight conflict parts.
      
     -    Signed-off-by: Lin Sun <sunlin7@yahoo.com>
     +    Signed-off-by: Lin Sun <lin.sun@zoom.us>
      
       ## mergetools/meld ##
      @@ mergetools/meld: merge_cmd () {


 mergetools/meld | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f883..318653cc9f7 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -10,10 +10,10 @@ merge_cmd () {
 
 	if test "$meld_has_output_option" = true
 	then
-		"$merge_tool_path" --output="$MERGED" \
+		"$merge_tool_path" --auto-merge --output="$MERGED" \
 			"$LOCAL" "$BASE" "$REMOTE"
 	else
-		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+		"$merge_tool_path" --auto-merge "$LOCAL" "$MERGED" "$REMOTE"
 	fi
 }
 

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
-- 
gitgitgadget
