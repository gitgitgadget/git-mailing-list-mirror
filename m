Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7915C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 16:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiBCQYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiBCQYE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 11:24:04 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1F3C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 08:24:04 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so10414997eje.10
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 08:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7KnnBJOJ6vX1vVyRAMOjPXVVG31+j3ABLxGEziY08D4=;
        b=TYjEe28HaKoAVvJKoKQAUc3Vq1aUAJy6serQPpifasU2f7iMmaKPi56oezKwlhqoS/
         zqOqSSD6f0X1IqgHCl0urPggBHsYRgUE1nogKyLUPmL/8j7KVYW3Y7s76GNXoW7xLVTL
         Doe1UpgH0/+gAMxhOHguIcBZE5nekcVVyG8NGjBv+7J+7NDusy9YzV9rPgGzldNaN2Z0
         CDZiuk4uoCBJdSIaACw2G+QASkPccMUkcS3G2QXyAAdzAgHnzEISnttQEbYbyiXNBfGu
         KEcmstAM+e4Gi+mIB7iUmpyLBKMcl49uSOyHIus+6/koksQmdFQC4pvphDAz0OOAq7Zo
         E4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7KnnBJOJ6vX1vVyRAMOjPXVVG31+j3ABLxGEziY08D4=;
        b=oeRCmpzZ7oQ6c3R+yjOVyf4Da7WZotPBiX6uOL29ckvmsBi8sk6SZ/oXq8bpnkaNOr
         2b9z/+4xS73GMbiPnycCM8wt2Wsbo47EO6oXvfCIgTr5qp5JJyHAPTBi7jzyqlWoQ5D5
         Dw1jzDCvd8GyXDkR8pJOQmKdNJ5FpeysnSEMHCH2gpA48aa/P+hHJCfisAXizWrUxdrC
         i0yc+YrqkT5vBA8ovMlb4A07nEjA6Afe2zqn0VKZlJYIEzektr+EP/TOj6ESO98urNpo
         U4wYcEY35VUD95FXOPJFkMlB5MEwbYFMf1rRr4fibRw66FWomad3+pCS8pgJHq9x9kvi
         d7uQ==
X-Gm-Message-State: AOAM533OGK7DqTCe1h1fPzPiKrG0A1sSr15RZWq1DITNuKkW6oy37MAM
        8LfYojKyItBM8OJ5GrCzCD3M2S2K929sbg==
X-Google-Smtp-Source: ABdhPJySLGKgCuNs3Wx9fkZGnAQGL9TQbS6TVm3DiSChH1ByxMgdtVPpahC1DzN50rbHvcf+Ma0I1Q==
X-Received: by 2002:a17:907:6ea7:: with SMTP id sh39mr29578800ejc.380.1643905442099;
        Thu, 03 Feb 2022 08:24:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f4sm17018328ejh.93.2022.02.03.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:24:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFets-0054hD-Qn;
        Thu, 03 Feb 2022 17:24:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 08/15] merge-ort: allow update messages to be written
 to different file stream
Date:   Thu, 03 Feb 2022 17:19:15 +0100
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <04c3bdc44d2c76ffc82a95db3ca4fd07270f94cf.1643787281.git.gitgitgadget@gmail.com>
 <220203.86ee4k7lo8.gmgdl@evledraar.gmail.com>
 <CABPp-BHye_Zyw=x8B+QoSxWA1b0xyVL9==7kA4CD0q3eTrk8cQ@mail.gmail.com>
 <220203.86o83o5jr2.gmgdl@evledraar.gmail.com>
 <CABPp-BEKuXHELVx4=5JJTj5HVOKZ=Y-4G4BK47BCZYYRSrkFsQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BEKuXHELVx4=5JJTj5HVOKZ=Y-4G4BK47BCZYYRSrkFsQ@mail.gmail.com>
Message-ID: <220203.86fsoz6hr3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Elijah Newren wrote:

> On Thu, Feb 3, 2022 at 2:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> On Thu, Feb 03 2022, Elijah Newren wrote:
>>
>> > On Wed, Feb 2, 2022 at 6:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
> [...]
>> >> I would get it if the point was to actually use the full usage.c
>> >> machinery, but we're just either calling warning(), or printing a
>> >> formatted string to a file FILE *. There's no need to go through usag=
e.c
>> >> for that, and adding an API to it that behaves like this new
>> >> warning_fp() is really confusing.
>> >
>> > Because the formatted string being printed to the file won't have the
>> > same "warning: " prefix that is normally added to stuff in usage?
>>
>> But the pre-image doesn't add that either. We're just calling
>> vfprintf(), not our own vreportf().
>
> Right, I'm saying that I thought you were reporting the original patch
> as buggy because it doesn't produce the same message when given a
> different stream; it'll omit the "warning: " prefix.  And I was
> agreeing that it was buggy for those reasons.
>
> Or was there a different reason you didn't like that function being in us=
age.c?

Maybe it was accidentally a bug report :) But no, I was just observing
that it was odd that it was in usage.c when it seemingly had almost
nothing to do with what that API accomplishes.

But maybe the underlying issue is that the "warning: " part is missing
here. But I didn't mean to report that/missed it.

>> > That's a fair point; that does have a bit of a consistency problem.
>> > And I'd rather the messages were consistent regardless of where they
>> > are printed.
>>
>> I think that makes sense, that's why I added die_message() recently. If
>> you meant to print a "warning: " prefix I think it would also be fine in
>> this case to just do it inline. See prior art at:
>>
>>     git grep '"(fatal|error|warning):' -- '*.c'
>
> So, making diff_warn_rename_limit() stop using warning(), and just
> always directly writing out and including "warning:" in its message?
>
> I'm wondering if that might cause problems if there are any existing
> callers of diff_warn_rename_limit() that might also be using
> set_warn_routine() (e.g. perhaps apply.c?).  Of course, those callers
> probably couldn't handle anything other than the default stream.
> Hmm...

Using set_warn_routine() is the "right" way to do it currently, and with
or without a "warning: " prefix the current API use is "wrong" if the
purpose is to have it behave nicely with the pluggable usage.c API.

But of course that may not be the goal at all, i.e. I think here we've
probably stopped caring about usage.c's formatting, logging
etc. entirely, and are just emitting a string.

Just like serve.c emits "E <msg>" or whatever (and not with error()).

>> >> diff --git a/diff.c b/diff.c
>> >> index 28368110147..4cf67e93dea 100644
>> >> --- a/diff.c
>> >> +++ b/diff.c
>> >> @@ -6377,14 +6377,21 @@ static const char rename_limit_advice[] =3D
>> >>  N_("you may want to set your %s variable to at least "
>> >>     "%d and retry the command.");
>> >>
>> >> +#define warning_fp(out, fmt, ...) do { \
>> >> +       if (out =3D=3D stderr) \
>> >> +               warning(fmt, __VA_ARGS__); \
>> >> +       else \
>> >> +               fprintf(out, fmt, __VA_ARGS__); \
>> >> +} while (0)
>> >> +
>> >>  void diff_warn_rename_limit(const char *varname, int needed, int deg=
raded_cc,
>> >>                             FILE *out)
>> >>  {
>> >>         fflush(stdout);
>> >>         if (degraded_cc)
>> >> -               warning_fp(out, _(degrade_cc_to_c_warning));
>> >> +               warning_fp(out, _(degrade_cc_to_c_warning), NULL);
>> >>         else if (needed)
>> >> -               warning_fp(out, _(rename_limit_warning));
>> >> +               warning_fp(out, _(rename_limit_warning), NULL);
>> >
>> > Why do the only callers have a NULL parameter here?  Is this one of
>> > those va_list/va_args things I never bothered to properly learn?
>>
>> That's wrong (I blame tiredness last night),an actual working version is
>> produced below. Clang accepted my broken code, but gcc rightly yells
>> about it:
>
> Well, seeing the new code makes me feel better as it makes more sense
> to me now.  ;-)
>
>> Note that both your pre-image, my macro version and Johannes's
>> linked-to-above are technically buggy in that they treat a
>> non-formatting format as a formatting format. I.e. we should use
>> warning("%s", msg) in that case, not warning(msg).
>>
>> See 927dc330705 (advice.h: add missing __attribute__((format)) & fix
>> usage, 2021-07-13) for a similar bug/fix.
>
> Good point.
>
> Man, what a can of worms this all is.  Maybe I really should just drop
> patches 5, 6, and 8 for now...

Yeah, I really think it's worth it to just sprinkle a tiny bit of
if/else (or a macro) here and print to stderr inline or not. We can make
some use of some usage.c when there's good reason to do so, but this bit
just seems like a needless digression.

I hope all of this has helped somewhat ...
