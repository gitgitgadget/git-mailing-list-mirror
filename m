Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531E2C433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 09:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143266140A
	for <git@archiver.kernel.org>; Sun,  9 May 2021 09:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhEIJLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 05:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhEIJLj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 05:11:39 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5FEC061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 02:10:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s25so17071422lji.0
        for <git@vger.kernel.org>; Sun, 09 May 2021 02:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGCnfb4mpJOnYha8RrrnJIgSXJL2UTsfGlTI2yYSEWQ=;
        b=VWLcv/ZcXJbw9HAPaCD97UibdLi3Unlx8J7jptDsqQixakmbKek+HSeX362aoM3uN+
         FfWYGUTnnKyqeO810bwq8dTem2wLTyqRcKvJbfESHRwdIhdgzq+YwVtcMkQrrpi6zqmn
         NB5dwF9edWGaNgi2T43BN2B6tIc3FJAdoIXrGP+A2/CjbVy8oE7po+CP3wNs7AtqBrwA
         aTjO2Ijcw8NvIkDsEVwF06x28OrVdElPUdeFRBbsBDXYQXBNdghP8LhqajVYwtTI1AAL
         aTO/Hpts9AgcOqttyIBkKWdVLBUu4tBxeE1GfpARit5xIMxaMzKsQUsCO8QhfHMOI6c7
         Ap/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGCnfb4mpJOnYha8RrrnJIgSXJL2UTsfGlTI2yYSEWQ=;
        b=aoi3U1jS0uO0y4qp6Zv7zNDxLY73xT9CDjiaV4FjNV7dcAlaGhcK6WTEjNtXzNumyJ
         DsC+xmmbfYIn0UJRfO/u5YU0V4nsUXfspdr9U4PP5oIULF1fqZjMF1sjqw6CmWyir4AE
         OdSBWYwdCG5Kza5U5NYjYrosDfq6UlTNHwaeVjjFAY68EO4OXcLqCkERQqZlYbrWD3hF
         OBdsbXYVviWAfKUVjvFC0Oszi8IyKgLJar1ppZav7SJFzxcxr9qxBrJQo3djJnidhrtz
         B918Pm9qC6tpPjkvzwbM2KB0Y4DSvy0oD/LhsabDwtOWDgMpl/BErnAxbZ11OliEkT9u
         O1yA==
X-Gm-Message-State: AOAM530EXOx7SwjjxuTbo8S+0oCE7eSaOiTYBILg53usC6W0AvgP6dKb
        KTm+mV5zzRzGMPE/016GD5csWK7Yz0M=
X-Google-Smtp-Source: ABdhPJwr+W0nvwp5LACkT4iodNLzPwY0/HsELe8XnDJ3rfcRTZfWHgK3YX4dM8JI86046OBt2ZiOEg==
X-Received: by 2002:a2e:9152:: with SMTP id q18mr15820470ljg.188.1620551433328;
        Sun, 09 May 2021 02:10:33 -0700 (PDT)
Received: from localhost.localdomain (81-231-136-235-no600.tbcn.telia.com. [81.231.136.235])
        by smtp.gmail.com with ESMTPSA id h9sm1839164lfu.305.2021.05.09.02.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 02:10:32 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/2] minor doc fixes
Date:   Sun,  9 May 2021 11:09:58 +0200
Message-Id: <cover.1620551314.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two small things I noticed while going through the doc-diff between
v2.31.0 and master ("The fourteenth batch").

Martin Ågren (2):
  git-repack.txt: remove spurious ")"
  pretty-formats.txt: add missing space

 Documentation/git-repack.txt     | 2 +-
 Documentation/pretty-formats.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.31.1.751.gd2f1c929bd

