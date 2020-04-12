Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22808C2BA2B
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB77820705
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mazurok-com.20150623.gappssmtp.com header.i=@mazurok-com.20150623.gappssmtp.com header.b="qgBn6rzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgDLNIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:08:09 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52526 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgDLNII (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 09:08:08 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so2817479pjb.2
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mazurok-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NQF601bi7LZxRPOhHwOsjnpxFhzDGL3UB9nfQsrPopc=;
        b=qgBn6rzCsdPg3KFSZHdvgPs4+80yEXlIHfwnMwt2gpBLr9fNbLKP5wBdOtY0NoKtIV
         4H9kOpW+i3oTw2sSLArxAlkQusSwd8OIQp5MzPuMk1E3dmxVe5KCFmyysHDuYGWCdmQe
         jDQD7O4ZI4N71gKrzEs/j7BABZsAIaM53wNXPOStcAvkB2jtZKSW9u1gOvDdk2aEAmYO
         dcnCMvFa3WmTr4GSMj3URYYuzqToVc4vmVK2qRWvooR3vU99R5a9Z3jycIQJtqmoDA3c
         2cok/Drk7PqPiLDgHbXZTpneB/XvSEOyC3gPT5HQmGE7+nJY7V1mcwhusLj274Fhrt5F
         Be6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NQF601bi7LZxRPOhHwOsjnpxFhzDGL3UB9nfQsrPopc=;
        b=L7PJYtBjDItIjiVFcGN480bQZ+VJsHqFrV4i71NCey1yEyDaWCap5dENqileEv9h3i
         0tNEQDe/UP/KZlkessyZHHZjRkfHdLv1Ol9HAHDyrDtk55E1/8RJTRoom8CanMUsGf2m
         L0npMzWEyu45wY9XltqBJP+IJc+SCufYeO0BadB4R/qzfVSY3NhbuuczT/CospmypVYQ
         PtrE4GjcntOXt9lW7byr0b4ZI05rMH6iOZk9Bap8Q8mYlURRufTVVBeo50KJuz/hlWgL
         PrgoscZo3yMAkwKiy4eAjfQ44AlwjnGJ2fK1gQ6yY4VemFWPHJqHb6eDIVCW+ijbvvTo
         dKvA==
X-Gm-Message-State: AGi0PuZdJBiGl+osBcOVJMPrCeqKIh1k7ueHVFIJ418IVOZok7g7MsjU
        kKRcGpRJDPRoq246Y6LVtpH0sQ==
X-Google-Smtp-Source: APiQypK8gk97Ts9YiANquAxfNmgf8gJU9fVoq/Gvt7b2y1Sj+PK0BHijUh9FN4u58qGHU0givZH/dA==
X-Received: by 2002:a17:902:6a88:: with SMTP id n8mr13007783plk.292.1586696888255;
        Sun, 12 Apr 2020 06:08:08 -0700 (PDT)
Received: from maxims-mac-mini.lan (124-149-62-136.dyn.iinet.net.au. [124.149.62.136])
        by smtp.gmail.com with ESMTPSA id c10sm5723436pgh.48.2020.04.12.06.08.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 06:08:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Make stashing nothing exit 1
From:   Maxim Mazurok <maxim@mazurok.com>
In-Reply-To: <87d0mic9fm.fsf@evledraar.gmail.com>
Date:   Sun, 12 Apr 2020 23:08:01 +1000
Cc:     Keith Smiley <keithbsmiley@gmail.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F6FC77C-1784-4EF1-B005-2C01516A5BEB@mazurok.com>
References: <01020169a7ad6af3-ad50e2d1-19fb-46eb-b397-759f8d579e8b-000000@eu-west-1.amazonses.com>
 <87d0mic9fm.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * stash is currently (in the 'next' branch) being rewritten in C. It's
>   a better move at this point to patch that version, this code is =
about
>   to be deleted.
>
> * This is missing a corresponding test, and skimming the stash manpage
>   we should document how these exit codes are supposed to act.
>
> * Shouldn't we do this consistently across all the other sub-commands?
>   Trying some of them seems 'push' may be the odd one out, but maybe
>   I've missed some (and this would/should be covered by
>   tests). I.e. some single test that does a bunch of ops with no
>   entries / nothing to stash and asserts exit codes.

I was doing git automation where I=E2=80=99m doing this:
1. git stash push --keep-index --message all-changes
2. git stash push  --message staged-changed
3. git checkout -B my_branch master
4. git checkout stash -- .
6. git stash drop
7. git stash pop
The goal is to do this for every folder and put changes for this folder =
in it=E2=80=99s own branch. More info here: =
https://github.com/Maxim-Mazurok/google-api-typings-generator/blob/e4d277b=
67ee34999e2fea04cba7d06c97af9e6bb/bin/auto-update/index.ts#L57

So, I also found that "git stash push=E2=80=9D doesn=E2=80=99t return 1 =
and I think it=E2=80=99s not in line with =E2=80=9Cgit stash pop=E2=80=9D =
behavior.

In my workflow it makes harder to find the problem.

Another problem is that sometimes =E2=80=9Cgit stash=E2=80=9D doesn=E2=80=99=
t seem to work.
You can see by downloading full log from here: =
https://github.com/Maxim-Mazurok/google-api-typings-generator/runs/5802748=
97
That at the bottom, when processing gapi.client.youtubereporting it says =
that both stashes (form step 1 and 2) were created, but then when =
running =E2=80=9Cgit stash list=E2=80=9D it shows only one stash.
Because it only happens sometimes, I assume that it may be because =
filesystem not flushing all the changes immediately.
Any help on this would be appreciated.

Regarding =E2=80=9Cgit stash=E2=80=9D return code, do you think it makes =
sense to add this to C implementation, create tests and find other =
potential inconsistencies? I would be happy to help. And it seems like =
other people also are facing this problem because =E2=80=9Cgit stash=E2=80=
=9D doesn=E2=80=99t fail: =
https://stackoverflow.com/questions/34114700/git-stash-pop-only-if-success=
fully-stashed-before

Regards,
Maxim Mazurok=
