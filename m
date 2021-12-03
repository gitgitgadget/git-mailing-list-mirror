Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12055C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 20:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382971AbhLCUEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 15:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353557AbhLCUEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 15:04:09 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F3C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 12:00:45 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so15793897edd.13
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 12:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PedTdXWD9toyoJHdsYqojTiyay7JP0DL3gGGNau+jYw=;
        b=puf5RRUyjCdnNn0Xc4uEoyqKkBWAubHKe4TNauNunyUEHXn4kAhmRfof+2Y9nlPENY
         D0xu6Pj4CqGCoiL/9QkLa99ZuFsePSNDqOJOnvDC8OFy64/pRjpUkzkdbgTJ5N7SVWSL
         qVSa3euUPokLhfHztEvtjjH2H+Fdhs0y5L9HNSCcdTrjpTiP/b3iOVJOFAwAD2fxEycJ
         /mnXQcjeggny8y1qanMpmuR1064elnC1bnSqpd71qTtkMWQuWgH6DcZghsG4KA8lmUKd
         3RIAe7A/HdkhQtpbmprfCC4HjB1eLGWllVrgkdVQ5UHcr4tZRiE5lyIMKImGWsPPE6vx
         pdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PedTdXWD9toyoJHdsYqojTiyay7JP0DL3gGGNau+jYw=;
        b=kbH4isr0gtlmnDA2ztdZW2hgiUIBmFwgHWYsMr52np71g0Ap0b/1ZTx0BDYIbhiPYw
         rEhEWjznhbwQECUUhEFB83h4ZPUTNgGYoegA8sqHtD2BfFynbk6xFJf+ulA28V/FqRmN
         c0+Ip0YIOgg+5FN5KlGgjemwusLRMoTZQbeBoptSYg8+9pBA3NOzgYRB+Rt88xgQoLK2
         jjU+iIITCYQbDTiONX+pg91ldORnMUGaWM7Ur1ZiAqhWUxcA4spZ5PYzjqd1o4YddSwy
         BXHYqnUP2Ppi3sKkNpLeT7pyEe4JyB2aTm0JKQqb0R/nITIcwLoVMBcHB1gMilY8Tibt
         exSA==
X-Gm-Message-State: AOAM531LjwSoSegnpeceiqAJSud7cv9yz/8SF8ozLqY2iz4QzqDdkG41
        t1O5otGAcAubsZPgc5TGY4/ee30Bn5pfiQ==
X-Google-Smtp-Source: ABdhPJxG0/yd3IPHyO+pWWeb6OLEF2y99rjWyNDgMOWw68Gm/W4IA4JfmdZMhN+/W3ZJ5okLFzOh3Q==
X-Received: by 2002:a17:907:2d87:: with SMTP id gt7mr26180142ejc.554.1638561643766;
        Fri, 03 Dec 2021 12:00:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qb21sm2526659ejc.78.2021.12.03.12.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:00:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mtEja-000IIK-No;
        Fri, 03 Dec 2021 21:00:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>,
        Aleen via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
Date:   Fri, 03 Dec 2021 20:56:43 +0100
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
 <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
 <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
 <211203.861r2tsfej.gmgdl@evledraar.gmail.com>
 <CABPp-BGE5Ff=adH3nREMDm38DGLEmtRTcPwuJowHw-ckwpbmqQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CABPp-BGE5Ff=adH3nREMDm38DGLEmtRTcPwuJowHw-ckwpbmqQ@mail.gmail.com>
Message-ID: <211203.86wnklqx05.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Elijah Newren wrote:

> On Fri, Dec 3, 2021 at 10:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Wed, Dec 01 2021, Elijah Newren wrote:
>>
>> > On Tue, Nov 30, 2021 at 5:42 PM Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwx=
u@coremail.cn> wrote:
>> >>
>> >> > Please don't, at least not this version.  There have been newer
>> >> > submissions with three commits.
>> >> >
>> >> > I also still find the word 'die' confusing, since to me it suggests
>> >> > aborting the whole am operation, and the documentation does not dis=
pel
>> >> > that concern.  Even if you don't like 'ask' (for consistency with
>> >> > git-rebase), I think 'stop' or 'interrupt' would be much better
>> >> > options than 'die'.  If you really want it to be 'die', I think the
>> >> > behavior needs to be explained in the documentation, rather than ju=
st
>> >> > assumed that users will understand it (because I didn't understand =
it
>> >> > until I read the code).
>> >>
>> >> Dears Newren,
>> >>
>> >>     I don't think 'stop' and 'interrupt' words are better to explain =
more than 'die'
>> >>     because they still indicate that it will stop or interrupt the wh=
ole am session,
>> >>     rather than stop in the middle of it.
>> >
>> > Since you've been through several rounds of revisions already, if this
>> > is the only remaining issue with your series, I wouldn't try to hold
>> > it up for this issue; I just thought it could be fixed while you were
>> > working on the --allow-empty stuff.
>>
>> FWIW I think it's worth getting the UX issue right, tweaking it is
>> relatively easy, and if we can decide on what the thing is called
>> then...
>
> :-)
>
>> > However, while I don't think it's worth holding up your series for
>> > just this issue, I would definitely submit a follow-up RFC patch to
>> > fix the wording, because I do disagree with your assertion here pretty
>> > strongly.  Let's look at the meanings of the terms:
>> >
>> > die: connotes something pretty final and irreversible -- people tend
>> > not to revive after death as far as recorded history goes; most such
>> > recorded instances tend to be causes for people to debate the
>> > definition of 'dead'.
>> >
>> > stop: could be final, but is often used in a transitory setting: "stop
>> > and go traffic", "stopped to catch my breath",  "the train will stop
>> > at this station", "stop! I want to get out", etc.
>> >
>> > interrupt: seems to nearly always be used as a transitory thing
>> >
>> > Now, in the computer science context, all three terms come up relative
>> > to processes.  You can interrupt a process (the kernel does all the
>> > time), but it'll usually continue afterwards.  Or you can give it a
>> > SIGINT (interrupt from keyboard signal), which the process can catch
>> > and ignore.  You can stop a process (and SIGSTOP cannot be caught),
>> > but you can also continue it later.  die essentially means the process
>> > is going to be gone for good (at least short of some kind of black
>> > magic like a reversible debugger such as rr).
>> >
>> > So, I think it's much more likely that 'die' will be misunderstood to
>> > mean abortion of the entire am-process, than that 'stop' or
>> > 'interrupt' would.
>>
>> Why are we exposing an --empty=3Ddie at all? It's what we do by default,
>> so why have it? The user can just not provide the "--empty" option, then
>> they'll get the current behavior of die_user_resolve(), which seems to
>> have inpired the name for this "die" (it exits with code 128, just like
>> die()).
>
> That's an interesting angle to take; I hadn't thought of that.  It's
> worth considering.
>
> We do often introduce options equivalent to the default as a way to
> either countermand an earlier option (e.g. --do-walk overrides
> --no-walk in git log), or because we want to allow new config options
> that change the default while allowing the user to explicitly request
> something different (e.g. --no-renames was introduced at the same time
> as diff.renames), or because we may want to change the default
> behavior and want users to be able to explicitly request a certain
> type of behavior (e.g. rename detection is the default and
> --no-renames overrides).
>
> It's not clear to me whether that type of flexibility is needed or
> whether we can just leave it unnamed.  Three points that may affect
> that decision: (a) the default (and actually, hardcoded) behavior
> before this series for git-am was 'drop', (b)  the default behavior
> for git-rebase is 'drop' (though it only affects commits which become
> empty, something we can't determine in the context of am) and (c)
> there was one point during the series that the author asked about just
> removing the 'die' implementation and picking a different default.
>
> The above three points suggest to me that there might reasonably be
> config added to control this or that the default could change, and
> thus that it might be useful to name the interrupt-the-operation
> behavior so that users can explicitly request it.  But that's
> somewhere around three levels of chained "might" conditions, so...
> :shrug:
>
>> Once we get rid of "die" the rest of the UI can follow the example of
>> the existing "git rebase" options:
>>
>>     --empty=3D{drop,keep,ask}
>>
>> I.e. the "drop" and "keep" will be the same, no "ask" currently, but it
>> can be implemented in the future.
>
> Um, there are minor contextual differences, but what rebase calls
> "ask" (interrupt the operation and tell the users what commands they
> can use to keep or drop the commit and then resume the operation) _is_
> implemented by this series -- it's just being called "die" here.
>
> That's the kind of maddening inconsistency in Git that users complain
> about that I really think we should avoid adding to.  If for some
> reason 'ask' from rebase seems like a bad choice, then I think we
> should pick a new name for this interrupt-the-operation behavior that
> makes sense (unlike 'die') for git-am and add it to git-rebase as a
> preferred synonym to 'ask'.
>
>> Maybe I'm missing something, I haven't used "am" in this way (or rebase
>> with --empty=3D*), but this just seems to me to be needlessly exposing a
>> "die" (or "stop" or whatever) because it's how we implement this.
>>
>> Whereas for the UX we don't need to call it anything except the absence
>> of an --empty option, or perhaps --no-empty.
>
> `--no-empty` would semantically be read by users to mean get rid of
> empty commits, which would be a synonym of 'drop'.  I think it'd be as
> confusing as 'die' (and maybe even more so) for naming the
> interrupt-the-operation behavior.

Ah, I didn't look into the finer details. Yes if it does maps to "ask"
in rebase we could just use that, so would this be consistent?:

    --empty=3Ddie -> --empty=3Dask
    --empty=3Ddrop -> (ditto, no change)
    --empty=3Dkeep -> (ditto, no change)

I think "ask" is a bit of a weird term for this, but I think consistency
trumps a while-we're-at-it fix here.

Whatever new synonym we'd come up with (if that would be justified, that
itself would add to confusion) could be done as a follow-up and
implemented for both "rebase" and "am".
