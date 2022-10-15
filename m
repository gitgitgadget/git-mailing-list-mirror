Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C3DC433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 19:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJOTKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJOTKX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 15:10:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC0232071
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 12:10:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n7so7568322plp.1
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJJsoqYqWwSwtFoBv3xI5tZR2e2448haP7aKJYbQmBY=;
        b=d1iQwKVSgK3/L5CVNl5OUWJfdOCRD6tGrfiL0loWX1ocvUT6GtAGLY6c5EQ9OT1bPZ
         ntIsMYtAYju8+/QDPsDdhs/tkAlJa64jL/LOD0rPDwPax6Q4rm5JS02uyDfmhHnWgd5n
         8pgfmVT7sPEPQxIuMgqrViyVV79DMKYHDQcdfbCnowR+Ekj+mSuwsNF+r2UuVPHS2E+q
         +H4fejfBHBrP6J1fRM4B6wgLz8D8wFNy8vBqCaGPDu8ftb74P02VC/9fPG9YJvu34ENS
         c6ScB+HbmKz9zfdpCltUFAf9Li8/D10AKGl4ZHZwCsRGQgk/jATMsMLYAas4JIzqdMzp
         4OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJJsoqYqWwSwtFoBv3xI5tZR2e2448haP7aKJYbQmBY=;
        b=Lc1kWOrjpzkBxHpS14PU3Nk2l7PvmNwHabCYqHT6ZFn5W/9vDm5+EZuSQWnpGEisZo
         WPAHa54VGYahj4WVyHr+iy1M64GLd8F5OatFtaUcJw9g4llj+oYa1n9f0Cr6IZrb7Otp
         Y21TyEeCNHQ6dFfvxqONbBevSkm/IyfoeKBA4z+ybuykFUdj1NflsTFEzM5f6WyzfuFi
         BITpYeoh2wifRN4pFW0FXWGPrJPk+HT+ZDbQeWEt7qwiRsNWwqqJwPaxc8vEmnPLcT8j
         kG3nHfAp8Wv7tIyrA6nSO4l7kbvki9NMtn2Hl6Hau8UvKtuz06/vmTHZV62u1o+vqZpk
         uNow==
X-Gm-Message-State: ACrzQf0KwcdyytM223kFIBLQgtw0snPUYNUelAuBeGRxGQ/7ONwBFGrV
        4TyR+jx8n5atWkmoPKltRQXdB/9n+4IEtr1Bm1+kXnXxzUI=
X-Google-Smtp-Source: AMsMyM7F4KJrbu82xnEHuWN05dAAFbqY+y6nkwlPMBJatiozJVTHblGNltqejrZ5rK+9QKpDxNws33l9TpYWrXn1raI=
X-Received: by 2002:a17:90b:4f45:b0:20d:3282:e5e0 with SMTP id
 pj5-20020a17090b4f4500b0020d3282e5e0mr4882894pjb.8.1665861020409; Sat, 15 Oct
 2022 12:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAAheMRzYX6PdWMtcB=px_kD=-gnGGHvDgvR6Jxy94JH2DpYpJw@mail.gmail.com>
 <xmqq7d11540b.fsf@gitster.g>
In-Reply-To: <xmqq7d11540b.fsf@gitster.g>
From:   Rupinderjeet Singh <rupinderjeet47@gmail.com>
Date:   Sun, 16 Oct 2022 00:39:44 +0530
Message-ID: <CAAheMRy+B=2tBX-Frq5-NkdQFSm4jZHhEBVTReMwfGcvHVMQgQ@mail.gmail.com>
Subject: Re: [suggestion] Fail cherry-pick if it overwrites untracked files
 with the matching file names
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, thank you for being so through with the example. I understand now.

I want to ask if you would suggest that local configuration (or any
information required by the project) that is too sensitive to be
tracked in git, should either be kept as 'untracked' files or 'outside
of git repository'.

Since, any merge or similar action can do this, it should be
considered risky to keep files with important information in
.gitignore file.

As an example, when I am working on an android project, I usually add
firebase-integration info and keystore details in the .gitignore,
because I don't want to add them to version control (even by mistake).
I have seen it as a good practice suggested by many devs around me,
codelabs, online courses, and from experienced developers at google
too.

With your explanation, am I correct to think that only the following
kind of information is suitable to be put in .gitignore files?
1. that can be regenerated
2. that doesn't matter when it is lost
3. that isn't used by the files tracked in git repository

Honestly, the name .gitignore implies that git will completely ignore
these files. Overwriting an ignored file does seem like a violation of
the rule present in .gitignore file. But, if the implementation is
intended as you describe, I have definitely learned something new.

Thank you for your answer. My bad for not including the report-file as
text, it slipped my mind.

From,
Rupinderjeet Singh Hans.


On Sun, 16 Oct 2022 at 00:05, Junio C Hamano <gitster@pobox.com> wrote:
>
> If the situation is about cherry-picking a commit that adds a new
> file F to a checkout of another commit that lacks the file F, I
> think the command is working exactly as designed.
>
>     $ git init
>     $ git commit -m 'initial' --allow-empty
>     $ git tag initial
>     $ date >file
>     $ git add file
>     $ git commit -m 'add file'
>     $ git tag added
>     $ git checkout -b second initial
>     ... at this point we are back to the original state
>     ... without 'file'
>     $ >file
>     ... the file is untracked with precious contents
>     ... and the presence of it stops a cherry-pick that clobbers it
>     $ git cherry-pick added
>     error: The following untracked working tree files would be overwritten by merge:
>             file
>     Please move or remove them before you merge.
>     Aborting
>     fatal: cherry-pick failed
>
> Now continuing from the above, things get (slightly) interesting
>
>     $ echo file >.gitignore
>     $ git cherry-pick added
>
> This will replace "file" with the one from the "added" commit, and
> that is because the user marked that the "file" in the working tree
> is expendable.
>
> Files in a working tree controlled by git fall into one of three
> classes.  Tracked files are those that are known to the index and
> appear in "git ls-files" output.  Among the others, ignored files
> are those that .gitignore mechanism says are expendable.  The rest
> are "untracked", possibly containing valuable contents that should
> not be lost as the user may choose to 'git add' them later.
>
> Not just cherry-pick but any merge-related operations, including
> "checkout", follow this semantics.  Untracked files are kept, but
> ignored files are expendable and will be removed if they are in the
> way to complete the operation the user asks.
>
>     $ rm .gitignore
>     $ git checkout master
>     error: The following untracked working tree files would be overwritten by checkout:
>             file
>     Please move or remove them before you switch branches.
>     Aborting
>
>     $ echo file >.gitignore
>     $ git checkout master
>     ... this should succeed, removing "file" whose contents were
>     ... marked expendable.
>
> Of course, after switching to 'master' (or cherry-picking 'added'),
> the project now cares about the 'file'.  After all, it bothered to
> add it to keep track of the changes to its contents.  So it is
> recommended that you would adjust the contents of .gitignore so that
> it no longer is marked as expendable.
