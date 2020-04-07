Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8780C2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B752074B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="UMMSeteu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgDGUBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:01:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34191 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDGUBV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 16:01:21 -0400
Received: by mail-io1-f65.google.com with SMTP id f3so4768337ioj.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 13:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7DWNluOpU9cwgeKd6Ivt8y4HXd2FCbx7hJ7O5Gvghg=;
        b=UMMSeteubjNsvOlMLyrzcpYi8zhyEvNV9jZ9M+NmcvfUjQ9Rz6A8I3aXrfuzgqcezT
         m5aREnimdlPP23SMNEJd+kQ/sVUUnfd9wo/ueiWKM+Caoyrr646sFSFnOakS/LQBwzUw
         hXQFXpCvxPA4wi9Zy6P8plBWDluxajYy5GrSewONyeniihRWblnaCZ8K1cE4/vHatDZ4
         u54/Jg7NG7L0FhrpvmJRKiYjFHhvWks3XI2Y6wzCMfyeGt6rU/+0DC/KSM5B2fcU2hs7
         BFJLZx1R5VKjv1L0ZmXhoE/18LXEOFsKOcbOUVM9mHHAoK0xGJnazL8UMys+qASY7MIo
         sBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7DWNluOpU9cwgeKd6Ivt8y4HXd2FCbx7hJ7O5Gvghg=;
        b=ABVtJHN3z7N/uO+0UEE4kwrlXf9warcM1Jmjnfpeope/5TfvaflGEuIol+/KK0Tviz
         WXW9IRt3nKjA5pyNRJTgjKa48nMgJcLDdy4KDEpEVs2d6TZKCVmiS98j7MMjXwGToqqY
         hG7gYmRxzKC6EqzK7YtdJ7CdJGdfKbzY32K21MaFNgeiOZswgEHeR6dPZ2NhXgTt9thW
         yFZ7Tcs8SdXZKj+aSqFzulCJMaxS6PM+nYOcFhAskuIT/b7GbqrowqA/x7JmfkH4KFcT
         38UVFrpd7oHTH2vFejJb4gpBhcACapcfydYiLmY/x7y5Y8Ne1tRYI0XIaqAv3GeanwFU
         7HyA==
X-Gm-Message-State: AGi0PubLo42pD64z/yHyq0Mtc/p2bYMUdgfbLu5NrYGXRZaCff7zHYr3
        M2MDps8uLtqhFqu0zkR8FH5aZy2N9zVPN3YVVCjeGw==
X-Google-Smtp-Source: APiQypJjQACwYItsqTs11x+cPZ/0jHdlIuLxXusqJLMYVWErFaciZbF8Zl3hBuA5/MXsgq9RK2kQW9ICo+ubhC1XXY0=
X-Received: by 2002:a05:6638:d6:: with SMTP id w22mr3527882jao.72.1586289680047;
 Tue, 07 Apr 2020 13:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMSEaH6+fQuDjhY-5THoYpEjjrHU4Sofnmr-nASHaTZbHvQw1w@mail.gmail.com>
 <CAMSEaH5eZdNooNHQJAto_0dCZSFtiji8ZYvft+oZQXfzDHSyEg@mail.gmail.com>
In-Reply-To: <CAMSEaH5eZdNooNHQJAto_0dCZSFtiji8ZYvft+oZQXfzDHSyEg@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 7 Apr 2020 13:01:09 -0700
Message-ID: <CAGyf7-GVYMXKpptZ8w3tcZAKp41j5_EDe9kp6YcDp7=S4LuVpQ@mail.gmail.com>
Subject: Re: Git clone question
To:     Sankar P <sankar.curiosity@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 7, 2020 at 11:21 AM Sankar P <sankar.curiosity@gmail.com> wrote:
>
> Hi
>
> I am trying to understand about git clone.
>
> From the few git videos that I have watched and using git, I
> understand that git stores the difference between each version, as an
> object, with the sha of the diff as the way to address the object.

This is not correct. Git stores full objects, not diffs/patches, and
the SHA is of the full object contents, not the changes to those
contents versus the previous contents.

Objects are stored compressed (using libz). In addition to
compression, when objects are packed Git can use a technique called
"delta compression" to allow it to build one object in terms of
another. This is something like a diff/patch, but it's not the delta
that gets hashed; it's the full object (before and after).

>
> However, what is not clear to me is, how does `git clone` then work ?
> If a repository has a thousand commits, do we download all the
> thousand objects to the client system and then apply them one on top
> of the other ? I am sure that must not be the case because the `git
> clone` operation completes so fast, and I doubt if my disks are that
> fast.

Between libz compression and delta compression the pack file
containing all of those objects tends to be substantially smaller than
the full set of objects.

>
> However, when I do a `git clone` I could see the history until the first commit.

Yes, when cloning by default you receive all the objects in the
history of the repository and, as you note below, you can also perform
a "shallow clone" to limit what you get to some specific depth. Newer
versions of Git are also working on introducing the concept of a
"partial clone", where some types of objects (large files, for
example) are not downloaded up front and are instead downloaded on
first access. This isn't yet widely supported, though.

>
> I can also partially ignore the history and clone only the last N
> commits history too. So my question is, how does `git clone` work
> under the hood and how is it so fast ? Does the git server save the
> expanded git tree (with all the git patches applied) and we just
> transfer them when we do the `git clone` ?

As noted above, there's no "patching" going on. The server does store
a packfile, though, and depending on how recently the pack was created
it can reuse substantial portions of that pack when creating a pack to
serve the clone.

>
> Are there any good talks / papers / books on the internals of the
> working of git ?

Have you checked https://git-scm.com/book/en/v2 ?

>
> Thanks.
>
>
> --
> Sankar P
> http://psankar.blogspot.com
