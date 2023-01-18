Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C710CC38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjARMfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjARMey (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:34:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849B2618A9
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:57:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id tz11so18240325ejc.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O9vQd6FUxCTOcPQ/8W5WU1ppy7m2/oPV5PyqC+tNsCM=;
        b=nT2TTz001oXd9mAggP82qxko8F9saRPJYJPrEDPJmxNPQcJnSTPlALCbOHgDTxK6SN
         olRVy7a9Ux4zIYeD194kn6TnanTUj/DKVnPwBscND814NKktNdNza/oXUFfl5VM7toEQ
         OAW1HYWfDpw3lQhCbwOoPaNNbCb4hNkHfxSYvyzXmRpjuqpNXTd6kLDhJE45NGOG/fta
         X2Hzs/QL8sqDJ7aMcWwy2qazm6UK3FeFas68PcgP8spW8ajHwigkVza7weo7XqwVDlsA
         ZBqnA3QmTZ5tRbShPUOhR+Xap8NzCG+U6oLCq6M5hZ09sYRJQrmxpP3NcFYIflURIzsj
         teFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9vQd6FUxCTOcPQ/8W5WU1ppy7m2/oPV5PyqC+tNsCM=;
        b=3jY9Gp7YcSB8G6Lc7Or1LLdHWc1x82Lt/bvj5TAU9Zl+TTzoPeUtjOhnDjyz+8giKR
         oySeIPUwHan7KahkHUJk1nCTsjDKeteBcTtX5Q3rBBC3Qrk5nyhlaTeWabvqyPknyFnC
         qPdcgHJZ4ty6cqvgqGySSMCeIQqzIX3EM02mkAHD8StVsBl+AgiRKm1b1515mdPEHXja
         F8fdQXHNy0IbpfFtwFDHcIIb22E3vGjPM6aRp7rr87OkEEJheXG0VNobqwup+90qTxKL
         q26NwOsckpnScxJ0D95aaGTIsEY9qxjArOfJR+FocEZMfPe7m+3eu/BgNSfRFwydouRn
         vcUw==
X-Gm-Message-State: AFqh2kphPuwdGFyALqvsQMD91jwck8vwjtnKbQiwtKOj9G+fF1ExUSBB
        AATuzj4eWGS6qjvmaIxmUDU=
X-Google-Smtp-Source: AMrXdXu2E0l25ZtHT6VqmgsaymJp0sSDHYVsqlcG2dFVOD51ZMedlnz4PvXJeLGFLcMOcjQZnhMu1A==
X-Received: by 2002:a17:907:1a46:b0:84c:e89e:bb4c with SMTP id mf6-20020a1709071a4600b0084ce89ebb4cmr2426600ejc.49.1674043057624;
        Wed, 18 Jan 2023 03:57:37 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q14-20020a1709066b0e00b0074134543f82sm14828656ejr.90.2023.01.18.03.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 03:57:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pI74S-002p5J-22;
        Wed, 18 Jan 2023 12:57:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Diomidis Spinellis <dds@aueb.gr>
Subject: Re: [PATCH v3] grep: correctly identify utf-8 characters with
 \{b,w} in -P
Date:   Wed, 18 Jan 2023 12:49:36 +0100
References: <20230108155217.2817-1-carenas@gmail.com>
 <20230117105123.58328-1-carenas@gmail.com>
 <230117.865yd5z4ke.gmgdl@evledraar.gmail.com> <xmqqr0vt9oj9.fsf@gitster.g>
 <CAPUEspgzrW63GgbjXhKuvjpKXjEhiKaC7jtupiB-3AhcKTba8A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CAPUEspgzrW63GgbjXhKuvjpKXjEhiKaC7jtupiB-3AhcKTba8A@mail.gmail.com>
Message-ID: <230118.86tu0ovyvj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 17 2023, Carlo Arenas wrote:

> On Tue, Jan 17, 2023 at 7:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > To argue with myself here, I'm not so sure that just making this the
>> > default isn't the right move, especially as the GNU grep maintainer
>> > seems to be convinced that that's the right thing for grep(1).
>>
>> OK.
>
> I think that is definitely the right thing to do for grep, because the
> current behaviour can only be described as a bug (and a bad one at
> it), but after all the push back and performance testing, I am also
> not convinced anymore it needs to be the default for git, because the
> negatives outweigh the positives.
>
> First there is the performance hit, which is inevitable because there
> are just a lot more characters to match when UCP tables are being
> used,[...]

I'm less concerned about the performance, we should aim for correctness
first. We can always provide an opt-out (and the locale setting is
already that opt-out).

> and second there is the fact that PCRE2_UCP itself might not be
> what you want when matching code, because for example numbers are
> never going to be using digits outside what ASCII provides, and
> identifiers have a narrow set of characters as valid than what you
> would expect from all written human languages in history.

[0-9] will be ASCII, but \d will use [^0-9] Unicode numbers.

I agree it might not be expected by some, but I can't really square that
view in my mind with the desire to match "\b=C3=86var" :). After all that "=
=C3=86"
is also arbitrary byte garbage in the ASCII-view of the world.

I can see how it might be more practical in some cases to have "\b" have
Unicode semantics, but to specifically make "\d" an exception. But the
ship has sailed on that in Perl & PCRE land years (or more than a decade
ago). I think us coming up with some exception to that would probably
suck more than going with their behavior.

> Lastly, even with PCRE2_UCP enabled, our current logic for word
> matches is still broken, because the current code still uses a
> definition of word that was done outside what the regex engines
> provide and that roughly matches what you would expect of identifiers
> from C in the ASCII times.

Yes, FWIW I have some WIP patches somewhere to get rid of that bit of
grep.c if we're using PCRE. I.e. the "-w" should be powered by just
adding "\b" to the start/end of the provided string.

That'll then be correct, and faster.

I can't remember if there were some subtle bugs in that, or why I didn't
finish that...

>> > Of course all of this is predicated on us wanting to leave this as an
>> > opt-in, which I'm not so sure about. If it's opt-out we'll avoid this
>> > entire question,
>>
>> Making it opt-out would also require a similar knob to turn the
>> "flag" off, be it a configuration variable or a command line option,
>> wouldn't it?  I tend to agree with you that it makes sense to make
>> it a goal to take us closer to "grep -P" from GNU---do they have
>> such an opt-out knob?  If not, let's make it simple by turning it
>> always on, which would be the simplest ;-)
>
> GNU grep -P has no knob and would likely never have one.

I think the general knob in not just GNU grep but GNU utils and the
wider *nix landscape is "tweak your LC_ALL and/or other locale
varibales".

Which works for it, and will work for us once we're using PCRE2_UCP too.

> So for now, I think we should acknowledge the bug, provide an option
> for people that might need the fix, and fix all other problems we
> have, which will include changes in PCRE2 as well to better fit our
> use case.

Hrm, what are those PCRE2 changes? The one I saw so far (or was it a
proposal) was to just make its "grep" utility use the PCRE2_UCP like GNU
grep is now doing in its unreleased version in its git repo...
