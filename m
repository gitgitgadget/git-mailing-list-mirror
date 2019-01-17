Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E3A1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfAQU3e (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:29:34 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:46212 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbfAQU3e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:29:34 -0500
Received: by mail-qk1-f201.google.com with SMTP id c84so9653392qkb.13
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qr8MhcWiBmF3K0w1PbPgxycSTLe0mpfW5Oexhj6li+8=;
        b=JITWelJIIZDzii6V1n3VsnSVY2uqMi4eW7Iq4HJ1w1ytzPR/Tzn4oXYAV/PFxVZn05
         iTqbII7hoOXoZ9o3xSxlfYgQWeuVsFg7N/DDy46PXED1POAIoId4f9RwOjJHcxUW/3cQ
         OzdW+m/4wmYFqXGHLcl8Xwhmo8UYzI0+28Hj3Yjk3wz5N6UDbgmBshiBn9YTR94jcTC0
         MvMINmhZm5xbl2QDY+UzQQZJCQy+Dh3BZQInZtKeJn7h1CQur5vWewLZSyIfjtQtdEku
         5GpuRddpTIgs+Mnd+ev/ie1SpexgdzNWCWUV6IAN4I+ZVsruTDIugp9kRU10mOzRfU0W
         y4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qr8MhcWiBmF3K0w1PbPgxycSTLe0mpfW5Oexhj6li+8=;
        b=O0MujF5yVtGkDXPHFaFpFNehPdja3lEgnhjCM2R6Q+KPksqy08DazIiDpu1IdWkWas
         bXYeWWMaHiEGE++3y/6lScZWGkgp7XQtNUrV7sRIqziBafyDAlzUpU1wCbdnLNh+6IE1
         2/IuoUpN3rC7VBKKj05Tw+IF6eO+cMnw18mRPrh2VEaGs6D7Vliv7ObJo25vAmnZf001
         9BGDZ+DPIzEPz99OvXw0YiX7RaIKod5r91bLG4scffEM/Tez71rmAiaFO6ozr+ZRzC4x
         Fe3Z2thYCKZHZnGwsGM1BMx/aYORfI7W518hVTlvCGN6F5Bsse9X1OyU+BI58t2Mkk0R
         midw==
X-Gm-Message-State: AJcUukfFXG7ixnoFIUiKLRm0aAjD6Bh6g6/Ln9jJN7p+h1P8hPNM3UET
        aITsHwd/L+HYKJonn6X3q1BjGtEYDbunTkY++WucrcT5vUFvy3RyoXofIZyOPZUPuRIg56wnfP/
        ELlbPJXChBYSVU9Ai/ZoogHTusVtEWbfARnXqvPGHFYeVUN+AE8Pi
X-Google-Smtp-Source: ALg8bN4YehYc2MKn1pwzpm7wzxgZsT1RwZllpCjPr4q16Mj47dISr3kHaEPgdrq9+fx0Td54JV7XFKQW
X-Received: by 2002:a0c:98c6:: with SMTP id g6mr8617514qvd.46.1547756972856;
 Thu, 17 Jan 2019 12:29:32 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:29:16 -0500
In-Reply-To: <20190107213013.231514-1-brho@google.com>
Message-Id: <20190117202919.157326-1-brho@google.com>
Mime-Version: 1.0
References: <20190107213013.231514-1-brho@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v2 0/3] blame: add the ability to ignore commits
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds the ability to ignore a set of commits and their changes when
blaming.  This can be used to ignore a commit deemed 'not interesting,'
such as reformatting.

v1: https://public-inbox.org/git/20190107213013.231514-1-brho@google.com/
v1 -> v2
- extracted the skiplist from fsck to avoid duplicating code
- overhauled the interface and options
- split out markIgnoredFiles
- handled merges

Barret Rhoden (3):
  Move init_skiplist() outside of fsck
  blame: add the ability to ignore commits and their changes
  blame: add a config option to mark ignored lines

 Documentation/blame-options.txt | 15 +++++++++
 Documentation/git-blame.txt     |  1 +
 blame.c                         | 56 +++++++++++++++++++++++++++------
 blame.h                         |  3 ++
 builtin/blame.c                 | 33 +++++++++++++++++++
 fsck.c                          | 37 +---------------------
 oidset.c                        | 35 +++++++++++++++++++++
 oidset.h                        |  7 +++++
 8 files changed, 142 insertions(+), 45 deletions(-)

-- 
2.20.1.321.g9e740568ce-goog

