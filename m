Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FDFC20958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935068AbdCWRCn (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:02:43 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34835 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935057AbdCWRCk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:02:40 -0400
Received: by mail-pg0-f49.google.com with SMTP id t143so60900985pgb.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 10:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tA3t5O9qfhBJy60kn1AfyiOamgWueD5lnKmkzfdH3e4=;
        b=o2Gr0//AjpH+fvnUO9pPxTTKHNp9INfN7d5x1zxupp2hOhQqP+KNbJfmNp3nMdoOjf
         zVs0OI08LOYz5+KJLSmyfzF2+Gr8LurST9u+dN5egANb7SBUZp1PXmFmec84cJ8d0nCY
         EDwAiivwehsmgNToqxWtrIXzoFMtYdBaR1/BEVfFQZo3rqeSKNg0Q8XklHDNqodD+Y9i
         s3aTxbJtZZUx3vmGEjDlciOlJkdNcFDk6X4r5GfP6VpD4ln8xOGJH/lUFPfVFKXlEKC/
         gWCuk4Ah2arjBeXhXnih3T2aczvreWFvKO60elMGHO1lrKlR5GAqAlK06PPWpLurKZKF
         GZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tA3t5O9qfhBJy60kn1AfyiOamgWueD5lnKmkzfdH3e4=;
        b=Lm8sQW4cORPjSjAfQluAzozktGCpurItJG+3RzXy+hmTZzUX1qqSWOckc6ZZeq9FjU
         fMvDyQhidDjI7XtLOpOAnu/pbWmPwUUalcy8taMljz/1WtmSKOIYyrhYGo4zVhPX2UcF
         vX/Ej52FfGnS7srb15ruSZY4AzdpZsUbHo09v+nNUn6MegZKytuk5TpdVKFmp9KTx/9O
         OpQfON8eQ73sHnnx/z3FucpZOb81KDUg1OEj74KdgauLn5CtRmGFGEoTvAUk3+iWvQy9
         ZrP/RZ7A1+MLCurSzX0Lg1zVPLA8eog6Dc+o3GkgvE50OmWYPxa3eNdFzL7OXq1JGqGQ
         iWvg==
X-Gm-Message-State: AFeK/H1gt14VNdZxUHOQZn/C2Yv1dcoa76YslbKunPz785+gMN8GynJsdvQuANPanU+FtUNv
X-Received: by 10.99.119.140 with SMTP id s134mr4042631pgc.162.1490288559161;
        Thu, 23 Mar 2017 10:02:39 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r89sm11422961pfe.6.2017.03.23.10.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 10:02:38 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, johannes.schindelin@gmx.de
Subject: [PATCH] sequencer: fix missing newline
Date:   Thu, 23 Mar 2017 10:02:33 -0700
Message-Id: <20170323170233.50499-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.1.500.gab5fba24ee-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using rebase --interactive where one of the lines is marked as
'edit' this is the resulting output:

    Stopped at ec3b9c4...  stuffYou can amend the commit now, with

      git commit --amend

    Once you are satisfied with your changes, run

      git rebase --continue

A newline character is missing at the end of the "Stopped at ..." line and
before the "You can amend ..." line.  This patch fixes the malformed output by
adding the missing newline character to the end of the "Stopped at ..." line.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 8183a83c1..d76dc9cb2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1998,7 +1998,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				struct commit *commit = item->commit;
 				if (!res)
 					fprintf(stderr,
-						_("Stopped at %s...  %.*s"),
+						_("Stopped at %s...  %.*s\n"),
 						short_commit_name(commit),
 						item->arg_len, item->arg);
 				return error_with_patch(commit,
-- 
2.12.1.500.gab5fba24ee-goog

