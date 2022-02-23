Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EFCC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242370AbiBWVSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbiBWVSL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:18:11 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE140E50
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:17:43 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE4A2178E71;
        Wed, 23 Feb 2022 16:17:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sNgbdwQ6Wu7Q/AA8hHXXrHhEyPuKMO41uYow+n
        j+XK4=; b=w1WeZJ5RIb4st9J2ddToeRUHqhviB72oB7A2WXQncTqx3DWPce8LM9
        wFo99E8EpXnlS7050TwjHjUWxgXYa5v9zKFgHKc3r9mAduI0/EmFvgrPGOpU6n0q
        EJslrImIyWSVEqHLFEQCpK0ArE3CAUYK5IunNf/DE37kI0hRv5+vs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C67D4178E70;
        Wed, 23 Feb 2022 16:17:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 367DD178E6F;
        Wed, 23 Feb 2022 16:17:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Lawall <julia.lawall@inria.fr>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2] add usage-strings check and amend remaining usage
 strings
References: <pull.1147.git.1645030949730.gitgitgadget@gmail.com>
        <pull.1147.v2.git.1645545507689.gitgitgadget@gmail.com>
        <CAPig+cRq7H2bnkcU-V5uiWA9z=FLvxj3ji0bhO3DMX9HfptHtQ@mail.gmail.com>
Date:   Wed, 23 Feb 2022 13:17:39 -0800
In-Reply-To: <CAPig+cRq7H2bnkcU-V5uiWA9z=FLvxj3ji0bhO3DMX9HfptHtQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 22 Feb 2022 12:16:33 -0500")
Message-ID: <xmqqilt5th8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0833B2D2-94EE-11EC-8582-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This is a relatively minor observation, but it might make sense to
> split this into two patches, the first of which fixes the offending
> usage strings, and the second which adds the check to parse-options.c
> to prevent more offending strings from entering the project in the
> future.

Yeah, that sounds like a quite sensible split.

I notice that the real-looking name

>> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

does not match with the in-body "From:" that has less real-looking.
Please fix the in-body "From:" if this is rerolled so that both
mention the same "Human Readable Name <email@add.re.ss>".

>> ---
>> diff --git a/parse-options.c b/parse-options.c
>> @@ -492,6 +492,15 @@ static void parse_options_check(const struct option *opts)
>> +               if (opts->type != OPTION_GROUP && opts->help &&
>> +                       !(starts_with(opts->help, "HEAD") ||
>> +                         starts_with(opts->help, "GPG") ||
>> +                         starts_with(opts->help, "DEPRECATED") ||
>> +                         starts_with(opts->help, "SHA1")) &&
>> +                         (opts->help[0] >= 65 && opts->help[0] <= 90))
>> +                       err |= optbug(opts, xstrfmt("help should not start with capital letter unless needed: %s", opts->help));
>
> This list of hardcoded exceptions may become a maintenance burden. I
> can figure out why OPTION_GROUP is treated specially here, but why use
> magic numbers 65 and 90 rather than a more obvious function like
> isupper()?
>
> Perhaps instead of hardcoding an exception list and magic numbers, we
> can use a simple heuristic instead. For instance, if the first two
> characters of the help string are uppercase, then assume it is an
> acronym (i.e. "GPG") or special name (i.e. "HEAD"), thus allowed.
> Maybe something like this:
>
>     if (opts->type != OPTION_GROUP && opts->help &&
>         opts->help[0] && isupper(opts->help[0]) &&
>         !(opts->help[1] && isupper(opts->help[1])))
>

Much better than what was posted, but such a heuristic deserves some
in-code comment to check why we see the first two.

>> +               if (opts->help && !ends_with(opts->help, "...") && ends_with(opts->help, "."))
>> +                       err |= optbug(opts, xstrfmt("help should not end with a dot: %s", opts->help));
