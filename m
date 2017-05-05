Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 985B2207F8
	for <e@80x24.org>; Sat,  6 May 2017 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbdEFSta (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 14:49:30 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36291 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdEFSt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 14:49:28 -0400
Received: by mail-qt0-f170.google.com with SMTP id m91so26237126qte.3
        for <git@vger.kernel.org>; Sat, 06 May 2017 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mubuv53Msupaf0QkAWX6bjUt0KDR8qQ+kbNZOCou6j4=;
        b=ni9iHs884Pp7M8LxyEpfrx6UKJq5Rukt6SMv6dWhOzk1TBAI32vhk6gFbVdwbPHMEp
         rFIR9SBTVT93pE5uMly6u3eD0UbgHMBqVzzkXT5gIZmquYzQz7UAnpEoBjKvNO73SYfz
         j3d4ntEkeJ96vPgkjlaXPrdbBlnc9Cxnk/iyuCNeNrPl+mShPZqLtROlekVIStxe+qfZ
         RD0jiL+TON8gS4aXEevk4XGVeodE7r/5Gy+Vc5JM5SJ1u+tIuJZwzIybXKT4W1q2OgBh
         Cq6Uw3pRGLYu/6bS2LtP6fOmSO/4QYRZfYbCw9SvKB620gtZkqn6KfndzcDSpIF9qavv
         Qvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mubuv53Msupaf0QkAWX6bjUt0KDR8qQ+kbNZOCou6j4=;
        b=jMw++IQAw3N/6U9fs2IcgTR64+IiV9MP5W7zYpgUS+I5qJa5plirOB2LnuWxpWtFmo
         bVk/FsrCtIJVqIH1+nJjltm3iI5UL3okcvqI/IqEhXmNLOqBNuogWWxUM1nZASmNT79L
         vMNKo3w0dJ3AZ0y4kRH6y0yVYO9yUmQdh4GwYHYXmKNnNMX7+QXDx3co+ZXEWusVzBFy
         JVgy2icDZMYFmmnTcxqW2ElK/VbocCNPhTufJZJ5uzPhGgP54XpyIIFGQND+sC6Ig3C3
         VjRbYr+UTFbFybbbWNX4CTawkcHLTtBfASwLKbYHAWFREixIWzsH0WYe8reunlLc3ctz
         mTfA==
X-Gm-Message-State: AODbwcCFA/q6RelDH1y+NXjTGPkKkMr4FZngBg7dxsSvyLM1g/3EntjM
        oG8OzzMdmD41sPEXuII=
X-Received: by 10.200.45.121 with SMTP id o54mr9731012qta.43.1494096567375;
        Sat, 06 May 2017 11:49:27 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.17])
        by smtp.gmail.com with ESMTPSA id 83sm6866347qkq.26.2017.05.06.11.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 11:49:26 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 0/9] Keep git clean -d from inadvertently removing ignored files
Date:   Fri,  5 May 2017 05:46:02 -0500
Message-Id: <20170505104611.17845-1-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses the issues raised by Stefan and Junio (thanks for your feedback) about not using C99-style comments and keeping tests working on every commit to prevent breaking git bisect. (About the latter one: is it necessary to prevent compiler warnings, in addition to compiler errors? Because if so I should probably squash some of the commits together.)

Note that this introduces a breaking change in the behavior of git status: when invoked with --ignored, git status will now return ignored files in an untracked directory, whereas previously it would not.

It's possible that there are standard practices that I might have missed, so if there is anything along those lines, I'd appreciate you letting me know. (As an aside, about the git bisect thing: is there a script somewhere that people use to test patch series before sending them out?)

Samuel Lijin (9):
  t7300: skip untracked dirs containing ignored files
  t7061: expect failure where expected behavior will change
  dir: recurse into untracked dirs for ignored files
  dir: add method to check if a dir_entry lexically contains another
  dir: hide untracked contents of untracked dirs
  dir: change linkage of cmp_name() and check_contains()
  builtin/clean: teach clean -d to skip dirs containing ignored files
  t7300: clean -d now skips untracked dirs containing ignored files
  t7061: expect ignored files in untracked dirs

 builtin/clean.c            | 24 ++++++++++++++++--
 dir.c                      | 61 ++++++++++++++++++++++++++++++++++++++++++++--
 dir.h                      |  3 +++
 t/t7061-wtstatus-ignore.sh |  1 +
 t/t7300-clean.sh           | 10 ++++++++
 5 files changed, 95 insertions(+), 4 deletions(-)

-- 
2.12.2

