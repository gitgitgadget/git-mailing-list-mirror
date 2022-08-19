Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231B4C00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 02:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbiHSCzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 22:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344900AbiHSCzm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 22:55:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3FCD4754
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 19:55:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j7so3694446wrh.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=G+PvpKvSwdVFhDi3KJlzSq3teqXPEhTgBxhhnh2Cyis=;
        b=PWkAwiD5AKxCAr+D+xuMOkZRDlvJmEVbCrbAFRkHabOKtC1hDTy3kAu96Lxy9i/RdF
         NsVtLK8ZTSxn69jZXKfgSu/eSLUbv4n4vToSyHP/zoUka/c9FSK1PWd9ZiTnigwfKu/0
         HJp8dvfWEjeFgjiksx4ofDrkH9MK+wbR7o3bvzWaMjCuIRogGnoJYiCjE4L9mcJitcIB
         +VSMx19fTQxu476g4igTzZ4tZXjhTVhIIOlMt9te7lTkzoQLX4fKSXfbkl9W3CldPo//
         HIeUfyWMZRYQ1+Q8pBhnpjo2iEwj7c8HgP7hwYhZ+LpLV/UyUgVBUMenDdiDdBD5pJpV
         4/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=G+PvpKvSwdVFhDi3KJlzSq3teqXPEhTgBxhhnh2Cyis=;
        b=OnYngHjsr3xVwIgZsPCsDeDJdkRLOfwc5eWSm9kKfw5jstcqRkgUyitufDRo3Cd41h
         W8juGyrWlS0C0Y8jzB4uw5FctMFwkVVGl6TcyHBOdPeBmP9XVmivumSiEP7EgC6R8ec8
         9Vo4WwwkPZRnXnwaBEKx8RYplaOS1lgWRUpxs3EiwHfuCsBl7jMGeefvs3kNJmfNtANB
         p6YF1diFzKHi1grEJaBnsVeha/lFxE8+x8R99uA1sm0c6X/dU9xi94VEvVBSFQ1mpphj
         86ZiGYwN0TGNpUnlhYd7ZPKjPn3VpmmQABI4zZilyeHjGLJ68mn1t4zNRPiVckZ6BzFD
         nvgQ==
X-Gm-Message-State: ACgBeo0FcIAGJtwHuRuVbirm8En+pTi64fOmkluxIGBKzmBS5tkWJwa4
        leVgG8l5cB4yUrzyo36UV1JFrekMBRvsuA==
X-Google-Smtp-Source: AA6agR4aU04OxwtfuzSfybX/c4+o6wcJ6dqZrnczQZ8zV9Jvf49fGVTyuphm+c+IYKy6g5/iTLecPw==
X-Received: by 2002:a05:6000:178c:b0:222:f8ec:9977 with SMTP id e12-20020a056000178c00b00222f8ec9977mr2796274wrg.509.1660877738142;
        Thu, 18 Aug 2022 19:55:38 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c384900b003a35ec4bf4fsm4110449wmr.20.2022.08.18.19.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 19:55:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oOsAa-000bYE-04;
        Fri, 19 Aug 2022 04:55:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
Date:   Fri, 19 Aug 2022 04:45:54 +0200
References: <20210317204939.17890-1-alban.gruin@gmail.com>
        <20220809185429.20098-1-alban.gruin@gmail.com>
        <20220809185429.20098-9-alban.gruin@gmail.com>
        <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
        <xmqqilmzkd7p.fsf@gitster.g>
        <qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr>
        <xmqqedxgt1zx.fsf@gitster.g>
        <848p4p89-2219-7874-ss50-2o0rp4r02902@tzk.qr>
        <CABPp-BGSFYWvA5HktLf33=w7JB95iDLDNoE0gdA3oUtb+qYoQQ@mail.gmail.com>
        <xmqq7d36vfur.fsf@gitster.g>
        <220818.868rnlaa0h.gmgdl@evledraar.gmail.com>
        <CABPp-BEvn5ovFF8DzjVW-H9rQ-UdU56uT_dk80w9p7DHokD+rQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CABPp-BEvn5ovFF8DzjVW-H9rQ-UdU56uT_dk80w9p7DHokD+rQ@mail.gmail.com>
Message-ID: <220819.865yip7xi0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 18 2022, Elijah Newren wrote:

> On Thu, Aug 18, 2022 at 7:42 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Wed, Aug 17 2022, Junio C Hamano wrote:
>>
>> > Elijah Newren <newren@gmail.com> writes:
>> >
>> >> There's also another concern you tried to address in your other email;
>> >> let me quote from that email here:
>> >>
>> >>> If you want to have an easy example of a custom merge strategy, then=
 let's
>> >>> have that easy example. `git-merge-resolve.sh` ain't that example.
>> >>>
>> >>> It would be a different matter if you had commented about
>> >>> `git-merge-ours.sh`:
>> >>> https://github.com/git/git/blob/v2.17.0/contrib/examples/git-merge-o=
urs.sh
>> >>> That _was_ a simple and easy example.
>> >>
>> >> ...and it was _utterly useless_ as an example.  It only checked that
>> >> the user hadn't modified the index since HEAD.  It doesn't demonstrate
>> >> anything about how to merge differing entries, since that merge
>> >> strategy specifically ignores changes made on the other side.  Since
>> >> merging differing entries is the whole point of writing a strategy, I
>> >> see no educational value in that particular script.
>> >>
>> >> `git-merge-resolve.sh` may be an imperfect example, but it's certainly
>> >> far superior to that.
>> >> ...
>> >> If someone makes a better example (which I agree could be done,
>> >> especially if it added lots of comments about what was required and
>> >> why), and ensures we keep useful test coverage (maybe using Junio's
>> >> c-resolve suggestion in another email), then my concerns about
>> >> reimplementing git-merge-resolve.sh in C go away.
>> >>
>> >> If that happens, then I still think it's a useless exercise to do the
>> >> reimplementation -- unless someone can provide evidence of `-s
>> >> resolve` being in use -- but it's not a harmful exercise and wouldn't
>> >> concern me.
>> >>
>> >> If the better example and mechanism to retain good test coverage
>> >> aren't provided, then I worry that reimplementing is a bunch of work
>> >> for an at best theoretical benefit, coupled with a double whammy
>> >> practical regression.
>> >
>> > Ah, you said many things I wanted to say already.  Thanks.
>>
>> I may have missed something in this thread, but wouldn't an acceptable
>> way to please everyone here be to:
>>
>>  1. Have git's behavior be that of the end of this series...
>>  2. Add a GIT_TEST_* mode where we'll optionally invoke these "built-in"
>>     merge strategies as commands, i.e. have them fall back to
>>     "try_merge_command()".
>
> In the portion of the email you quoted and responded to, most of the
> text was talking about how git-merge-resolve.sh serves an important
> educational purpose, yet you've only tried to address the testing
> issue.  I think both are important.

*Nod*, I meant (but should have said) "on the topic of the test
 coverage"...

> The easiest way to fix the
> educational shortcoming of this series is to reverse the deleting of
> git-merge-resolve.sh, and restore the building and distribution of
> git-merge-resolve from that script.  Unfortunately, that generates a
> collision between both the script and the builtin being used to build
> the same file (namely, git-merge-resolve)...

I'd think if we were shipping it as an example we could give it a
different name, or not install it as an executable, but in the "shared"
part (along with the README etc.).

Or keep it in-tree in contrib, but we did try that sort of thing before
with 49eb8d39c78 (Remove contrib/examples/*, 2018-03-25) :)

I think the best way forward is to just note in the documentation some
examples of how to write a merge driver, either by linking to an older
version of the script, or quoting it inline.

> which is yet another
> reason that the easiest solution available here is to just not rewrite
> this script in C at all.

I think there's bigger benefits to moving more things to C & built-ins,
so I'd prefer to see some version of this where what we do by default is
to call this C code (or similar), and not as a sub-process.

> There are certainly other possible solutions to the educational issue,
> and might not even be too hard, but we'd need someone to implement one
> before I'd agree we found an "acceptable way to please everyone".  :-)

*nod*

>> So something like this on top of this series (assume my SOB etc. if this
>> is acceptable). I only tested this locally, but it seems to do the right
>> thing for me:
> <snip patch>
>
> How did you test?  I'm a bit confused...unless I'm misreading
> something, it appears to me that ci/lib.sh sets SKIP_DASHED_BUILT_INS
> unconditionally which would probably cause your proposal to break.

Admittedly not very thoroughly, but I'm fairly sure it does the right
thing when it comes to this, and SKIP_DASHED_BUILT_INS doesn't enter
into it (and all my local builds use SKIP_DASHED_BUILT_INS=3DY).

The try_merge_command() invokes merge-what-ever, and does a
run_command_v_opt(args.v, RUN_GIT_CMD). At that point we'll invoke a
"git merge-what-ever", i.e. we don't need a "git-merge-what-ever" binary
to exist.

This is what we do in general when git is invoking itself, and we'd need
to go out of our way to have it not work in this case (i.e. build it as
a stand-alone program, like git-http-fetch, and not as a built-in).
