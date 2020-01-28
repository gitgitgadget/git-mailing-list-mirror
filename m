Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D842DC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 21:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69DF207FD
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 21:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrxvD7mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgA1VRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:17:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36391 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgA1VRn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 16:17:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so4177200wma.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 13:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMHAN2IpHC6m4tVRtjqASh1AfjGfdDB98fzgqfx0FCI=;
        b=TrxvD7mOFtktxsyw/R2d1mxe+ZAmXpfj8/OWIqQ5kNuGxmU7vHShXLH5HBJPX71QiB
         An24pdDMvjHzqT90URijzSF480g1ww9iWwo1lYRM7Xsy724o7paj/Ms8zUvmZPfTKAEL
         7Ul8wnLArXVaH8O/NOq029KvMem0JvvsVDs7TaRhbKdYmOlkTOakBkammk5Qi1hFaHrz
         ZE7Vx3FT1sSpTahP0f4zgvsBJ0ZlnhGwWFDb1eDqjoD4XyI4mdvgZGsupAsPJltgAJQ2
         RcaZzYxYZ03tFq/mse0/Uv2+q1h65BvVR7+n2cebYGO6NmsuZ3+agppAIogchu2nnE17
         6Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMHAN2IpHC6m4tVRtjqASh1AfjGfdDB98fzgqfx0FCI=;
        b=IFtNYfy849x/g6WThjEl7/0cGS3LzRD9PTT6EB7LcEKpC2I+0qVFyhtUbC1jLXabpe
         FwMMrv0L4eMHao9Xd08obm4UrFZerRTPHvpz35TGV9aipO2kjFwb6Xsd+i2T6b39dNRd
         8XKOQYGwfqi6jETlfdKPhsAqdZtJ0A6Dod7p/AYnKnToqRSgzr+DsvjIhBoFdhc/7wiI
         kEcqdrwJ0gqb+MapYPQcZeEyChEFupU8kEysJwI7EuoYmLQg6QrbZ8siP/9h5zQkNLBs
         Vm7AQtqlmEpTknOuZ4u5EoNI+/mTAwEJy5EI4FyiU113GmFEpMnJyJHsuMO+pkOrabqv
         q0Lg==
X-Gm-Message-State: APjAAAW6aIjmBPmZIrVRtsZGZcnqQ8yx5zPPtR0Qt64Gnvsw/gfoHHz1
        b4u0+UmFbHh8ZUpkRZ20CrrdjnR4
X-Google-Smtp-Source: APXvYqwqap/fCaKBq9AE50A6aHeh1Jo7WprQOCvdAWCcT5LEa9gEUxCqO6Si6DAZiixud7hUWpmDAw==
X-Received: by 2002:a7b:cb8e:: with SMTP id m14mr7232007wmi.66.1580246261040;
        Tue, 28 Jan 2020 13:17:41 -0800 (PST)
Received: from localhost.localdomain (atoulouse-551-1-75-233.w92-146.abo.wanadoo.fr. [92.146.226.233])
        by smtp.googlemail.com with ESMTPSA id y6sm27056035wrl.17.2020.01.28.13.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 13:17:40 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 0/2] rebase -i: extend rebase.missingCommitsCheck
Date:   Tue, 28 Jan 2020 22:12:44 +0100
Message-Id: <20200128211246.10855-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200125175436.29786-1-alban.gruin@gmail.com>
References: <20200125175436.29786-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prevent mistakes when editing a branch, rebase features a knob,
rebase.missingCommitsCheck, to warn the user if a commit was dropped.
Unfortunately, this check is only effective for the initial edit, which
means that if you edit the todo list at a later point of the rebase and
drop a commit, no warnings or errors would be issued.

This adds the ability to check if commits were dropped when editing the
todo list with `--edit-todo', and when resuming a rebase.

The first patch moves moves check_todo_list_from_file() and
`edit_todo_list_advice' from sequencer.c to rebase-interactive.c so the
latter can be used by edit_todo_list() and todo_list_check().  The
second patch adds the check to `--edit-todo' and `--continue' and tests.

This is based on 26027625dd ("rebase -i: also avoid SHA-1 collisions
with missingCommitsCheck", 2020-01-23).

The tip of this series is tagged as "edit-todo-drop-v6" at
https://github.com/agrn/git.

Changes since v5:

 - Rebased onto js/rebase-i-with-colliding-hash.  This means the backup
   is once again created with todo_list_write_to_file(), but without the
   flag `TODO_LIST_SHORTEN_IDS' this time.

Alban Gruin (2):
  sequencer: move check_todo_list_from_file() to rebase-interactive.c
  rebase-interactive: warn if commit is dropped with `rebase
    --edit-todo'

 rebase-interactive.c          |  84 ++++++++++++++++++++---
 rebase-interactive.h          |   5 ++
 sequencer.c                   |  51 ++++----------
 sequencer.h                   |   2 +-
 t/t3404-rebase-interactive.sh | 121 ++++++++++++++++++++++++++++++++++
 5 files changed, 214 insertions(+), 49 deletions(-)

Range-diff against v5:
1:  996045a300 = 1:  4f07ce94a8 sequencer: move check_todo_list_from_file() to rebase-interactive.c
2:  6dbaa8cbe6 ! 2:  68481d89b0 rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
    @@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list
      				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
      		return error_errno(_("could not write '%s'"), todo_file);
      
    --	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 0666))
    --		return error(_("could not copy '%s' to '%s'."), todo_file,
    --			     rebase_path_todo_backup());
    -+	if (initial || !incorrect) {
    -+		if (!initial)
    -+			unlink(todo_backup);
    -+
    -+		if (copy_file(todo_backup, todo_file, 0666))
    -+		    return error(_("could not copy '%s' to '%s'."), todo_file, todo_backup);
    -+	}
    - 
    - 	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
    - 		return -2;
    +-	if (initial &&
    +-	    todo_list_write_to_file(r, todo_list, rebase_path_todo_backup(),
    ++	if (!incorrect &&
    ++	    todo_list_write_to_file(r, todo_list, todo_backup,
    + 				    shortrevisions, shortonto, -1,
    + 				    (flags | TODO_LIST_APPEND_TODO_HELP) & ~TODO_LIST_SHORTEN_IDS) < 0)
    + 		return error(_("could not write '%s'."), rebase_path_todo_backup());
     @@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list *todo_list,
      	if (initial && new_todo->buf.len == 0)
      		return -3;
    @@ sequencer.c: int sequencer_continue(struct repository *r, struct replay_opts *op
     +			unlink(rebase_path_dropped());
     +		}
     +
    - 		if (commit_staged_changes(r, opts, &todo_list))
    - 			return -1;
    - 	} else if (!file_exists(get_todo_path(opts)))
    + 		if (commit_staged_changes(r, opts, &todo_list)) {
    + 			res = -1;
    + 			goto release_todo_list;
     @@ sequencer.c: int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
      	return res;
      }
-- 
2.24.1

