Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C43C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352550AbiFHA2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580660AbiFGXmB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:42:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F8248518
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 14:57:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kq6so24800426ejb.11
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 14:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4PBVhhBzDnTUlalGQvTnArfh1Umvyus4WDju7uYLihM=;
        b=SI+2MULlFXFJbJtRWBSzYansOZA0fEoPVRRqicdmZzgPCqpKXB/qVFsbXTHXTbvXRB
         Rw4PsU20d4tsNUqyTngBCjTmagng3vZP7+m4X4T/zyOZfkkxEmc5yOHxYEcCLSfeZKT6
         jNqi5c64qrD7pVfmYtoodJJ3a5oLQuZSRJDSO1X2M4jhpNUpCbz7GNR90nJE6jCa3R+A
         AuXcQCCVQX/MVFCrMihrVzcpy0SbeeHkdY+mzCXkchF7Eg/dI8id+1MhwfyNu9K7v908
         mLU99LQS2RKVec9eGrCjNxlXkn/AFYxzrEjWdsEgj9m6dRCW9R90ng94OtwWq700XL27
         Xb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4PBVhhBzDnTUlalGQvTnArfh1Umvyus4WDju7uYLihM=;
        b=J9E+yWtZW4YjOWs53CAR8qGWwRnHmx4+4VhT9SXgpXbSE3E7Bv+RaeZoDNqpvES3l/
         QqPPnvnefL/7FOj38bXVaS2D8aJ+3cAxnJdYK9XQbPv7zHowUiHNm1mieuXUkpdDh/f0
         gddYiVB1stx94vPz/k82mKb1TLxCkdS4BokV2E3rSQvVCQUEVRZhJJajc8Fq0eLRaYU+
         kzAaRFCOHikyNO+9NpcQwTWd2FYNuFclg4f1tx2C7vPbQHykOec7YazYXq7DMCalt5UG
         Igj3rrYSdK5ostShdzkVDZfQijiKA1q2SYc54cSNXUl/XzV4yZqO31QwiYlvKuFrtzSb
         W+BQ==
X-Gm-Message-State: AOAM53286Q+Qwr4IjDb6sX/n2VDAywnNN4ikteX4Yd2SEpPqsAPWhiTG
        nMOzOJnLbtKvae5JeSOQDFo=
X-Google-Smtp-Source: ABdhPJzIvosu53GoQzSiBllsokNd2arCD1irwIFtJH644DJBvZgVhxqz5FJ5NnqaYyMdlcyD3FHQHg==
X-Received: by 2002:a17:907:90c4:b0:710:456a:6981 with SMTP id gk4-20020a17090790c400b00710456a6981mr20215459ejb.484.1654639036169;
        Tue, 07 Jun 2022 14:57:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id qu19-20020a170907111300b006fe960c5c5asm8267494ejb.126.2022.06.07.14.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:57:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nyhCM-002gRY-MS;
        Tue, 07 Jun 2022 23:57:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        congdanhqx@gmail.com, dyroneteng@gmail.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: js/ci-github-workflow-markup output regression
Date:   Tue, 07 Jun 2022 23:40:31 +0200
References: <xmqqee28spni.fsf@gitster.g>
        <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2206021703110.349@tvgsbejvaqbjf.bet>
        <220603.86fskmxd43.gmgdl@evledraar.gmail.com>
        <xmqqpmjpeedq.fsf@gitster.g>
        <220604.86y1ydwcq1.gmgdl@evledraar.gmail.com>
        <xmqqo7z4wcsw.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqo7z4wcsw.fsf@gitster.g>
Message-ID: <220607.86tu8wt9vp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 07 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, Jun 03 2022, Junio C Hamano wrote:
>>
>>> Indeed it makes it impossible to figure it out things like this
>>> case.  But ...
>>>
>>>> But this does look easy to "solve" with a quicker fix, just bringing
>>>> back the "ci/print-test-failures.sh" step so you can at least expand i=
t,
>>>> and not have to go to the "summary" and download the *.zip of the log
>>>> itself. As that shows we still have the raw log there, it just didn't
>>>> make it to the new GitHub Markdown formatting mechanism.
>>>
>>> ... it seems a solution is possible?  Care to send in a patch (or
>>> perhaps Dscho already has a counter-proposal)?
>>
>> The only thing I have at the moment is:
>>
>>     1. git revert -m 1 bd37e9e41f5
>>     2. merge: https://lore.kernel.org/git/cover-v6-00.29-00000000000-202=
20525T094123Z-avarab@gmail.com/
>>     3. merge: https://lore.kernel.org/git/cover-v6-00.14-00000000000-202=
20525T100743Z-avarab@gmail.com/
>>
>> I.e. to pick this in the sequence I'd proposed doing & have tested
>> thoroughly.
>
> I know you two have difference in opinions, but throwing away
> everything the other party did and forcing your stuff in is not a
> very effective way to work together.

I'm suggesting getting Johannes's patches in combined with the changes &
bugfixes I'd proposed.

So no, not throwing that work away, it would (applied up to 14/14) give
you functionally the same end result that's on "next" now as far as the
new GitHub Markdown output is concerned. The [3] above has links to the
relevant CI output.

I had tried to rebase the above [2] on top of "next" before this
discussion started, I agree that would be ideal, but it's a much larger
logical change that I don't have time to pursue now.

I.e. there's a reason I proposed doing it in that order, a logical
rebasing of [2] on top of bd37e9e41f5 would involve a lot of backing out
of the existing direction taken there. I.e. the whole part where the
split by "steps" provides much of the ci/* specific code in bd37e9e41f5
for free.

>> It also addresses other noted some other regressions in "next", but as
>> noted e.g. in [A] there's other issues in "next", e.g. that even the
>> "raw" trace logs are altered as a side-effect of running with
>> --github-workflow-markup, and of course the major UX slowdowns.
>
> Dscho?  I know you do not care about the UX slowdown as much as
> others, but I am sure you do not consider what is in 'next' is
> perfect. It seems to need further work to go back to the feature
> parity with what it replaced.

Just to be clear [3] up to 14/14 would still exhibit this particular
bug, but with 13/14 it wouldn't from the links in [3] the relevant
outputs are:

 "next" (well, similar): https://github.com/avar/git/runs/6571972194?check_=
suite_focus=3Dtrue
 [3] with 14/14: https://github.com/avar/git/runs/6588407676?check_suite_fo=
cus=3Dtrue
 [3] with 13/14: https://github.com/avar/git/runs/6588579493?check_suite_fo=
cus=3Dtrue

I really would like to get is out of this long-running ci/ limbo,
perhaps Johannes has some proposed patches, but I don't think fixing the
outstanding bugs is going to be trivial or easy.  Some of it's hard to
tease apart, e.g. the altered *.out logs seem to require some tricky
test-lib.sh and test-lib-functions.sh changes.

I don't see why wouldn't get all of that code in now though, just hidden
behind a flag, that would take the pressure off dealing with the current
regressions, [2] with 13/14 would do that. Then once those outstanding
issues are fixed we'd just need the one-line 14/14 change to flip the
default CI output.

But is it the smallest possible change on top of what's now in "next"?
No, of course not.

But I don't have those hypothetical patches, just the above. That's all
I meant in reply to the "care to send in a patch?"  upthread.
