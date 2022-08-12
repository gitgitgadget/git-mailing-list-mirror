Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40695C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 08:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiHLIRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 04:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiHLIRt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 04:17:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638D9A5C47
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 01:17:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bs25so381051wrb.2
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 01:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=38DxwhVZIWUo7N6+V3fAUyXgaTvh86yypdzYXhHITKQ=;
        b=WpQTlWtC3p/meJjR7Mmfhu51vva+uMsAwFnFwGr0WmDvHiPWdkf2iQoMZ+x46Wfz8d
         zCcr7YrrwTTVDhkaBbyYKF2/ZklqDN5KTZQF6f+q0DpVe/KbbU3zLvCBOu2omLFvQDlI
         herVLdr+KSeSIPZuvqMMnoykQDSCBKioTkP+ETC5sYQO1G9uQ8iblfjAtys5kvafVmfE
         DOhkO3M46hjjaNzAYlHkGCN+mQWC71ddTubE/7+vZGQNtVV6AwsO5EwqFKwJs+FahAmJ
         zhLX4YoHJQ9OLlvdp62w+Qg9xZxFyG9yhcLupM6z7sNeUjRXjcwAdDl8eL4uvZZzkRv0
         SOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=38DxwhVZIWUo7N6+V3fAUyXgaTvh86yypdzYXhHITKQ=;
        b=qpHGx7zTZpZtGGJ3y0+RkN6/zIWIWxF5rIHRhc+E7maGwKX4GT97/BZjXsND/p21Zm
         kh0mIyL3TH4sZUncRA64+xNp+y3g+BkHopdptMu+tmXEMPmIWV6Kpt86UPDDhGuJAi9l
         MPCak5760l6a7Tcw5wFzuQFtwpS4rFp66TgdB4ZDJanYD0WLg+cch1EgZ+xBMCfAptLO
         PcDX1GrjubH4PnGcWe7Oml9smgSpvkXkWdv3FQaeP2yb6w6KU7qK18HjOL4Ax7xP981o
         +wafgpI8xXXuAN7x+tjIoDYxDpoi+4cVo3tk9CrSfXwa/3oTw7evD69E0R+uBKhXisqK
         J98A==
X-Gm-Message-State: ACgBeo37cWwfpBhLzo7qE0M54UK4NmbObzByyG2RsvYJnyqgtS8UEf3N
        DgpuU+Y8iZ8Fqo+xf4hh26bCjZExZ9k=
X-Google-Smtp-Source: AA6agR4PmaAYw0x2Lww9jnSWBx5h9K5sTWZ5VVPN//VVvdTieathhx0erGGYs3g/4F0ZgEWzVfx0oA==
X-Received: by 2002:adf:db4c:0:b0:21e:ef46:af22 with SMTP id f12-20020adfdb4c000000b0021eef46af22mr1375473wrj.424.1660292266722;
        Fri, 12 Aug 2022 01:17:46 -0700 (PDT)
Received: from rah.. (2a02-8429-8157-8b01-3203-c8ff-fe28-5999.rev.sfr.net. [2a02:8429:8157:8b01:3203:c8ff:fe28:5999])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d494d000000b0021e4f595590sm1270501wrs.28.2022.08.12.01.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 01:17:46 -0700 (PDT)
From:   Anthony Delannoy <anthony.2lannoy@gmail.com>
To:     git@vger.kernel.org
Cc:     Anthony Delannoy <anthony.2lannoy@gmail.com>
Subject: [PATCH 0/1] pathspec: fix memleak
Date:   Fri, 12 Aug 2022 10:17:43 +0200
Message-Id: <20220812081744.456280-1-anthony.2lannoy@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sending this patch to fix a memleak, created with copy_pathspec, found
thanks to the address sanitizer.

Thanks

Anthony Delannoy (1):
  pathspec: fix memleak

 preload-index.c | 3 +++
 1 file changed, 3 insertions(+)


base-commit: 5502f77b6944eda8e26813d8f542cffe7d110aea
--
2.35.1
