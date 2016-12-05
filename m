Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1959F1FC96
	for <e@80x24.org>; Mon,  5 Dec 2016 14:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbcLEOhy (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 09:37:54 -0500
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35805 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbcLEOhx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 09:37:53 -0500
Received: by mail-yw0-f181.google.com with SMTP id i145so255113511ywg.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 06:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=TTitohAlu/mKtygPoExXaHKGk4rAc+w2FdVkV7hFnQg=;
        b=uk5u5wjGSe1kqFv2ErLU3TinNW8uS1efAtLVaO+LDma4czPeOMgpKkPd3wwUiubeg8
         h3db84e0tBk37LRi6xVQUejipws0nUt4AogcnAU/AV06ExKPv5gKLlWJrdSCBKm7rqIH
         OgeiuCg2bBwq3tGB/xE/yjGbOU3VapTCgxCfuq1S4WZ35bteN930wiRXQBkkJ9t6b0qB
         3e5izB3pLH1+09Be/VsU08l8UXRBz7sN5hiczTCb64f2GItyRKyw+n0UKpZfbjdHGlWA
         xA0FWeTDhQVQ6sqJoU33MPtV0jOO6jI45LNjeGIrDfgJVHjPpjDkqhJfy12B+bl5QREP
         L6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TTitohAlu/mKtygPoExXaHKGk4rAc+w2FdVkV7hFnQg=;
        b=TtzRuYnZTxwbhTXEIPxuvdHY13QcIxpe/bQptsorsfrHceQsMijhF1vHYI/D9ZQjZG
         JZ5KjjD5Z9awDw6NUYtp83nPkoXXo8WFuWv5eBFMZDcOvM/p0g9MbT1YYPkFSus/0T4v
         2avuNo+F0fIQ/deOMWAnf0N/Q2KvnG6yrOZvc9cQWYRjbQUcM7/Y/ssDufFmhpR98ByG
         Vmazum/X6fmtFMH5Ps+TBuoYiOHJ/kFKrdxbTLtlSigUYclNG5Ac8+myEe+c7fsX6j4E
         vtkaZ65t2jiouoEM1pf/Aj4g3rg6AMJBctn1Lf6hL8XgqOqO3mfbdPFjYhC5q3yz0ePX
         odBA==
X-Gm-Message-State: AKaTC01iTxKsJtSvE2E7pdWdebQgVuQOvJgBHWhjvJa/TuxEsjN9ZLrLwj66kSyoC8LMs3tOdeDbFXihcx6UkQ==
X-Received: by 10.129.106.215 with SMTP id f206mr53518664ywc.210.1480948672168;
 Mon, 05 Dec 2016 06:37:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.216.215 with HTTP; Mon, 5 Dec 2016 06:37:51 -0800 (PST)
From:   Matthew Patey <matthew.patey2167@gmail.com>
Date:   Mon, 5 Dec 2016 09:37:51 -0500
Message-ID: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
Subject: Bug: stash staged file move loses original file deletion
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git version 2.8.0 (sorry can't update to more recent on my machine) on Ubuntu.

After moving a file, if the new file is in the index but the deletion
of the old file is not staged, git stash loses the deletion operation.
Repro:

1. git mv a b
This will have both the "deletion" and the "file added" in the index

2. git stash; git stash pop
Now file a is still in the index, but file b deletion is not staged.

3. git stash; git stash show -v
This will show that the deletion operation is not in the stash

4. git stash pop
Again confirms the issue, file a is in the index, but file b is
present and unmodified in the working directory.
