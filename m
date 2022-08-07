Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38933C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiHGCtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHGCtp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:49:45 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86A0BF59
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:49:43 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s204so6913040oif.5
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=GUcBvf90mC6vtbA5uV9F2ZkevFioYRtt1QfDpu6iuQY=;
        b=dEHF99/TnixcSCJ9IDGA0/rM/F85oj/K6xbNsaOYqpu9nj7Uo2Xbn9FnnUz1BlV2H0
         I5ffi8RTJVwVPNLmN8Fu5alWu4oimWjWzdkEO3y/fc5M0LDi9G+LlIg5+iWpmZb1EJT7
         5UTkheDYNxn9hJbJuwVsjJ3hd1yqwwqBPdgdrUB3pBS9VYz2KiBJfJyiHH2WU4klnh/W
         cts1JPYJyCIqUmS51sZRZ87GYUsTAMuZ7vDhMRZn4dr5BLJNx0uVa/msak2VQfq7RXMI
         H3w+QzQ4k+HfVK6NQSeFtqu3iiJ7AMOmAKu0CY87vB5DGIZwecoruWMbSTtgx9BuKU4V
         ANhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=GUcBvf90mC6vtbA5uV9F2ZkevFioYRtt1QfDpu6iuQY=;
        b=Wsf01fCkdRooWFB0cpiZiclOaAKDX3wHfBEFKgEmyztp4j5TIczGfGx+E8eThPzrK/
         oUqjjlhrJOgAMo70FZ643KoIZvBjIKi00RANarbxmYjMoTzv1pThNm2FMKvpFuc0YemS
         S+pY60zGcQxlCWIOhwyI/o4nIuKND2FiPzep1RSMSKn1wk4gdR/dmWBDxNM93JTBT3ww
         jdJNJrYytrKYpUAiTSJGiMDtsibzqtg64jXAxF7mTGrqbD2m93I8oih1qGTiifRP7QZF
         /yWxO7z3QZ+bGih3DQ31nfYizwu3RK81lddHiNgEIV9eUMzciobbFRDaDqxp8YCSkdXj
         n/0w==
X-Gm-Message-State: ACgBeo3kEgjTWpON/eni5KV14KaYXISsoZoCUaevn544qxJ93UzUszaq
        vFM9l/Z0cbT/dG1ImUCqm3WTjL/v6dw=
X-Google-Smtp-Source: AA6agR7yvpS3fiFmVaXc333ecsf1gp7++WvkDXDx9MsiaLeKPiwhQYpHI9V0wtNMbhX/NktG044ISA==
X-Received: by 2002:a05:6808:1392:b0:33a:df9a:7e20 with SMTP id c18-20020a056808139200b0033adf9a7e20mr5321465oiw.283.1659840582726;
        Sat, 06 Aug 2022 19:49:42 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q43-20020a056830442b00b0061c825bc627sm1515688otv.29.2022.08.06.19.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:49:42 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/9] mergetools: vimdiff: regression fix and reorg
Date:   Sat,  6 Aug 2022 21:49:32 -0500
Message-Id: <20220807024941.222018-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.378.g3f95da6bac
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

After discussing v1 with Fernando Ramos I came up with a different route
to fix the issues by reorganizing the code first, and after the code is
reorganized for the special case of single window mode, it should be
clear that the switch to the old vimdiff mode for vimdiff3 is easy and
trivial.

Felipe Contreras (9):
  mergetools: vimdiff: fix comment
  mergetools: vimdiff: shuffle single window case
  mergetools: vimdiff: add get_buf() helper
  mergetools: vimdiff: make vimdiff3 actually work
  mergetools: vimdiff: silence annoying messages
  mergetools: vimdiff: fix for diffopt
  mergetools: vimdiff: cleanup cruft
  mergetools: vimdiff: fix single window mode
  mergetools: vimdiff: use vimdiff for vimdiff3

 mergetools/vimdiff | 74 ++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

Range-diff against v1:
 1:  d0530af49c <  -:  ---------- mergetools: vimdiff3: make it work as intended
 2:  01a229ef5e <  -:  ---------- mergetools: vimdiff3: fix diffopt options
 -:  ---------- >  1:  20c5abdbc8 mergetools: vimdiff: fix comment
 -:  ---------- >  2:  e6c860d2be mergetools: vimdiff: shuffle single window case
 -:  ---------- >  3:  bdf1e919a5 mergetools: vimdiff: add get_buf() helper
 -:  ---------- >  4:  c5e21e3049 mergetools: vimdiff: make vimdiff3 actually work
 -:  ---------- >  5:  2bf45c882d mergetools: vimdiff: silence annoying messages
 -:  ---------- >  6:  77a67628e7 mergetools: vimdiff: fix for diffopt
 -:  ---------- >  7:  adc9d18f2b mergetools: vimdiff: cleanup cruft
 -:  ---------- >  8:  fe7fb1a018 mergetools: vimdiff: fix single window mode
 -:  ---------- >  9:  15765aa9d2 mergetools: vimdiff: use vimdiff for vimdiff3
-- 
2.37.1.378.g3f95da6bac

