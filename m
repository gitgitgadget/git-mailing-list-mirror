Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAEBC433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 13:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiK3NQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 08:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiK3NQH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 08:16:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629005F865
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 05:16:06 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a19so5079361ljk.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 05:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GsLQAA5H+/tMx404viDqdLYjaNPG/cyyIdf7xaIJRN4=;
        b=kih+5/3Fq2nyO9OjR8zfRZZDLIpkhWgLTs9HysA+G6IA5vf9Zzd0stJqQUl7dLQ0yH
         npx2iZW/0MCgswKidCmVpEOMbywhvFyqg7mH6cxXUdQXpnRHb2gO1cdBIB+KvGHU//6+
         e4HmsB8HReqwl8/olz3dIHo0VnVWddk9bWaiba2Ga7r9v8yN9lnuCglCKqJL1bfdUt9e
         cYnSkVHDHuFj0Mxw30Zxu7KxOudphQuC7ARvmfKoxaM0RnzxgyxtBTtElEjGWRQApyyY
         JvLng1taNH0xBYIcjUWZ2qxMXUcH4/QaZt/8N5Hj0zXAlEANwYEFT/Y0Hni6KBSqnZhW
         iP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsLQAA5H+/tMx404viDqdLYjaNPG/cyyIdf7xaIJRN4=;
        b=tjCjDA0YOvRJvZeWmDlq5F4mpJf43Thr+c224sGRwHz3SXcga0MBmLkb7EgZDXEDl5
         E+NcvGI0qfSoeZmdV1avzGo8SKpGRO0MnlrVh+uwdJ9yZ2LcYA9LtFmkoeyaTBsKssHo
         wy1FjK3uPDz38yTGqxftnVe0N4OrsUnku3Ss8EYMiSo1JS3fRg2Q2Cpz4m5lkI6l2c86
         geJMhrY1waliAkBF9IAFGB1w/hxOO8qVZf/llu3mGge/ikqYIRVY/hUG3RTaTcM+2uI1
         xFDZOcRYkrFTy/Id+aU20VMg0PsGv0vQxgg3AZC5y04sF2ipYatPk43ZCIJDmMYTmD6w
         Va0w==
X-Gm-Message-State: ANoB5pkGfWDbzqSo1koxK0Exg8NnKUjOANlpsvZbQ6MhMO3r56vVIt08
        39Tlm/Nf6t+FfHLR5fme/UGW0b1+k/Q=
X-Google-Smtp-Source: AA0mqf6mAJQ/rqls8QCyiuybaX4BRQhm4sKtc+H0APEe8B13Dr43UvgopXFgfnwnbRMc1oBBvmQDKA==
X-Received: by 2002:a05:651c:894:b0:277:3e1:297c with SMTP id d20-20020a05651c089400b0027703e1297cmr15166740ljq.109.1669814164232;
        Wed, 30 Nov 2022 05:16:04 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u4-20020a056512040400b00492f1b2ac0bsm256112lfk.101.2022.11.30.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:16:03 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] diff-merges: more features
References: <20221127093721.31012-1-sorganov@gmail.com>
        <CABPp-BHaPpQdO-uBT6ENHAM1Y-c=SBxktH-S_BTtxJvfd1qSpw@mail.gmail.com>
Date:   Wed, 30 Nov 2022 16:16:02 +0300
In-Reply-To: <CABPp-BHaPpQdO-uBT6ENHAM1Y-c=SBxktH-S_BTtxJvfd1qSpw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 28 Nov 2022 20:50:45 -0800")
Message-ID: <87lenstwfh.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sun, Nov 27, 2022 at 1:37 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> 1. --diff-merges=[no]-hide
>
> This seems problematic to me.  Currently, all the options to
> diff-merges are exclusive of each other; the user is picking one of
> them to determine how to format diffs for merges.  Now you are
> introducing the ability to combine various options, leading users to
> think that perhaps they can run with all three of
> `--diff-merges=combined-dense --diff-merges=remerge
> --diff-merges=separate` or other nonsensical combinations.  Shouldn't
> this [no-]hide stuff be a separate flag rather than reusing
> --diff-merges?

Yes, it's a precedent indeed, but I don't see any actual problem here.
Unlike git silently dropping changes on rebase, this can cause no
damage. I think I can emphasize that we now have "formats" and "flags"
in the documentation, where "formats" are mutually exclusive (the latest
specified wins), while "flags" are cumulative.

>
>> The set of diff-merges options happened to be incomplete, and failed
>> to implement exact semantics of -m option that hides output of diffs
>> for merge commits unless -p option is active as well.
>>
>> The new "hide" option fixes this issue, so that now
>>
>>   --diff-merges=on --diff-merges=hide
>>
>> combo is the exact synonym for -m.
>
> Why is completeness important here?  Perhaps I should state this
> another way: when would users ever want to use this new "hide" option?
>  I got through your cover letter not knowing the answer to this, but
> was hoping it'd at least be covered in one of your commit messages or
> documentation changes.  Maybe it was there, but I somehow missed it.
>
> Is the only goal some sense of developer completeness for these
> options, or are these end-user-facing options of utility to actual end
> users?  I'm hoping the latter, but if so, can that be documented and
> explained somewhere?  I'm pretty sure this is explained somewhere in
> an old mailing list discussion, but where?

Completeness is essential as I want '--diff-merges' to provide all the
needed capabilities, and one of them was actually missing, that is there
in the '-m' semantics, exactly as I said in the descriptions.

>
>> The log.diffMerges configuration also accepts "hide" and "no-hide"
>> values, and governs the default value for the hide bit. The
>> configuration behaves as if "--diff-merges=[no-]hide" is inserted
>> first in the command-line.
>>
>> 2. log.diffMerges-m-imply-p
>>
>> Historically, '-m' doesn't imply '-p' whereas similar '-c' and '--cc'
>> options do. Simply fixing this inconsistency by unconditional
>> modification of '-m' semantics appeared to be a bad idea, as it broke
>> some legacy scripts/aliases. This patch rather provides configuration
>> variable to tweak '-m' behavior accordingly.
>
>> 3. log.diffMergesForce
>>
>> Force specific log format for -c, --cc, and --remerge-diff options
>> instead of their respective formats. The override is useful when some
>> external tool hard-codes diff for merges format option.
>
> Why just these three options and not -m (or --diff-merges=separate)?

As I said in my answer to your other mail, '-m' is already configurable,
so it is not needed to be included.

None of --diff-merges= options are affected by diffMergesForce, only 3
specific options from the documentation.

>
> Also, I read this and didn't quite fully grasp the intent; your
> explanation in response to Junio seemed much more enlightening.
> Perhaps the wording/explanation could be cleaned up a bit?  I'll
> comment more on that specific patch...

Yeah, thanks, I got your suggestion you put in another mail.

>
>> 4. Support list of values for --diff-merges
>>
>> This allows for shorter --diff-merges=on,hide forms.
>
> And thus making users think they can pass
> --diff-merges=combined-dense,remerge,separate and suspecting that
> it'll do something useful?  Seems like this is reinforcing a mistake
> to me.

Yes, they can. For now it's useful only for 'hide', but we might add
more flags in the future. It's also harmless, so I don't see it as a
serious issue.

Thanks,
-- Sergey Organov

