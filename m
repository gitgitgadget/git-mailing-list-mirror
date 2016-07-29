Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150911F955
	for <e@80x24.org>; Fri, 29 Jul 2016 16:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbcG2QTv (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:19:51 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34698 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbcG2QTu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:19:50 -0400
Received: by mail-pf0-f193.google.com with SMTP id g202so5714952pfb.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 09:19:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vWT3n3eQ2eGATWE8G5sfuSrNTtGOK3qCTH3KOak4l9E=;
        b=BJFf/daMAFhWRAnpspF8xDMSjM+eXpDVy8GD88L8xz4Ngo2q0XoDhGSl4I6PkMIRXc
         02y90r46srPBw5IiocFFzn87r1vxdejLM/UOe3XT3c08BpYABwdWwRVeP8SLWL5ROzQy
         DInw+uku26a64hvwvX3QOmfopJ7vRCk6v83A5xrtJIlJ+CrvqbZgnEjtzTXnV45boF2R
         JzvZhMgRGz95ATtdN3cFVw4xWNv2tGQRL5uYxWsRj90jpOZ7B3NNq5Lf67m5Ubmu1sLQ
         AnURZTFidOBk+ymFgLabZ2MvB6XfTZvzcFV0UCxvVELEL2pLEkahykKvAbzSxXipkhkZ
         queQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vWT3n3eQ2eGATWE8G5sfuSrNTtGOK3qCTH3KOak4l9E=;
        b=j830UcIzAomZPjKHefdzvYPfh1v+PQuZRv7vLv8PF3uYSs0t02hGmKJ3xQLfuKqs9M
         GEtOXkRxb2cZOWmhAY05m4kIfx0uqGu2IAxTIhBflzLnPvWhNxHkjSBQ5/ITufd2y02M
         waywkFaV//ZzhXfe2Aj3rMsDYrohADlPYbiA0FQyc0WrCZ7lQUHrlBvYzNFjEf3O8i1T
         C1ZUGPywuEgjS6ZBaukPX97j0ZLLHSfIyMJ7qKT3g+UuTOI6Ft0oVSuX7468VdEkT/GM
         hXear9o9tpvMYJUGT7DN2MJ3kTbXihgmEkxY52JKcjgak62CyYgmHo565Cunid8HplwS
         yR5A==
X-Gm-Message-State: AEkoouuI4foWTn+mwjHiaxgdqbeIQU5Zh0oXpLmnJmVk5Ms3MBC8l5/uAw/edDgyq8A10g==
X-Received: by 10.98.27.200 with SMTP id b191mr69945608pfb.111.1469809189295;
        Fri, 29 Jul 2016 09:19:49 -0700 (PDT)
Received: from DESKTOP-SLJ7FNG.northamerica.corp.microsoft.com ([2001:4898:8010:1::5b0])
        by smtp.gmail.com with ESMTPSA id i69sm26193282pfk.30.2016.07.29.09.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 09:19:48 -0700 (PDT)
From:	Kevin Willford <kcwillford@gmail.com>
To:	git@vger.kernel.org
Cc:	Kevin Willford <kcwillford@gmail.com>
Subject: [[PATCH v2] 0/4] Use header data patch ids for rebase to avoid loading file content 
Date:	Fri, 29 Jul 2016 12:19:16 -0400
Message-Id: <20160729161920.3792-1-kcwillford@gmail.com>
X-Mailer: git-send-email 2.9.2.gvfs.2.42.gb7633a3
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This patch series is to remove the hand rolled hashmap in the patch_ids
and use the hashmap.h implementation.  It also introduces the idea of having
a header only patch id so that the contents of the files do not have to be
loaded in order to determine if two commits are different.


Kevin Willford (4):
  patch-ids: stop using a hand-rolled hashmap implementation
  patch-ids: replace the seen indicator with a commit pointer
  patch-ids: add flag to create the diff patch id using header only data
  rebase: avoid computing unnecessary patch IDs

 builtin/log.c                        |  2 +-
 diff.c                               | 16 +++---
 diff.h                               |  2 +-
 patch-ids.c                          | 99 +++++++++++++++---------------------
 patch-ids.h                          | 11 ++--
 revision.c                           | 18 ++-----
 t/perf/p3400-rebase.sh               | 36 +++++++++++++
 t/t6007-rev-list-cherry-pick-file.sh | 17 +++++++
 8 files changed, 114 insertions(+), 87 deletions(-)
 create mode 100644 t/perf/p3400-rebase.sh

-- 
2.9.2.windows.1

