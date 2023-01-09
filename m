Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E6FC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 17:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbjAIRff (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbjAIRfP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 12:35:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4F33FCAE
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 09:34:32 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r2so8970646wrv.7
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 09:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ER4pX251Yuq9/dEAQrx6GOQ3FKhWoTfLJnuozml3aM=;
        b=oHcezrYvzuUuXYTtheHyWonjRfADSJKfibzXMR91H4ZTUuWnP7AwlBP5iFnVIOWMpV
         P+Q4i972WJI/g20FrFAtHAnTD3xmoSAHKmdh1ZGLa7RS9RSsTv9JusOKsfrQe62PJF6h
         2XWwV6Kkh00IY/ORviQdvOC71oGjJIBMVmpnEXMCVrEawW0GZzTKTAiz6YlGyLukCB/h
         BhIEdr9QYHAfMgYVZRmP+sHL+kathAyDvK8T6GGbpKUUHvAxAU+605BP/DLabzBnbCDB
         Xyg0OmTtLsjKFzi0GdMe3MyCQa5PYKCeQlESnRBle6gDmRJuy4M51O6lPLOSetSIoqC1
         W3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ER4pX251Yuq9/dEAQrx6GOQ3FKhWoTfLJnuozml3aM=;
        b=Tx0usRuQeWvhhFmXeCrMdH5jRfDc/oN8R0uYNfi19PYq6g+tG9/kLjHFaSNecXRptI
         1htROuvsk+bLiMEerxYWL6loMgAXlvPR4QMpn7eCWO510xPzusgVn3CuvN6+5w88CeI5
         364Vof4MZEewIdQ0hkgrHd4SZmniD+42J2EnvoW9rzn83I38dXSTW2Zpu6TLxU+EOmlz
         pfvMrcrJnhTbWdy4zQoMWvAlrcpqpzsbY88bSoNEXPNwV9jnIoecEitlHZ+3oDETHLff
         8IHYSY9dv26KL6G4simIVHCkLSWzLqB1nMHjfdmZtuRJvqA1AZ4USqt99zjnagwueUhe
         OWCA==
X-Gm-Message-State: AFqh2konDAn2tW6uEjqEhx7zqmxM/Evy5MOkB4twd37oLpAHczE6Gs86
        vlF9CYjqsaeDBa1fXNe7s+THvMYWRls=
X-Google-Smtp-Source: AMrXdXt9zguXI9MnSq7zinswF80OXRp3malMudf4PfeUaA4m/WXwPCc8ZTDOwSGMppX/UPt647n6LA==
X-Received: by 2002:a5d:6383:0:b0:2bb:dad4:9525 with SMTP id p3-20020a5d6383000000b002bbdad49525mr5195069wru.10.1673285670030;
        Mon, 09 Jan 2023 09:34:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1-20020adf9b01000000b0028e55b44a99sm8924882wrc.17.2023.01.09.09.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:34:29 -0800 (PST)
Message-Id: <pull.1429.v2.git.git.1673285669004.gitgitgadget@gmail.com>
In-Reply-To: <pull.1429.git.git.1673203153257.gitgitgadget@gmail.com>
References: <pull.1429.git.git.1673203153257.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Jan 2023 17:34:28 +0000
Subject: [PATCH v2] merge: break out of all_strategy loop when strategy is
 found
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

strncmp does not modify any of the memory.
Once we find a match, there is no point
in trying to find the second match
in the inner loop.

Break out of the loop once we
find the first match.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    merge: break out of all_strategy loop when strategy is found
    
    strncmp does not modify any of the memory, so looping through all
    elements is a waste of resources.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1429%2FAtariDreams%2Fexit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1429/AtariDreams/exit-v2
Pull-Request: https://github.com/git/git/pull/1429

Range-diff vs v1:

 1:  82c1d021b2c ! 1:  d93d4aff780 merge: break out of all_strategy loop when strategy is found
     @@ Metadata
       ## Commit message ##
          merge: break out of all_strategy loop when strategy is found
      
     -    strncmp does not modify any of the memory,
     -    so looping through all elements is a waste of resources.
     +    strncmp does not modify any of the memory.
     +    Once we find a match, there is no point
     +    in trying to find the second match
     +    in the inner loop.
     +
     +    Break out of the loop once we
     +    find the first match.
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
       ## builtin/merge.c ##
      @@ builtin/merge.c: static struct strategy *get_strategy(const char *name)
     + 		for (i = 0; i < main_cmds.cnt; i++) {
       			int j, found = 0;
       			struct cmdname *ent = main_cmds.names[i];
     - 			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
     --				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
     --						&& !all_strategy[j].name[ent->len])
     -+				if (!strncmp(ent->name, all_strategy[j].name,
     -+					     ent->len) &&
     -+				    !all_strategy[j].name[ent->len]) {
     +-			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
     ++			for (j = 0; !found && j < ARRAY_SIZE(all_strategy); j++)
     + 				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
     + 						&& !all_strategy[j].name[ent->len])
       					found = 1;
     -+					break;
     -+				}
     - 			if (!found)
     - 				add_cmdname(&not_strategies, ent->name, ent->len);
     - 		}


 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0f093f2a4f2..74de2ebd2b3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -188,7 +188,7 @@ static struct strategy *get_strategy(const char *name)
 		for (i = 0; i < main_cmds.cnt; i++) {
 			int j, found = 0;
 			struct cmdname *ent = main_cmds.names[i];
-			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
+			for (j = 0; !found && j < ARRAY_SIZE(all_strategy); j++)
 				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
 						&& !all_strategy[j].name[ent->len])
 					found = 1;

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
