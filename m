Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AF0FA373E
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 19:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiJYTRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiJYTQs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 15:16:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B49EF5B2
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 12:16:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n12so9876352eja.11
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 12:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eLUJ3xkUY3VfqSbDP0K1K0Dyc26x7Z/KKctYsjnz9DI=;
        b=LDG6Ns7S828YG3Zp3OAxKefiun354YiXmqcFx+UB/sXwYc1FCv4/3dgYZ7OpivnGYT
         A5AfFcxlSxPItdzT+smhlkXFRH73vcIa8HaNv8Au7ejdlira18sN97QFB7NWDLPjxGkA
         mB+FWKeKMrwCoMOrHkLQIvae5SFFwMxqUdnBhDsYVn8Gxb/UD56AP28TNhNo2OnfZCAg
         /pPyHrIO6PSgGvgzaU0YMvaKO5nEpyUwdsWA+N5dBZYKfrI0WwUKSmIc1PcDZpJISnQm
         kqkNO4gteFElZok/tTZ5N4yWjT7RD0EqtKvop/8iYLPPzms+rDDm57lSY5iTuwXmxCC/
         k7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLUJ3xkUY3VfqSbDP0K1K0Dyc26x7Z/KKctYsjnz9DI=;
        b=Mi/b4ucIqwuE638wqgH69ABpwWEN7MQ98+QR7GjcyT1EM+usImbXCFxXsH44hb6YWF
         faaf063zN/c8q6z2F7mksuD09wvbRMazQN+RymkRsDLV2vA5jh5Ij22FX6EKZVKpd0Z0
         /NI4k1A4dNkB0c0RedRNcPtAXxNYQBFDmpLAbAvzhZ+Ss33YzqrqVSs2c6m0LW3s3Gpl
         5Hk0KsGEwP5BxRIhruw8g+S4oilC5gXPiKTbOikhbadh5qpuFSFNyxhF2hlgRHDeqf84
         H0VFBfxp5UsEBpqkSonMtCrU5O399u3lngqqNOgE8SEb50q0caO9xjrPwXydvHSArGDE
         6tRw==
X-Gm-Message-State: ACrzQf3cCOqWKZCWY9kdpp7/vSCypHyZQp0MPI/F9e/KhH8PhcT2guI1
        AX62FAzWUJiIbPpxnj675BI2vY22eWs=
X-Google-Smtp-Source: AMsMyM5ZHM8E3Hrga3WxmjtGHE4COY4mOHXZKyuHg/VuOaAwd/k1gU/nJULQQD6UHI1jU137iEO5rA==
X-Received: by 2002:a17:906:8a48:b0:7a5:a8f5:b870 with SMTP id gx8-20020a1709068a4800b007a5a8f5b870mr12483266ejc.458.1666725361152;
        Tue, 25 Oct 2022 12:16:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 14-20020a508e4e000000b00459012e5145sm2130009edx.70.2022.10.25.12.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:16:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onPP5-008AL5-2J;
        Tue, 25 Oct 2022 21:15:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Parallelism defaults and config options
Date:   Tue, 25 Oct 2022 20:47:45 +0200
References: <CAFySSZAbsPuyPVX0+DQzArny2CEWs+GpQqJ3AOxUB_ffo8B3SQ@mail.gmail.com>
 <221025.86sfjccjay.gmgdl@evledraar.gmail.com>
 <CAFySSZBnuszT0iYdFThRzktBuMaCTfGCTz5nbhK6sbrt=QL+5w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAFySSZBnuszT0iYdFThRzktBuMaCTfGCTz5nbhK6sbrt=QL+5w@mail.gmail.com>
Message-ID: <221025.86k04nd89c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 25 2022, Calvin Wan wrote:
>> > The safe option is to default to 1 process for many of these config
>> > options, but we trade off in improving the experience for the average
>> > user that is unaware of these options. If we're already defaulting to
>> > online_cpus() for grep.threads and selecting 5 for http.maxRequests,
>> > then why not do the same for other options? My suggestion would be
>> > defaulting IO dominant operations to min(4, online_cpus()) since that
>> > seems like the standard number of lanes for people using SSDs. I would
>> > also default operations that have a mix of both to
>> > min(8, online_cpus()).
>>
>> I haven't thought/tested what the defaults *should* be, but I think it's
>> a fair assumption that the current defaults were probably picked on the
>> basis of a few ad-hoc tests on some person's laptop :)
>>
>> I.e. the 48 core case you mention etc. is likely to be untested & wasn't
>> thought of at the time.
>
> Even with 8 threads, git grep runs very slightly slower than with 1 thread
> for me. Unless we have something along the lines of "git setup-parallelis=
m",
> any default we pick will have different outcomes for different users, but=
 I
> think we can at least make a better guess than what we currently have.

For me e.g.:

	hyperfine -L f E,P -L n 0,1,2,3,4,5,6,7,8,9,10 'git -P -c grep.threads=3D{=
n} grep -{f} a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'

Gets this in git.git, this is on a 8 core box:
=09
	Summary
	  'git -P -c grep.threads=3D4 grep -P a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa' ran
	    1.01 =C2=B1 0.11 times faster than 'git -P -c grep.threads=3D3 grep -P=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.03 =C2=B1 0.16 times faster than 'git -P -c grep.threads=3D5 grep -P=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.14 =C2=B1 0.14 times faster than 'git -P -c grep.threads=3D6 grep -P=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.22 =C2=B1 0.12 times faster than 'git -P -c grep.threads=3D7 grep -P=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.29 =C2=B1 0.13 times faster than 'git -P -c grep.threads=3D0 grep -P=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.29 =C2=B1 0.13 times faster than 'git -P -c grep.threads=3D8 grep -P=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.31 =C2=B1 0.13 times faster than 'git -P -c grep.threads=3D2 grep -P=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.33 =C2=B1 0.13 times faster than 'git -P -c grep.threads=3D9 grep -P=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.40 =C2=B1 0.15 times faster than 'git -P -c grep.threads=3D10 grep -=
P a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.49 =C2=B1 0.15 times faster than 'git -P -c grep.threads=3D6 grep -E=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.50 =C2=B1 0.15 times faster than 'git -P -c grep.threads=3D7 grep -E=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.57 =C2=B1 0.16 times faster than 'git -P -c grep.threads=3D0 grep -E=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.59 =C2=B1 0.17 times faster than 'git -P -c grep.threads=3D8 grep -E=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.59 =C2=B1 0.19 times faster than 'git -P -c grep.threads=3D5 grep -E=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.64 =C2=B1 0.17 times faster than 'git -P -c grep.threads=3D9 grep -E=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.66 =C2=B1 0.20 times faster than 'git -P -c grep.threads=3D4 grep -E=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.73 =C2=B1 0.18 times faster than 'git -P -c grep.threads=3D10 grep -=
E a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    1.94 =C2=B1 0.28 times faster than 'git -P -c grep.threads=3D3 grep -E=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    2.15 =C2=B1 0.21 times faster than 'git -P -c grep.threads=3D1 grep -P=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    2.59 =C2=B1 0.25 times faster than 'git -P -c grep.threads=3D2 grep -E=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'
	    4.70 =C2=B1 0.46 times faster than 'git -P -c grep.threads=3D1 grep -E=
 a?a?a?a?a?a?a?a?a?a?aaaaaaaaaa'

YMMV.

I think there's been some past discussion about having a probing command
figure this out for you, longer term that would be neat.

>> I think *structurally* the best approach is something like having a
>> family of config variables like:
>>
>>         core.jobs: [(false | 1)|(0 | true) | [2..Inf] ]
>>         core.jobs.IOBound: [(false | 1)|(0 | true) | [2..Inf]]
>>         core.jobs.CPUBound: [(false | 1)|(0 | true) | [2..Inf]]
>>
>> Note that it's "0 or true" and "1 or false", not a mistake, i.e. that
>> matches our current defaults. You'd set it to "true" to get the "yes, I
>> want it parallel" setting.
>>
>> We'd have these take priority from each other, so "grep.threads" would
>> override "core.jobs.IOBound", which in turn would override "core.jobs".
>>
>> The common case would be that you wouldn't set either "core.jobs" or
>> "grep.threads", so we'd default to "core.jobs.IOBound", which we'd set
>> to some sensible default.
>
> While I like this concept very much, my worry is that some commands
> might not fall nicely into IOBound or CPUBound. If they're a mix of the t=
wo
> or bound by possibly something else (like network for fetch.parallel? not
> sure about this one haven't looked too into it), then what bucket would we
> put them under?

Just have them use the top-level config if there's no "intermediate".

Or maybe everything should go straight to the top-level default.

Or maybe there shouldn't be a "top-level" at all, and nobody wants to
configure these N at at time, I don't know.

I was just trying to offer you a way out of the problem of wanting
different defaults for certain variables, we could "hardcode" them
across the different variables, or if we find commonalities we could
have them fall back to another parent config variable.
