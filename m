Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD6D209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946764AbdEZDP0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:15:26 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36621 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946760AbdEZDPP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:15:15 -0400
Received: by mail-it0-f68.google.com with SMTP id i206so409996ita.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1frcdyXGlSpgsFnpCcsBueFUxgAs6uiUG2aTsL4lcRI=;
        b=jm9jhY6/jzQX3TwtBlp6ViKYHU+bnXih7WpmJ2CoxXnPXhTX+MBgADoO+ygzdNtAOf
         WZbdfedUMSfAs3w8nfu2C+i9pllUVV7h590QnT46LKmFT/Ov0SDsQkB38WrYwiQQJKOG
         VLql3Q2OMTcW6huw3bwNrSAgSVLVPDIwnPvnduDHhZrV3eZ/uA2cK7byr45OYGkK8aeG
         +co76K7AExjIF25obIWMa5Eaycvfe8fdh5pKF0oz01AJs9Oj4qn81loFi0G6emN9Yd0B
         NIuLc3Oq/R/zlyvJuZrxbDnjuCrEgJGCh11iuGXDFnA6u+YcH/fidnrKliBi+/BQ6c1q
         Yi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1frcdyXGlSpgsFnpCcsBueFUxgAs6uiUG2aTsL4lcRI=;
        b=HTquPvI977Yj/frwBplWDpswzmNiBBnY6oJ20sAlGzzAidZMvj37RQNvXoBmYxv5yo
         EGkz1FfnlWoQ2QqAdAop6Pj/hWGNU9emFVWAx+4YBtR4XMWYGNcGinJj5046ypgJSGyc
         C1YuwaQiase0KI7sAgWDrkKa3Sgoso9ChTXBocdpJQPK25iUKIGNPehLLpzVjrCQrg95
         uCiccvfUT6U/fhbQhtLfqVkkDDQLN8DEaJHMSdX2KjLuDlJ0XBy/iLlgKjJQqEFbGktG
         NJG+wSii8hiWfKFicih/n2poQJa+au9e2K5BxxkhTXrG74W73yUfbR1z+oNavOKyVVLH
         InDQ==
X-Gm-Message-State: AODbwcCRRDnrWUiRWwk7UJB3081bODzOL3c58dsmrkXuk40Yhc6ARg+N
        jz3aEkP8M9RB3Q==
X-Received: by 10.36.104.198 with SMTP id v189mr684704itb.99.1495768515018;
        Thu, 25 May 2017 20:15:15 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id 78sm3861689iou.36.2017.05.25.20.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 20:15:14 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
Subject: [PATCH v4 00/10] The final building block for a faster rebase -i
Date:   Thu, 25 May 2017 23:15:08 -0400
Message-Id: <20170526031508.24838-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1493414945.git.johannes.schindelin@gmx.de>
References: <cover.1493414945.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> This patch series reimplements the expensive pre- and post-processing of
> the todo script in C.
>
> And it concludes the work I did to accelerate rebase -i.
>
> Changes since v3:
>
> - removed the no-longer-used transform_todo_ids shell function
>
> - simplified transform_todo_ids()'s command parsing
>
> - fixed two commits in check_todo_list(), renamed the unclear
>   `raise_error` variable to `advise_to_edit_todo`, build the message
>   about missing commits directly (without the detour to building a
>   commit_list) and instead of assigning an unused pointer to commit->util
>   the code now uses (void *)1.
>
> - return early from check_todo_list() when parsing failed, even if the
>   check level is something else than CHECK_IGNORE
>
> - the todo list is generated is again generated in the same way as
>   before when rebase.instructionFormat is empty: it was interpreted as
>   if it had not been set
>
> - added a test for empty rebase.instructionFormat settings
>
>
> Johannes Schindelin (10):
>   t3415: verify that an empty instructionFormat is handled as before
>   rebase -i: generate the script via rebase--helper
>   rebase -i: remove useless indentation
>   rebase -i: do not invent onelines when expanding/collapsing SHA-1s
>   rebase -i: also expand/collapse the SHA-1s via the rebase--helper
>   t3404: relax rebase.missingCommitsCheck tests
>   rebase -i: check for missing commits in the rebase--helper
>   rebase -i: skip unnecessary picks using the rebase--helper
>   t3415: test fixup with wrapped oneline
>   rebase -i: rearrange fixup/squash lines using the rebase--helper
>
>  Documentation/git-rebase.txt  |  16 +-
>  builtin/rebase--helper.c      |  29 ++-
>  git-rebase--interactive.sh    | 373 ++++-------------------------
>  sequencer.c                   | 530 ++++++++++++++++++++++++++++++++++++++++++
>  sequencer.h                   |   8 +
>  t/t3404-rebase-interactive.sh |  22 +-
>  t/t3415-rebase-autosquash.sh  |  28 ++-
>  7 files changed, 646 insertions(+), 360 deletions(-)
>
>
> base-commit: 027a3b943b444a3e3a76f9a89803fc10245b858f
> Based-On: rebase--helper at https://github.com/dscho/git
> Fetch-Base-Via: git fetch https://github.com/dscho/git rebase--helper
> Published-As: https://github.com/dscho/git/releases/tag/rebase-i-extra-v4
> Fetch-It-Via: git fetch https://github.com/dscho/git rebase-i-extra-v4
>

This is my first review so it's probably not the best you'll get, but
here it goes!

I rebased the series ontop of v2.13.0 and run the whole `make test` on
both revisions.
The changes do not seem to have introduced any evident breakage as the
output of `make test` did not change.

I tried to time the execution on an interactive rebase (on Linux) but
I did not notice a significant change in speed.
Do we have a way to measure performance / speed changes between version?

Liam

