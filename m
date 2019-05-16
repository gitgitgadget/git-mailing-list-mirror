Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE751F461
	for <e@80x24.org>; Thu, 16 May 2019 12:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfEPMPD (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 08:15:03 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:56129 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfEPMPD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 08:15:03 -0400
Received: by mail-wm1-f46.google.com with SMTP id x64so3371313wmb.5
        for <git@vger.kernel.org>; Thu, 16 May 2019 05:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqReqfttG/IQx2Zs/GT7bZBLPDmZrBjAgWJOxx9JYI8=;
        b=eU+Jpvop86n37P7DuGh4/3QiWzOv1ykSICbB7kIL+1+tPPuOdSzJFQ8GbzabHI/6hD
         dm1t4zvDj/bulTcvKkXwpwFsMPkwhv67hQ+YqK7bJVyVLK6nljC+EuTm9kUgI2RBUmXe
         iL6j47KqgzLGM+QDEx0mvbk+saoY88IqFrTE4Fj0DThw2ZIzvj5Jq/72LwHxNI+ObN1a
         OakOM9EJQY1JytGWpADK+bjhOjDua/xIo6HVH3fFNSudwlKMmpAw5UDLkIZfelz14iTh
         wy90/76XOaEouups/r7BGk+2qGRmE0JafmHxLHdtewZI+N+x4EPmguXKHHmY1YRWL2bn
         S4cA==
X-Gm-Message-State: APjAAAW5Og+1O2gA4b1EjkdIFvad9f6KU8JghvSRPj4Qa9xgHT5WeO6d
        Vzm6iy4uMJ3dJMOPjKjj3yWvdP3qQLc201c3JwA=
X-Google-Smtp-Source: APXvYqw7sfuNU/UgaC85ZQPJGoefGPJSFereQn7/X9K6sgrjRPLNk90m5vfZaY5biWr0ulSexuhkU5l/f+K5Y8fBZYA=
X-Received: by 2002:a1c:b789:: with SMTP id h131mr26883339wmf.71.1558008901054;
 Thu, 16 May 2019 05:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
 <CAPig+cTQrF1W4LEgOiEoKn4f69OEygFat=4V8aTzf0Rxom2hEw@mail.gmail.com> <CACsJy8BXxVggL7CWA5Q0d7U4B+encfZ85NshxLJ=VvHhf_LUYg@mail.gmail.com>
In-Reply-To: <CACsJy8BXxVggL7CWA5Q0d7U4B+encfZ85NshxLJ=VvHhf_LUYg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 May 2019 08:14:50 -0400
Message-ID: <CAPig+cTCdBkru-6tJVeYxQSaosv7pb8R5ge_aedzi5C7w39mQg@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 7:42 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, May 16, 2019 at 6:33 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > You run afoul of it in other situations, as well. For instance, say
> > you have your index file in a non-standard location:
> >
> >     $ export GIT_INDEX_FILE=../storage/index
> >     $ git worktree add --detach other
> >     Preparing worktree (detached HEAD c9156d2)
> >     fatal: Unable to create '/.../foo/other/../storage/index.lock': No
> > such file or directory
> >     $
> >
> Oh if it's relative $GIT_INDEX_FILE then I think its our environment.c
> code that does not work so well when we chdir() away. I vaguely recall
> something about this when discussing Jeff's chdir-notify series. But
> it turns out that's about chdir() in run-command.c [1]. But the idea
> is still the same, all variables are supposed to be relative to $CWD.
> Whenever you move $CWD you should reparent all of them, including
> $GIT_INDEX_FILE.

builtin/worktree.c:add_worktree() is already assigning
new-worktree-specific values for GIT_DIR and GIT_WORK_TREE, so for the
specific example I showed above, the correct fix would be for
add_worktree() to remove GIT_INDEX_FILE from the environment before
invoking other Git commands, correct?
