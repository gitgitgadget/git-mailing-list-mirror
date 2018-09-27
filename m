Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293181F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeI1Etw (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:49:52 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:51033 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeI1Etw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:49:52 -0400
Received: by mail-it1-f169.google.com with SMTP id j81-v6so494624ite.0
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eJ3wD8cOh1cQlc/fQ6mvTPL6dBvRM6lR1qDAA1AemwM=;
        b=SclQ0SdzYw/bKxA2sbWNeXyaRxmW/nI8fTaMvjlprTwZ1K38UA63cuc6yqAawkBzlO
         jeKbJjaCn6H97Q0dhcItZ/8dIk2Oi2wT97mSkPOosKSD/AZFtz1Yd84tIDdlVobcHPhD
         k7R3uEvRE/OpR4UTTCUmgh+pJBIr+6a+P+cX7MiDgfQbwr6CuGW+mwjiJdRjsnJ0PoIt
         FPjQ3NwOc2I2DBCdgaYXAsJN1DDPLYyJ1Af6wzUfgl87/iJiQ93DDkwoEInC1xrDHC9S
         2P+KtOm9QjrYKYBHuVKU4jA3Rf9mEf5SJw1wJdAWeBr8ld61V5kfdhYVGZgVq4nux/6y
         q7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eJ3wD8cOh1cQlc/fQ6mvTPL6dBvRM6lR1qDAA1AemwM=;
        b=kK57yfCan0xtu8Q21dm7dqAw5v+sA9mQndyfWLWL+GTUm3SfIIY7V3CrD9YjB99/dd
         EeI/c3CQCsGQTwZNrtWUKKHLY7Usqdc2otWRQASC69uzrY0wf819YcCPAF5703huta0d
         98i8W4rJQOzYiwDTsl/BJ9W0oVey+iI2+kmambQVbNDx6EwbR2JZ0LEjsD6xnidTmMn2
         +ngKKsn1v4svwol6P2q7SWZ+n9QzxZ6aJOaITPhJJPYOhVa9T5OtpMXe+dQ8aWPZgWD4
         0UgHcoB908CaN62SYuNvFQ5Oo5S0vImbkIeeECJAzWBE2ghFDA4AR4149KTeWcA6wIqK
         Yl5A==
X-Gm-Message-State: ABuFfoj4NuUcZD3NqhR1tIQB8GMtIp6f0A98j30eeg9z8E2zPSy6eynG
        x2ccdVBOHN7P4WlYaiepMaqO8x51eSsTW9AN2sXJgvjk
X-Google-Smtp-Source: ACcGV61HaDmLf/c9C4ApM01cYPrJzbABbuygYDLKFvToB39+zIJjgN8POzAD0+Q6yPqV9CIza8Aoda28QH/IhNXZ0e4=
X-Received: by 2002:a24:be8f:: with SMTP id i137-v6mr453697itf.61.1538087360767;
 Thu, 27 Sep 2018 15:29:20 -0700 (PDT)
MIME-Version: 1.0
From:   Raman Gupta <rocketraman@gmail.com>
Date:   Thu, 27 Sep 2018 18:29:09 -0400
Message-ID: <CADF5XCygzArjd9rgY_x_BqnhL5QpFL1CO1JjOHnBQc3HFn_JdQ@mail.gmail.com>
Subject: --skip-worktree and operations like checkout / stash /etc.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comand `update-index --skip-worktree` seems to be an ideal way to
tell git to locally ignore some modified files. However, this seems
not to play well with very common commands like `checkout` and
`stash`.

$ git checkout other-branch
error: Your local changes to the following files would be overwritten
by checkout:
        path/to/ignored/file
Please commit your changes or stash them before you switch branches.
Aborting

Ok, well lets try stashing:

$ git stash save
No local changes to save

Ok, lets try a checkout with a merge:

$ git checkout -m other-branch
error: Entry 'path/to/ignored/file' not uptodate. Cannot merge.

Ok, lets force this sucker:

$ git checkout -f other-branch
error: Entry 'path/to/ignored/file' not uptodate. Cannot merge.

Ok, at this point I'm wondering, do I really need to
--no-skip-worktree all the ignored files, do my `checkout -m`, and
then ignore them again? Umm, no, that ain't gonna work.

I'd love for git to just check if my worktree-skipped changes will
merge cleanly into the target branch, and if they do so, go ahead and
do that merge (with perhaps a notification printed to the console) and
keep the skip worktree status. If the merge ends up with a conflict,
then feel free to no-worktree-skip it and show me merge conflicts.

Regards,
Raman
