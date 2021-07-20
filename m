Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC0C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 13:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C9B6113A
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 13:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhGTNQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbhGTNLp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 09:11:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB29C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 06:52:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ga14so34450011ejc.6
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1kPjR9XNn7kgBUtH7NqdNXeNxvQ++EHomduZtTRpwZo=;
        b=H7f+40ECYIIucEyxLFCZ1LBE/lOpcHCSj4r5cfgXZ9xfj21jrjKFhYwpWD8PjK1s3w
         BWlMOy9JG4uMtsANdMTudwBlB6I74xAa0HFvI7Sm45YjDzTu4PWRU03DYUEoLUkwBAZH
         IYIfdU5TGu6MzxYHM/pzs+Elp1Bo9dguqCF81LfXGVMEaApC4CMTfDNQrY2GmgJvEBCJ
         nmAPvTDJ/ndJJNG1mW6JQsbu1URX3D7b8TysFiJrn+WLFo3mV5ORgt5yvNgz+D4HmZBd
         Ox/P0UBsf6OQAHyWQzRdKePESGKib4p1OI2/ZnLsktAIU9wy2VmIE1SAzUHKhoHYM6/C
         ZP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1kPjR9XNn7kgBUtH7NqdNXeNxvQ++EHomduZtTRpwZo=;
        b=f5Edl0EfuZ8nhLwXHVIymv4wB/EHzKpzTCzL8uiYdGETIcV8CnZnZUwikl80RkK6BS
         OAWGCVitsYK6yWXeuNjhvKJy7IyldS0J2NwAFFFPInj1kFinnJO/Rz49SueGRbv1akRf
         Ui5FuDD6tVKjPU8FzWUwvDHzAnLpt2XQ3vUxcBYD/xN71NhA0lbNeAVrinypT6BNeDwH
         PDwCZNwe2YNJ81ICbsEaxLTKDzMSm+c2IVjCu1CDUzvDpxuLnMK8a0AMZ5PIeWRruZ6d
         rojAvVcPVW2qwdDjlpq21/sGXX//+sxrfBsGlwn/xvVb3XGnQ6Qt8B+YKMsP8+nrhGKE
         oTRw==
X-Gm-Message-State: AOAM5322MpS+z6HLGV39PHBXFUYPe1cue5GXFhl9P8z8P+odpMaHm69X
        42X4uqYVUrPaQWOiTmzni0k=
X-Google-Smtp-Source: ABdhPJzMpRURxX2XC9XY8vNcSyIXLCiEQwUzIwrS2GZC11Tu2gyCGklm5KNryTB7BxJhcHhZ0U3+hQ==
X-Received: by 2002:a17:907:1ddb:: with SMTP id og27mr32517166ejc.540.1626789141029;
        Tue, 20 Jul 2021 06:52:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j18sm7169318ejs.114.2021.07.20.06.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:52:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] pack-objects: fix segfault in --stdin-packs option
Date:   Tue, 20 Jul 2021 13:55:31 +0200
References: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210709T101014Z-avarab@gmail.com>
 <patch-2.2-c7315f2b378-20210709T101015Z-avarab@gmail.com>
 <YPXvQXOcdKdCzcFb@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPXvQXOcdKdCzcFb@nand.local>
Message-ID: <87zguhum6y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 19 2021, Taylor Blau wrote:

> On Fri, Jul 09, 2021 at 12:13:48PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
> Thanks for the update, and sorry that it took me so long to get to. I
> see that this still hasn't quite made its way to 'next', so I'll just
> add one comment.
>
>> +test_expect_success 'pack-object <stdin parsing: --stdin-packs handles =
garbage' '
>> +	cat >in <<-EOF &&
>> +	$(git -C pack-object-stdin rev-parse one)
>> +	$(git -C pack-object-stdin rev-parse two)
>> +	EOF
>
> I see that you left my suggestion to inline this here-doc with the
> actual 'pack-objects' invocation below alone, which is fine. I think
> that it does help the readability, too, since it separates the input
> from the command its being fed to.

Yeah, per CL:
=20=20=20=20
    I didn't end up moving away from the "<in" pattern. I prefer it
    because it makes manual inspection easier, and the tests above this
    one used it consistently, so I left it in place.

>> +	# That we get "two" and not "one" has to do with OID
>> +	# ordering. It happens to be the same here under SHA-1 and
>> +	# SHA-256. See commentary in pack-objects.c
>> +	cat >err.expect <<-EOF &&
>> +	fatal: could not find pack '"'"'$(git -C pack-object-stdin rev-parse t=
wo)'"'"'
>> +	EOF
>
> On the other hand, crafting this err.expect with one of the object's
> full OID still sits funny with me. I appreciate you checking that this
> is the correct object to test with in SHA-1 and SHA-256 mode, but isn't
> the point that we shouldn't be relying on which object comes out?
>
> I think that dropping this down to just something like:
>
>     grep 'could not find' err.actual
>
> would be an improvement since it avoids the finicky shell quoting,
> hardens this test in the event of a future change in hashing algorithm,
> and brings the test more in line with the spirit of the patch itself
> (which is to report some of its input, not necessarily the first one
> given).

If we've got another hash transition (unlikely, at least near-ish term)
we can just look at this test again.

More plausibly it's a common pattern in our test suite that greps like
that elide actual problems, e.g. a loop printing the error N times, that
seems more likely in this case.

Do you mind if it's just left as it is?
