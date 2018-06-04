Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5180E1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 17:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbeFDR3n (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 13:29:43 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46386 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFDR3m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 13:29:42 -0400
Received: by mail-pg0-f66.google.com with SMTP id d2-v6so4130060pga.13
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=70Jr7SPZagmElGHCZS/YpZd2JgneDsH2pUr3HkBfpQk=;
        b=SjEoV0OK8qc3rblC38DzTl87DFe1TvruPGRElUWeE6xpptdnZvsewybkTA4S0qVaD6
         stzDHlPE1q6XTcMBLG8pIuKR6RNuUlRZlm2W7sVkRh45S/iw/I/bfG9HGTucjuECNfH5
         SgkpOcPRhdGu0EJxeYBaUiCyy+7yiQ7Mlr+VAQQQ7tmoVDMam+F1gZ7MYsfyhLeZ3LNT
         XCcGH1QZshNAygaLkyWnLAHIBV84qhuYvnDAC/PQ7L9lqDUZEE4Zo2VwDty5AmDpg5xO
         L6lSyZmZ2esPhlm5BwavZiiwNIu0hzy4Y7phdyndjr63XNykuoyEomvU76F5ncQGej/I
         zC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=70Jr7SPZagmElGHCZS/YpZd2JgneDsH2pUr3HkBfpQk=;
        b=QWz6P18vZ+6r5eYlmb7BcyWi+GQrdTTNclIl2hCgBuKgQ4X0Zd/cdxRmCEJHovm1Ki
         QowU46V3cDdMBEVd45yKn6y4OEb1bgTRjgbxKoESBcspeTa/4N8K1pkNwNQfPBrrrAu6
         69Gy0Z+iN4v6pzygRUsH6+o2mxse/mDBZgCEtzGz+QFynDoKHYItfTOlzaqOJrHx4sBm
         vfmKSsrGPbpbGWobtJs0GwLZtGCQBKWQOClUIO5VfSjX022/4HS7L1YoQ8xR+Jbk8GKN
         VFZo1wOkHkPdNjxOAPutj5YsWwGRoEProZYo6AfIGJbKaB8cYCpJnTNJrEmYNoYuLwX5
         bNkg==
X-Gm-Message-State: ALKqPwe7YOd5N+s+Yg1iOlEesmThafRLl42ln/WMtYZI25OOR8tn28S3
        2ZB7sRw0DL4qvERYDfz8GMf06sC1LOo=
X-Google-Smtp-Source: ADUXVKLU8+M/RRQ1VnVDl10BhH8uvKW2ptVdAdbZ2bZYcVyZvuJ3DqpuhRzibP6AGeg67wTw2yWIAw==
X-Received: by 2002:a63:648:: with SMTP id 69-v6mr17999676pgg.205.1528133381358;
        Mon, 04 Jun 2018 10:29:41 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x2-v6sm4491994pfn.11.2018.06.04.10.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 10:29:39 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        bmwill@google.com
Subject: [PATCH 0/6] Refactor fetch negotiation into its own API
Date:   Mon,  4 Jun 2018 10:29:30 -0700
Message-Id: <cover.1527894919.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both Stefan and Junio have suggested in [1] that I create a new
negotiation API first, then implement a new algorithm, and I perhaps too
optimistically said that doing it all at once should be fine. Extracting
the API turns out to be more difficult than expected. Here are the
patches that do that, without any new algorithms.

The patches include 3 patches that eliminate some minor differences
between protocol v0 and protocol v2, then 3 patches that implement the
API. I tried to write tests for all of the former 3, but could only do
so for one, because I didn't know how to construct situations that show
a difference in behavior as an effect of such a code change (or, if such
a situation is possible without custom transports). As for the latter 3,
these are refactorings with no user-visible changes, and I have tried to
write them in such a way that it is clear to a reviewer that the same
functionality and logic is present before and after, and that they are
just organized better.

Overall, these do not change much functionality, but would be a good
base for contributors (myself and even others) to experiment with
negotiation algorithms.

[1] https://public-inbox.org/git/20180521204340.260572-1-jonathantanmy@google.com/

Jonathan Tan (6):
  fetch-pack: clear marks before everything_local()
  fetch-pack: truly stop negotiation upon ACK ready
  fetch-pack: in protocol v2, enqueue commons first
  fetch-pack: make negotiation-related vars local
  fetch-pack: move common check and marking together
  fetch-pack: introduce negotiator API

 Makefile              |   2 +
 fetch-negotiator.c    |   7 ++
 fetch-negotiator.h    |  45 +++++++++
 fetch-pack.c          | 222 ++++++++++++------------------------------
 negotiator/default.c  | 173 ++++++++++++++++++++++++++++++++
 negotiator/default.h  |   8 ++
 object.h              |   3 +-
 t/t5500-fetch-pack.sh |  35 +++++++
 8 files changed, 332 insertions(+), 163 deletions(-)
 create mode 100644 fetch-negotiator.c
 create mode 100644 fetch-negotiator.h
 create mode 100644 negotiator/default.c
 create mode 100644 negotiator/default.h

-- 
2.17.0.768.g1526ddbba1.dirty

