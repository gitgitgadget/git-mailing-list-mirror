Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2D11F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 09:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfJGJ07 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 05:26:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37238 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJGJ07 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 05:26:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so13413493wro.4
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rv0Vma0PfiIUEeKX0rfmxRUk+/4HGWZPP2I9fSwBp5M=;
        b=rhKpXd1eK4XWlLRJlEV80tL4ImCQX3FCVJuJCQv11BuAhrCq4IDuqz0wI2gqTlllXq
         aHlEXolNTUj0JNV58GO31ik1OV8mkk90anTd0lmD1TPzH5th5PfM6inIKcJGat12fgkn
         7ghVvx1zpEyZv5AW2Ap7n7wWa5tiN3sv2CghPwzUkU+VHOZuH5B07TAx4tDTs2GBgwQe
         oculvoxY2MW0Eh1+xB/CfEvEp6+oXBCRBGRaFomeZor9e9nG/7/vq6qXd4BA4rYgXQ0o
         aBFA7AUJ0eqZDuEUcHJ2NQ0v1M+AxbWzrIL9cHV4ENPqqnL1Ya1O29j8QMPv/ThEXYZx
         lg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rv0Vma0PfiIUEeKX0rfmxRUk+/4HGWZPP2I9fSwBp5M=;
        b=efhNXHKMoP3e0eTIaSWzpkvtt5rIodUJuW2e+iL7OMBM3F+WxXK86nlw2LI9mE76sB
         2fKyTj8Dny4vdKt9v6kTdWEaZLi4FuqW0QmHKCzEtyLwK9PTgke6Ig04+JRfBC4Y9Vor
         K1Ub3mIS0g2IKnxh48TH31Xit4uAYv33jInRqWN2fRnJ8Cgpk+1SzRpAjb4ZbrCa3Vbn
         O199rgrksykCwvwcW6CoCEIVmPom5y/yqbutPvPYTNmMsVtk00PBwAMMopAbui69uRVU
         AYp7KQt59/lLUC3gFewWloJdlXiVaJ0oNsaKPbrSwNElQY/9dVAQVhe7rNTXFSPSVRgL
         ac8g==
X-Gm-Message-State: APjAAAXwNGu/qjqOkmlEJoFACzXIJQZ/G69cSY2tjMutjRsZsrg8ZPoP
        3b8XTFIsd5beE7HDhaCVaE7tM5Pc
X-Google-Smtp-Source: APXvYqyNCLVoGXYHBYT4T1/RjMSwCEJfraSeXAsETQwRlk/FfmkxdCaFJcuUnIYGKfyL39gXZ+9YDw==
X-Received: by 2002:a5d:4043:: with SMTP id w3mr22616111wrp.318.1570440415914;
        Mon, 07 Oct 2019 02:26:55 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-47-220.w86-221.abo.wanadoo.fr. [86.221.54.220])
        by smtp.googlemail.com with ESMTPSA id w125sm25250914wmg.32.2019.10.07.02.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 02:26:55 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 0/5] Use complete_action's todo list to do the rebase
Date:   Mon,  7 Oct 2019 11:26:36 +0200
Message-Id: <20191007092641.12661-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925201315.19722-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
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

Changes since v1:

 - Rewording of patches 1, 2, 4 and 5 according to comments made by
   Phillip Wood, Junio C Hamano and Johannes Schindelin.

The tip of this series is tagged as "reduce-todo-list-cont-v2" at
https://github.com/agrn/git.

[0] http://public-inbox.org/git/20190717143918.7406-1-alban.gruin@gmail.com/
[1] http://public-inbox.org/git/1732521.CJWHkCQAay@andromeda/

Alban Gruin (5):
  sequencer: update `total_nr' when adding an item to a todo list
  sequencer: update `done_nr' when skipping commands in a todo list
  sequencer: move the code writing total_nr on the disk to a new
    function
  rebase: fill `squash_onto' in get_replay_opts()
  sequencer: directly call pick_commits() from complete_action()

 builtin/rebase.c |  5 +++++
 sequencer.c      | 26 ++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

Diff-intervalle contre v1 :
1:  d177b0de1a ! 1:  9215b191c7 sequencer: update `total_nr' when adding an item to a todo list
    @@ Metadata
      ## Commit message ##
         sequencer: update `total_nr' when adding an item to a todo list
     
    -    `total_nr' is the total amount of items, done and toto, that are in a
    -    todo list.  But unlike `nr', it was not updated when an item was
    -    appended to the list.
    +    `total_nr' is the total number of items, counting both done and todo,
    +    that are in a todo list.  But unlike `nr', it was not updated when an
    +    item was appended to the list.
     
         This variable is mostly used by command prompts (ie. git-prompt.sh and
    -    the like).
    +    the like).  By forgetting to update it, the original code made it not
    +    reflect the reality, but this flaw was masked by the code calling
    +    unnecessarily read_todo_list() again to update the variable to its
    +    correct value.  At the end of this series, the unnecessary call will be
    +    removed, and the inconsistency addressed by this patch would start to
    +    matter.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
2:  09fcbe159b ! 2:  7cad541092 sequencer: update `done_nr' when skipping commands in a todo list
    @@ Commit message
         or skipped, but skip_unnecessary_picks() did not update it.
     
         This variable is mostly used by command prompts (ie. git-prompt.sh and
    -    the like).
    +    the like).  As in the previous commit, this inconsistent behaviour is
    +    not a problem yet, but it would start to matter at the end of this
    +    series the same reason.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
3:  26a18cd1a9 = 3:  7c9c4ddd30 sequencer: move the code writing total_nr on the disk to a new function
4:  5d74903cfe ! 4:  cd44fb4e10 rebase: fill `squash_onto' in get_replay_opts()
    @@ Metadata
      ## Commit message ##
         rebase: fill `squash_onto' in get_replay_opts()
     
    -    get_replay_opts() did not fill `squash_onto' if possible, meaning that
    -    this field should be read from the disk by the sequencer through
    -    read_populate_opts().  Without this, calling `pick_commits()' directly
    -    will result in incorrect results with `rebase --root'.
    +    Currently, the get_replay_opts() function does not initialise the
    +    `squash_onto' field (which is used for the `--root' mode), only
    +    read_populate_opts() does.  That would lead to incorrect results when
    +    calling pick_commits() without reading the options from the disk first.
     
         Let’s change that.
     
5:  dc803c671f ! 5:  523fdd35a1 sequencer: directly call pick_commits() from complete_action()
    @@ Commit message
         sequencer: directly call pick_commits() from complete_action()
     
         Currently, complete_action() calls sequencer_continue() to do the
    -    rebase.  Even though the former already has the todo list, the latter
    -    loads it from the disk and parses it.  Calling directly pick_commits()
    -    from complete_action() avoids this unnecessary round trip.
    +    rebase.  Before the former calls pick_commits(), it
    +
    +     - calls read_and_refresh_cache() -- this is unnecessary here as we've
    +       just called require_clean_work_tree()
    +     - calls read_populate_opts() -- this is unnecessary as we're starting a
    +       new rebase, so opts is fully populated
    +     - loads the todo list -- this is unnecessary as we've just populated
    +       the todo list
    +     - commits any staged changes -- this is unnecessary as we're starting a
    +       new rebase, so there are no staged changes
    +     - calls record_in_rewritten() -- this is unnecessary as we're starting
    +       a new rebase.
    +
    +    This changes complete_action() to directly call pick_commits() to avoid
    +    these unnecessary steps.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
-- 
2.23.0

