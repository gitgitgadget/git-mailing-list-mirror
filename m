Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC6620756
	for <e@80x24.org>; Tue, 10 Jan 2017 18:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934153AbdAJSye (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 13:54:34 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36264 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933330AbdAJSyb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 13:54:31 -0500
Received: by mail-pf0-f182.google.com with SMTP id 189so38898350pfu.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 10:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rxm7dj+rqn8x44dhtbkh/HhUP6LtgVk16l0UUphiEGU=;
        b=AB+dtmYM5BGjSmClTVTBo0RXm6qYAWH4yr+VqBcifZAXVFroGd0qt30wd0U4lQAB1n
         fG4k01xm2KL0C6kxuupm7SEbesWiysWsyyM6CwfflSkrgMlMGpI/eRy4yn5mdNv0QEYU
         PbPUPjsk1G5Hz6K/SsimWItzjkvMxS78D5Mw8IrUzkfw1Qtkt6Qfx1TPS0UHetIbEzSm
         lP/ihJV+8njInqEJD9SyKnga1B0CgO5SPlnpJtnvJAK1Zqx6QTL8L9EIJIu2rNn3Et3Q
         rFvi/PXFO2FWGOzJ10rhF42HIo8bOX/f8uJITC5HYKiDuOBc91DvPjpriNXURsYOt0YW
         yQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rxm7dj+rqn8x44dhtbkh/HhUP6LtgVk16l0UUphiEGU=;
        b=CDli3jI0vUywMq3BHIxymFYDQdRGbHisSP8vQDH0BIdtkrctVzKX42GQ+KlYhdvTJ8
         WPqv6W/3W5duIrvdY8kK0tg265FUp+iYMM/ziwT4MDCS81byewXVPUYb0Of8JqPeehEe
         +a9V0+WWKSQS/ko5nuIU2k1WR1+18GsHaou7LuAgPJTcE3nPji9jM9zW9GlnuHAzJiXJ
         foEvp2jM8g5AgpIFgIyQnrGIrWCoQdYuAuRLF/gJkPg7mIH+pSRcnj6QkA3gP3lA0+3X
         zglepfWUJIzKcy/0cCdEnKCoejyxhagR1K9nRMROtpfARuWx5ttpJNm/Fz/0Qa3LvhTV
         B1Kw==
X-Gm-Message-State: AIkVDXIqs34oru0FOLCvgmWPw4JwJ3uaPAKtkqRHa3eQGJzCZM7TYUHfUBgvxxSUEUJJp9pY
X-Received: by 10.99.238.17 with SMTP id e17mr5875854pgi.58.1484074470290;
        Tue, 10 Jan 2017 10:54:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1e2:be00:4066:92e5])
        by smtp.gmail.com with ESMTPSA id n25sm7548300pfi.33.2017.01.10.10.54.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 10:54:29 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: git-mergetool to be used for rebases as well?
Date:   Tue, 10 Jan 2017 10:54:21 -0800
Message-Id: <20170110185421.2638-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An internal user report running on origin/next:

    $ git pull
        From .
         * branch                ... -> FETCH_HEAD
        First, rewinding head to replay your work on top of it...
        Applying: ...
        Applying: ...
        Using index info to reconstruct a base tree...
        CONFLICT (content): ....
        error: Failed to merge in the changes.
        Patch failed at 0002...
        The copy of the patch that failed is found in: .git/rebase-apply/patch

        When you have resolved this problem, run "git rebase --continue".
        If you prefer to skip this patch, run "git rebase --skip" instead.
        To check out the original branch and stop rebasing, run "git rebase --abort".
    $ git status
        rebase in progress; onto ...
        You are currently rebasing branch '...' on '...'.

        Changes to be committed:
                modified:   ...

        Unmerged paths:
                both modified:   ...

    $ git mergetool
        No files need merging
    $ git diff <file name>
        diff --cc <file name>
        index ...
        --- a/file
        +++ b/file
        @@@ ...
          content
        ++<<<<<<< HEAD
         +  content
        ++=======
        +   content
        ++>>>>>>> other commit
        content


The mergetool used to work apparently, but stopped for rebases.
I noticed in neither t7610-mergetool.sh nor any rebase test the combination of
rebase and mergetool is tested.

Stefan


