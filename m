Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940DA1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 11:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfHULEg (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 07:04:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53938 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfHULEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 07:04:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id 10so1654781wmp.3
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HZLkrDoS901lLC85FvB5lLMU0mdC0ApyRrGuC3N2SF4=;
        b=tYU9o8v+mXiNt1R0PWv7tXb9bI+eOJ89aiETIXpX3MNZ4gC1Ly89pWv2WWl5IlTMSl
         xJu5HkTj9bP6cxCfMUsfxI3vW+cllDe0ZDI5eV/KLMsT1CtH3MPFgAQRfc+eMwNtE4+x
         YCNt+oJ1xTQdkk9QW/0D2PInFZpv6naIV4aU/CrlsU1WlXb/V/2jC206UMpI+5ZHhWCd
         eZY3A1Ym3KiUPeMa3Z4WmQ1VyFBE41GCfQDOSkJdJFlBvBm7bH8oMZ6Ya67tcar1LaqJ
         PB0nmesnpTRwUYDUrW6vanCS1cBKCrCHq433H44KP05ifFZUzWT598nBD4bMXigAdxw1
         iLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HZLkrDoS901lLC85FvB5lLMU0mdC0ApyRrGuC3N2SF4=;
        b=gHYy2TLnAC6BmXABX9cGPCFycohRVn9GLd17asrqZTVEv5tdkx00v3lAix2x4K+9Ll
         8qYr7h9zpEE8pylTvk9Q1D5aAMNp+md+3IAX0wPXM6u6UxiVPatoPkqkCJSOQ6+f08GA
         bPPGajHhdODcX7dhNo4Ae2GFutYsNGxm+A06dgrU7TO92vTt/QYiorEJY465/DlYDoOa
         0nKKUW2Z9unsr3LtrqbS9lQsmEntkSdvSzYM9xxLLeM3Q63Q72sPtHzexrEzcJ/5ixSf
         3RoKkeZa6NSjJIpNN8xYKyShoLrUH24HWoMLjtku4dSlrcOWKxIiGJlawNvEPwOu83t/
         rEpQ==
X-Gm-Message-State: APjAAAWKwcn0sA4Jjc/MDv3uAbSJhfAC+DRMUFczLYyrVnqmk2It3JNg
        JB96tBPcSLCADE9t1+SIiZCj8B85
X-Google-Smtp-Source: APXvYqw/bUziYgNYAc1Pg5P3rm0ll405Vo4lOfxh0BLxQjRYC12euv9p3Uo6CDbwHlPWBRWZtujtNg==
X-Received: by 2002:a1c:3907:: with SMTP id g7mr5374724wma.58.1566385474254;
        Wed, 21 Aug 2019 04:04:34 -0700 (PDT)
Received: from localhost.localdomain (x4db50904.dyn.telefonica.de. [77.181.9.4])
        by smtp.gmail.com with ESMTPSA id c15sm61648441wrb.80.2019.08.21.04.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Aug 2019 04:04:33 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] line-log: avoid unnecessary full tree diffs
Date:   Wed, 21 Aug 2019 13:04:22 +0200
Message-Id: <20190821110424.18184-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.352.gebb2b55eae
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Line-level log can be very slow with rename detection enabled (and its
enabled by default), which is caused by it using the diff machinery
very inefficiently.  The second patch fixes the issue and make it much
faster, especially in large repositories.

This patch series is independent from my other patch series making
line-level log incremental [1].  The two can be merged easily, as the
changes to 'line-log.c' don't overlap, and the conflict in
't4211-line-log.sh' is trivial (both series add new tests at the end
of that test script).


[1] https://public-inbox.org/git/6a576e13-79e6-43be-c4a8-065e7a8310ea@gmail.com/T/

SZEDER Gábor (2):
  line-log: extract pathspec parsing from line ranges into a helper
    function
  line-log: avoid unnecessary full tree diffs

 line-log.c          | 71 ++++++++++++++++++++++++++++-----------
 t/t4211-line-log.sh | 82 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 19 deletions(-)

-- 
2.23.0.352.gebb2b55eae

