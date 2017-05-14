Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF46220188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757332AbdENDQH (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35069 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757197AbdENDQG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:06 -0400
Received: by mail-oi0-f66.google.com with SMTP id m17so14323803oik.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aqQochhNySBdPzHz14HabCLDNOEHCX0MxFvgyir3jys=;
        b=lr+07vSc8y9Qf7a3tsKcfB0zNwzCXDLrgKgrpDxaeoQ83TKBLeHq6M3N9Wghc8d4hD
         doIIN5ZjFDvw3Ev52NImmMo+PA0+DYUE4S/1bHGaeu6MUjNjBZLvvnQ27YS2NoAHQMAl
         XOiKlWTR//3xipsL9fuWxCmT4CnrffPRkMjn6fbBg61q6z0y/CI/Y8hTZroS7vfo7FsS
         zLUd2LK9IFBEux3d+nlTEcz/pdkdHz4vJLUT9XGQ9/buR3VK4vqxdZ4WWmOCLNaozhRn
         Fbo9EC0eRqZHzoGYboQ2tfY7TRX1M5+H72WWxuBJOeH9/fq1kH7lH6XxeqOESWxtotjj
         IZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aqQochhNySBdPzHz14HabCLDNOEHCX0MxFvgyir3jys=;
        b=L3EH0nc+gvMdRCfIUCcXE07tx6yxXyZJr5Gsnoxszj5zaOhSJliaRQFOwaJ3Y7FD8K
         r9xNDXm8U6or3/XO3CsesH+04B9Rl4PK5x+SiZtg7T7vhOO8Ebxh0sWsKnmDcYrkkLVz
         p0ctqjTdKSxH0M1gri0CFQbkeIzymUatjlYwUfXCx4EYq80jad9m86eW6vOSh9RbWQR5
         fOn86gB+vZQvLrE3S2TlhTxjtuj8uvedMQ88d0mWLJa2s2JGf94+UOljkCExX88GHYqF
         mlHeHNP6pGHxSNOrP5Zx5lj8c5SfQA6KbpoS2PPULkoWNOleYyxN/AHxown7Av1rq35I
         se1A==
X-Gm-Message-State: AODbwcAh994B9D+dbNJlNBqB0i0fqFoWqyDD3cz7zXhW0t2PG958TkHo
        SnVoh8NcHtqYZg==
X-Received: by 10.157.20.143 with SMTP id d15mr5886671ote.35.1494731765401;
        Sat, 13 May 2017 20:16:05 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:03 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 00/22] Add blame to libgit
Date:   Sat, 13 May 2017 22:14:51 -0500
Message-Id: <20170514031513.9042-1-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170505052729.7576-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than duplicate large portions of builtin/blame.c in cgit, it
would be better to shift its core functionality into libgit.a.  The
functionality left in builtin/blame.c mostly relates to terminal
presentation.

Since initial patchset:
  Made commit titles consistent
  Broke some commits into more atomic pieces
  Fleshed out commit message bodies
  Made public structure and method names more clearly blame-related

Jeff Smith (22):
  blame: remove unneeded dependency on blob.h
  blame: move textconv_object with related functions
  blame: remove unused parameters
  blame: move origin and entry structures to header
  blame: move scoreboard structure to header
  blame: move stat counters to scoreboard
  blame: move copy/move thresholds to scoreboard
  blame: move contents_from to scoreboard
  blame: move reverse flag to scoreboard
  blame: move show_root flag to scoreboard
  blame: move xdl_opts flags to scoreboard
  blame: move no_whole_file_rename flag to scoreboard
  blame: make sanity_check use a callback in scoreboard
  blame: move progess updates to a scoreboard callback
  blame: wrap blame_sort and compare_blame_final
  blame: rework methods that determine 'final' commit
  blame: move origin-related methods to libgit
  blame: move fake-commit-related methods to libgit
  blame: move scoreboard-related methods to libgit
  blame: create scoreboard init function in libgit
  blame: create scoreboard setup function in libgit
  blame: create entry prepend function in libgit

 Makefile           |    1 +
 blame.c            | 1863 +++++++++++++++++++++++++++++++++++++++++++++
 blame.h            |  175 +++++
 builtin.h          |    2 -
 builtin/blame.c    | 2130 ++--------------------------------------------------
 builtin/cat-file.c |    1 +
 diff.c             |   23 +
 diff.h             |    7 +
 8 files changed, 2143 insertions(+), 2059 deletions(-)
 create mode 100644 blame.c
 create mode 100644 blame.h

-- 
2.9.3

