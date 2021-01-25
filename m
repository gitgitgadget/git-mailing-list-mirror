Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5247BC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9CA22D04
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbhAZFBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbhAYTSH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:18:07 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3BC0613ED
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id g10so14148486wrx.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAJX3NFtLmy/fLeGnvoJav4GSYgfzhuYteWG9MVIxW8=;
        b=I+G5vaIMZzrN8GIruUkEMvaNo32Tv2oRgdSIf5ZIjmvKQcTgYdm48shcUC8WQojGaH
         /OX96BGV7AShBvgyAUo++Wkz56wkNLrRWtdO6xyVOuC7vHNDhn2oLcQRyLBoaKxXZMKI
         TXN8LArIfLBdBw6WvRUdGqj2+BvLXaNW4Frexs5wXgJZWOWePEnyJB4IAZ9rbIfpQTNz
         7sYXPf0LkouXQR2Aif3MQDlgbhQaIp/83a4/+4zJh3VFdhJWkqlNz53acZAtxjz4LpLD
         x81LUkncIVljn/Vbmc48lQcsJp/yiqEw8IXN67eAxGzap+Q4UAVQH5yS2AE3Pct/XmGf
         5raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAJX3NFtLmy/fLeGnvoJav4GSYgfzhuYteWG9MVIxW8=;
        b=TfnZRMNyJqDJ8UGgDAHtijdcTRcJ1Ct4SNiDJ6It/7Ddv9qfasuBeCExCVCfJET2ce
         qxLnoyA353yyfDBJGig6KB+ch4qgwfFPZLpkWlW0qUpFxKB7sr7kpbs1gbMZok0wbtXo
         3Ogb2r9gC3a5YCqUYz1LqL5dvWqUfBbIv8abbSGHKcbowNLg2+1tnVgBGeAu5LO4s4c6
         +FladJGKNv0nNqDmBnMkDS5ExtSoFDMVqZrgciFSyqsxRIzgzXsGvwMrOauoaf1rVhkO
         58AX+0KqBr7DzDT3EHflg/Ag0Q6W9iyYzK1xdoeg5YXR4Zf23q+tHYnxiM+NBUr0aFiY
         MzPw==
X-Gm-Message-State: AOAM530mPix0wbGtgbfHP1NqDL3naKzR/UvbU1d2wSW4WJkzXBuE5wAn
        pFbNZAD8dk0yJ5N0tGMGGgtfS8YoV2A=
X-Google-Smtp-Source: ABdhPJwHzzxgJ4tiosVS1RhNIr95ILaGmMvzEjFe4SFP6fF0PRIpVEooZzkY/w5V9w+QL95+tJIAgQ==
X-Received: by 2002:a5d:4292:: with SMTP id k18mr2611499wrq.218.1611602244439;
        Mon, 25 Jan 2021 11:17:24 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.108])
        by smtp.gmail.com with ESMTPSA id e4sm11665895wrw.96.2021.01.25.11.17.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:17:23 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 0/7] Finish converting git bisect to C part 3
Date:   Mon, 25 Jan 2021 20:17:03 +0100
Message-Id: <20210125191710.45161-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a third part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This third part is formed by reimplementations of some `git bisect` 
subcommands and removal of some temporary subcommands.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part3_v3.

I would like to thank Rafael Silva and Junio Hamano for their
reviews and suggestions.

Specific changes
----------------

[1/7] bisect--helper: reimplement `bisect_log` shell function in C
* Add a missing space.
---

[2/7] bisect--helper: reimplement `bisect_replay` shell function in C
* Fix declaration after statement warning.


Pranit Bauva (7):
  bisect--helper: reimplement `bisect_log` shell function in C
  bisect--helper: reimplement `bisect_replay` shell function in C
  bisect--helper: retire `--bisect-write` subcommand
  bisect--helper: use `res` instead of return in BISECT_RESET case
    option
  bisect--helper: retire `--bisect-auto-next` subcommand
  bisect--helper: reimplement `bisect_skip` shell function in C
  bisect--helper: retire `--check-and-set-terms` subcommand

 builtin/bisect--helper.c | 179 ++++++++++++++++++++++++++++++++-------
 git-bisect.sh            |  58 +------------
 2 files changed, 151 insertions(+), 86 deletions(-)

-- 
2.29.2

