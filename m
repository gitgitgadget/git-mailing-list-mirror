Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162FEC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 01:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjBBBcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 20:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBBBct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 20:32:49 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3196B99F
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 17:32:49 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e10so258817pgc.9
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 17:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3+Vm7JQVMkTwxdi1CkoyPYdJsTOgKqa4J/RD54uG78=;
        b=g48CyNfhriSMsqFYiV4F9FfQV3uOC+OY4kLTDOGaFesJP9Gn9Zx/OmWDb8AS71+EcC
         8cdPvagqTmqfrMHf0SoQnVNII4yMhKNmxNOzoJIYl+weOmw1JIH881orhaBZJdjRW3Iz
         T0rYvZCvdiSjYq2Pqk6Ec9LEC3zTzABhJHOknwhE5PT9Y5ysPERLOs0MeT7xnohUDBVY
         3+DVNcv4HzJkDrAJxsNb5c4dX4qXCCOmX3p4e0G1W4NwMZv6nBPl+K4uCn9Odvg75snE
         Gw12oupik6QA5x+YyiIxJtYlAbv1E+WZ30b63GQBLvD24+vQ162cDgXyYEK+h6PX/l+1
         e3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3+Vm7JQVMkTwxdi1CkoyPYdJsTOgKqa4J/RD54uG78=;
        b=KujNiHR/m+echFAQkOsqcDsGzDYES33c9MMCsSf6a7cFihtmorL1xfQPgKQk4I39oU
         wMDpOGM8Bci0t0G4tBkHhKv1mZIykf0722auKoQQNHKU3tmx2amCrbFzX0V9g+M2X45y
         Hu3aiC8/chpRyVxaggDzzp8x8yQ4dU2BwbZcVxG0WZMtQLE8b02zhVFe4I+NytMeIshQ
         6x28KE7CQAgQqZWtwYOVD1vYHHY1N7Xl7rBD9ztmDuJ3zhttXS32T9s0vj/UBNfeggbY
         b3L3L/tMMYRfogJxyTL71+X7rLGQDC8YROLEZP2EfX0ASgmVn3rqffqwzg5mbDxqi9f1
         faFg==
X-Gm-Message-State: AO0yUKXKg6rAQXeSk7Tt8klPDsgDnesvgJZP9irxz6WInlSXf+kjCyAC
        TuGPBpwX9m7IzfwrYVu1OM4=
X-Google-Smtp-Source: AK7set+TbCZsE05Y5tSRL/3KrcS/AJipRsx/8N2Rr0pwuOrSQ3gX6xYc2v/cMC2CVFsHOBBXo0biJw==
X-Received: by 2002:a62:1593:0:b0:593:cda6:f402 with SMTP id 141-20020a621593000000b00593cda6f402mr4285254pfv.17.1675301568411;
        Wed, 01 Feb 2023 17:32:48 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id q9-20020aa79609000000b00592626fe48csm10794053pfg.122.2023.02.01.17.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:32:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] imap-send: replace auto-probe libcurl with hard dependency
References: <20230201113133.10195-2-worldhello.net@gmail.com>
        <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <xmqqlelhx973.fsf@gitster.g>
        <230202.86zg9xormj.gmgdl@evledraar.gmail.com>
Date:   Wed, 01 Feb 2023 17:32:47 -0800
In-Reply-To: <230202.86zg9xormj.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 02 Feb 2023 00:56:24 +0100")
Message-ID: <xmqqpmasx35s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> The equivalent of USE_CURL_FOR_IMAP_SEND is now always true, and that's
> what "--curl" would enable.
>
> The "--no-curl" option would then have us use the OpenSSL codepath, but
> that'll no longer be supported, we'll always use curl.
> ...
>> Or did you just forget to document that we stop to ship with our own
>> IMAP routines in the above?  If so, as long as it is made a bit more
>> prominent in the proposed log message in a reroll, I would be happy
>> with such a change rolled into the same patch.
>
> I'm not sure what you mean here, we still ship with the same routines,
> we just always take the "curl" codepath for the non-tunnel codepath now.

I am referring to this part of the documentation:

    --no-curl::
            Talk to the IMAP server using git's own IMAP routines instead of
            using libcurl.  Ignored if Git was built with the NO_OPENSSL option
            set.

So when built with openssl and libcURL, we used to have a feature
that allowed to bypass cURL by passing --no-curl for whatever reason
the user chooses to avoid cURL.  This patch discards that option,
doesn't it?

Maybe such an optional feature may not be very useful, but it should
be explained and defended in the proposed log message, and it also
sounds like an orthogonal change to always require libcURL.

