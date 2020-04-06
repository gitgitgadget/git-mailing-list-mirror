Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE443C2BA1A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 22:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC2D2072A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 22:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POHU0aHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDFWpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:45:34 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:37004 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFWpe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 18:45:34 -0400
Received: by mail-pj1-f74.google.com with SMTP id a12so1406pju.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 15:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=EoUTh9WkJx1wxVAZGu2r0Z6VM0Sk5qeY3OREBMvSalE=;
        b=POHU0aHyKiTiYGUaTc0HTZk0FIICmRNokTeWi4MTzOhBU2/Vhbm2aCSRK2dXKezcok
         krvRPo/+Jsffg5C+SJ3XtMf2sT0lOi8aTJsNcI5t4pHqbR/Zp4NiB1bFYtgeFPST3WED
         ckp85KXr5G5jbARtZGFzgp3Ck8E7y/ONBUr5ZfLVtf6qlgfBCvlVobefTTre/C3GCV5N
         rm+0xlwgAB9W2PYcvmsktY97J6wZEzxisjmZokOp38rKUHR45igPdsoSY9C0ge7SWRaF
         jqGvcbrU+ehb4xZrDfNXTNfU13sUFc1A+swbJAHbKdt6FlkWP06EHWrjjk32wzQbD6h7
         avfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=EoUTh9WkJx1wxVAZGu2r0Z6VM0Sk5qeY3OREBMvSalE=;
        b=SlmcemrSQjSpxSuvkO7B/0cAN9Wbcv+FLxMrIyyrrRf9F1F4QYxeqwVhTZNwv6ZbqM
         Zwm3U9fma1O5bhsP8s/H04x3uunx208zQt32LYMSi4Iu74VKle5BsLBV0hgQ7jUvTXOz
         SMKwKhHwZHhEXY8CNwCAnwVemBpp4WH/xSOY7GfK9zIpaQMgNctd4eOzhI3p+ExjsV9k
         SoKIbYjW0dx70+ixwWjwSL3YaP4b21GHQxNm+LFJMG4F21o6tZLoi6NYJujnxRWjCDn7
         jwlwwcON+m+6nMneI2qiiLjfIkBwS3w2FvIMXq6femOe4NsV9bzMbYKwbaezfD6JyIj9
         3ReA==
X-Gm-Message-State: AGi0PuZBEtNt2hH25aQqlMSBLFG1QYhzbrMaPFs+0joATK1TFS2tV8aQ
        pJebxuWy0L2CN5rDNIZd9x0lzs0bUNnS60D5BXjG8FIKoDzx6JTM2BHwZbT8mCdu1ekJKV/f8Ri
        vZ/cIJs68dYGyBzs34X2lUZ95HFivBj9xqGeXEVMPS4ExOgBL2z8E+UyVy/UinalC2xFBk1yUvw
        ==
X-Google-Smtp-Source: APiQypJby8qv94IQTNQ0hIkFN8YZhXUzvwiNUxDwbiKOmXZz9W5us0a1PIgdKRpHMdom/24cwl6ENrn9o/6u2RtS6CY=
X-Received: by 2002:a63:6b45:: with SMTP id g66mr1133897pgc.99.1586213133049;
 Mon, 06 Apr 2020 15:45:33 -0700 (PDT)
Date:   Mon,  6 Apr 2020 15:45:21 -0700
In-Reply-To: <20200325212500.135046-1-emilyshaffer@google.com>
Message-Id: <20200406224526.256074-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v12 0/5] bugreport: add tool to generate debugging info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Martin=20=C3=85gren?=" <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v11, reordered tests per SZEDER's comment so that the
test_when_finished lines come first in each test.

Emily Shaffer (5):
  help: move list_config_help to builtin/help
  bugreport: add tool to generate debugging info
  bugreport: gather git version and build info
  bugreport: add uname info
  bugreport: add compiler info

 .gitignore                      |   2 +
 Documentation/git-bugreport.txt |  52 ++++++++++++
 Makefile                        |  18 +++-
 bugreport.c                     | 142 ++++++++++++++++++++++++++++++++
 builtin/help.c                  |  86 +++++++++++++++++++
 command-list.txt                |   1 +
 compat/compiler.h               |  41 +++++++++
 generate-cmdlist.sh             |  19 -----
 generate-configlist.sh          |  21 +++++
 help.c                          | 131 +++++++----------------------
 help.h                          |   2 +-
 strbuf.c                        |   4 +
 strbuf.h                        |   1 +
 t/t0091-bugreport.sh            |  61 ++++++++++++++
 14 files changed, 455 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100644 compat/compiler.h
 create mode 100755 generate-configlist.sh
 create mode 100755 t/t0091-bugreport.sh

-- 
2.26.0.292.g33ef6b2f38-goog

