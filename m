Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCC9C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 14:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjBBOMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 09:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjBBOMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 09:12:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6658E069
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 06:12:27 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id dr8so6219185ejc.12
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 06:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rZl92GGPkpXm10EN0yUnMXuAPI+/LE1lVPZ9ASg7Fw=;
        b=OdyFKdZjG/muj58KKawEG4lwWDJb9uvnBb0DJFfjXL5BoJSJwRmkbpTQW7DVG2XB3Y
         +cNLELfVHon8vHyOolSbKD6zi2meogwtxyLQeaBa9VO8wsxg5V/lcIcJmTm6mStAo9n3
         zwNPJGqPUCSlPjiaqDoxrZOMv1R7tvkiUP+3h25Dh9yOubg412WdeQS0oG3wW58g7E2E
         zTPr6hoenw8oNRXJV2FuB9lKuU/tRXMsG0/Xs6aSQypipGnvqVz6/SYkp4GpaOBB/7ZO
         BPDb/pO7tPAXmy0aBBWZvtybwTX2lFUR6NsPcvCnwFa5y9YOGNZa6kOljmMOytr5Wrvx
         lJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rZl92GGPkpXm10EN0yUnMXuAPI+/LE1lVPZ9ASg7Fw=;
        b=Hj1jaDwUYsxXZe2GprCMHP2fgy+KIEnYGnuYukPiEy/0LpZZ4jaeY2rOmxKsK9raRW
         qBm102LN4/4GzsUe1dwBZugouYkqKzASeGKnmO2k+xfWX17UT7hs3uLsz7Pc6gWzStNV
         xU2inBc9+4VsiJjGX0TclUPAuOfrmgtISQb9e9txXTVFNqs3be1KLsYF7pmcx+PKUVjU
         XUP+RxgWBV0hVl18aXcf/N5CZWUKUxSB4RWSBYcGRIusjEziugQMayDFWpqX7i1eUBSp
         KSpjUeuqAqGXtkdcp7MkXF1z62jcMReS9lxssSLlLh3pPn7rkYldB0qRHQF7vwAoy6OH
         axDQ==
X-Gm-Message-State: AO0yUKWghap9KnKJ6k22Kgrnx5hG3pa1xGZZDDPoJDw/+4wGmcFBiXrv
        m09plVEpm3kOF3iTLsi6vkjNE4njJFC+N1P7Sx7BqBK2o8o6BA==
X-Google-Smtp-Source: AK7set+Yp0TCV8DiYqiiiTkGRjZ45h8JWQSKYkP3ACQXnAnzbBD/dWf2qTpcIGwx9ZUkcuq223Hdi/yU+hIzWmdRNTs=
X-Received: by 2002:a17:906:914e:b0:87b:d26f:eb49 with SMTP id
 y14-20020a170906914e00b0087bd26feb49mr1888294ejw.176.1675347145659; Thu, 02
 Feb 2023 06:12:25 -0800 (PST)
MIME-Version: 1.0
References: <CAFY6qgHNvXQq1Fjg4K3E5aPwr5JMxegjSJymgcGus-iw8L4riA@mail.gmail.com>
 <CAKEM=PMnBYqW-0TkB_P6Tav5JonEkefs71fOXr9s7hVpJ0uK6A@mail.gmail.com>
 <CAFY6qgG=myafvkyJcVFZS_8JXQm5zVCDOOsMtDTVB90QwuvjDQ@mail.gmail.com>
 <CAFY6qgG+YTX63ND68zdF98SqTK87+4kKu3aQUVCX-dsAVwqGAg@mail.gmail.com>
 <CAKEM=POA6L4pZCeWgYiqgamaAt4OG6Fg50QSRnXBbFEekmOXSQ@mail.gmail.com> <CAFY6qgH3jUqUNra_eTR+Feoi3-Y-mEve3vVvnJo0JYHN1PiYCw@mail.gmail.com>
In-Reply-To: <CAFY6qgH3jUqUNra_eTR+Feoi3-Y-mEve3vVvnJo0JYHN1PiYCw@mail.gmail.com>
From:   =?UTF-8?B?4KS14KS/4KS24KWN4KS14KS+4KS44KWLIOCkteCkvuCkuOClgeCkleCkv+CknOCkgyAoVmlzaA==?=
         =?UTF-8?B?dmFzIFZhc3VraSk=?= <vishvas.vasuki@gmail.com>
Date:   Thu, 2 Feb 2023 19:41:49 +0530
Message-ID: <CAFY6qgHPAaHumKNoV++RpPt3dHM9nxfF09bUAYfzz55pLRjqCQ@mail.gmail.com>
Subject: Re: Cloning submodules on github actions very slow
To:     sanskrit-programmers <sanskrit-programmers@googlegroups.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(A bug report - resending as plain text as the html one bounces.
kindly reply-all/ cc me if I am mistaken, since I am not subscribed to
git@vger.kernel.org .)

Why does submodule cloning pull in unrelated branches? Trying the
below did not work (the second command fails with " Unable to find
refs/remotes/origin/content revision in submodule path 'content'"):

        git submodule update  --single-branch --init --recursive
        git submodule update --remote --merge --recursive

For background info, please see
https://github.com/vishvAsa/purANam/issues/5 or the thread below.


>
>
>
> On Thu, 2 Feb 2023 at 19:19, Shreevatsa R <shreevatsa@gmail.com> wrote:
>>
>> Yes, the size of the repo has gone from ~8 GB to ~120MB now, so it's fas=
ter now.
>>
>> The size of the repository depends on all the objects in it, which inclu=
des the history of all branches. It need not have any direct relationship w=
ith the number of files.
>>
>> On Thu, 2 Feb 2023 at 02:28, =E0=A4=B5=E0=A4=BF=E0=A4=B6=E0=A5=8D=E0=A4=
=B5=E0=A4=BE=E0=A4=B8=E0=A5=8B =E0=A4=B5=E0=A4=BE=E0=A4=B8=E0=A5=81=E0=A4=
=95=E0=A4=BF=E0=A4=9C=E0=A4=83 (Vishvas Vasuki) <vishvas.vasuki@gmail.com> =
wrote:
>>>
>>>
>>>
>>> On Thu, 2 Feb 2023 at 13:39, =E0=A4=B5=E0=A4=BF=E0=A4=B6=E0=A5=8D=E0=A4=
=B5=E0=A4=BE=E0=A4=B8=E0=A5=8B =E0=A4=B5=E0=A4=BE=E0=A4=B8=E0=A5=81=E0=A4=
=95=E0=A4=BF=E0=A4=9C=E0=A4=83 (Vishvas Vasuki) <vishvas.vasuki@gmail.com> =
wrote:
>>>>
>>>>
>>>>
>>>> On Thu, 2 Feb 2023 at 11:39, Shreevatsa R <shreevatsa@gmail.com> wrote=
:
>>>>>
>>>>> AFAICT the issue has nothing to do with submodules or GitHub actions;=
 the repository in question is just massive.
>>>>>
>>>> I thought so too initially, but it doesn't seem so. Observe the timest=
amps on the following lines
>>>>
>>>> 2023-02-01T17:34:32.3793039Z Cloning into '/home/runner/work/purANam/p=
urANam/content'...
>>>> 2023-02-01T17:47:40.0953104Z Cloning into '/home/runner/work/purANam/p=
urANam/static'...
>>>> 2023-02-01T18:00:36.8478598Z Cloning into '/home/runner/work/purANam/p=
urANam/themes/sanskrit-documentation-theme-hugo'...
>>>>
>>>> Now, you see it took 13 minutes for the static_files branch. And, that=
 branch has - just a few files, and just two commits - https://github.com/v=
ishvAsa/purANam/tree/static_files .
>>>
>>>
>>>
>>> Oh - It seems like I had to squash ALL branches (and ensure that the de=
ploy-branch history does not keep growing over time).
>>>
>>> I could not figure out a way to make sure that submodule initialization=
/ updation works without peeking into unrelated branches.
>>>
>>>
>>>>
>>>>
>>>> To add to this - This is in contrast with 27s for purANam_vaiShNavam, =
where the number of files is quite large.
>>>>
>>>>
>>>>
>>>>
>>>>>
>>>>> Just ran git clone git@github.com:vishvAsa/purANam.git and it (still =
running) seems to be about 8 GiB in size!
>>>>>
>>>>> See this Gitlab help page for some ideas on reducing repository size =
(basically rewrite history). (If you want to understand what's going on, th=
is blog post I wrote a few years ago (needs to be updated for Python 3) may=
 be helpful though it's been a while and I haven't thought about how releva=
nt it is in this case...)
>>>>
>>>>
>>>>
>>>> I already tried squashing commits ( https://github.com/vishvAsa/purANa=
m/issues/5#issuecomment-1412653883 ) and force pushing - did not help.
>>>>
>>>> (Something like git rebase -i 4d7ca0eaf2583d8454b36671fed09b7ab2501680=
  followed by squashing all but a few commits, followed by force-push)
>>>>
>>>>
>>>>
>>>>>
>>>>>
>>>>>
>>>>> On Wed, 1 Feb 2023 at 20:13, =E0=A4=B5=E0=A4=BF=E0=A4=B6=E0=A5=8D=E0=
=A4=B5=E0=A4=BE=E0=A4=B8=E0=A5=8B =E0=A4=B5=E0=A4=BE=E0=A4=B8=E0=A5=81=E0=
=A4=95=E0=A4=BF=E0=A4=9C=E0=A4=83 (Vishvas Vasuki) <vishvas.vasuki@gmail.co=
m> wrote:
>>>>>>
>>>>>> ( Using github actions to build a sanskrit related site. )
>>>>>>
>>>>>> Any ideas regarding https://stackoverflow.com/questions/75318595/git=
hub-actions-cloning-submodules-very-slow ?
>>>>>>
>>>>>> --
>>>>>> --
>>>>>> Vishvas /=E0=A4=B5=E0=A4=BF=E0=A4=B6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=
=A4=B8=E0=A4=83
>>>>>>
>>>>>> --
>>>>>> You received this message because you are subscribed to the Google G=
roups "sanskrit-programmers" group.
>>>>>> To unsubscribe from this group and stop receiving emails from it, se=
nd an email to sanskrit-programmers+unsubscribe@googlegroups.com.
>>>>>> To view this discussion on the web visit https://groups.google.com/d=
/msgid/sanskrit-programmers/CAFY6qgHNvXQq1Fjg4K3E5aPwr5JMxegjSJymgcGus-iw8L=
4riA%40mail.gmail.com.
>>>>>
>>>>> --
>>>>> You received this message because you are subscribed to the Google Gr=
oups "sanskrit-programmers" group.
>>>>> To unsubscribe from this group and stop receiving emails from it, sen=
d an email to sanskrit-programmers+unsubscribe@googlegroups.com.
>>>>> To view this discussion on the web visit https://groups.google.com/d/=
msgid/sanskrit-programmers/CAKEM%3DPMnBYqW-0TkB_P6Tav5JonEkefs71fOXr9s7hVpJ=
0uK6A%40mail.gmail.com.
>>>>
>>>>
>>>>
>>>> --
>>>> --
>>>> Vishvas /=E0=A4=B5=E0=A4=BF=E0=A4=B6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=
=B8=E0=A4=83
>>>>
>>>
>>>
>>> --
>>> --
>>> Vishvas /=E0=A4=B5=E0=A4=BF=E0=A4=B6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=
=B8=E0=A4=83
>>>
>>> --
>>> You received this message because you are subscribed to the Google Grou=
ps "sanskrit-programmers" group.
>>> To unsubscribe from this group and stop receiving emails from it, send =
an email to sanskrit-programmers+unsubscribe@googlegroups.com.
>>> To view this discussion on the web visit https://groups.google.com/d/ms=
gid/sanskrit-programmers/CAFY6qgG%2BYTX63ND68zdF98SqTK87%2B4kKu3aQUVCX-dsAV=
wqGAg%40mail.gmail.com.
>>
>> --
>> You received this message because you are subscribed to the Google Group=
s "sanskrit-programmers" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n email to sanskrit-programmers+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msg=
id/sanskrit-programmers/CAKEM%3DPOA6L4pZCeWgYiqgamaAt4OG6Fg50QSRnXBbFEekmOX=
SQ%40mail.gmail.com.
>
>
>
> --
> --
> Vishvas /=E0=A4=B5=E0=A4=BF=E0=A4=B6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=B8=
=E0=A4=83
>


--=20
--
Vishvas /=E0=A4=B5=E0=A4=BF=E0=A4=B6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=B8=E0=
=A4=83
