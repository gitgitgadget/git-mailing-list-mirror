Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18031C4332F
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050B56108B
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbhKRKJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 05:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245497AbhKRKHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 05:07:46 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F33C061200
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:04:20 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id w23so12409941uao.5
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZvQZeSGEqAci6suI9TfTNYV+uMFPvW4xvnZHd44FY3s=;
        b=Mn9+NBtcTS8uIdiplEHFwVnPS3OvMatGuB7CZ5jHCPSqn9vgorg+C7hVnpM/4qlcNn
         swlWW5nJHWVl7hQeGmH8AiiMJDCQVyU+gJNLRXrQAAHgIvSR/4mAMbji298yYnFKcxL1
         6p1WzYHEcFXAVbsET4lxoSctqFPyG1I4FuipOscMjkiU+a/w/ej1aHEFpyq44QwElwlR
         aUIH9VSB7OZwJ6n5f5/hM/m1a2FArBC5qn+DPU74sWNb/5t6edztITgNJdCumjjB2fZ3
         YDP6/tBW1x9//fp4ciu8pL5aTxxze6RIji5J+E/1dZ8Fbrai6rLna6sWWSLPXEl/ejNs
         0CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZvQZeSGEqAci6suI9TfTNYV+uMFPvW4xvnZHd44FY3s=;
        b=Dt6TZD4G6ayX9SJGTjSNRX22MVP2q7cL6epCL1/4MA6q1dK7Eu5sW8FI5EJoi6Zc+k
         t3q7c27rIRq9HRu5kvWTpvtigWbRGHmvFNEh8lFU8C1mcibjpmvIKkq9PgpifZsvR1sW
         Nsr9lTbrxvVW+0P66pLgmeFzJ2RSyMv7PmF5aINzTdamX8T5xzTxKmv5n82PNIYItyqp
         9FaKRvsHQiTZUZXOpSw5QEFJp4iKo4+tDSpjGwqbRaPFnaaIxa1gLsR4K4uL4fkQ1Uvw
         rlYD2nBjotSE4hVizO1K+6JtrjzdChxns2xp85VrptV8nS+GH2tE+he6zIwoJtz6Zn6Y
         vkcQ==
X-Gm-Message-State: AOAM530gwaKBEVRNZJ9cNp34kfhjKusdbB6/UsOHL9viYgHerkC0VCLW
        HnITHmdGwlla7nU3FhrT6pqWY6owgeappWc4Jvw=
X-Google-Smtp-Source: ABdhPJzIKMN/3Hjh2qegGIgU/oH3k2AoxnXs9Y8kKm28N/RYYL2LdGJn8Fjxh0ooA+g2PL9Gjfr3q9OVuZvPOnEHWlo=
X-Received: by 2002:a05:6102:512b:: with SMTP id bm43mr80210992vsb.14.1637229859434;
 Thu, 18 Nov 2021 02:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20211118084143.279174-1-someguy@effective-light.com>
In-Reply-To: <20211118084143.279174-1-someguy@effective-light.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 18 Nov 2021 02:04:08 -0800
Message-ID: <CAPUEspi5-urxZxHCsAWjyLxPWDfaYCK7nqGBL8FejU=n=qcFrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] grep/pcre2: limit the instances in which UTF mode is enabled
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 12:42 AM Hamza Mahfooz
<someguy@effective-light.com> wrote:
>
> UTF mode is enabled for cases that cause older versions of PCRE to break.

Not really; what is broken is our implementation of how PCRE gets
called and that ignores the fact that giving it invalid UTF-8 (which
might be valid LATIN-1 text for example) and telling it to do a match
using UTF, will fail (if we are lucky even with an error) or might
even crash (and obviously don't match) if we also tell it to not do
the validation, and which is something we do when JIT is enabled.

> This is primarily due to the fact that we can't make as many assumptions =
on
> the kind of data that is fed to "git grep." So, limit when UTF mode can b=
e
> enabled by introducing "is_log" to struct grep_opt, checking to see if it=
's
> a non-zero value in compile_pcre2_pattern() and only mutating it in
> cmd_log() so that we know "git log" was invoked if it's set to a non-zero
> value.

I haven't tested it, but I think that for this to work with the log,
we also need to make sure that all log entries that might not be UTF-8
get first iconv() which is why probably =C3=86evar mentioned[1]
i18n.commitEncoding in his old email.

Of course doing that translation only makes sense if the log output is
meant to be UTF-8 which is why there is all that logic about being in
an UTF-8 locale or not which probably needs to be adjusted as well.

Carlo

[1] https://lore.kernel.org/git/87v92bju64.fsf@evledraar.gmail.com/
