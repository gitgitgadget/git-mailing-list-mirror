Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983991F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 18:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751491AbdGYS3p (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 14:29:45 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33461 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdGYS3o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 14:29:44 -0400
Received: by mail-pg0-f47.google.com with SMTP id g14so24654493pgu.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TUeuKwksVjrJsx7l+P37h7exjkkL4re36wxsixGSgTQ=;
        b=BJet2KWMOSnPgkzb3PsZj/Hpemj+bFGrBdMll5pWJ7SEnZ4OjyfiYB1YSLuEscaixg
         6jscF8L86sWrFsOk0x33ltT2gWzZlN6jMp2G8+jzbtfT530jSj2+3EhN02QHXieJDb9y
         utN2uss7l9FfSRsiuX1eUHAn/HumZRomaAEvacAZVJGYQhEOSgLAdgdpxqW2Msh/Mmpe
         YH1wzwJEVV5qD5hPAQZzAC+U7ytN47NnyrH2aEW1ZHmXOe4ZgSNPIwZHV3GJKIlF5IXO
         H43mWs+aBbKM3rH8ixvAbJw47H27O2qW6E3RY6+tkRCWB+I4XwADJIA1byNvBDS50TvO
         H57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TUeuKwksVjrJsx7l+P37h7exjkkL4re36wxsixGSgTQ=;
        b=GMzO9lKaGmMlyznuR8OKOu2SOuPGYdgaXMjN+436Z8D7O65UkiSn890Gd1UaTB5QyJ
         MWoneHVmc73IKuh3YPa++6+E4o5xQ0ZG/GGpvqWSSr8UGJL5T6c9ZA78Xl/j/DYy1k5H
         AUYdRlFU10d6EpVAm+E+9R88nLqaAbNsvRjvs1iZX+37T5qnbsEjA2hXT247LnwziBIK
         FUDBVYSD/K+6nGsNhYhbhesnTM57heCwow9cNMICORMOI0IjPZvAciZK7hgMORcEH+K1
         zCTXiVDB7C6WTMTkDLayZbAUGEfe5yiNAkDh9K/akf6TeLKjBlvq4t0qnffp6K9Tpx4m
         IGog==
X-Gm-Message-State: AIVw113ORxOcRfWY+/4jU8QG/NZgoEkYVFcDWwXHo6QaRmS/xdaxmUEU
        bWw+BLIpqJPjKTK9wGAc3w==
X-Received: by 10.99.95.12 with SMTP id t12mr20235054pgb.352.1501007383367;
        Tue, 25 Jul 2017 11:29:43 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id e10sm3354139pgu.16.2017.07.25.11.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 11:29:41 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        peartben@gmail.com
Subject: [PATCH v2 0/2] sub-process: refactor handshake to common function
Date:   Tue, 25 Jul 2017 11:29:36 -0700
Message-Id: <cover.1501007300.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170724213810.29831-1-jonathantanmy@google.com>
References: <20170724213810.29831-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v1:
 - Moved API docs to header file
 - Updated documentation
 - Updated commit message of patch 2 to explain why the error message
   changed

Jonathan Tan (2):
  Documentation: migrate sub-process docs to header
  sub-process: refactor handshake to common function

 Documentation/technical/api-sub-process.txt | 59 ------------------
 convert.c                                   | 61 +++----------------
 pkt-line.c                                  | 19 ------
 pkt-line.h                                  |  2 -
 sub-process.c                               | 94 +++++++++++++++++++++++++++++
 sub-process.h                               | 51 +++++++++++++++-
 t/t0021-conversion.sh                       |  2 +-
 7 files changed, 151 insertions(+), 137 deletions(-)
 delete mode 100644 Documentation/technical/api-sub-process.txt

-- 
2.14.0.rc0.400.g1c36432dff-goog

