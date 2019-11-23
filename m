Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86963C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5144320706
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvHF20GL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKWOq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 09:46:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36697 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfKWOq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 09:46:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so12116805wru.3
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 06:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+2SubINweCIHuMBWbzG1663cGH29UVYCseeLIMysjI=;
        b=SvHF20GLR8eGllVSTm+ItEhmH6auhaJJih1lgiGzrIBxwY++PF+lwx99qlYAC335eB
         cHmtLiY9ZsZ2K4IqPpTulAfuQ8h8YaUrLRDOC096hub0kGMcBjUYR5mcJklk5YsHk9Ul
         iL1mj/D8OzyllZ3SyOkorR7qbcCKJG66uVBOIacgHzCjAgHqqmWCN3/B7RfYOuJ+hWjy
         VoyuzGbjocWID2Ce2jJdD4XDsORRsEkcInO8MhscZ6nR7T7NjHeS/K3bLCpxNz7mM7wp
         F/8Vaswc8ozjqjcSzEkVVtv4FmqEcVUc0e+R8AMsZQKOq6ULIyIfYfrjXubd1E+NDfbv
         84ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+2SubINweCIHuMBWbzG1663cGH29UVYCseeLIMysjI=;
        b=IS8mwH7Lz+Sadt8UGg+4n36j2pksqTCuVKa9njulcmLySivZcmjVTnzefafb09AabK
         XdbSx+ie7acmGRr6Anwrd6Lga4EJ5o7KsK452ylyD8Nd9xFEWs+vA7hkBHKR+dDEsq3p
         ytVRfk1XEQgkaHOunCft1Fp9AsPvYs5ynBbdqnimctpzLpk25mLW1oVN4WJCSztWF1yX
         ButP/XzYbSRVI4uZUINJa5zPLNyj7V7XEKUt2unWEowEr8/7ABu/ehDoOUPp84sLQVg8
         Q3EopCK9zeDP9auPfUiEZO6anMa8AxM7wK7JFXTLkT5VZUl4Hcpp/dXdwFGjf5XblEZZ
         FgEA==
X-Gm-Message-State: APjAAAWTghOTfLG9q4zov6poQ08EWe7iydjvXx26tw9R50fnu+5dy1jI
        2klRSQLbrJy4mnfgonRN3k8ozkc/
X-Google-Smtp-Source: APXvYqz33v13+tvzjrUdkbJRigoV6OnbxBNS2hefGA2N+4oi2FRIqpo19bSKh+QhFYpc+AD5JODjBQ==
X-Received: by 2002:adf:db86:: with SMTP id u6mr23935733wri.318.1574520038391;
        Sat, 23 Nov 2019 06:40:38 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id b10sm2399298wrw.53.2019.11.23.06.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 06:40:37 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 0/5] Use complete_action's todo list to do the rebase
Date:   Sat, 23 Nov 2019 15:37:00 +0100
Message-Id: <20191123143705.17280-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191007092641.12661-1-alban.gruin@gmail.com>
References: <20191007092641.12661-1-alban.gruin@gmail.com>
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

Changes since v2:

 - Patch 1 has been reworded to fix a mistake in read_populate_todo()'s
   name, reported by Jonathan Tan.
 - Patches 4 and 5 has been reworded to improve descriptions of the code
   paths, according to comments made by Jonathan Tan.
 - Squashed b0537b0ec3 ("SQUASH??? tentative leakfix") into the 5th
   patch to fix a memory leak reported by René Sharfe.

The tip of this series is tagged as "reduce-todo-list-cont-v3" at
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
 sequencer.c      | 32 +++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

Diff-intervalle contre v2 :
1:  9215b191c7 ! 1:  11a221e82e sequencer: update `total_nr' when adding an item to a todo list
    @@ Commit message
         This variable is mostly used by command prompts (ie. git-prompt.sh and
         the like).  By forgetting to update it, the original code made it not
         reflect the reality, but this flaw was masked by the code calling
    -    unnecessarily read_todo_list() again to update the variable to its
    +    unnecessarily read_populate_todo() again to update the variable to its
         correct value.  At the end of this series, the unnecessary call will be
         removed, and the inconsistency addressed by this patch would start to
         matter.
2:  7cad541092 = 2:  76a3af70b6 sequencer: update `done_nr' when skipping commands in a todo list
3:  7c9c4ddd30 = 3:  9c5bd30465 sequencer: move the code writing total_nr on the disk to a new function
4:  cd44fb4e10 ! 4:  bc3d69a10e rebase: fill `squash_onto' in get_replay_opts()
    @@ Metadata
      ## Commit message ##
         rebase: fill `squash_onto' in get_replay_opts()
     
    -    Currently, the get_replay_opts() function does not initialise the
    -    `squash_onto' field (which is used for the `--root' mode), only
    -    read_populate_opts() does.  That would lead to incorrect results when
    -    calling pick_commits() without reading the options from the disk first.
    +    When sequencer_continue() is called by complete_action(), `opts' has
    +    been filled by get_replay_opts().  Currently, it does not initialise the
    +    `squash_onto' field (used by the `--root' mode), only
    +    read_populate_opts() does.  It’s not a problem yet since
    +    sequencer_continue() calls it before pick_commits(), but it would lead
    +    to incorrect results once complete_action() is modified to call
    +    pick_commits() directly.
     
         Let’s change that.
     
5:  523fdd35a1 ! 5:  e7691db66b sequencer: directly call pick_commits() from complete_action()
    @@ Metadata
      ## Commit message ##
         sequencer: directly call pick_commits() from complete_action()
     
    -    Currently, complete_action() calls sequencer_continue() to do the
    -    rebase.  Before the former calls pick_commits(), it
    +    Currently, complete_action(), used by builtin/rebase.c to start a new
    +    rebase, calls sequencer_continue() to do it.  Before the former calls
    +    pick_commits(), it
     
          - calls read_and_refresh_cache() -- this is unnecessary here as we've
    -       just called require_clean_work_tree()
    +       just called require_clean_work_tree() in complete_action()
          - calls read_populate_opts() -- this is unnecessary as we're starting a
    -       new rebase, so opts is fully populated
    +       new rebase, so `opts' is fully populated
          - loads the todo list -- this is unnecessary as we've just populated
    -       the todo list
    +       the todo list in complete_action()
          - commits any staged changes -- this is unnecessary as we're starting a
            new rebase, so there are no staged changes
          - calls record_in_rewritten() -- this is unnecessary as we're starting
    @@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts,
      	}
      
     -	todo_list_release(&new_todo);
    --
    ++	res = -1;
    + 
      	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
    - 		return -1;
    +-		return -1;
    ++		goto cleanup;
      
      	if (require_clean_work_tree(r, "rebase", "", 1, 1))
    - 		return -1;
    +-		return -1;
    ++		goto cleanup;
      
     -	return sequencer_continue(r, opts);
     +	todo_list_write_total_nr(&new_todo);
     +	res = pick_commits(r, &new_todo, opts);
    ++
    ++cleanup:
     +	todo_list_release(&new_todo);
     +
     +	return res;
-- 
2.24.0

