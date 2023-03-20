Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFFCC77B60
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 16:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCTQUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjCTQTr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 12:19:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79182595E
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:11:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j24so1989021wrd.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679328692;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3wLMI1gA7ExhRV/QdoM3Thz+i163zkxUl5Lrs5DC0w=;
        b=BVlc9x9gA/x2NZPBUgcbsVaBDHJkr5Gp9QOdPvUAo0Xe48MM7uCUkYQTgIeoAjNNOl
         h/fBiRY7PGWv47J856jCRDLdPasV2ZCejPTKqSlQtGyYRjb0LrkKd+VphRXRdxilJjvH
         Twy4pBpN8o8Zb4WlWnaeeVPCuf3v3DRxa7bQjyh3N9L+zg2DdD4ggjFd9w8Dl0tsWI5w
         NHvqTKzCXHFPTFwnufn7jmFQVlJ5tKeKTbnVtt0Kr4ySrF2WKzHOM8Tu2s4dH8lYVWEw
         VoBagImAd7l3NiwHwOQZtMA8wbNyp/RxhHSxiNeLdf5W1HselGE96UPReWmboBuX7q9S
         StDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328692;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3wLMI1gA7ExhRV/QdoM3Thz+i163zkxUl5Lrs5DC0w=;
        b=NvS77HR8SnCpt/dCH/Y5pffVxVwgTcJdP+oUBkORCm9O6s2L5F9U8ePONFqPg+8PU5
         DqiicKVroBWCQ6weSS+F/sPhExKGyDclauSYXzUorCCBhmNxfAp/4EL3e2k6JkDjSyzb
         5GOyVGme+lVO10HLxBsnXMxUW1wIjQz8xoCLtPUfEgsIagGkgvHd+OIHfA+fzoz3MqjS
         pyzqyOGpwA29/nX6i7Faw9hMZSyFImleL/xRJb0YRfluvRVpAw6GIQ+O+tRTBa7wnQ6R
         JWGNmCn+y2TQlj4QLvYcfi+bWeFOAG07PjSkhkE5Em476gleK+cDgySkd9Yak+oJtwvr
         Jf7Q==
X-Gm-Message-State: AO0yUKW9BVwZ9madz+fTgox7vTzVOXb/LnXjzv/nwEC4rVvuMKb7iCfm
        Pk0poT+bXuGX/8HXiGRDyPc6LOLzfYE=
X-Google-Smtp-Source: AK7set/8LcioB93JFU3UDiArdJcqfXTrwT88s5MhCoiQBrOWbJhz6Sqx62SDE1erGuHjjZNd+sIa0g==
X-Received: by 2002:a5d:4906:0:b0:2ce:a897:9fd0 with SMTP id x6-20020a5d4906000000b002cea8979fd0mr13973413wrq.6.1679328692092;
        Mon, 20 Mar 2023 09:11:32 -0700 (PDT)
Received: from localhost.localdomain ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d484c000000b002c59f18674asm9279628wrs.22.2023.03.20.09.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:11:31 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/3] wildmatch: fix exponential behavior
Date:   Mon, 20 Mar 2023 16:09:59 +0000
Message-Id: <cover.1679328580.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.39.2
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The wildmatch implementation in git suffers from exponential behavior as
described in [1] where the time taken for a failing match is exponential
in the number of wildcards it contains. The original implementation
imported from rsync is immune but the optimizations introduced by [2.3]
failed to prevent unnecessary backtracking when handling '*' and '/**/'.

This bug was were discussed on the security list and the conclusion was
that it only affects operations that are already potential DoS vectors.

In the long term it would be nice to get rid of the recursion in the
wildmatch() code but the patches here focus on a minimal fix.

This series is based on maint. Unfortunately it conflicts with
my/wildmatch-cleanups when merged with seen. There are sematic
conflicts with the removal of dowild() in  e303cf8092 (wildmatch:
more cleanups after killing uchar, 2023-02-26) as well as textual
conflicts around the change of uchar->char.

[1] https://research.swtch.com/glob
[2] 6f1a31f0aa (wildmatch: advance faster in <asterisk> + <literal> patterns, 2013-01-01)
[3] 46983441ae (wildmatch: make a special case for "*/" with FNM_PATHNAME, 2013-01-01)

Published-As: https://github.com/phillipwood/git/releases/tag/wildmatch-fixes%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/73876f486...a74ab7138
Fetch-It-Via: git fetch https://github.com/phillipwood/git wildmatch-fixes/v1

Phillip Wood (3):
  wildmatch: fix exponential behavior
  wildmatch: avoid undefined behavior
  wildmatch: hide internal return values

 t/t3070-wildmatch.sh |  9 +++++++++
 wildmatch.c          | 23 ++++++++++++++++-------
 wildmatch.h          |  2 --
 3 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.39.2

