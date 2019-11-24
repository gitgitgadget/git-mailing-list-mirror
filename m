Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE165C432C3
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E463207DD
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOxd4oCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKXRpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:45:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37747 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKXRpj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 12:45:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id t1so14732835wrv.4
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 09:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMiTw6jXXcGijeMQbFDNLn+VyxhGxjCMltbZkdVcTFY=;
        b=kOxd4oCtUVC9f1LQsHNPeavUCbnQmWZKke64sjSVFqLP9AjGv+DjmS4iOgBuHg0dOI
         gejnxwhdlnqXy2KKHdMILIGHCyY2OOKdeMv2PL3VIPH1vDfolFLIMVCiJskKSiGTQQCH
         +WDu9GnIl3LNUew24sIGM+IeD2w86Ear7Nbd3KSdJ1BDGWH6/F5FtXtyDGCOUNu6Xvfk
         koE/I+k+F+QSWP0gbYoxbcoRO3jTpXFnZ3A1OBAIlB1W+JJY8gppFjjLSO91DzRcHLGp
         /Dlq9TK7lP2/Rq9mzY/tbkRQXyU+JJRuHTKwOvS16oxE33Za5FSQlEIAieBhrDyPs+aF
         2T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMiTw6jXXcGijeMQbFDNLn+VyxhGxjCMltbZkdVcTFY=;
        b=p3O3BrpEWImW7PXMw6qz18L1hlJz+g95WGS6CuVwIgsvTB3YEZEZPlcAkxNz2wODEe
         pZ8rbF1nYj0mKf0lpwlo4O+OHhrp0pNHeoUW9XO/63tCS3XXdd42QtLASMRcne08YXZX
         wInSuo/oKL+Dy6WgZSY1EUcuDpC4DDVieTbqY+xyT1ECpqBy9GpVhTrDSO8v/uuLT++w
         uYoypkW37+9hDoy6JOt0i3V/1ZzbOk3DnEnlsQnraErb92+9sOlTn4Vryf3NmiqElva6
         oQyBlNJqmTFvbBO4V8OYqeGsYJRfqQ7AIxVJhwKBBLpMc2sUfNGMQONfTGn7H3ADYp4b
         7HTA==
X-Gm-Message-State: APjAAAXkq1gigmZXzF3eThEHwdHDVUD/fbPoIPI8e2pNCuAQEUxOw4lp
        VDl4UHdheso0+C9Z7Nv2U8GXgLlp
X-Google-Smtp-Source: APXvYqzS7e/G6i3DJMcRkSgTJg1DkGNdgXabbFjxnkQJ7qsx/Dm9Hq5cIOGPj+6yj2ebrfS+MfDlkQ==
X-Received: by 2002:adf:e303:: with SMTP id b3mr12019419wrj.335.1574617537047;
        Sun, 24 Nov 2019 09:45:37 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id a2sm7171315wrt.79.2019.11.24.09.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 09:45:36 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 0/5] Use complete_action's todo list to do the rebase
Date:   Sun, 24 Nov 2019 18:43:27 +0100
Message-Id: <20191124174332.30887-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191123143705.17280-1-alban.gruin@gmail.com>
References: <20191123143705.17280-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This can be seen as a continuation of ag/reduce-rewriting-todo.

Currently, complete_action() releases its todo list before calling
sequencer_continue(), which reloads the todo list from the disk.  This
series removes this useless round trip.

Patches 1, 2, and 3 originally come from a series meaning to improve
rebase.missingCommitsCheck[0].  In the original series, I wanted to
check for missing commits in read_populate_todo(), so a warning could be
issued after a `rebase --continue' or an `exec' commands.  But, in the
case of the initial edit, it is already checked in complete_action(),
and would be checked a second time in sequencer_continue() (a caller of
read_populate_todo()).  So I hacked up sequencer_continue() to accept a
pointer to a todo list, and if not null, would skip the call to
read_populate_todo().  (This was really ugly, to be honest.)  Some
issues arose with git-prompt.sh[1], hence 1, 2 and 3.

Patch 5 is a new approach to what I did first.  Instead of bolting a new
parameter to sequencer_continue(), this makes complete_action() calling
directly pick_commits().

This is based on 4c86140027 ("Third batch").

Changes since v3:

 - s/amount/number/ on patches 2 and 3, according to a comment from
   Junio[2] that I had forgotten before I sent the v3 X-(

The tip of this series is tagged as reduce-todo-list-cont-v4 at
https://github.com/agrn/git.

[0] http://public-inbox.org/git/20190717143918.7406-1-alban.gruin@gmail.com/
[1] http://public-inbox.org/git/1732521.CJWHkCQAay@andromeda/
[2] http://public-inbox.org/git/xmqqmuecnefe.fsf@gitster-ct.c.googlers.com/

Alban Gruin (5):
  sequencer: update `total_nr' when adding an item to a todo list
  sequencer: update `done_nr' when skipping commands in a todo list
  sequencer: move the code writing total_nr on the disk to a new
    function
  rebase: fill `squash_onto' in get_replay_opts()
  sequencer: directly call pick_commits() from complete_action()

 builtin/rebase.c |  5 +++++
 sequencer.c      | 32 +++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

Diff-intervalle contre v3 :
1:  11a221e82e = 1:  11a221e82e sequencer: update `total_nr' when adding an item to a todo list
2:  76a3af70b6 ! 2:  6b402a3070 sequencer: update `done_nr' when skipping commands in a todo list
    @@ Metadata
      ## Commit message ##
         sequencer: update `done_nr' when skipping commands in a todo list
     
    -    In a todo list, `done_nr' is the amount of commands that were executed
    +    In a todo list, `done_nr' is the number of commands that were executed
         or skipped, but skip_unnecessary_picks() did not update it.
     
         This variable is mostly used by command prompts (ie. git-prompt.sh and
3:  9c5bd30465 ! 3:  0171db4fba sequencer: move the code writing total_nr on the disk to a new function
    @@ Metadata
      ## Commit message ##
         sequencer: move the code writing total_nr on the disk to a new function
     
    -    The total amount of commands can be used to show the progression of the
    +    The total number of commands can be used to show the progression of the
         rebasing in a shell.  It is written to the disk by read_populate_todo()
         when the todo list is loaded from sequencer_continue() or
         pick_commits(), but not by complete_action().
4:  bc3d69a10e = 4:  88f6335c37 rebase: fill `squash_onto' in get_replay_opts()
5:  e7691db66b = 5:  53586b1bed sequencer: directly call pick_commits() from complete_action()
-- 
2.24.0

