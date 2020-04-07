Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E231C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16A22075E
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO72sr6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgDGUKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:10:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39534 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgDGUKj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 16:10:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id d63so2675640oig.6
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNlbSoO/IZSPRSgsNFQUJteQu+TU1TOyyppaeq+Z0iM=;
        b=XO72sr6JbXN122Q9WIyTSwWXNiotGDCtAowlP/tT3j3quz1l9t045bjSCwTcQJcSGy
         lCIXMTyAIUUFpf5H/90qd/kq//kBDxKCB/BWUVf5THktNrJNzhG/4nqDS0kFlh7nVy/s
         rfcb2N+JPeNinVoXr/rRR5FN4jEoJ7hNd6GPjxnxPxouNx4SyA1WajccEAlRy8nXcTT9
         4FO8Oo2hykS++ceAP/T4t8G+KWDWn50h9rRA3wtOvOoSeBZhMyKQIxRJXedZOjbOPgWw
         +WyIlTkPL3pudq8S8O6hK/74YyogySEGE9hnxER+hECgPvbnt52frRCevl53sj+Cu/z9
         slQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNlbSoO/IZSPRSgsNFQUJteQu+TU1TOyyppaeq+Z0iM=;
        b=GMTBdzmNACXpElxcn+2xqtn3/LtWmDI6dDR3uyRpQf7XCOZzyv72rm+4ZSrMaDpizJ
         UPNIQglE+RtQFs5VbFeMzXVHqeTgJq57q617wzo+H/mFHkYF7mkAehxCMERqsUczONCB
         AIfWGdxqtl+ulXikvc5twxENyPeFo+V/JFWkrezbfEDF/ih9Qq7kMvCqQnJFDiyPxetM
         PJZeuuJKvXvQ3qSf/sIy4e0/Nq6Z+t5XjvDRfgOjv+zhQkq77/4uNma1EGYbA/i0h093
         TUG463yAt+00KLMgSC/peV7F6pzybnl07dtbmob9827b+KbhHWfIuMXHfftWIkVsq3jJ
         pOkg==
X-Gm-Message-State: AGi0PuYlpv2NE/ONdbpfO9gpgbPIkpF3XWbVroh5rSkkzdcsaX0XKtge
        EUERjzNad8krY4wAxUY/DciwtGRhvR2XnSxZWsA=
X-Google-Smtp-Source: APiQypKEnQZ76MeOn5TSOlnpL0qsZB4RkBGt4Y0wbic4MGYKN662GmLZhNf2iYB/W+a9sYoLIAWqSwIJlW68e7cA2GU=
X-Received: by 2002:aca:f346:: with SMTP id r67mr485767oih.39.1586290237103;
 Tue, 07 Apr 2020 13:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <1249625346.805132902.1586274429644.JavaMail.root@zimbra39-e7> <1537903963.805193304.1586275292611.JavaMail.root@zimbra39-e7>
In-Reply-To: <1537903963.805193304.1586275292611.JavaMail.root@zimbra39-e7>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 13:10:26 -0700
Message-ID: <CABPp-BH=XcX6tsSAu9bN-qk2h0ayj+rqmdJWwYwvCGnpKivGHw@mail.gmail.com>
Subject: Re: [BUG] bulk move silently dropped, leaving the "delete" part in
 work dir, on commit reorder (rebase -i)
To:     ydirson@free.fr
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Apr 7, 2020 at 9:03 AM <ydirson@free.fr> wrote:
>
> Hello all,
>
> Please find attached a fast-export test-case for the problem.  It contains an "original state" commit
> and 2 commits moving lots of files around.  As context, the first one is a logical fixup of the second
> one, adding one more move to the bulk move in the second commit.
>
> If I use "rebase -i" to reorder the 2 commits, "subject 1" which originally contains 4 blob changes and
> 324 moves, loses all the renames.  Problem exists at least in 2.25.1 and 2.26.0 as shipped in Debian testing.
>
> Additionally, the files in workdir are all locally deleted and stay there as "Changes not staged for commit",
> which should have prevented the rebase from proceeding to the second "pick".
>
>  (ref0/ref1)$ git log --raw HEAD^^..
> commit d368ee70ca358f4877185175780147b5bfba0ec5 (HEAD -> ref0/ref1)
> Author: User 0 <user0@example.com>
> Date:   Thu Apr 2 17:15:29 2020 +0200
>
>     subject 1
>
>     body
>
> :100644 100644 16fd26f 16fd26f R100     path15/path30/path89/path102/path106/path107    path15/path607/path30/path89/path102/path106/path107
>
> commit a6b4902d848acdeeb0238d22dd7a093317e7a389
> Author: User 0 <user0@example.com>
> Date:   Wed Apr 1 18:14:31 2020 +0200
>
>     subject 2
>
>     body
>
> :100644 100644 386a5e0 67bb842 M        path12/path10
> :100644 100644 703e2a3 57729f1 M        path13/path10
> :100644 100644 386a5e0 67bb842 M        path14/path10
> :100644 100644 53d9ddb fe616ea M        path9/path10
>  (ref0/ref1)$

Thanks for the report.  The testcase was slightly hard to understand
from the description at first, but it's basically:

    # download the file that Yann attached
    cat $DOWNLOADED_FILE | git fast-import --quiet
    git checkout -b testing ref0/ref1
    git rebase -i HEAD~2
    # Swap the two pick lines, save & exit editor

at which point the rebase will complete with a report of success, but
it will drop most the changes in the "subject 2" patch, and leave the
working directory quite dirty at the end despite the fact that it
started out clean.


One can also duplicate this bug using cherry-pick or merge-recursive;
for example, assuming the testing branch was already created as above:
    git reset --hard testing ref0/ref1~2
    git cherry-pick ref0/ref1


This bug goes back to at least git-2.20 and likely earlier.

I tested with the ort merge strategy and it happens to fix this bug
(among others), so maybe if rebase stuff ever quiets down then I can
address this bug just by pushing that new strategy forward.
