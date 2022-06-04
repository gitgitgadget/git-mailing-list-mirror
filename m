Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23921C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 20:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbiFDUbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240924AbiFDUbw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 16:31:52 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E56222AA
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654374678;
        bh=I3jgkRzPe8lO40gokcJ9/2/s/tr8mXXjhTNpRa7KeTo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EqJ3Nn5KphkyrG5U/ExOc7ImnjstIjuM2BfgcSrn+nycEhJD/wmYk3PjIbrv41Giq
         djW1vVAld2y7V/qbum5IJQNALGQBHEQxUDcPIKazzaVUDIMuyTbxeoVmcmbgDSaqNs
         IU6o2YD+EnFp1Vp0IrYTiRH6JyACtA+CJ0Av514M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAcpW-1o4EH80id6-00BTp6; Sat, 04
 Jun 2022 22:31:18 +0200
Message-ID: <3d2b349b-81aa-fd29-552d-5719dd75003d@web.de>
Date:   Sat, 4 Jun 2022 22:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 03/15] reftable: don't memset() a NULL from failed
 malloc()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-03.15-0b570d112fc-20220603T183608Z-avarab@gmail.com>
 <693ed3c3-535e-9eae-9fd7-ca612ebf6943@web.de>
 <220604.86pmjpw8h0.gmgdl@evledraar.gmail.com>
 <1de74bf7-0e75-8ae3-6ea7-62939b540061@web.de>
 <220604.868rqcwfnw.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220604.868rqcwfnw.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NC/JC0quYfaPdocDEVnsaSj5O3IRaQWPqj1V6kGYwpA8nMRgpLe
 5N7PgDk1oqgAOfBPx2gVi58NZrsp6MdhYyLcmiDmRZ2wrROvLmHHoDQHkXZ/yjjysynIRuo
 2DbxSWT1b9PezDnBkoRIbpjcCzbpiSsh4hpnQaO9csmCdll9FkZRmx1Qt6rHlGwwSmAlViP
 3ilDUBnbXETDuC7CGLMrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gUQq4YFqrPA=:CtoPU/vuuEMBilb66vEuKG
 ih4MIybaj4ITy33FnpN4fpcb2CgDkEmcNHylc9t3hkoJHqL+kpU13CPB6NJOiVXz3pee9f9M0
 2iLkdSbsdJFxnbghAO7TD3OUNVfW4KY1hTKZyClCgfG1vvt90FS8DLyjkGAcOaNNOAfS9nS71
 UpudoveO7P25O5+0SiG1i0IukqRbJuOoB5EHkt/PLGRb6Uipb++j5pLmVx28+zLZYqWzwWHNV
 5bQLwPeENjNMrjsJ5BsMsj3iqca4rrtANnq6tSbC/az4jAVVSWllwyzdUctklw59hXXw9rA6u
 IyaybO/3WfD4I/q2KWf/yO4zaRVTpa7+YdLvxenCYZoprlzAK2WdLoNfaO71PQ5Z8x2FBs5Bt
 HqiIIakUE5oO1cU0qOnLsMtCuU27a56kqiuvuAEpbVKVavJcWxpsZt79GJ4N+RZrtYMWarQAp
 e6bFw0WrJXuAnBVnX8qFnp2efctUuxbNYaHHpsC4r/ruRsHmfjRAbYh+GfH7SAW7sca44meUw
 ooEHhZHIw0iQ189PioonXEDUtT18QTtN+1/IlVeVE0ZbsUjxrVRCOwaPiaEl5zXaooo3qmKu3
 Jrsh4gYT8EYwu5trYpccpPvmeBwMUG7mF+UeQoPRyHzI+8BchsxXsqlXlOY2owDs0LLVdkJ9n
 m55lAKwH+IwOpXuFaQCIhcGIQtWFANVHD9yXo4EYsQAL7JeEML4sLDVWi+HSCRaLHxAl4ztxM
 pWgKQnCrVwTY+ODnnjCsDs6NR+7oSfCKbWXr77lNP4oA8a/ZYoWyikGwOnt4V/F3QyEmltKLg
 oeHS+5s4loL49qLOOSebSQLHR9gkM5Al+ZyLbtyc4rsnymyAOPodeqSomjZo/GB5zJCK/RmAt
 JC8/wV2ek79521TcYJbuN69Mt/fz4+f/95Zmdrcfk+DfV3Qb6TCbEcRbUUceX6fcfWVHMbEat
 I+9d0TWLkZfozzsDJbRA0rkW0QAmr/Osy6UIsKU9tOZYAFfti33CGhjSV//aFSuOWHxrnXE+C
 m8UnZBy4c8ncURTxnPsiC9enmKgLwIlCQe2Bx5vD2P/YiKp/tl6Xwaq8fmjJZY/64/yvgJ1AP
 xP0C8WLKl8d8NejESFr7u8wxEFW4c2MLgsK
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.06.22 um 18:23 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Jun 04 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 04.06.22 um 02:54 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> To your comment here & some others (e.g. FREE_AND_NULL()): I was reall=
y
>>> trying to focus on narrowly addressing these -fanalyzer issues without
>>> digressing into the larger topics "what is this code *really* doing, a=
nd
>>> does it make sense?". It was pretty unavoidable in 13/15 though.
>>>
>>> Which isn't to say that I shouldn't fix some of it, e.g. your
>>> s/return/BUG()/ suggestion, but I think it's best to view these patche=
s
>>> with an eye towards us already having these issues, and in most cases
>>> making -fanalyzer happy is a small cost.
>>>
>>> And by doing so and getting a "clean build" we'll be able to turn it o=
n
>>> in CI, and thus notice when we run into new -fanalyzer issues.
>>
>> Future analyzer reports are likely of the same quality as the current
>> ones.  If the goal is to shush them then we should just not use the
>> analyzer.  If reports contain a helpful signal, e.g. pointing to a real
>> bug or to overly complicated code, then we better address these issues.
>>
>> We can think about automating the analyzer once we have a certain numbe=
r
>> of commits with improvements that would not have been made without it.
>
> We might decide not to go with -fanalyzer in CI or whatever, but I
> really think that your line of reasoning here is just the wrong way to
> evaluate the cost/benefit of -fanalyzer, a new warning or whatever.
>
> There's ~15 commits in this series addressing things -fanalyzer brought
> up, and it would be ~20 if the remaining issues I punted on were
> addressed.
>
> The question shouldn't be whether those things in particular were worth
> the effort, but whether the added safety of getting the new diagnostic
> going forward is worth the one-time cost.

Is it pointing out real issues?  Yes, the ones from patches 1 and 2 look
legit.  Let's get them fixed and attribute -fanalyzer for finding them!
They are good selling points.

Is it giving us false positives?  Patches 4, 5 and 6 look like that to
me.  Perhaps we can still use this opportunity to simplify the code for
both human and machine, or at least add helpful asserts.

Patch 3 is a bit surprising to me.  It's a real issue, but the whole
reftable code never bothers to check for allocation errors, so I would
have expected the analyzer to report lots more places.

Is it worth automating the thing?  Perhaps, but we better work through
the reports we already have first before getting new ones.

> FWIW I spotted a couple of bugs in my own unsubmitted code from running
> all of it through -fanalyzer, and that POV is also worth thinking about,
> i.e. it's not just about improving git's current code, or even commits
> that might land in git.git in the future.
>
> But also to provide a development aid so that when we're writing patches
> we spot issues earlier, even if they're ones we might spot before we
> send the patch, or in review before it gets applied.
>
> It's also a much faster way of spotting certain issues, if you take into
> account that we've already been spotting some of these with the likes of
> SANITIZE=3Daddress, valgrind runs, or coverity.
>
> I find the warning output from -fanalyzer to be *really useful*. It's
> scarily verbose at first, but it's basically doing most of the work for
> you in terms of exhaustively describing how the control flow got to a
> given location. With e.g. SANITIZE=3Daddress and valgrind (to the extent
> that they overlap) you might get a stacktrace or two, but you generally
> have to chase all that down yourself.

Sounds good, makes me want to try it.  And I actually can, to a certain
degree: GCC 13 seems to get confused when compiling compat/ code on my
machine (macOS).  Not sure what's going on.  Compiling e.g. strbuf.c
works, though, and gives me the same false positive. :-|

Ren=C3=A9
