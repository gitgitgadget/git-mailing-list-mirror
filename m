Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8701CC433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 22:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhL0WPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 17:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhL0WPi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 17:15:38 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA5BC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 14:15:38 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q14so58848638edi.3
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 14:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBEbWzreNrE99fgcXoSGoAxokIsJjrEX6SffS2OhSAU=;
        b=b/JUGlLkKR2eoo+Kl0SnhPCCwSwdot4mmDNZdAudseCcct8UpSEDPeZExbr1c5QAy+
         IA8xKfAVB+DUZYOGStyFNcHilZyMmdb6N+OoooMQb2ebIspW+Fh02wTgr/+yKRdBrXI3
         YyXgcA5ma6Ie8gQOpi33hy7UEI5G/Erz3oufcCwo95fGByZo8uxVyiADRlzALcn57rPO
         bCQwG0RUV6M6JXXTE71yFs7lfxEsq/yQ1kMknN4yiwNd46G8xKVHyV5BRBmX2PBs5KfT
         F/YLhV02OU4I8QZoRr9LNXX6HT6PqXwoAi9HlhODe7GUcw6W7R6p1qav6xiR5cJNYkYS
         55iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBEbWzreNrE99fgcXoSGoAxokIsJjrEX6SffS2OhSAU=;
        b=FugVnJ6cnvLtOugBdCUxCai9011S8YeCHm74x6HWH3qSBDBDzNlaWovbTk+HEP+2ne
         QpUThP+EdbCrAVB1Sza3WnsyWhznaoXBjRMNs4DTMAEdY9dD5XwxBsPcl5sjzCgdJnRj
         573OlKfRS3pXoJiUeBrMFC0KQV1ws2uARDhznG8JMmNOBXhYcqxqWCo/zNyi7Zp5U+4x
         3qCFgpc1MeoDQ+vOYqI2TSwJSGsFzmPCvcaRM1MxLzzQezaI4O1+1rl/9bB+yDMkdVFa
         HRM5Uz1uP5A7FRCWQzVM2y1OWeQoXiPtbQPQUrTzqhlC95NywDqQMhnFwYhhdNoHJFOa
         iMoQ==
X-Gm-Message-State: AOAM531MLAdITidNet1+s9I3nUaqF1GAwXLQEgMgMRmjAp6IANS+ZqLF
        jgiMD+yqbpExEjbSBW58ozvoRXAI5gN5S+DOF5S9HH6RMhwrUQ==
X-Google-Smtp-Source: ABdhPJzb7n0n2KGXVnL6ViK0LxvB6++X1xc5PErSQ/czMeI+PQnmg7VOzTQx9qIMN0axtMxAhaZCmluxkvAraqUd/s8=
X-Received: by 2002:a17:907:160e:: with SMTP id hb14mr14629029ejc.328.1640643336622;
 Mon, 27 Dec 2021 14:15:36 -0800 (PST)
MIME-Version: 1.0
References: <CAN0XMOK8iHZnbtYw7CPAQGJcmuVSDxQoFNFEwiaa41V89F1rzA@mail.gmail.com>
In-Reply-To: <CAN0XMOK8iHZnbtYw7CPAQGJcmuVSDxQoFNFEwiaa41V89F1rzA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Dec 2021 14:15:25 -0800
Message-ID: <CABPp-BH=nqeqpW8Grn+6No4HvRaBaC9spwEsDcj1BWdsipJh=Q@mail.gmail.com>
Subject: Re: [BUG?] assertion failure when merging branches
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 27, 2021 at 10:35 AM Ralf Thielow <ralf.thielow@gmail.com> wrote:
>
> Hi,
>
> At $WORK I tried to merge two branches and ran into an assertion
> failure. I exported the two branches down to the merge base as
> an anonymous repo, so that it can be reproduced.
>
> In the branch I tried to merge into, files have been moved
> and/or reformatted.
>
> My Git version is 2.34.1.
>
> wget https://gist.github.com/ralfth/5b624abb0a99e3e705a0984c4b2d253e/raw/7f7ef5b10711550b90342c50b53ce25c19075c97/repo.txt
> mkdir tmp
> cd tmp
> git init
> cat ../repo.txt | git fast-import
> git checkout ref0/ref1
> git config merge.renormalize true
> git merge ref2/ref0/ref3
>
> git: merge-ort.c:3846: process_entry: Assertion `!ci->df_conflict &&
> !ci->path_conflict' failed.
> Aborted (core dumped)

Yikes, sorry about this renormalization bug in merge-ort.  For now,
you can recover via:

  $ rm .git/index.lock
  $ rm .git/MERGE_*

and then as a workaround you can either use the old merge backend for now:

  $ git config pull.twohead recursive

or continue using the new merge backend and just turn off
merge.renormalize.  After that, a subsequent `git merge
ref2/ref0/ref3` should work for you.


As for the bug, I introduced this in commit a492d5331c ("merge-ort:
ensure we consult df_conflict and path_conflicts", 2021-06-30), and
before that commit, this type of setup would be mis-merged (with a
rename/delete conflict getting ignored).  I'll submit a patch with a
smaller testcase soon.
