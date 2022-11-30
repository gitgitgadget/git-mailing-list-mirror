Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A7C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 12:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiK3M6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 07:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiK3M6f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 07:58:35 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A427DFF
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 04:58:34 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id c1so26797092lfi.7
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 04:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4AfnyvRgZziMvyatpZMd/BxZzpsxDP5GyeQc1H251M=;
        b=ICI361R84rdagw3ZLk2EMoBAM291HnGfLraDzkjXDPYnuxFj3+wav2Koi27qyoGdn/
         FvOvGEaPj9cn7lTeTRgelwsbgV8if/SSr/tJktJHofhVTvkBW1S4ZaYO1MGu/tc4673X
         yexOd4KNxslLpuE+XV4yyZjAP5zpQrBo4hKdxSLupYiivADRVFXqTTZa/p/Fs21k+LwU
         hUHSt313UV2wW7zQGWU5Is3dlCK0olhv9k8eAb4gXWYbSRIUdFiESyAGnTUEeQecvruU
         IZ0n5JKO+7gosV0ySz9UnAP1Ib+F4EyrPlYLYX1akIEOF+s9Ym9o+c4VclMuzFCB/W/k
         gM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4AfnyvRgZziMvyatpZMd/BxZzpsxDP5GyeQc1H251M=;
        b=73EkBRMwMPEOFzGVxZnQuyQCUn/0QE0nI/gdY5Xwz4OUSQjd+/FQ1YZx2H1L56wLPd
         0qAePA0gjv3k698NBU1V/Og4nO9vc33HthnVZ7/lLS3MnIGyjGPdXE7cCXz8QHZ/9ZYh
         wRpOj8aVu2cV/JdF3dNIBhH5LF9tJ/GK3m9sXHjQuwzoW2ohbzW8YyJF7p7jagBNpQXa
         ulVKLfIDUd/vG0QlNnYHYMg15wwU+Fgl+8CCcN9/ItwpPK3EaKTUvn6fTmwLt+0GX/v+
         C/DIVV5g+8HWFkIgbuk5SMd79rNseyXUxXZqkzXvWaGxdmrOOoNMU8dxNnfHqFS77tZd
         okLA==
X-Gm-Message-State: ANoB5pnbTxwTCZSusvZkkl06Rn0vdFC7+/YS6gGy7aqUG85DPQfnj+GI
        NXBFfkCpWJCG90B+F1hPMbVk+GZNYs0=
X-Google-Smtp-Source: AA0mqf5rEWcI//iR15MK6nFAbWrXEkEg/KGiQdb8U3KTqwQ2TXirVFR90kld4Vl+gEoOo+ztOGlEtA==
X-Received: by 2002:a19:675c:0:b0:4a2:5be6:c0bf with SMTP id e28-20020a19675c000000b004a25be6c0bfmr23044125lfj.390.1669813111918;
        Wed, 30 Nov 2022 04:58:31 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c24-20020a056512075800b004a01105eea2sm247075lfs.150.2022.11.30.04.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 04:58:31 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] diff-merges: implement log.diffMergesForce config
References: <20221127093721.31012-1-sorganov@gmail.com>
        <20221127093721.31012-4-sorganov@gmail.com>
        <CABPp-BFHQ8KwNK=FKGc96iQYqr9xT--WH7kg5R-CzCaAiWiRZg@mail.gmail.com>
Date:   Wed, 30 Nov 2022 15:58:30 +0300
Message-ID: <87zgc8tx8p.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sun, Nov 27, 2022 at 1:37 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Force specified log format for -c, --cc, and --remerge-diff options
>> instead of their respective formats. The override is useful when some
>> external tool hard-codes diff for merges format option.
>>
>> Using any of the above options twice or more will get back the
>> original meaning of the option no matter what configuration says.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/config/log.txt | 11 +++++++++++
>>  builtin/log.c                |  2 ++
>>  diff-merges.c                | 32 ++++++++++++++++++++++++++------
>>  diff-merges.h                |  2 ++
>>  t/t4013-diff-various.sh      | 18 ++++++++++++++++++
>>  t/t9902-completion.sh        |  3 +++
>>  6 files changed, 62 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
>> index 265a57312e58..7452c7fad638 100644
>> --- a/Documentation/config/log.txt
>> +++ b/Documentation/config/log.txt
>> @@ -43,6 +43,17 @@ log.diffMergesHide::
>>  log.diffMerges-m-imply-p::
>>         `true` enables implication of `-p` by `-m`.
>>
>> +log.diffMergesForce::
>> +       Use specified log format for -c, --cc, and --remerge-diff
>> +       options instead of their respective formats when the option
>> +       appears on the command line one time. See `--diff-merges` in
>> +       linkgit:git-log[1] for allowed values. Using 'off' or 'none'
>> +       disables the override (default).
>> ++
>> +The override is useful when external tool hard-codes one of the above
>> +options. Using any of these options two (or more) times will get back
>> +the original meaning of the options.
>
> I didn't quite understand your intent here from this explanation.
> When you pointed out to Junio that you wanted to override magit's
> hard-coded `git log --cc` and turn it into `git log -m -p`, then it
> suddenly made more sense.  And the two or more times I guess is your
> escape hatch to allow users to say "I *really* do want this other
> format, so `git log --cc --cc` will get it for me.".
>
> Maybe something like:
>
> Override -c, --cc, --remerge-diff options and use the specified
> diff-generation scheme for merges instead.  However, this config
> setting can in turn be overridden by specifying an alternate option
> multiple times (e.g. `git log --cc --cc`).  Overriding the
> diff-generation scheme for merges can be useful when an external tool
> has a hard-coded command line it calls such as `git log --cc`.  See
> `--diff-merges` in linkgit:git-log[1] for allowed values.  Using 'off'
> or 'none' disables the override (default).

Thanks for suggestion, I'll take this into consideration should we agree
to actually let this feature in.

>
> However:
>   * This feels like we're trying to workaround bugs or inflexibility
> in other tools with code in Git.  This feels like a slippery slope
> issue and/or fixing the wrong tool.

Yep, that's why I said in my another answer to Junio that I won't insist
on it if you guys object, even though it does look useful for me.

>   * Why is this just for -c, --cc, and --remerge-diff, and not for
> also overriding -m?  It seems odd that one would be left out,
> especially since tools are more likely to have hard-coded it than
> --remerge-diff, given that -m has been around for a long time and
> --remerge-diff is new.

'-m' is rather the first one that got an override support, see
'log.diffMerges'.

[As for --remerge-diff, as a side note, I'd call it something like --rd
for short, as we have --diff-merges=remerge anyway. And then I'll think
about adding --pd  (pure-diff) or --fpd (first-parent-diff) ;-)]

>
>> +
>>  log.follow::
>>         If `true`, `git log` will act as if the `--follow` option was used when
>>         a single <path> is given.  This has the same limitations as `--follow`,
> [...]
>> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>> index 1789dd6063c5..8a90d2dac360 100755
>> --- a/t/t4013-diff-various.sh
>> +++ b/t/t4013-diff-various.sh
>> @@ -557,6 +557,24 @@ test_expect_success 'git config log.diffMerges-m-imply-p has proper effect' '
>>         test_cmp expected actual
>>  '
>>
>> +test_expect_success 'git config log.diffMergesForce has proper effect' '
>> +       git log -m -p master >result &&
>> +       process_diffs result >expected &&
>> +       test_config log.diffMergesForce on &&
>
> I think the default for `on` is bad; it made sense at the time, but I
> think we have a better option now.

We probably disagree about what a better option actually is, but the
point is valid anyway.

> Perhaps we switch to it, perhaps we don't, but if there's _any_ chance
> at all we change the default for "on" (which I think there definitely
> is), then you should really use the option that matches the actual
> mode you are using rather than a synonym for it; doing so
> future-proofs this testcase.

Yep, agreed. Thanks for the catch!

>
>> +       git log --cc master >result &&
>> +       process_diffs result >actual &&
>> +       test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'git config log.diffMergesForce override by duplicate' '
>> +       git log --cc master >result &&
>> +       process_diffs result >expected &&
>> +       test_config log.diffMergesForce on &&
>
> Matters less here, but just in case "--cc" were to become the default,
> it'd be nice to explicitly use something else like separate here.

Yes, thanks!

>
>> +       git log --cc --cc master >result &&
>> +       process_diffs result >actual &&
>> +       test_cmp expected actual
>> +'

-- Sergey Organov
