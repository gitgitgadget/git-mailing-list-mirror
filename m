Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C31B1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 15:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbeIFTtU (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 15:49:20 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38352 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeIFTtT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 15:49:19 -0400
Received: by mail-qt0-f195.google.com with SMTP id x7-v6so12656875qtk.5
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O3gkbJsPUyN6IUZ4iUfPa4JgKDzNl4WhFzMXwf6LRxk=;
        b=lRVQkrHp6SyhOSbF/JF+3X8mtb9GtB+wdkFEQwOVwT+qWLMqKsXX/StNHMm9N63MSI
         h0+IXTYdB8NDKunlizlpuDQRRc5NUFGTr/JgrDGaP9wtZAzzuZLALuBDODVHggIwU9B/
         MpB1jU3kXS7iy5+WfFbqXtBAKcIcprkylIN65Ut0iDujiqhZ2LVJPMwLbPIu+hN9Dq7n
         ndrXPLbvnuWuAiMVReEsVrPGk/BN1oDyU3P21w4eiS8i8f6AmzlOvqnRzE46kqEOUPuW
         Yuzt4WUkxPrSaqU8kYul8rNDezNEKQe3Md2SVdwuyyqC+rXz3H8Vd+ArYL+1A6LqOuub
         W16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O3gkbJsPUyN6IUZ4iUfPa4JgKDzNl4WhFzMXwf6LRxk=;
        b=TzhY7JVcmcKlSHPq3CVfMiBYFC5ziHo9Zb5MUcSC2M3hrOhG2da8T9P+J6fzzXELZj
         daj4vUxBtSpDP5avODGllZDJP2HNpypcuhWxPc4WWVVopVVLV567zWDUQrnRvKBfEoDm
         XGRhmVA3gpdTmxiA8i/q58MVRKgKP50UwqSYeantxyC/ayC02x3j/wlPBixkChfnnRPp
         PooHrqqXLlOaxmRlzPfrdXw9VavpQBGOq4PdGqrLHWEj9SgV/tWauIaVtC+S0jzoF3qd
         ONYdbY+rTMitChjE195D/rreKquUMeO8ozN+bKHjff6Jd3R52jPuho2ZAoQjlpvyzm0E
         DPtA==
X-Gm-Message-State: APzg51AIOl1ohOn8v33GZ6HGHAZHBc0WAbQkjY5cQT+gkFUONePZg0oa
        MKNClRC1NRABvElUFMj279qdDSct
X-Google-Smtp-Source: ANB0VdYMsmuQqQWc+U0c6pczG3W8YTab/+lsQlTUpkjJzwIfOcMzV4gmaCysB11c/VdfsmcFGJ8Z+g==
X-Received: by 2002:ac8:fb2:: with SMTP id b47-v6mr2551726qtk.203.1536246800727;
        Thu, 06 Sep 2018 08:13:20 -0700 (PDT)
Received: from linux.mshome.net ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id z3-v6sm2752030qkc.55.2018.09.06.08.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:13:13 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 0/6] Use trace2 in commit-reach
Date:   Thu,  6 Sep 2018 15:13:03 +0000
Message-Id: <20180906151309.66712-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <2ba9d81a-5578-a81c-a7d9-179864cb4277@gmail.com>
References: <2ba9d81a-5578-a81c-a7d9-179864cb4277@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As promised, here is the direction I took when applying the trace2
feature to the walking code in commit-reach.c. Hence, this depends
on Jeff's trace2 patches and ds/reachable.

There are multiple benefits to the approach I take here:

1. If a user has performance problems, we can rerun the command
   with tracing on and get the region enter/leave notifications
   and the extra data like "num_walked".

2. While I was testing this series against real-world examples,
   I found a number I didn't expect. The numbers for
   can_all_from_reach_with_flags were much higher than I expected.
   Turns out the heuristic I wrote was not working correctly. With
   the trace2 library, I was able to add a "run_and_check_trace2"
   function in test-lib.sh so I could make the number of walked
   commits be a condition we check in the test. Then, the benefit
   we expect is demonstrated by the test suite when I fix the
   bug.

Thanks,
-Stolee

P.S. I'm sending this RFC from gmail because I'm having SMTP issues
with my work email.

Derrick Stolee (6):
  commit-reach: add trace2 telemetry and walk count
  comit-reach: use trace2 for commit_contains_tag_algo
  commit-reach: use trace2 in can_all_from_reach
  test-tool: start trace2 environment
  test-lib: add run_and_check_trace2
  commit-reach: fix first-parent heuristic

 commit-reach.c        | 32 ++++++++++++++++++++++++++++++--
 t/helper/test-tool.c  |  3 +++
 t/t6600-test-reach.sh |  6 ++++++
 t/test-lib.sh         | 14 ++++++++++++++
 4 files changed, 53 insertions(+), 2 deletions(-)

-- 
2.19.0-rc2

