Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9E71F42D
	for <e@80x24.org>; Tue, 22 May 2018 08:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeEVIlS (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 04:41:18 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34229 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEVIlR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 04:41:17 -0400
Received: by mail-wr0-f171.google.com with SMTP id j1-v6so7656737wrm.1
        for <git@vger.kernel.org>; Tue, 22 May 2018 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9Ni8SBQvXP3oxwa+sX4Mxck6IFhwZyZFzjWa8YiSpg=;
        b=FkZIDDSIRH0jTHkTMGa8c8U8KHly68n7jFZOtZfQeDP/dX+Z7OLrgw0U6Y/QmPyr/y
         7XkB/3nycTXPHKa4yh2XH5jhRCssMshDXmLLj+8u6V/fErEMiGjaAbqWlvTkLHWSnc30
         zYNNdDPf9cOlFE0N/3sSvVUSXENjQE4Z0XgMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9Ni8SBQvXP3oxwa+sX4Mxck6IFhwZyZFzjWa8YiSpg=;
        b=H9dO+HCTCN+e/yofITrZ0eM0FzuiGA7GpVZKHYO5Y+riGIhNfkCMjBrd4dhJyY/Yw8
         Tp3eo34yaKP6YSZ8KUKfkncKtkld8xxlWZkK5DXPPYt2Jf25fAP4C7LRhJPj4l45+ZYz
         UokH9kiS9B7+r3p/1uNWrmFvr25LrtbShYBoCDKxPn5bNDfcMhCzjyrsBROzBMBEI9tz
         a1lEbtSRlO0ZLZ5748umvpdu7N72rPl4L//OJUcU20iwx5XQzC33Wcl9sDqp4dhN6aYw
         ZvvxFmlQR6oDpccv9MtSsLZCYCuwa6HfoigwdrAWkPdw/vNNpGwpmjBKU0Xe0bm9d9M/
         imqw==
X-Gm-Message-State: ALKqPwe31XzPvcsa4iwxS0gbGlZrG1Y+qNcv6KpGgofO9Xt1tJzrRCtO
        eCf1P1SFUBC6c+6okxdLOssDbqxU
X-Google-Smtp-Source: AB8JxZqxb3NbliMkatfn2gpoUeRkltcdSaduT2Dp+gD1cHnZdD4dekxdxpsmlEGsSc0+jT2b/+c1HQ==
X-Received: by 2002:adf:abc6:: with SMTP id s64-v6mr17960046wrc.66.1526978475746;
        Tue, 22 May 2018 01:41:15 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id 135-v6sm19202922wmx.21.2018.05.22.01.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 01:41:14 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/1] git-p4: unshelving: fix problem with newer P4
Date:   Tue, 22 May 2018 09:41:08 +0100
Message-Id: <20180522084109.29787-1-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a problem found by SZEDER Gábor with newer versions of
the Perforce database engine (2016 onwards). It looks like the
behaviour has change subtly when reporting the revision of newly
added files. The fix is to just use the file status.

Luke Diamand (1):
  git-p4: unshelve: use action==add instead of rev==none

 git-p4.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.17.0.392.gdeb1a6e9b7

