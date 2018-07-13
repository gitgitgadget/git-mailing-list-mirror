Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737651F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 05:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeGMGF7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 02:05:59 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:39850 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeGMGF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 02:05:59 -0400
Received: by mail-io0-f177.google.com with SMTP id e13-v6so30321322iof.6
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 22:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=jrM5pxmkl5YRIwOl82JDOllwS8l+b9RQZjoXEUaApps=;
        b=HVAP3QIiVQrXnPfP/mYR1IdIPF/TIgkZxJJ1ES3psVnHQCMwHDVkt1tMBXM6uHo8G2
         GQON2LY2olSurH8b4xV+kF9K5bLbHiobGAPSFYD73d70pCjoozJlrby2f6mXAHp/AbCm
         +2GAyUaQRS1PZH3Fdo5eJOifWPnxmTV+Qzf+iA2IP55vZz8Ea/js1boDm8x4csMaB7CA
         7WeuAoxtsbYMCPI4I7gjGqPFsrhYng33L/0xpbWT67xvU8PqPPmdP/07tACLz9+0WX2D
         HvVMLkdSol+vjU6vbiquMQ4RWSwVGEaMplhHth3aegmWH83fKufioeT79BbkcKiQJN0L
         eTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=jrM5pxmkl5YRIwOl82JDOllwS8l+b9RQZjoXEUaApps=;
        b=QKQ50SmoF5FmX6QhF1VZAlROJ8uid7tNLaTHqAZwrruuaObvokVemDsLpvFi/RHDJh
         FYNIOcFcN6I4D8sutwcOwSpAn/T31jVV/JGy3EcxlBrfi+rQByF/DU0Vk/8Y2C62FYuf
         0uGoooc3KcWspED2pylO+wNY8rBnlG3khsZf0JQGEi3mYgBW58V8u/GgZ6VM3CIx1rQB
         RH5OWfZDfJxV6vJoquolbOvC/t7eDz9Sn78uh9eDtunBSUgkjrbSNcwz6CFFPdwfgLkY
         5mNwiF5/bsxdjfwmH0w425OKTwtvGhIrn18kNXdBfbwE9CZEnzSbLkfhFu/kyDdFzS6r
         SUiQ==
X-Gm-Message-State: APt69E0YpEpVa6a22J0fR0BmryVvrwC0JM+Sx1rJZ/01bzrWWJsoZKU9
        jrkn+M6uV5P/RW99LBnN9IMBkQ==
X-Google-Smtp-Source: AAOMgpeEug9KhNOKv1C6ylR3IJQAe3uA9qvJpYKNWMRXSLnMBElt92bI4Tt3MQuokv+Ll8pZxj6d/w==
X-Received: by 2002:a6b:1644:: with SMTP id 65-v6mr24537240iow.137.1531461177279;
        Thu, 12 Jul 2018 22:52:57 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id m10-v6sm3138036ioj.22.2018.07.12.22.52.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 22:52:56 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/4] test-lint: detect one-shot "FOO=bar shell_func"
Date:   Fri, 13 Jul 2018 01:52:01 -0400
Message-Id: <20180713055205.32351-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One-shot "FOO=bar cmd" environment variable assignments exist only
during invocation of 'cmd'. However, if 'cmd' is a shell function, then
the variable is assigned in the running shell and exists until the
process exits (or is unset explicitly). Such a side-effect is almost
certainly unintended by a test author and is likely due to lack of
familiarity with the problem.

Upgrade "make test-lint" to detect this sort of suspect usage.

Also fix a couple instances of "FOO=bar shell_func" detected by the
improved linting.

This series is built atop 'jc/t3404-one-shot-export-fix'[1].

[1]: https://public-inbox.org/git/xmqqefg8w73c.fsf@gitster-ct.c.googlers.com/T/

Eric Sunshine (4):
  t6046/t9833: fix use of "VAR=VAL cmd" with a shell function
  t/check-non-portable-shell: stop being so polite
  t/check-non-portable-shell: make error messages more compact
  t/check-non-portable-shell: detect "FOO=bar shell_func"

 t/check-non-portable-shell.pl          | 31 +++++++++++++++++++++-----
 t/t6046-merge-skip-unneeded-updates.sh |  4 +++-
 t/t9833-errors.sh                      |  4 +++-
 3 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.18.0.233.g985f88cf7e
