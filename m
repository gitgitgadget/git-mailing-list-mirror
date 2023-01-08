Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FFAC54EBD
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 18:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjAHSjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 13:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHSjR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 13:39:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C030BBF4F
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 10:39:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso4984156wmq.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 10:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kPp7T7vYiOLay9IM86Lbb/f5QAcotBuGsNEbxf448UQ=;
        b=p/UmkaqdsTkVRhZwbQ6JuvyoYOW0k3gyWgOhngYHXB8ZRLBQtveneJCh0ub3eiVkUi
         CpYCoPrSX5RJYamROJ05wodTQ6bSeAWtF3tocizdMcv56GvNPA7u19DwvGQN0APr2OQd
         bnHblr/mMyK2rqhozW+ErxnAX6l3r1cn3YPDINUDvaLUp8b4CWncCUvd4OICmKkEXFIk
         GNYALcJ5U4Q2MDwmC2zoJzsBt2uFDFsa33wIjZloRAViYaRRZdoPu4c0dxEuBi9iedfm
         MyN/0S6mftTzL0dp4QolJaWaSyFrR4WCSdv+FLIMGzQxYADzXhDWbU+jd204IpL2ZOnm
         XHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPp7T7vYiOLay9IM86Lbb/f5QAcotBuGsNEbxf448UQ=;
        b=sivy0SFv5tY+PsKolCC5o4dIBwrHh9M8OtaoSc6CA3QevH0dTfD6rINVQ0wz+PxoTv
         wrJ6X5Goso4/JDR3VZVLqNcSpBZVZk0ovSPdkeaF01Byyq49xaTzwt+4yf2KVcbZamut
         ejIkHQQ+ydqT49eYYknedGWUXXubLK19xtPAlvsB1GMy0xYTrxr1dDrh6SFYaKXQYwbJ
         nNFqzKbbLAiNFwG2qBqnb9VXUPZ8cYat+fIOHVEP5wMoi2rCbABx45o4YZuPXTZY5lJb
         cWx2tLrF5tUSPg2eu6NbfTQlcVi2nSch/tW/pU9qFmz74MFYRzACfsRfBXvSuyrtxP6f
         vSzw==
X-Gm-Message-State: AFqh2krTFx/ImdT9eRXRqe8C8rSv+FXXzs716FYZeO4cnnR+ihc/hlN3
        M7dKKxpR+oU8C9nFsOIUjICMj9rVlp0=
X-Google-Smtp-Source: AMrXdXsdAIwxg2BTjK39rWFayZt/2/5qJGL0yXqpqVaxEauLKKyZQFVHr+TM4jJRO9702lRYTzp5kg==
X-Received: by 2002:a05:600c:1e18:b0:3d2:5e4e:701 with SMTP id ay24-20020a05600c1e1800b003d25e4e0701mr44369643wmb.31.1673203154129;
        Sun, 08 Jan 2023 10:39:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b003d01b84e9b2sm9760787wms.27.2023.01.08.10.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:39:13 -0800 (PST)
Message-Id: <pull.1429.git.git.1673203153257.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Jan 2023 18:39:13 +0000
Subject: [PATCH] merge: break out of all_strategy loop when strategy is found
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

strncmp does not modify any of the memory,
so looping through all elements is a waste of resources.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    merge: break out of all_strategy loop when strategy is found
    
    strncmp does not modify any of the memory, so looping through all
    elements is a waste of resources.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1429%2FAtariDreams%2Fexit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1429/AtariDreams/exit-v1
Pull-Request: https://github.com/git/git/pull/1429

 builtin/merge.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0f093f2a4f2..5ab0feb47b6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -189,9 +189,12 @@ static struct strategy *get_strategy(const char *name)
 			int j, found = 0;
 			struct cmdname *ent = main_cmds.names[i];
 			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
-				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
-						&& !all_strategy[j].name[ent->len])
+				if (!strncmp(ent->name, all_strategy[j].name,
+					     ent->len) &&
+				    !all_strategy[j].name[ent->len]) {
 					found = 1;
+					break;
+				}
 			if (!found)
 				add_cmdname(&not_strategies, ent->name, ent->len);
 		}

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
