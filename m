Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4454AC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 15:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiCJPcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiCJPcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 10:32:46 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1869E15A228
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 07:31:45 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bg10so12929553ejb.4
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 07:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GmQLRtgRVu/1xBBcQUVsQD2rdMqe/1C6tVt8ubFnn68=;
        b=N5vnde5dE8z4HFcPcbVZOwdenphVO9B8wBb0hCqAdO5EjmJ8hYDYlfD6O7hJA0sER6
         ZeOrcxL7fKrL8wDaox2Grb9FGfkXtrjSVa7ZP8IBm57E59ZXrhNIw0PwWl9g1mzGtsox
         7bO3N8H9duaDZx71h29D1iedADoMw3c/OBKEKPgpDIX9T8punmz7g4jUoyL4IAQlgpTw
         2OjpDunhDtLYtQhOfH00VSbd28eFUQ2ck1MYsV61VjVr9+vZjuMWGCGNYHjb1FV9eCRp
         b7u1oOaYY1x0EsQh8+1DWqo6vYz+r2YLRfmLasUWaCRmqtX1Rd0yCSbngCQS0WpJToBU
         wJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GmQLRtgRVu/1xBBcQUVsQD2rdMqe/1C6tVt8ubFnn68=;
        b=YxZdj+Dh44M4IGqXtTCPTXSm44Z/5tDMpkXbK91aZim+sOp3XabCPfp46lhjjWFP+/
         5YRR0qqWQZcjw0bYRYOXkhHgDPcQ1Ys7OHwuOIdA0PD4KvsOPWb3rW9Dgo5LyPB1sQ40
         bjjtduD7m1Y537Rydohd4ZqcUAMJGY6CX1tr1ooG3EFXplee7FhuR0O3OavXvAsnve4p
         nT0HXAdn/Ibe/TI8NwJR8O+T30Jbz4jdY7a1SiONl0R3LiEYkGqQlzrPcESElkrSAjQ5
         vD5VvVj2Zi7tSr4Bqpq6iWojACOpPLm43PrWlp3Xydbw9bWlMhyTGgtYx9vzD8p3mwcH
         GPSA==
X-Gm-Message-State: AOAM532Lc4ePETjDWJOog6vzbIUvu+0HiMnCDQW2Z29D/XH1D0h3dtjG
        duISj8o2nCeUJ+3RBVHXCp8=
X-Google-Smtp-Source: ABdhPJwGoAp3vlOVPZu5RjUIfqo4bHh9RFfMnHfN/fS6QoD7AHj/4U4r7ADl8GboYYuIGD2N8LDbSg==
X-Received: by 2002:a17:907:6d9f:b0:6db:62b6:f3d6 with SMTP id sb31-20020a1709076d9f00b006db62b6f3d6mr4903642ejc.366.1646926303348;
        Thu, 10 Mar 2022 07:31:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402105300b004162d0b4cbbsm2150103edu.93.2022.03.10.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 07:31:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSKlR-000Yja-Uu;
        Thu, 10 Mar 2022 16:31:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: win+VS environment has "cut" but not "paste"?
Date:   Thu, 10 Mar 2022 16:23:02 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
 <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
 <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
 <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
 <xmqqv8x2dd7j.fsf@gitster.g> <xmqqee3i2mlw.fsf_-_@gitster.g>
 <220304.86mti6f4ny.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2203071649100.11118@tvgsbejvaqbjf.bet>
 <xmqqmti1u20m.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2203091320140.357@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2203091320140.357@tvgsbejvaqbjf.bet>
Message-ID: <220310.86o82dj02q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Mon, 7 Mar 2022, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > I said that the current output is only useful to veterans. The output =
that
>> > hides the detailed log, under a separate job that is marked as
>> > non-failing.
>> >
>> > That's still as true as when I said it. :-)
>>
>> I think getting rid of the separate "print failures" CI step and
>> making it more discoverable how to reveal the details of failing
>> test step is a usability improvement.
>
> I'm so glad you're saying that! I was starting to doubt whether my caring
> about getting rid of that `print failures` step was maybe misguided.

I don't think anyone's been maintaining that getting rid of it wouldn't
be ideal. I for one have just been commenting on issues in the proposed
implementation.

I think we might still want to retain some such steps in the future,
i.e. if we have a failure have subsequent steps that on failure() bump
varying levels of verbosity / raw logs etc., or even try re-running the
test in different ways (e.g. narrow it down with --run).

But the failure step you see when something fails should ideally have
the failure plus the relevant error, just as we do with compile errors.

>> I am not =C3=86var, but I think what was questioned was the improvement
>> justifies multi dozens of seconds extra waiting time, which is a
>> usability dis-improvement.  I do not have a good answer to that
>> question.
>
> It is definitely worrisome that we have to pay such a price. And if there
> was a good answer how to improve that (without sacrificing the
> discoverability of the command trace corresponding to the test failure), I
> would be more than just eager to hear it.

Isn't the answer to that what I suggested in [1]; I.e. the performance
problem being that we include N number of lines of the output that
*didn't fail*, and that's what slows down showing the relevant output
that *did* fail.

I.e. if say t3070-wildmatch.sh fails in a couple of tests we'd show a
*lot* of lines between the relevant failing tests, let's just elide the
non-failing ones and show the output for the failing ones specifically.

*Sometimes* (but very rarely) it's relevant to still look at the full
output, since the failure might be due to an earlier silent failure in a
previous test (or the state it left behind), but I think that's rare
enough that the right thing to do is just to stick that in a subsequent
"verbose dump" step or whatever.

>> But new "non-veteran" users may not share that.  That is something a
>> bit worrying about the new UI.
>
> Indeed. My goal, after all, is to improve the experience of contributors,
> not to make it harder.
>
> Still, given that you currently have to click quite a few times until you
> get to where you need to be, I have my doubts that what this patch series
> does is actually making things slower, measured in terms of the total time
> from seeing a failed build to being able to diagnose the cause by
> inspecting the command trace.

Yes, but wouldn't the "Test Summary Report" in [1] be the best of both
worlds[1] (with some minor changes to adapt it to the GitHub "grouping"
output, perhaps)?

Then you'd always see the specific of the failing test at the end, if
you had N number of failures you might have a lot of output above that,
but even that we could always tweak with some smart heuristic. I.e. show
verbose "not ok" output if failures <10, if 10..100 elide some for the
raw log, if >100 just print "this is completely screwed" or whatever :)

1. https://lore.kernel.org/git/220302.86mti87cj2.gmgdl@evledraar.gmail.com/
