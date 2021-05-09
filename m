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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960AFC433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3CD61424
	for <git@archiver.kernel.org>; Sun,  9 May 2021 09:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhEIJLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 05:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhEIJLt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 05:11:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A57EC061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 02:10:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i9so12437733lfe.13
        for <git@vger.kernel.org>; Sun, 09 May 2021 02:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZEmhHhEATACuRzuGFHB8S3zKcGrgio/GrudcUquYU4=;
        b=Nbusf4KbaJK+v/6IMhfTjSkPcP8lOvRh2xNvR8SO9c8UwiWgD6iABakxnNDb07gmpH
         gzoAJU7sAwo/AvAF5n1ht2UHxWnB2cH247eHWGK6Jpx8W2q6VW333zqqfEnMvakSUbcm
         /Oj2a/iIZRp1+My2q1KwPlWtCnJEum4sOb/gRjTDjPpi3MezisIDYS/zhpPAFTnr6PlT
         E4x+du0272anz1edeby3IytsEGDTfaw7Owt6JWndENhH+xxrTwVWZvUzoA9iezoFFv23
         7Z55sjkP05dCp4NdZyWAG+HZ9ORPlnr09DFrLIPQ1/NsUPPSfi9NMDPkwJfwjWtPweKZ
         +XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZEmhHhEATACuRzuGFHB8S3zKcGrgio/GrudcUquYU4=;
        b=no2NqspO7E085qe0TQxBvLpu0DMILGuLzFMjtIObhDaBjBeB5f7j7Z1RQVOTN5w4Ib
         nqqyilr/9Rru/a9yHD6AV553MwWXpkyLaKFDiK5x+hoBczM2ToqEXqQrGYTJVHC/ztYE
         l1Kj7Uu0wOq9w2ZIjwmk6OTYOfUfiPQ+4xd8U83PJrFoLqclByiJ0+WB2WeoD7CMsWab
         qkoS81Br/CPHKpkvM9oqTkzJRnxDrIljjXqtc/u1KG12Thzifv+Hep2pPpUXyQ+gafDP
         /R94pF2WffDFkxkNGJRY4P96ydi4+GSX3aexZsdZ7iIn/51C+z9OD50theeC6j6BLJOv
         e8Dw==
X-Gm-Message-State: AOAM530YXg9zFSTZskJV6Kiu0F/X+nGV0xet7LQrEbdspfLGG7H1KR3y
        Ha1XBcnu9b/qAQKEtLvU1cRfwu/aFjg=
X-Google-Smtp-Source: ABdhPJybM/rD2iHFW0HIOT7GxE06qmj44SCZWXbYotRFThpL3u8QNo2BaL4W6lWxdjxN6JdTgKrggw==
X-Received: by 2002:a19:c143:: with SMTP id r64mr13214136lff.563.1620551443720;
        Sun, 09 May 2021 02:10:43 -0700 (PDT)
Received: from localhost.localdomain (81-231-136-235-no600.tbcn.telia.com. [81.231.136.235])
        by smtp.gmail.com with ESMTPSA id h9sm1839164lfu.305.2021.05.09.02.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 02:10:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/2] pretty-formats.txt: add missing space
Date:   Sun,  9 May 2021 11:10:00 +0200
Message-Id: <3d06c3beee0299db369f1dd859b092d529bd6846.1620551314.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
In-Reply-To: <cover.1620551314.git.martin.agren@gmail.com>
References: <cover.1620551314.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of "%ch" is missing a space after "human style", before
the parenthetical remark. This description was introduced in b722d4560e
("pretty: provide human date format", 2021-04-25). That commit also
added "%ah", which does have the space already.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index cd697f508c..58bb279528 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -208,7 +208,7 @@ The placeholders are:
 '%ci':: committer date, ISO 8601-like format
 '%cI':: committer date, strict ISO 8601 format
 '%cs':: committer date, short format (`YYYY-MM-DD`)
-'%ch':: committer date, human style(like the `--date=human` option of
+'%ch':: committer date, human style (like the `--date=human` option of
 	linkgit:git-rev-list[1])
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
-- 
2.31.1.751.gd2f1c929bd

