Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E350CC00140
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 00:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbiHIAp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 20:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHIApw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 20:45:52 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667F025F7
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 17:45:51 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bb16so12223558oib.11
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 17:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=N9AmHxGGl4neRdAchtT862BYYhv/rD36/YivBZ86QXQ=;
        b=XQ2QXMso5hs9XOuFALpdNK/pSFoMnYxFLvGco9fLiYjSznCNPCe7djfdszPAlFQ3nB
         4fRjPIiBw2wdAEZBAUxTIzJjlk2di7QKeeO8XILPIiGFnjdqzDiozu67+hrIyCg8EbEw
         eVvRQEctpc5xIMBdMColapvDiza5c709btMc3IRly7MzukspvNtQ//4O5cBzXfSmDKT1
         MQb6/7OwyZPEnmCF/KK6QeJf5C9QJYD2sn8AIv0hQ+rRD1V1bi7S+8D9uo8BZ9wIUuzT
         gZy0MLHIxxGaNE/xqzHrm6jvJlHDaglQ3OS9VsXLnfUwDYx7QNKfFFZtbM0t23mE0/tp
         MhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=N9AmHxGGl4neRdAchtT862BYYhv/rD36/YivBZ86QXQ=;
        b=I5zSh1eernn5V4HvmFMu4yT92f1+cruzH6MsS999k2hyiI2IaTbgwOR7mEOoL3t6KF
         wtYz+PjsxQGjLHm0PdMoioCcxtJG88jQIfmoiAMpwNDrKt5tXpj7sUpeIvY71ieUgjTn
         i2RLER2p956FO2n1NK0mXF/IEPGt9G8cpe/VpmluJBk/MBZaFr4COb6P/WvjL8gcSk/o
         4y3AGnHAU+TzKMiqrp/4/SAMrVRPCHafSWxax0xcn4G5adD3m/6EfkrwKJCiaWrRPdSk
         Gf4qHx/ZAejD5eUo5FtCQUXNZ6iPJUwy+XTS0EcYQO2x/RY06+b07rZPjM8IwPtCQ94T
         wyqw==
X-Gm-Message-State: ACgBeo2yZ18Ezj2fMuP+qZ8UioMmZXhxGqaerlc7NQu2SIMjbPcrVxH/
        LGp0a3gohUMEG4jpmwPWnlxNID68GZc=
X-Google-Smtp-Source: AA6agR48ChIJUX13y6R8phTtDeNVjN+UYyX+gjCLEXsULkxOAHiIWO9GNXXdo7EKO7PA5qkaAno8xw==
X-Received: by 2002:a05:6808:a10:b0:33a:d654:bf98 with SMTP id n16-20020a0568080a1000b0033ad654bf98mr11871121oij.112.1660005950465;
        Mon, 08 Aug 2022 17:45:50 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h67-20020a9d2f49000000b00636e9a0cce5sm902290otb.60.2022.08.08.17.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 17:45:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/7] mergetools: vimdiff: regression fixes and improvements
Date:   Mon,  8 Aug 2022 19:45:42 -0500
Message-Id: <20220809004549.123020-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I wrote vimdiff3 to leverage both the power of git's diff3 and vim's
diff mode, but commit 0041797449 broke that.

Here you can see how it used to work:

https://i.snipboard.io/hSdfkj.jpg

The added and changed lines are properly highlighted.

After I fix the conflicts vim still properly highlights which lines were
changed, and even what specific characters were modified:

https://i.snipboard.io/HvpULI.jpg

Now I get absolutely nothing:

https://i.snipboard.io/HXMui4.jpg

Additionally, every time I run the command I get an annoying message:

  "./content_LOCAL_8975" 6L, 28B
  "./content_BASE_8975" 6 lines, 29 bytes
  "./content_REMOTE_8975" 6 lines, 29 bytes
  "content" 16 lines, 115 bytes
  Press ENTER or type command to continue

Because that's what `bufdo` does.

Since v2 there's a lot more reorganization in order to deal with cases
Fernando Ramos mentioned.

Felipe Contreras (7):
  mergetools: vimdiff: fix comment
  mergetools: vimdiff: make vimdiff3 actually work
  mergetools: vimdiff: silence annoying messages
  mergetools: vimdiff: fix for diffopt
  mergetools: vimdiff: fix single window layouts
  mergetools: vimdiff: rework tab logic
  mergetools: vimdiff: restore selective diff mode

 mergetools/vimdiff | 96 ++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 51 deletions(-)

Range-diff against v2:
 1:  20c5abdbc8 =  1:  20c5abdbc8 mergetools: vimdiff: fix comment
 2:  e6c860d2be <  -:  ---------- mergetools: vimdiff: shuffle single window case
 3:  bdf1e919a5 <  -:  ---------- mergetools: vimdiff: add get_buf() helper
 4:  c5e21e3049 <  -:  ---------- mergetools: vimdiff: make vimdiff3 actually work
 5:  2bf45c882d <  -:  ---------- mergetools: vimdiff: silence annoying messages
 6:  77a67628e7 <  -:  ---------- mergetools: vimdiff: fix for diffopt
 7:  adc9d18f2b <  -:  ---------- mergetools: vimdiff: cleanup cruft
 8:  fe7fb1a018 <  -:  ---------- mergetools: vimdiff: fix single window mode
 9:  15765aa9d2 <  -:  ---------- mergetools: vimdiff: use vimdiff for vimdiff3
 -:  ---------- >  2:  8d466e06aa mergetools: vimdiff: make vimdiff3 actually work
 -:  ---------- >  3:  95bfab5813 mergetools: vimdiff: silence annoying messages
 -:  ---------- >  4:  08f6b2bce2 mergetools: vimdiff: fix for diffopt
 -:  ---------- >  5:  2bff74f499 mergetools: vimdiff: fix single window layouts
 -:  ---------- >  6:  39e8277317 mergetools: vimdiff: rework tab logic
 -:  ---------- >  7:  92df35208d mergetools: vimdiff: restore selective diff mode
-- 
2.37.1

