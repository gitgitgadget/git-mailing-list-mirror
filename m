Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF666C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 16:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCSQ44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 12:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCSQ4z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 12:56:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E5F13D61
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:56:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p34so1053104wms.3
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679245012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UuGcHecT8qTm6aWTbVzMomeAE4+nJ5f9Wl6dyK4wZrU=;
        b=plxnNi2Y84QsITy7JsOlNRrO6QhOQ6GUwj6TbaYcKGf/r1GV72e4b9nrfPANa8A1JV
         dsF9KmtVciWiDMXltS4OpIJwnSePxbTrYUfpcYQLjjeOVGD8L3oVpHJU/hp5wHEIKF1m
         weThAJ/u9PWku78/+9zkvMhz0aV4+FrabVnL0d9LbtY/qWAlO104zusyrGshthWyXCDd
         zAwOlvlAurYfCmac8m/WYvTpGBWALxz2/D0aWl88jXgpP0duDq2hw44L2J+ZAY+RNCGz
         q9qBJRkTfXlTTQHVC0l00L3rqPpIXgdRnCLHlW55pgQrffuz8aZeX65JZBpge6QunMJd
         LxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679245012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UuGcHecT8qTm6aWTbVzMomeAE4+nJ5f9Wl6dyK4wZrU=;
        b=Z0QQFS5wYYcpgzh5MpwkUEIQnbz3ouCgEgAL5qYJ6ePs5578x/EqW/CHlL09pfEVcf
         dBxFApl6PWBgHTT+JVXf02B/21VZb0tsHvMa/16PAWGzG8EtkvPpJSVKpY4Cf7V2ZJzA
         7he3qnQ1ml4eAN0TI4CFHUaOcqgD5zwNMloLqcr4fCkNL6BqmnpgdGmCLV3ZXHqrNvcB
         3ekW3yi9MznCt04vxgzNtpSoJVQsHLcv2Tce001pfFqCgxJ3NRd8eukQtbTX7LN0TcR+
         C8uqr10FFZSvvmgFB1ZwSAx2YcEC/cLcFqgZyfHz49ZaCrVk1EMOG/8deNX3/zlCD+F2
         pThA==
X-Gm-Message-State: AO0yUKVFan/ePhR2vuk2ciRcsZwtI8gp1qzsPT96lInOX1UIToqC4rB0
        ff1BfaiANPDDmkHeEf1h2NqNRdHs9VU=
X-Google-Smtp-Source: AK7set/TJXybfthOInMEn4q3wCAvTAGMs1SRb6Imiv1j4VAHfwiaAW0qJOHrjZLQVg58wB9Da63efQ==
X-Received: by 2002:a05:600c:19cf:b0:3eb:2da4:f304 with SMTP id u15-20020a05600c19cf00b003eb2da4f304mr28689353wmq.17.1679245012694;
        Sun, 19 Mar 2023 09:56:52 -0700 (PDT)
Received: from localhost (62-165-236-170.pool.digikabel.hu. [62.165.236.170])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c35c600b003ed29189777sm14363699wmq.47.2023.03.19.09.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:56:52 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] parse-options.h: use designated initializers in OPT_* macros
Date:   Sun, 19 Mar 2023 17:56:45 +0100
Message-Id: <20230319165648.656738-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.40.0.499.g88fa0b00d2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use designated initializers in the expansions of the OPT_* macros to
make it more readable which one-letter macro parameter initializes
which field in the resulting 'struct option'.

SZEDER Gábor (3):
  parse-options.h: use consistent name for the callback parameters
  parse-options.h: rename _OPT_CONTAINS_OR_WITH()'s parameters
  parse-options.h: use designated initializers in OPT_* macros

 parse-options.h | 311 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 244 insertions(+), 67 deletions(-)

-- 
2.40.0.499.g88fa0b00d2

