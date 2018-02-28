Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 437F11F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933023AbeB1TIN (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:08:13 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40473 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932365AbeB1TIM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:08:12 -0500
Received: by mail-wr0-f194.google.com with SMTP id o76so3574062wrb.7
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YcPiUeZ2Ym9FKyWLmrdEgNyrHnOpUdVoY7meORXPSEA=;
        b=GJL/EN3ZgI0jAlgz5n33lmLFxlJqo93hjOrNHtNW6VtPwxv+lHTZCORaWyVTnPxVoc
         lmkS9t1ALKnOd1y46StYq5IQVgcmsOWpGyJErbqwvEwvjUjVumY613ATtIwiZ4Qb8fHh
         OSoRUhhioqi3vjKaw+RGzegzXRBOF6hpudvYci7Cd3LTC3dTDZmNKYCsAE+4+ZnKMr33
         oWRiCOYrX0dkJh2sSGa+y011gF0OdkWzd5SQI6PZvQ2IH/ylyhmuQA0tnq5q2obiGyDJ
         3ZlWKID1xUvgEs744+2T96DX2dpIMUa8+sTOUSGXUS8Jluw2bpagt7Bd/pDbc8AX1tu1
         BewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YcPiUeZ2Ym9FKyWLmrdEgNyrHnOpUdVoY7meORXPSEA=;
        b=JK5Y1AIIFap7FQZ3Tyg8VoRCHBuo/j4AsSJFnuVoY0+fOdGaHaAjCwb1nQAA3SoisD
         b5dG8KLSPPbh17PwtvgOo7kZI7PsjGGUFaAsZ7cx4mE1xkH4HgsstIcPNhA4uRF5bea2
         hUNHp97nxR7ZPUUg0958sMVfC80Q3qwhquTLE20Gwf6Vik3duJAKRCsADxibbHYSJYS7
         Nge2EnEl+rABhGfCXsik3BFjx1gkP/TPzOMyil2yUGAxNVcmtDNKnBrinX7LVm2jdQCh
         OAraZFwT/ElBxnvSsMJtdnwp96taRKgp5EZHJZD2GNBPMXyCytiw8IRZiDoWfpHYyZ8v
         bTrg==
X-Gm-Message-State: APf1xPBifJtPmzAA1SkWbrBN7QSOQ7zL1Gethczb0VRsegIL/Z8YX0gC
        CY0ejePlgmjz3TarD5c14TFlWM3N
X-Google-Smtp-Source: AH8x227AFHUF0r9r/j7h05erKsyTJ1rYGzkVXULBxWOuHzbyo0CStGPjhdGQBGI36g8juxPSIcgnHg==
X-Received: by 10.223.151.140 with SMTP id s12mr17355645wrb.37.1519844891041;
        Wed, 28 Feb 2018 11:08:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p76sm2832609wmb.19.2018.02.28.11.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 11:08:09 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/5] roll back locks in various code paths
Date:   Wed, 28 Feb 2018 20:07:53 +0100
Message-Id: <cover.1519843916.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <CAN0heSqmWAN=rCO8busGtb0xNPiB5H_jkL664qH8xasPq1Sy0A@mail.gmail.com>
References: <CAN0heSqmWAN=rCO8busGtb0xNPiB5H_jkL664qH8xasPq1Sy0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of my series to always release locks. As before, there's a
conflict with pu, where the correct resolution is to take my version of
the conflicting hunk.

The only difference to v1 is in patch 3. I'll follow up with a patch to
address the confusing pattern which Peff mentioned and which fooled me
when I prepared v1.

Martin

Martin Ågren (5):
  sequencer: make lockfiles non-static
  sequencer: always roll back lock in `do_recursive_merge()`
  merge-recursive: always roll back lock in `merge_recursive_generic()`
  merge: always roll back lock in `checkout_fast_forward()`
  sequencer: do not roll back lockfile unnecessarily

 merge-recursive.c |  5 ++++-
 merge.c           | 12 +++++++++---
 sequencer.c       | 32 ++++++++++++++------------------
 3 files changed, 27 insertions(+), 22 deletions(-)

-- 
2.16.2.246.ga4ee44448f

