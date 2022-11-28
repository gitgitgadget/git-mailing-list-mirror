Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6965C4167D
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiK1Omb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiK1OmX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:42:23 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23411F637
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:42:21 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id n1so8702820ljg.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzbUGG8GLJAOT9O7wO1SUYH8yVctrcP9I1hbtDcSET4=;
        b=dX4oY0GgfO92X9unnGiP436YCKfHN2nmDvSqenHKJJrOgndy587np0r2STjOAiyCV3
         Ibh4Wv93t6wJldz/GsbnNlmGq5ZYFDtG98hrjf/RByMHPu2od9VFXjsvh360rsb44mQm
         lGMRO6S7Nqjeu6Ea9AwuHzWp1emCSmeqc8B7B5BufhLgAwzcpFtCRTFmDNwZsT4Key5y
         L1yUktNx2uLadLUmBc6bc02/ykR1sPd7x8ufrUpmUzwzI5NJZx0Cjsv132xmo8Kke8K1
         HBJ2gx7l9dvFO8h5T78k8/kqZodYkTGkRkqZSbpfiCgrUIvvY7ze27jR7trivw/tdY1e
         xHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzbUGG8GLJAOT9O7wO1SUYH8yVctrcP9I1hbtDcSET4=;
        b=6gXbSI9gwHoK5GtZ7vf7qcboH1DItz/8VogNfTINnpY66lqAT8/4YAkSR1G8KTNuj0
         lp9PZD9Lpy0U2qZpOkF9xrxagyKrLFN6yxhB0CeC6qrzFtVLYlPRUGfLL9DoLgk93P8W
         BTIjfQKPecVBlc2zRYgifxVN08ruVileDgGmuV0R0FBEhhTSHQQYD4C7Z3oZrPiw3xoT
         ZqlvMXS2RIvC8CZbRIzaUiGYZWrpcmpH/7Y5sWyrmoLq/9eyU/+xdPzbNVcyBkN/OBB0
         Rtg6EuD+QeuvWsYNlX5XW1437jwTcG1NVlC2R1EJwJvQivzuLVmi1qXrB/t68/iQGaJA
         tpzw==
X-Gm-Message-State: ANoB5plrgUezwYvgsLAfXiGHtAuG7TbWwuqX+BqJfttO+PdymrM7+inz
        kHamzyMK9JXUAEKoa40yfoRe3wg6Iog=
X-Google-Smtp-Source: AA0mqf6RdfVra7C3ovnp5FgKVL1tYxWG0v3CS7VVin49johM9s9DtWVSeyrL4aJ6RuY/aQqOqSQWFg==
X-Received: by 2002:a05:651c:2c6:b0:279:7617:cfb2 with SMTP id f6-20020a05651c02c600b002797617cfb2mr8649459ljo.423.1669646539850;
        Mon, 28 Nov 2022 06:42:19 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s14-20020a056512202e00b004b501497b6fsm1385542lfs.148.2022.11.28.06.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 06:42:19 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] diff-merges: more features
References: <20221127093721.31012-1-sorganov@gmail.com>
        <xmqqfse37c0n.fsf@gitster.g>
Date:   Mon, 28 Nov 2022 17:42:17 +0300
In-Reply-To: <xmqqfse37c0n.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        28 Nov 2022 16:51:04 +0900")
Message-ID: <877czfgmye.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> 2. log.diffMerges-m-imply-p
>>
>> Historically, '-m' doesn't imply '-p' whereas similar '-c' and '--cc'
>> options do. Simply fixing this inconsistency by unconditional
>> modification of '-m' semantics appeared to be a bad idea, as it broke
>> some legacy scripts/aliases. This patch rather provides configuration
>> variable to tweak '-m' behavior accordingly.
>
> I do not know how this can be a good idea.  For those users who set
> the configuration variables, those scripts and aliases get broken
> anyway, don't they?  IOW, I am not sure how this is better than the
> "modification of '-m'" that is "a bad idea".

The history behind this is that before the patch #1 of these series
there was no way to get exact semantics of current '-m' option using new
--diff-merges option, so there was no sensible way to "fix" these
scripts/aliases. That was in fact the primary objection for the new '-m'
semantics.

Now, when one stomps on such script/alias (by explicitly enabling the
new configuration option), they can fix it by replacing '-m' with
'--diff-merges=on,hide', that, along with the last patch of these series
that produces warning when lone '-m' is detected, looks to me as a way
to eventually get rid of the legacy and surprising '-m' semantics.

> I would understand why it may be a safer and more sensible solution,
> if the proposed approach were to find an unused letter $X and to
> introduce "-$X" that is the same as "-m" but implies "-p", though.

I've in fact considered this as well, and '-d' was free for such use
last time I've checked. It was very tempting to just add '-d' that
always shows diff to first parent for everything, be it merge or not,
and call it a day, but it won't fix '-m', which inconsistent behavior
still surprises people, and besides started the whole --diff-merges
business in the first place.

>
>> 3. log.diffMergesForce
>>
>> Force specific log format for -c, --cc, and --remerge-diff options
>> instead of their respective formats. The override is useful when some
>> external tool hard-codes diff for merges format option.
>
> Not convinced it is a good idea for the same reason as above (not
> convinced it is a bad idea, either, though).

Here the intention was entirely different though. I'm using magit and it
does hard-code --cc in one place that I'd like to be able to override.
If I got this problem, I figured chances are high somebody else will get
it as well, and that's the rationale.

Then I figure everybody here has own favorite format for merge commits,
and this toy gives you exactly this: whatever option is used (once), you
get what you prefer instead, or use an option second time to enforce it.

For stable scripting, we for rather long time now have --diff-merges=c,
and --diff-merges=cc, as well as slightly more recent
--diff-merges=remerge, that are not affected by the configuration in
question.

That said, it looks useful to me, but I won't insist on the feature
should you guys object.

>
>> 4. Support list of values for --diff-merges
>>
>> This allows for shorter --diff-merges=on,hide forms.
>
> Good, probably.

Was useless before 'hide' though, as the rest of options just override
each other entirely.

Thanks,
-- Sergey Organov
