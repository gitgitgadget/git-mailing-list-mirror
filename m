Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88F7C4332F
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 13:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiL0N7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 08:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0N7G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 08:59:06 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6652719
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 05:59:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id tz12so32071445ejc.9
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 05:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hQ6bPKhGs09JkXU30cDixd576KKpgfX/PGOgFm/HXfg=;
        b=RJwwfdzSEgonOOQrJIBQD1kB6GXrUU4cIsyPxUImegDKAOdshxZlZYJyt8uAT/XT5r
         ho5pzTzmhErl/cq/2fgAzsibSuLpqfi8tWqS07uRu+a/uSQBmOixdJdgX/e8gWh4DnA/
         8OJ9taFNehXNbzrPhAChzSDi8otE2TSMqnSyhmt7hVMByVJaz4inq57nIeJxiPsqPWZv
         hpOj9Jn73sB8sc8BFdyjOyoHZqNdzZXBR+Rc1V5cVLna/5FXYpepyZtJm/o7CQTMx3Q8
         6MzqVIws7CDqR8MKHlR9110rhFGEH60lHGmLw9w9FHpiv6ANG0/3f/VJz0Iq7z6cTKzF
         cbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQ6bPKhGs09JkXU30cDixd576KKpgfX/PGOgFm/HXfg=;
        b=J5jVQtCWBYoDNNmSu+Tg3QXkuqNjSM9CT9efS2Gc3dRWNB6p0mSFMnxoAuXwoMUapJ
         45izCxNuk08XiG6WKTpKWnZ7ScAIcSUOYdXq9HS8/ECLPDJMDBviq1PjyUD+YcEm4xOZ
         08M5Jdp39LQWo5T+yPoFByuYrTgVnNPiMQmTMLQsqVBG4NoVpmcnwOzN2w0rBRsmtgnv
         gPUf8pK9nDacEnUSpZm1JVWgCMijxyvWG/eqXFyDz9d0n/uhGlsJM1SEVMFhxggGURd+
         Hvq8URtStKkpS/YTB/bwE1o79yrLQWf9FNgdpOZg1ZQ3rFyr6C+xUWdBe1/vWpYDqvgX
         V71g==
X-Gm-Message-State: AFqh2krc2Q5BLO8eTbwMHpq/dvQHVY218nPLX9HQ8peZdAAip1LIh/xB
        2XuTZPWZ6zIPEbTFUTt2bvY=
X-Google-Smtp-Source: AMrXdXsS4c52dzQ1vDNbG5Tw/wHq/hneamH2FPMp9I/Nm5MeldqNY3y0TB3zJRgpXCmVo7oltt074Q==
X-Received: by 2002:a17:907:77da:b0:803:3f50:a7ae with SMTP id kz26-20020a17090777da00b008033f50a7aemr16443015ejc.57.1672149543536;
        Tue, 27 Dec 2022 05:59:03 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u22-20020a056402111600b0046ee136fa3bsm5890738edv.69.2022.12.27.05.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 05:59:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pAATu-009DtL-17;
        Tue, 27 Dec 2022 14:59:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH] cmake: don't invoke msgfmt with --statistics
Date:   Tue, 27 Dec 2022 14:51:17 +0100
References: <patch-1.1-0fa41115261-20221219T102205Z-avarab@gmail.com>
 <45d8d9fc-ca68-5902-0aa7-70034f8383ff@dunelm.org.uk>
 <xmqqcz8e29d5.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqcz8e29d5.fsf@gitster.g>
Message-ID: <221227.86tu1huevt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 20 2022, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> On 19/12/2022 10:26, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> In [1] I made the same change to our Makefile, let's follow-up and do
>>> the same here.
>>> For "cmake" this is particularly nice with "-G Ninja", as before
>>> we'd
>>> emit ~40 lines of overflowed progress bar output, but now it's only
>>> the one line of "ninja"'s progress bar.
>>
>> I don't really have a strong opinion either way on this but if it
>> matches what we do in the Makefile than it sounds sensible.
>
> As a one-shot change, it might be sensible to claim consistency by
> saying "we do the same thing in two places", but I'd worry more
> about the root cause of such inconsistency in the first place, i.e.
> can we have some trick to ensure that two build systems will not
> reimplement the same thing slightly differently?

We could & should, but I think doing prep changes like these first makes
sense, as eventually e.g. driving both the Makefile & CMake via some
shared resource won't have to waste time on explaining why the msgfmt
invocation is slightly different.

> It also is worth examining if having "the same change" is a good
> idea in the first place.  The justification given "In [1]" was that
> a build driven by our Makefile were concise and non-verbose overall,
> but with --stat that concise output pattern was broken.
>
> I do not know (and I do not have particular interest in knowing) how
> a build driven by cmake looks like, but does it also aim the same
> concise output where output --stat does not fit well, ...

It's the same with CMake, as e.g. the reference to "ninja" in the commit
message covers (it would also happen with the "make" backend, but that
one's a bit more verbose by default).

> [...] or do folks who daily build with cmake find the output with
> --stat sit well in the output from other things given there?  If the
> latter, making "the same change" as the Makefile side may not make
> much sense.

I think the only justification that's needed here (and which should
short-circuit any questions about what someone using cmake may or may
not like) is the one given in my 2f12b31b746 (Makefile: don't invoke
msgfmt with --statistics, 2021-12-17).

I.e. this was something I added as part of the initial i18n support, but
I had no good reason for using --statistics other than ad-hoc eyeballing
the output at the time.

The CMake recipe then just copy/pasted whatever it found in the
Makefile, and the two then drifted apart.

So, in general with those sorts of changes I think it's sufficient to
say that we're not bringing them in line again, unless there's some
reason to suppose that the cmake version has since come to rely on the
divergence for some reason.

Which, in this case is clearly not the case, as we're just spewing this
output to the user's terminal.
