Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2DBB2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 17:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754971AbdIRRYk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 13:24:40 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34331 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753469AbdIRRYj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 13:24:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id g65so441177pfe.1
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZZ9JzXzsDLU7y71TLZJcPO0olqb607ZqO5hDKt7GAdo=;
        b=oqb458RUXzJLQz6fNUQsOQJM2xOyHmyApiaZz46FTOcDwZkCRXkfk8OGRQarFwfMyD
         Y1+LHAFc61cb/BITu0B3N/gcRT5xsS1M1KdNhSuIcLlvORO4a25M2BvSNjL54OsgUALZ
         eeRN3fOKoOyKjT0wt8sgCrXOzNAQ8/NcGTCxf3BF+4SA4409LxrQ0cv/tygY1Xja5XgI
         oTh8qgCouqEEBepHJZX2NQ42mFjCDnBti+nzxJlTABQCNxjgNTEYUt5tCZupzhvH359y
         8oD99iOub9zSiHWnecIBg20w2g9plVodNqkf5OGSTSBno6EVIKjQDydRYvysAI8SJg+Y
         y0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZZ9JzXzsDLU7y71TLZJcPO0olqb607ZqO5hDKt7GAdo=;
        b=kruNX1eXwN1KSsKwKqvPeO8xJE6OfGLvX3d9tz4I+tdDkCFaWdYhSmtYbxLQh1dyS6
         oE3rhmS/Y3S8MRO4L1v+TFPzD7EwgxB6wbMxB8bdoOQ60hDLmHDv9PQWciqlJtXo/4Jy
         d04+PxTc0BdRVbn2hWfFXMiE5w15DNaMNjwwFMePmxwPB5OcMQ3tuaO2PIKQU3saUv81
         IH0wX8MviAFfhEzbI2uBL+RwiQ16NZYdpgVR3wBUdyPRUAKwN6QeAnpftWO7M7DBNl4L
         7zkaCctlazPwJedeJkreYp+8lmuNtWvvev5ldJCFj1cxV38NkBbz8UjSFntBZtmA+pc8
         25Cg==
X-Gm-Message-State: AHPjjUgkuUtswyBVubpmTDHr9Wh1VhmJ++cZmKPFM1gxkRQjQA8QiJS/
        xwM7+4OX1oFyuQ==
X-Google-Smtp-Source: AOwi7QCnqrZTgnsFwoUCwbG403+xiGZuV13cicB62wCGX/AterjNoOqJtmu/tW8W4+VkC+qZhcLY/A==
X-Received: by 10.84.235.76 with SMTP id g12mr8132196plt.338.1505755478876;
        Mon, 18 Sep 2017 10:24:38 -0700 (PDT)
Received: from jamill-1.corp.microsoft.com ([2001:4898:8010::75a])
        by smtp.gmail.com with ESMTPSA id s184sm14912311pfb.123.2017.09.18.10.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 10:24:38 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sxlijin@gmail.com
Subject: [PATCH v2] Improve performance of git status --ignored
Date:   Mon, 18 Sep 2017 13:24:32 -0400
Message-Id: <1505755473-6720-1-git-send-email-jamill@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20170810184936.239542-1-jamill@microsoft.com>
References: <20170810184936.239542-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second version of my patches to improve handling of
ignored files

I have decided to break the original patch series into two parts:

 1) Perf improvements to handling ignored directories

 2) Expose extra options to control which ignored files are displayed
 by git status.

This patch will address #1, and I will follow up with another patch
for #2.

This patch improves the performance of 'git status --ignored' by
cutting out unnecessary work when determining if an ignored directory
is empty or not. The current logic will recursively enumerate through
all contents of an ignored directory to determine whether it is empty
or not. The new logic will return after the 1st file is
encountered. This can result in a significant speedup in work dirs
with a lot of files in ignored directories.

As an example of the performance improvement, here is a representative
example of a repository with ~190,000 files in ~400 ignored
directories:

| Command                    | Time (s) |
| -------------------------- | -------- |
| git status                 |    1.2   |
| git status --ignored (old) |    3.9   |
| git status --ignored (new) |    1.4   |

Jameson Miller (1):
  Improve performance of git status --ignored

 dir.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

-- 
2.7.4

