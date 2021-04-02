Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CFC433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 14:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBD361103
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 14:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhDBO5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBO5w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 10:57:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75181C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 07:57:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u17so1496152ejk.2
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NfeOQ7XmB72+VVq75I4Blqf6HkW+awWkL/pp+3a767M=;
        b=Tqdz7zfbrtfn+J+LUgtkd4W/ouMNIRU6nOK6+1jCGvG/puofjzEeVqIl7Gtjr50xC0
         I9ntr90BduOE9G5U8Uq0vKTjA6aMGgIhkIPfAz8W56UXmBUaqLTz27vlxKImxg3X42X7
         sTif1YoaGnuR/fMIHpgH29LeM1IQnHp3DR6V37fbdnCZNamguaB0HTMqfIy3SJAb+VsL
         XqmpOiCPAcEowF0CY9LgzEsG8tsDCECWABGOInkp2E0VXjQ/8Z5vZUusKfJkWX9yD2FS
         f5I/KeHb1UzJM/+h4BNoAr2QAPipXibN4VsBkhiqG3+wByOSS8T1d4DuMolXh2IpAjr4
         V+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NfeOQ7XmB72+VVq75I4Blqf6HkW+awWkL/pp+3a767M=;
        b=YtM8ET18K9MSRLAK4RE6A+9+NWHzfz55aIEZZgiMdzzCb0382r4TnW/QOdD9F7RouZ
         BoZLNrX4SMZS7zi7ofIhdRasPZZgakYgMf0pwh/6g/xxg45YbD1srbLsAo6K+N+v6VXB
         MBDAA/no7KZzw+vXTJF6EKu1Tf5fBu9GneNjzVFDmIAHt4T8Dd6gtAaZDLkl/j36Ws5x
         jmksB9buzWsG8tTRdThhZx0WJMu/EWXA/y7wSaqAWQ/GqzjkQlUE26r/fhyipalXzqvj
         2fNolV9U5+C+gM2vD+cHompH3lWRABBoZi3mlxMDCxOanwvHGYaYjAcCTqwMac9rFnVY
         O5ow==
X-Gm-Message-State: AOAM530/SdeuyNv0CU7THOCGGhsxhdWbUAWbMgmlh3dHHTFp8Pv4Vhvq
        oxBvUULJLGdqdVmFi31Kp8LyD9FQZSgJqn4dGWc=
X-Google-Smtp-Source: ABdhPJxg6f9+szvsJ1NQ411vpE+VLDLp3kEnJW9xdl1SMchiHQa84E34zrA0GVDk9e6zLWjkckjXi/tzLX2jtxuGBiM=
X-Received: by 2002:a17:907:8315:: with SMTP id mq21mr1639748ejc.197.1617375469656;
 Fri, 02 Apr 2021 07:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
In-Reply-To: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 2 Apr 2021 16:57:38 +0200
Message-ID: <CAP8UFD17jQyUSui3Czs1b7BP_sj2jB3_LvWSdP4Sd=1N_5PBRA@mail.gmail.com>
Subject: Re: GSoC Git Proposal Draft - ZheNing Hu
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Hariom verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Shourya Shukla <periperidip@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Apr 2, 2021 at 11:03 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Hello, Git,
> I'm ZheNing Hu,
> Here is my GSoC 2021 Proposal draft.
> And website version is there :
> https://docs.google.com/document/d/119k-Xa4CKOt5rC1gg1cqPr6H3MvdgTUizndJG=
Ao1Erk/edit
>
> Welcome any Comments and Correct :)

Thanks!

> ----8<----
> ## Use ref-filter formats in git cat-file
>
> ### About Me
> | Name | ZheNing Hu |
> | ---------- | ------------------------------------------ |
> | Major | Computer Science And Technology |
> | Mobile no. | +86 15058356458 |
> | Email | adlternative@gmail.com |
> | IRC | adlternative (on #git-devel/#git@freenode) |
> | Github | https://github.com/adlternative/ |
> | Blogs | https://adlternative.github.io/ |
> | Time Zone | CST (UTC +08:00) |
>
> ### Education & Background
> * I am currently a 2nd Year Student majoring in computer science and
> technology in Xi'an University of Posts & Telecommunications (China).
> * In my freshman year, I joined the XiYou Linux Group of the
> university and learned how to use Git to submit my own code to GitHub.
> I have learned C, C++, Python and shell in two years, I know how to
> use gdb debugging, and I am familiar with relevant knowledge of Linux
> System Programming and Linux Network Programming.
> * I started learning Git source code and made contributions to Git
> from December of 2020.
>
> ### Me & Git
> Around last November, I found a couple of projects
> [build-your-own-git](https://github.com/danistefanovic/build-your-own-x#b=
uild-your-own-git)
> on GitHub teaching me how to write a simple git, the mechanics of Git
> are very interesting:
>
> 1. There are four types of objects in Git: BLOB, TREE, COMMIT, TAG
> 2. The (loose)objects are stored in `.git/object/sha1[0-1]/sha1[2-39]`
> with the sha1 value of the data as the storage address.
> 3. All branches are just references to commits.
>
> Then I read`=E3=80=8APro Git=E3=80=8B`and Jiang Xin's `=E3=80=8AGit Autho=
ritative Guide=E3=80=8B`,
> learned the use of most Git subcommands.
>
> Later, I started learning some of the Git source code, I found Git has
> at least 200,000 lines of C code and 200,000 lines of shell script
> code, which leaves me a little confused about where to start.
>
> But then, after I submitted my first patch, a lot of people in the Git
> community came over and gave me very enthusiastic guidance, which gave
> me the courage to learn the Git source code, and then I started making
> my own contributions, You can find them here:
> [gitgitgadget](https://github.com/gitgitgadget/git/pulls?q=3Dis%3Apr+auth=
or%3Aadlternative+)
> or
> [git.kernel.org](https://git.kernel.org/pub/scm/git/git.git/log/?qt=3Dgre=
p&q=3DZheNing+Hu)
>
>
> These patches have been merged into the "master" branch:
>
> #### [master]
> * difftool.c: learn a new way start at specified file [(mail
> list)](https://lore.kernel.org/git/pull.870.v6.git.1613739235241.gitgitga=
dget@gmail.com/)
> * ls-files.c: add --deduplicate option
> [(mail list)](https://lore.kernel.org/git/384f77a4c188456854bd86335e9bdc8=
018097a5f.1611485667.git.gitgitgadget@gmail.com/)
> * ls_files.c: consolidate two for loops into one
> [(mail list)](https://lore.kernel.org/git/f9d5e44d2c08b9e3d05a73b0a6e520e=
f7bb889c9.1611485667.git.gitgitgadget@gmail.com/)
> * ls_files.c: bugfix for --deleted and --modified
> [(mail list)](https://lore.kernel.org/git/8b02367a359e62d7721b9078ac8393a=
467d83724.1611485667.git.gitgitgadget@gmail.com/)
> * builtin/*: update usage format
> [(mail list)](https://lore.kernel.org/git/d3eb6dcff1468645560c16e1d875300=
2cbd7f143.1609944243.git.gitgitgadget@gmail.com/)
>
> And These patches are in the queue:
>
> #### [next]
>
> * format-patch: allow a non-integral version numbers
> [(mail list)](https://lore.kernel.org/git/pull.885.v10.git.1616497946427.=
gitgitgadget@gmail.com/)
> * [GSOC] commit: add --trailer option
> [(mail list)](https://lore.kernel.org/git/pull.901.v14.git.1616507757999.=
gitgitgadget@gmail.com/)
>
> #### [WIP]
>
> * gitk: add right-click context menu for tags
> [(mail list)](https://lore.kernel.org/git/pull.866.v5.git.1614227923637.g=
itgitgadget@gmail.com/)
> * [GSOC] trailer: pass arg as positional parameter
> [(mail list)](https://lore.kernel.org/git/5894d8c4b36466326b0427bfda0d698=
1e52a0907.1617185147.git.gitgitgadget@gmail.com/)

Great!

> ### Proposed Project
>
> * Git used to have an old problem of duplicated implementations of
> some logic. For example, Git had at least 4 different implementations
> to format command output for different commands.

What's the current status? Which implementations have been merged
together since that time?

> * `git cat-file` is a git subcommand used to see information about a git =
object.
>
> * `git cat-file --batch` can print object information and contents on
> stdin.

It reads from stdin and prints on stdout.

> The only difference between `--batch-check` and `--batch` is
> that `--batch-check` does not print the contents of the object.
> * `--batch-all-objects` will show all objects with `--batch` or `--batch-=
check`.
> * `--batch-check` and `--batch` both accept formatted strings:

It might be better to say that they accept a custom format that can
have placeholders like the following:

> * `%(objectname)`: 40-bit SHA1 string of Git object

Git is being worked on to be able to use SHA-256 as well as SHA1.

> * `%(objecttype)`: Object Type blob,tree,commit,tag
> * `%(objectsize)`: Size of the object's content
> * `%(objectsize:disk)`: The size of the object itself on disk
> * `%(delatbase)`: If the object is stored incrementally in Git,

s/delatbase/deltabase/

> Returns the SHA1 string for its delabase

s/delabase/deltabase/

Also see above about SHA1 and SHA256.

> * `%(rest)`: Anything before the space and TAB in the input
> line is treated as an object, and anything after
> that will be printed as usual

In general it's ok to copy some parts of the doc if they are important
for your proposal as long as you say that it comes from the doc. It's
also ok with rephrasing parts of it, to adapt them or make sure you
understand them though.

> * In the original design, the first time use `expand_format()` in
> `batch_objects()` is to parsing formatted messages, the second time

s/parsing/to parse/

I am not sure what you call "formatted messages".

> use `expand_format()` in `batch_object_write()` is to format the
> object information and store it in a string buffer, eventually the
> contents of this buffer will be printed to standard output.
>
>
> * [Olga](olyatelezhnaya@gmail.com) have been involved in integrating
> `ref-filter` logic into `cat-file`
> [(link)](https://github.com/git/git/pull/568), the problem with her
> patches at that time:
> 1. Too long patch series, difficult to adjust and merge.
> 2. I don't think it's a good idea for her to use `struct
> ref_array_item` instead of `struct expand_data` for `cat-file` to fit
> `ref-filter` logic, because `struct ref_array_item` and `struct
> expand_data` are not very related.
> [(link)](https://github.com/git/git/pull/568/commits/e0aafaa76476ba5528f8=
4b794043531ebd4633c7#diff-d03110606a7ed8cb9832bbcc572f1093435cc6115c4e58d7a=
7750af3c33319a7R238)

Olga also sent patch series to the mailing list. Could you find them
and tell what happened to them?

Also Hariom Verma worked on a related project recently. Could you talk
a bit about it?

> * Because part of the feature of `git for-each-ref` is very similar to
> that of `git cat-file`, I think `git cat-file` can learn some feasible
> solutions from it.
>
> #### My possible solutions:
>
> 1. Same [solution](https://github.com/git/git/pull/568/commits/cc40c464e8=
13fc7a6bd93a01661646114d694d76)
> as Olga, add member `struct ref_format format` in `struct
> batch_options`.
> 2. Use the function
> [`verify_ref_format()`](https://github.com/gitgitgadget/git/blob/84d06cdc=
06389ae7c462434cb7b1db0980f63860/ref-filter.c#L904)
> to replace the first `expand_format()` for parsing format strings.
> 3. Write a function like
> [`format_ref_array_item()`](https://github.com/gitgitgadget/git/blob/84d0=
6cdc06389ae7c462434cb7b1db0980f63860/ref-filter.c#L2392),
> get information about objects, and use `get_object()` to grub the
> information which we prefer (or just use `grab_common_value()`).
> 4. The migration of `%(rest)` may require learning the handling of
> `%(if)` ,`%(else)`.

I will look at this later.

> ### Are you applying for other Projects?
>
> No, Git is the only one.
>
> ### Blogging about Git
>
> In fact, while I am studying Git source code, I often write some
> [blogs](https://adlternative.github.io/tags/git/) to record my
> learning content, this helps me to recall some content after
> forgetting it. Most of the blogs were written in Chinese previously,
> but during the GSoC, I promise all my blogs will be written in
> English.
>
> ### TimeLine
> * May 18 ~ June 8
> * Look for a scheme to make `git cat-file` and `ref-filter` more
> compatible, and start the integration attempt.
> * *Stretch Goal*: move `%(objectsize)`,`%(objecttype)`,`%(objectname)` .
>
> * June 8 ~ July 8
> * Move the body of the `git cat-file` attempt to the `ref-filter`
> logic, complete the basic function realization.
> * *Stretch Goal*: move `%(deltabase)`,`%(objectsize:disk)`,`%(rest)` .
>
> * July 8 ~ August 17
> * Analyze the performance of ref-filter and try to reduce the
> performance cost of a lot of string matching. I thought if I had some
> spare time, I could work on some other interesting patches.
> * *Stretch Goal*: Optimize ref-filter performance.

I will also look at the timeline later.

> ### Availability
> My exam is expected to end in June, but the time I don't have classes
> before the final exam, as well as the summer vacation after that, is
> basically my self-learning time. Although I am studying many other
> courses, I have enough time and energy to complete daily tasks. I'm
> staying active on the Git mailing list, you can find me at any time as
> long as I am not sleeping. :)
>
>
> ### Post GSoC
> * I love open source philosophy, willing to spread the spirit of
> openness, freedom and willing to research technology with like-minded
> people.
> * In my previous contact with the Git community in the past few
> months, many people in the Git community gave me great encouragement.
> I hope I can keep my passion for Git alive, contribute my own code,
> and pass this cool thing on.
> * I am willing to contribute code to the Git community for a long time
> after the end of GSoC.
> * I hope the Git community can give me a chance to participate in
> GSoC. I sincerely thank GSoC and the Git community!

Thanks!
