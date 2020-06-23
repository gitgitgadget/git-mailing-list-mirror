Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F0C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E1D20724
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMLbBPV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391398AbgFWVYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389802AbgFWUTe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 16:19:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D5C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 13:19:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d21so42792lfb.6
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+Sz8IO3Q0Wi9qYyweBh6gIY8y2TmrnBiTxKhHiQe4zs=;
        b=lMLbBPV9RKOxQvGJSz0Gk4XEgduxKSZz1figls4USd2QSHTF2njNCSq88FPBFt5lcf
         T8f7NSVQeiMO7GcxQJV4GqufFBWMLWAlX3vJ4zljB3bjI+4Dpc/xDjrUHzYRjzZl8zBk
         H2tdvcvrHlabRkwCUFIgKYw1GOOzB20yXXzmPLiqHkUbIVVcSFx6/xdqxMU70XhOg1tY
         QLN/D46OQ1GNQZ7BPZ9Kq4T4xsvK620eEVW6snOkQsrF3WSdT2x5sUNfzE1BBQ/Cy8Pk
         VBOC0v4SBx7eyG4Kvxu1ov/QDu7SDGbEuvC0/InoDe4b/7sYJvd8iPlGqkwpA7lvhty+
         aSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=+Sz8IO3Q0Wi9qYyweBh6gIY8y2TmrnBiTxKhHiQe4zs=;
        b=kJ+D4wqUiM+ndTpVqq2hnVYUlVyhC0boxBR0qc05XH9JFd+uuDqpN1Tr8tx4aCdbwf
         jSdjD6MJguiMnsEWQDwTbwsunSR6fJT8YyuoMditHCorCU7YHIWtCUDbncaKktrjLy3+
         U8Zgy+z7EDbdpVWL/L/ccCqsL/C5IhheuJ6mxbwGO4q3D01wG+BDvd3P95KeSG9krGZn
         kqXMIDHMdE3yALemaBRH0WYXQznA4XzDYpk+Tj612KpUnxEidyiO+AKnXh9iFq4sX/Lt
         yMB3lrv4ji+TaX5nGz8E4KUQdLUyodr/DCgtD73oBrHyEwQ0arFvN1g3PSX6adAcC8wh
         NifQ==
X-Gm-Message-State: AOAM531vbWxjAsks66ZcUkCIcQzcu9AwMHmFjLxs7J1aHbsWrLs3Kvao
        QPWBXKDz1TDCQ+iRvcEOOic=
X-Google-Smtp-Source: ABdhPJzoMSlUK6EqV9Tw/SjDjjUBlhpoLYwEDlr6lqsY8xSFqjNYR34IwkEk2rrmYmKzPPWmWXeqfg==
X-Received: by 2002:a19:c8a:: with SMTP id 132mr13566932lfm.23.1592943570925;
        Tue, 23 Jun 2020 13:19:30 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f14sm1794789lfa.35.2020.06.23.13.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 13:19:29 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
        <20200622194122.GN6531@camp.crustytoothpaste.net>
        <871rm6x86y.fsf@osv.gnss.ru>
        <CABPp-BHa=jppGtoDiTz_NCXrd2zhTfALb_UrQjcF-VDcv+vuNA@mail.gmail.com>
Date:   Tue, 23 Jun 2020 23:19:29 +0300
In-Reply-To: <CABPp-BHa=jppGtoDiTz_NCXrd2zhTfALb_UrQjcF-VDcv+vuNA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 23 Jun 2020 10:08:30 -0700")
Message-ID: <87sgelpmb2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jun 23, 2020 at 5:47 AM Sergey Organov <sorganov@gmail.com> wrote:

[...]

>>
>> I believe we basically need support to apply different merge strategies
>> to different files.
>>

[...]

>> > Normally merges are symmetric, so if you want non-symmetric behavior,
>> > you have to define what it's supposed to be.
>>
>> Yes, I'm ready to define what it's supposed to be. The problem is that
>> "git merge" won't let me, due to lack of support to apply different
>> merge strategies to different files.
>>
>> As I see it, first step of improvements could be to support
>>
>>   git merge -- <files>
>>
>> where selected strategy applies only to <files>, and the rest of files
>> are kept intact (effectively applying "ours" strategy to them), along
>> with
>>
>>   git merge --exclude=<files>
>>
>> , to be able to exclude specific files (apply "ours" only to them)
>> rather than include.
>>
>> [ As a side-note, please notice that after such changes, the "ours"
>> strategy could be deprecated (not that I think it should), as either:
>>
>>    git merge <branch> --
>>
>> or
>>
>>    git merge --exclude=. <branch>
>>
>> would do the trick. ]
>>
>> The next step would then be to support
>>
>>   git merge --force -- <files>
>>
>> that would force to re-merge <files> with given strategy no matter what
>> their current status in the index is.
>>
>> Even though such support would be enough for my specific use-case, it
>> doesn't provide suitable way to configure the default behavior. As a
>> more generic solution, a new syntax for "git merge" to specify what
>> merge strategy to apply to what files could be designed, and then
>> ability to put that syntax into a file for "git merge" to pick would
>> solve the problem of quasi-static configuration problem. Alternatively,
>> even more generic .gitignore way of doing things apparently could be
>> re-used to some degree by adding support for .gitmerge files.
>
> I think you'd have an uphill battle to convince me that this isn't
> net-negative value:
>
>   * You can just do "git merge --no-commit ...; git restore
> [--source=<side>] -- <pathspec>" to do what you're talking about
> above.  I don't see the need to add extra functionality to merge,
> especially not functionality that duplicates restore's functionality.

Yeah, thanks, nice to know! I didn't, as "restore" is rather recent
addition:

$ git --version
git version 2.20.1
$ git help restore
No manual entry for gitrestore

However, it probably won't help with any other merge strategy anyway,
right? E.g., think "git merge -X ours".

It's already admittedly better than nothing though!

>   * The "ours" vs. "theirs" wording means you're going to have
> intrinsic problems with rebases.  Several users will like your choice
> of what "ours" means, the other half will complain that you've got it
> all wrong.  I think you need to let the users decide on a case-by-case
> basis, and we have a handy "git restore" command for letting them do
> that already.

I don't see how rebases are affected. I only suggested enhancements to
the merge-the-procedure, the "git merge" user command. Once merge is
finished and result is committed, there is (fortunately) now way for git
to know how exactly the resulting content has been achieved.

Nor do I see why to limit decisions to "ours" vs "theirs". I meant to
support arbitrary merge strategies for different files. Generic feature.

My thought was: if git at all supports different merge strategies, why
not to support different strategies for different files? I don't see any
inherent contradiction in adding of such a feature.

>   * The pathspec limiting is going to be a bug factory for renaming
> handling.  (The simplest form of which is just renaming a special path
> to a non-special path or vice-versa and modifying both sides of
> history.)  Rename handling can already get some pretty hairy corner
> cases without dumping more in the mix.  I'd rather have users decide
> what to do with paths that switched from being one of the special
> "ours" paths to being a normal 3-way-conflict marker path.

I admittedly didn't dive into such details, but I didn't suggest to
attach any additional attributes to paths either, so there is no need to
care about renames, as far as I'm able to see.

Apparently you talk about some other feature here that I didn't suggest.

> Luckily, we already have a command that users can use to do this: git
> restore.

"git restore" is nice, but solves only very limited subset of merging
strategies we try to find solution for.

>   * I've run into "branch-specific" files in the wild and even
> supported repositories that used them for years.  In my opinion, they
> are almost always nasty code smells that are artifacts from
> CVS/SVN-like thinking.  Although I wanted to stamp them out
> immediately, there was opposition to it.  However, over time, people
> removed those branch-specific files from the repository (and it wasn't
> just by me or at my prodding either; many were cleaned away by others
> without my involvement as other folks just found better ways to handle
> things over time).  Giving special support to bad practices will just
> enshrine them, which I'd rather avoid.

I didn't suggest any specific support for "branch-specific" files, nor
to any bad practices, as far as I'm aware.

OTOH, the generic feature I suggest, as any generic feature, could
indeed be (ab)used in multiple ways, but it's not a problem of the
feature itself.

> If someone wants to spend their time here, I can't stop them. Just be
> aware that personally, I think it'd be a bad idea to make any
> merge-recursive or merge-ort changes to support this kind of thing.

Hopefully your attitude is caused by some misunderstanding of the aim of
my suggestions.

> (Alternatively, if you're still convinced this is a good idea, you can
> consider this email a heads up about potential problem areas that you
> need to address and areas where you'll need to craft some good
> arguments to win over those who are skeptical.)

I still don't see any potential problems. Could you please give an
explanatory example?

Let me try to show my point by example. Suppose I've got a merge commit
where part of files were merged with recursive strategy, part of files
-- with the same recursive strategy but with -X ours, and the rest --
with the same recursive strategy and -X theirs. What problems,
exactly, do you expect?

In fact I even fail to see how you will be able to tell it has been
achieved with suggested feature rather than by manual resolution of all
the conflicts, so there must be no additional problems here.

What do I miss?

Thanks,
-- Sergey
