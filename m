Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2903E1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 18:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbcHQS16 (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 14:27:58 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35573 "EHLO
	mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbcHQS15 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 14:27:57 -0400
Received: by mail-ua0-f181.google.com with SMTP id n59so184583617uan.2
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 11:26:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=IH/VAEy6vEIJDqUN/wnm9rBDo0oNGPXVlxqIgrPvuAg=;
        b=vzuZtuJScJG7d5Ok8uMfw2RQUKpk2QjhnBQmT1hYyJ7UIBUFP5MNYpY+kRX7l+YCZ2
         13upRbVCNadO+N7aES+ZrDLCdH1RYQWpWRRf3cQ1xY6NAZw5rsR8r0Gp0vc9yTAUd8Rw
         mWsYKCyd5qWXu37sAHORGlRyRcnSOXj+IPsVW030MOIuIbpHvVoupZ73STdzoz7sfq03
         /BGvROoKYTn6sbZuntSnQBtIsejN9GgBSB2c/+SBTfznfO8Y+gK/uV3ATGBIi4lpSMPj
         axRwK41ntNFAyvFZCZH+/gPRyuFB54VhtENVd1K/EnfZqGOW0QKzQLexAZSzsCpUDJbA
         fqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=IH/VAEy6vEIJDqUN/wnm9rBDo0oNGPXVlxqIgrPvuAg=;
        b=O6rEAyozNQXYI4CBBkzD9IiqCdrU/hbS5J090hR6gMk0K3o8zyWky+UabZKQsH+B0O
         hrYl0dBScpTMmQnLrGxKqRy5OJOA7Hg6QMDCQ/Rf+tCKPTf2qKPrCOvRM+wU9aXtk1YC
         K8ZjPSIDZ5ANEmO14C6uwiFLgdeRiGy5Ko2GsdwqanIAAOhUZb2CgHIIyBWyJWASdb4u
         qvgydlJNBd0jYU122Zb3yCsMAPzCPFjdDFSVupHj06ybLG3jWStbdQk2qq//8fz6EJUg
         6gelMkVTR9ydqybeuaeA+iqheVej8ilA5n1VimY9Qm+Jzjsvg+OMr4YFqUA/aAlLVI38
         ruGg==
X-Gm-Message-State: AEkooutahaDWajbPJARtDwGemOgC/kGhlJzC5BuTFaC4W9ApX9fbC1PNvHAzdz6G9DVjIemmpPIWOlLg0c40wQ==
X-Received: by 10.176.4.85 with SMTP id 79mr6410134uav.56.1471457047630; Wed,
 17 Aug 2016 11:04:07 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.4.230 with HTTP; Wed, 17 Aug 2016 11:04:07 -0700 (PDT)
From:	Robert Dailey <rcdailey.lists@gmail.com>
Date:	Wed, 17 Aug 2016 13:04:07 -0500
X-Google-Sender-Auth: WvJ2qYQV5lsTE3sjXiJbmv152uM
Message-ID: <CAHd499D50TLMYtAovTF80ev0=2u=9yyMNcq6-he3Ba2kXzqW9g@mail.gmail.com>
Subject: diff --diff-filter on modified but locally deleted files
To:	Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

My use case is that I do a merge from branch A to branch B. Branch A
modified a file which is already deleted on B some time before the
merge.

When I do a `git status -sb`, these locally deleted but remotely
modified files show up as "DU".

I want to invoke git status or diff (or something else) to get a list
of these specific conflicts (locally deleted, remotely modified). I
tried this:

$ git diff --diff-filter=D --name-status

This gave me no results. I also tried adding --cached, didn't make a
difference. If I just do this:

$ git diff --name-status

This lists those files as just U instead of DU. So I'm not sure where
the "D" is coming from in this case.

Is there a way I can get a list of these specific conflicts? I'd like
to rely on working/index status for this if possible, since as I
resolve these conflicts I want the list to shorten and only show
unresolved conflicts of this type. Which rules out a diff range
between B...A that I could do.
