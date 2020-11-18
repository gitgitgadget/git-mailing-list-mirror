Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF44C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 13:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712322469D
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 13:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgXTGUNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKRNtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 08:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgKRNtn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 08:49:43 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B86EC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 05:49:42 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id dk16so2790303ejb.12
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 05:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rrci4bQxZO9mdrnx7vo9ct3wS+PpvmpPt1IrNUpfTY0=;
        b=mgXTGUNHaP+Sssh2bXpdqlhDpge93fPV8X2V431f6IzG1R6eDFlh+6kx3Dx4JT5yhn
         k8YGh5xroVvNLrrtfr5LrqSsavx6fGo+/O93TZCPmaqCA+Rw2P7wpX4mQnyP8wz6NDyc
         /EJq5iuK+TpmlD41/iFgEiFxMehOlesPbXnlkcbOxi6F9N+pRFQ21tZh6EDo8Ll1H0HE
         C8js0wtiqWf9/vh/unO9HVQc17AM8mbJj2fEQ8JIxVJ/BKfllIhpaxG52C1Vea0L/8BI
         AWPoo0dJvdHnvFzMZnRqts1w73m54yNqyAzi7XHI4DqP3PKkm7HnjH9g8CTEF5QL24QK
         CNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rrci4bQxZO9mdrnx7vo9ct3wS+PpvmpPt1IrNUpfTY0=;
        b=tQ5p/X4dx3L5RiWXpBYreX9hKUrq4RgO8fdx9Xi2tQY2znbQwIhqw/NTnWA4ElKZXx
         qw6PmlSLTM0npgKPcNZkcLnxgy4fgyQ//G6R/g189XtVZVJtkJ/V/m8SrfihqUQwx9Rb
         jhai1cVrxQRAast85ASnVK92POjbZgnCozSm5ZeBgcz8m5/ab4fbU/HQ36OebyRttuB5
         Un0z0kDvsIPsxYqhGuWfRKLI6EIULtDuUbT2hzbjs5a1yJjst7e2g0mrAwH0LOb/ltMe
         k5wOMKdt/ADsIhbvm5EHK4wWtpRO45YOY66g48Ci3HcAKmejtmAtGgt4/A/GtkPIyts9
         ugYA==
X-Gm-Message-State: AOAM532pbY6zODqVKGFFqOHDC+OHdadTIM3+4tvsGxyOXkHc0A33Rg7K
        kRS0qJmnLTcs9vanKlzuJAI=
X-Google-Smtp-Source: ABdhPJwqeC9u1ptIfhXLlvYMReptEVqVgk8/2U5LnXnl9e1WqcjWjJdeEuCPzY0BHnlvLVTdqRKQCw==
X-Received: by 2002:a17:906:b0c5:: with SMTP id bk5mr6422078ejb.217.1605707380902;
        Wed, 18 Nov 2020 05:49:40 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id n12sm12991162ejs.19.2020.11.18.05.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 05:49:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar pairs
References: <cover.1605269465.git.ps@pks.im> <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im> <87mtzlflw7.fsf@evledraar.gmail.com> <xmqqy2j1851k.fsf@gitster.c.googlers.com> <X7NtovvfE7IjWzie@ncase> <xmqq4klo7992.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <xmqq4klo7992.fsf@gitster.c.googlers.com>
Date:   Wed, 18 Nov 2020 14:49:39 +0100
Message-ID: <87d00arczw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 17 2020, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> I especially do not think we want to read from unbounded number of
>>> GIT_CONFIG_KEY_<N> variables like this patch does.  How would a
>>> script cleanse its environment to protect itself from stray such
>>> environment variable pair?  Count up from 1 to forever?  Run "env"
>>> and grep for "GIT_CONFIG_KEY_[0-9]*=" (the answer is No.  What if
>>> some environment variables have newline in its values?)
>>
>> You only have to unset `GIT_CONFIG_KEY_1` as the parser will stop
>> iterating on the first missing key. More generally, if you set `n` keys,
>> it's sufficient to unset key `n+1`.
>
> Yes, but those who want to set N keys would likely to be content
> with setting 1..N and happily forget unsetting N+1, and that is
> where "how would one cleanse the environment to give a clean slate?"
> comes from.

Not as an argument from whataboutism, but just to note a bug/existing
prior art:

Nobody in this thread has mentioned GIT_PUSH_OPTION_* which works pretty
much like Patrick's suggestion, and it looks like --local-env-vars
misses those:

    $ GIT_PUSH_OPTION_0=foo GIT_PUSH_OPTION_COUNT=20 git rev-parse --local-env-vars | grep GIT_PUSH
    $

I haven't tested this, but I expect there's a bug where a push hook
itself does a local push to another repo and that repo has a hook, that
the push options are erroneously carried forward to the sub-process.

That might also be a feature, depending on your point of view.
