Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B84C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 13:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiDYNiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbiDYNh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 09:37:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625F1DEAC
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 06:34:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h1so14777867pfv.12
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qa4iMpT8RCEhrmVdzGzL9xpKVtejwmGDXWkBq07H0VQ=;
        b=Z8iFwiXFFDT9c/DNN6fzUvxRvEUIGtBnAgF0+Gckf3bOyHW6Xjnxs1ADF+xhmrSyF3
         wcFKWyB7pf7JwAsvIoRpZwG4WI/mk02iqjD95yHbdUs27F4bPE05k1vsZHoOuy8xl996
         o80sxsiCRaVF7lDjw56KSSsN38WLV8GCL5PvigkyNpxrwqycN1KgePt9TzEsdZyXliry
         oJyRd1DQ+VQlllWrGzxVo3WBYyrHBefpXAhx22IzDYTQiFXfXBgZp90wFa2asrDqQrvO
         O3oy/tcmVGGGEgKOpgTKxZRcSLy9Pla5p0Heu81dVwHZgBGzC884wba26SUIrmeYtZz9
         ZZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qa4iMpT8RCEhrmVdzGzL9xpKVtejwmGDXWkBq07H0VQ=;
        b=LK9uYUIfI2H9Qdh8BRKqyqh3osw9kSMbk86+3sbNVrrSlJ5fnj2eaqhL0GWqxEVDxT
         VVUueQ5FkcOem4JmwpqwvaRb5HryLq/7Ipk7c4UkvEs3xadj/SOpE3TWUC+3u0B4LA+K
         nvVsV/tEIyBkMmJMozJXRUziQDNLq4WzJgz5hyklllaZ8+zpd/WE/LC7hcw/Cz0h3Bw8
         cCBQ9fACFIJYGCpY5UY19rrqPlNBOEbtlLFjt5rleXq7/Yv3mS+1JJgRMoCrYdQSzCJ4
         LzEFnv8lauljdGihh6seoF7KIIFOKjf0NmSIn5U2th0lF8xWw780GoGR1YosdXxUQjr4
         R/hg==
X-Gm-Message-State: AOAM533wSbry10u553Ya3Jj8osL44N2Or0pQ1RlkEK4I2sidvMkZgM6k
        EGGaqRFzJJJPURgfV3qyQcGqVPgdv5/b8r5vIw8=
X-Google-Smtp-Source: ABdhPJwod5evAT3hbuob6CTihBH1OtQnHpmnxKa7NI14nSjIDtaxI2UUwceSwBgIC3nEPSs9YSCg/SE8j7H1u1Pof+Q=
X-Received: by 2002:a63:4101:0:b0:3aa:6375:e5f4 with SMTP id
 o1-20020a634101000000b003aa6375e5f4mr15025097pga.240.1650893686600; Mon, 25
 Apr 2022 06:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR06MB4517C164C76C68394411C023E6F29@BYAPR06MB4517.namprd06.prod.outlook.com>
 <BYAPR06MB45178AC5D8E81525F8528725E6F29@BYAPR06MB4517.namprd06.prod.outlook.com>
In-Reply-To: <BYAPR06MB45178AC5D8E81525F8528725E6F29@BYAPR06MB4517.namprd06.prod.outlook.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 25 Apr 2022 15:34:35 +0200
Message-ID: <CAP8UFD3GhCWWvQ9ZoySQ2Z5G-4-zGe5p01jb2=E9CPu09mN+Fw@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal] Unify ref-filter formats with other pretty formats
To:     Jack McGuinness <jmcguinness2@ucmerced.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2022 at 10:55 PM Jack McGuinness
<jmcguinness2@ucmerced.edu> wrote:
>
> Unify ref-filter formats with other pretty formats, for the Fourth Time

Thanks for your proposal!

> For my microproject, I chose to Modernize a test script, specifically t42=
02-log.sh
>
> I will admit, I had a bumpy run completing my Microproject. Going into th=
is, I had no experience with open-source, and due to this, my first attempt=
 was done incorrectly. In response to this, I went back and redid it, howev=
er as of right now it has not been reviewed by anyone. I believe that I cor=
rected all of the improper syntaxes, but it=E2=80=99s entirely possible I m=
issed something.
>
> Note: I used gitgitgadget to submit my patches.

I just took a look at version 2 and sent a reply with a few comments.
Note that you don't need for all the patches to be fully reviewed
before sending another version.

> History of Problem:
>
> As most open source projects get developed, git has been built up over ti=
me by many different people,

s/git/Git/

working towards a common goal of improvement, but all with different
ideas of how to get there. While this is a great thing that is the
reason open source software is such a brilliant idea, it can cause
confusion within the project.
> A prime example of this is formatting command output, where different com=
mands that overlap in what data they would output have different logic for =
getting said output, which causes people to need to know separate systems f=
or each command.
> Git has had a history of having mentored contributors work to amend this,=
 starting in Outreach Round 15,

s/Outreach/Outreachy/

Also it might be nice to say when was that Outreachy round.

> where Olga Telezhania mainly worked to migrate the logic in cat-file.c to=
 the logic in ref-filter, but unfortunately near the end, she was forced to=
 scrap her solution and restart, and her main work was never merged to mast=
er.

You might want to explain a bit more the reason for that.

> From what I could find, the next person to work on this was Hariom Verma =
during GSoC 2020. He started his project by looking over the work of his pr=
edecessor Olga, and deciding to take a different approach to the problem. O=
ver Hariom=E2=80=99s summer, he implemented a plethora of formatting option=
s in pretty formats, implementing all formatting options in pretty-lib.

Hariom's project was not quite the same as Olga's. Olga's was focused
on `git cat-file` while Hariom's wasn't.

> After Hariom, ZheNing Hu carried the torch and worked on the project for =
the 2021 GSoC. His main contributions revolved around refactoring cat-file,=
 similar to Olga.

Yeah, ZheNing's project was focused on `git cat-file` like Olga's.

> However, he also made the notable decision to spend time optimizing the p=
erformance of ref-filter.

It would be nice if you could say why this decision was made.

> Proposal: Unify ref-filter formats with other pretty formats
>
> My proposal is one of the ideas provided by Git-SCM, unifying the logic o=
f ref-filter with pretty formats. What this means, is that I would be rewri=
ting the formatting logic currently used in ref-filter, to be used in prett=
y. However, alongside doing this, I also have the goal of adding some small=
 new functionality to the formatting, and possibly optimizing the logic as =
ZheNing did.

Your project is more like Hariom's than Olga's and ZheNing's as it's
not focused on `git cat-file`. If you can also finish what Olga and
ZheNing started, that would be a really nice bonus outcome though.

> Benefits of Proposal:
>
> Completing this would improve the quality of life of people contributing =
to the formatting. The erasure of duplicate logic would make it simpler to =
understand the logic being used to format,

It's likely that the old formatting logic will have to be kept for a
long time for backward compatibility and not breaking existing users
though.

> and therefore simpler for a prospective contributor to implement a new fe=
ature, or alter a current one.
>
> My Plan:
>
> I looked over the proposals and blogs of the previous undertakers of this=
 proposal, and with their work and struggles in mind, I have compiled the f=
ollowing plan.
> Before I start working on the formatting logic, I want to learn to a usab=
le degree how to use the following tools:
> Valgrind
> GDB
> Tmux
> Possibly Gprof and perf
> My reasoning for this is that reading Olga's blog, she commented how if s=
he had started using the debugging assets earlier, she would have been far =
more on track. I want to go into this already knowing them so that I can ap=
ply them when needed, and not needlessly waste time.
> After this, I would focus on understanding the logic behind the formattin=
g, by studying the relevant files and working on small contributions and pa=
tches, to better understand the system in place. From what I can see, most =
previous contributors took around a month before they started coding their =
main project. If possible, I would like to figure this out in under a month=
, but I know that that=E2=80=99s easier said than done.
> After I understand, to a well enough degree, the formatting logic, I want=
 to start implementing the formatting options from other files.

I am not sure what "the formatting options from other files" refers to.

> As I understand it, major progress has been made in unifying the formatti=
ng logic, however, there are still implementations that work separately fro=
m what we want the standard to be. Ideally, I would like to spend the major=
ity of my time doing this, along with the debugging that goes along with it=
.
> If I have misjudged the amount of logic left to be rectified, then my pla=
n for my time would be to work to erase the current problems with the forma=
tting logic.
> Hariom mentioned that the following problems persisted after he finished =
GSoC:
> 30% of log tests are failing
> Pretty-lin.{c,b} does not have apt handling for incorrect formatting
> Olgas work needs attention
> A Lot of what ZheNing worked on covers the third problem, so I would like=
 to tackle the first two.

Yes, please.

> The reason for the first problem was due to the branch it was tested on n=
ot having mailmap logic, and also the second problem influenced it. Because=
 of this, I think If I go this route, my first step would be to implement i=
ncorrect formatting handling. A simple form of this is already implemented,=
 however it currently causes a segmentation fault, which would need to be d=
ebugged.

Ok.

> Prior Commitments:
> To be completely transparent, over the summer I already have a job, howev=
er, it is a part time job at my local fair grounds where I help out in the =
mornings. It doesn=E2=80=99t take too much time out of my day, I just want =
to be transparent about it.

Thanks for being transparent about it...

> I also will be spending a few days attending my cousin=E2=80=99s wedding =
in June, but I will be able to work on the project during this time, except=
 for the day of the actual wedding.

...and about this.

> Projected Timeline:
>
> Week
> Goal
> Prior to work start
> In the time I have before the official start of work, I want to get to kn=
ow the community better, and gain a good understanding of the workflow. Alo=
ngside this, I want to look into the aforementioned software tools, and als=
o read Pro Git Book, as Olga said the later chapters were invaluable to her=
 understanding.
> 1 - 3
> During the first three weeks, I plan to spend a majority of my team looki=
ng into the formatting logic. It is an important step, and If I start worki=
ng without knowing exactly what I=E2=80=99m doing then I could make a mista=
ke and end up costing more time then I intend to. During this time I want t=
o make small patches and contributions, to keep me in practice and help me =
develop my relationship with the community.
> 4-9
> At this point, I want to start my actual work of unifying logic. At this =
point, I=E2=80=99m unsure of what file I would start with, but I believe th=
at during the time allotted previously, I would be able to figure this out.
> 10-12
> I am leaving this time period for debugging and optimization. It is inevi=
table that what I make won=E2=80=99t work in some unexpected way. In order =
to best improve my chances of having a master ready project by the end, I w=
ant to make sure I have the time to take the work I've done over the summer=
 and turn it into a polished final product.

The issue with that kind of timeline is that reviewers are not likely
to accept your patches if they look buggy or not polished or optimized
enough. So if you plan to only polish, fully debug and optimize
towards the end of your GSoC time, it is likely that nothing will get
merged before that time. Then if you are late (for example because
early steps took more time than planned) and decide for some reason
(which might be a very valid one) to stop working on the project at
the end of the GSoC time, it might mean that nothing will have been
merged.

So I think it would have been better to split the time in a way similar to:

  - weeks 1 - 4: improve incorrect formatting handling
  - weeks 5 - 8: add mailmap support
  - weeks 9 - 12: fix all remaining issues

where at the end of each of these steps hopefully something can be merged.

> After GSoC
> After GSoC ends I will go back to school, which will limit the amount of =
time I have available. However even so, I plan to stay connected to the git=
 community in some way. At the very least, I plan to watch the mailing list=
, and provide commentary to other peoples patches, and at the most I would =
want to keep working on a major part of git, and finish what I started.

Nice!

> Blogging:
> I am currently a stranger to blogging, as I never thought of any reason s=
omebody would want to read my thoughts. However, I do keep a private journa=
l that I use to remember what I do each month, and plan out the next month,=
 which I think can be translated to a blog.

We don't absolutely require blogging (especially public blogging), but
we think it can help you both during and after your GSoC.

> If I am accepted, then I plan to have 14 total blog posts over the course=
 of the project. 12 of them to summarize what I did each week, 1 before I d=
o any work to provide a reference point for me at the end, and to help me c=
ollect what I am going in knowing, and 1 at the end, to be the summation of=
 my experience, and describe my experience and work in full.

Nice!

> Motivation:
> My motivation for participating in GSoC:
> I have always wanted to participate in an open source project, but I neve=
r knew how to take the first step. At times I considered contributing to so=
me projects, but I was worried that my commits would get ignored, I would d=
o it wrong and waste the time of people. When I say Google had a program

s/say/saw/

> to connect people to mentors and help get new developers into open source=
, I thought =E2=80=9CWow, that sounds like exactly what I=E2=80=99m looking=
 for.=E2=80=9D I didn=E2=80=99t even find out about the stipend until later=
, which is an obvious plus.
>
> My =E2=80=9CWhy Git?=E2=80=9D:
> When the list of organizations participating in GSoC 2022 came out, I wen=
t to the list, and compiled my own list of organizations I knew and would w=
ant to contribute to. I ended up creating a list of around 10 organizations=
, but when I looked at it, I just knew that Git stood out among them. It=E2=
=80=99s something that I use almost daily, and that I have always wanted to=
 know more about the internals of. At that point I started looking into how=
 to apply. To me Git is a backbone of all other programming projects, and e=
xists as a testament to what open source can be.
>
> Closing remarks:
>
> I would be more than overjoyed if I can be accepted, but even aside from =
that, I think that I have already learned a lot from GSoC. The materials pr=
ovided by Google and Git have given me a lot of advice and ideas for how I =
can personally contribute to something open source. In the case that I don=
=E2=80=99t get accepted, then I will still spend my summer contributing to =
open source. I may branch out a bit and focus on more then just git, bit

s/then just git, bit/than just Git, but/

> the idea of contributing to a public project just excites me, and I know =
I have to follow through with it.

Great, thanks!
