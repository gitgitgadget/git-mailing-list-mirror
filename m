Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2C120899
	for <e@80x24.org>; Mon, 14 Aug 2017 23:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbdHNX5r (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 19:57:47 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:38513 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752651AbdHNX5q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 19:57:46 -0400
Received: by mail-pg0-f45.google.com with SMTP id l64so56572027pge.5
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 16:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dend2Y3zvfJOBhhd4KdqxDh6y+NYlZB55t+muLusxPQ=;
        b=msLCwpDoGnZ+uCYCWwNxKyTviSnvW8Okj+GrZ0/cRp/1gnmbrePoE01E4zchVkPfUe
         T7hKMz5PDjLpdDehAb9V+4q/y0KeKI+hx5p7du6yIeY2CG7IDmceXdVJGRUkEtrAzW3x
         JDMQJwIc6YpbYMIaqiERUaQq9MOgbT76x9HNzuBqG+t88Di5WCoOkFM7mI4mWnoFoFZK
         7kVRhv2oOFYnmKVhWjVyESvRi42jz1sYlsi1FNucxHm0WdrInYVMqQP7XOF2ugFePL41
         zRvi7rZYdKn+YXkkHazo2FI66nCAY+XOMDfJBEYdmHBQ59Gh/rZyjGUZSOaSdao79YTh
         CV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dend2Y3zvfJOBhhd4KdqxDh6y+NYlZB55t+muLusxPQ=;
        b=Htes/ZJqqvyCYPWF7yFTwTn1BKNn04YvCnbja1WQpVAz7mCFtadwH5GwMEAKAtHWEX
         ePgM1ZNYNhrgNhbOMFW13dE70QaDvVY7DO0ThUDHS2XlCOe5dMw+4SwMXFziSftIsl+T
         8JJO7Dn0zOH8jg7BL70OXviV7ZWrFgnW1ZBkQC5mxhWwmRk/l3EUBy3wdPPgm8LEIaqC
         KrvwsFvT/74cVB8mPk7GgIRtELhHSZ8vI3hyaR2aPEaAgWx7frr3A2ECnN3ij4NVp6SK
         jtp1Rm0wp6gnL9BtiyEc8RMnRtwewTOQyEZkAYFlV70r/xHF4ft7V/UB2Ii7Itv6M+XM
         E19A==
X-Gm-Message-State: AHYfb5hfIrRZWD2R8XWCNdbDBeVmJlJLCUq/G4KQu289TINw15UxKKPP
        UB3xAk0Nrk4QMJkySs/c5A==
X-Received: by 10.99.126.86 with SMTP id o22mr25284749pgn.385.1502755065915;
        Mon, 14 Aug 2017 16:57:45 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id 190sm15878796pfy.56.2017.08.14.16.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 16:57:45 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 0/3] "diff --color-moved" with different heuristic
Date:   Mon, 14 Aug 2017 16:57:40 -0700
Message-Id: <cover.1502754962.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are on sb/diff-color-move.

Patches 1 and 2 are unchanged.

If we're planning to cook a heuristic, we might as well try a better
one. What do you think of this? A heuristic of number of non-whitespace
characters, applied at the block level, and not dependent on the block's
neighbors.

As for the test, good point about testing the boundary conditions - I
have included another test that does that.

Jonathan Tan (3):
  diff: avoid redundantly clearing a flag
  diff: respect MIN_BLOCK_LENGTH for last block
  diff: define block by number of non-space chars

 Documentation/diff-options.txt |   8 +--
 diff.c                         |  44 +++++++++++---
 diff.h                         |   2 +-
 t/t4015-diff-whitespace.sh     | 129 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 163 insertions(+), 20 deletions(-)

-- 
2.14.1.480.gb18f417b89-goog

