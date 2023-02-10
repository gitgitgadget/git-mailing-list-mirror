Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7353EC636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 19:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjBJTCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 14:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjBJTCL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 14:02:11 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445E47D8A4
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:02:09 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w5so7418927plg.8
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FLpxWKybNd/lZ9j1ndXoARsVZK+wuBwsY65irHXk60=;
        b=AYMz73sZ0m0KQo7mJ9/SCwV2tK7vHdUjS95B1lv6V+N1bwgLM9VLsCFWk1/G801G3o
         A2ey9O71LrqOjHQsilMrg2rjf7UmTUIabfWe/08s+XFiDxsCmvfw75AUzwUrnNNJggwg
         QOn5/a1qTWBMDQvBUJXxDAzZO1gY2CDCSd4/QKx+yx2mzZQ2IWkF0dIXqJDe79elATgP
         /rQ2DuMW3vr7AX9m2SgkQHE6fpu/7BXVpQwjGZGRpIKjPsLoXSrUGZDlEh3CFWPLt90+
         51QN6UuzFLlpNIifFiwD9Sr84s8o4T4uQxr0ktOqhnpWr3AuYMvz2lpkByqVD2Nvz19L
         7kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FLpxWKybNd/lZ9j1ndXoARsVZK+wuBwsY65irHXk60=;
        b=Ej7/eKo4eYowpccAFMuGeDvDlO3d5iwUbHoJz8IwwPrwYyWK+kK8XAvNDU7UZ+Oqp4
         PiqlulOWkqhsZ+wEmoneNd/zmZ0g+u7vVyPLr3p6HQaavS9zouI9TyQP2Mx3pLtaK7kR
         XISNW7md29P0LE9AzSwWsqDP6KRB19oYlJmbXz45QJzvlyRw7GePclRtrmIaU6ggv+Kp
         PNHAqU9taj4h9EvTuaAiU3MUoAmwEyK5mcCyMaUAON6u0f7vW5xMuXpX2/rO050rf7+s
         iL13J8dhQZQEAhs3DoUk7ABwfHtgMzp8Lln/tc2Pa5JPpKOoYUwPDrci3lTf+P7Dz+TA
         lOCA==
X-Gm-Message-State: AO0yUKXSlrKNVwn5QmlpMxuIrndOKxRzhb6xT3U83BqNK9YpRqEG4BaX
        qDHLqW7rpDugFc9XBu1+LUI=
X-Google-Smtp-Source: AK7set9h6mQVl4EnN+CCdbgLwHCm+HF9zZLEQnR/vCNY3ltcO36NohQhvphGXzdWcRqPDCWYuLNHqw==
X-Received: by 2002:a17:902:da8b:b0:199:bd4:9fbb with SMTP id j11-20020a170902da8b00b001990bd49fbbmr18832473plx.43.1676055728682;
        Fri, 10 Feb 2023 11:02:08 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id io16-20020a17090312d000b001960706141fsm3709300plb.149.2023.02.10.11.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 11:02:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Max Gautier <max.gautier@redhat.com>
Subject: Re: [PATCH 0/2] gpg-interface: cleanup + convert low hanging fruit
 to configset API
References: <+TqEM21o+3TGx6D@coredump.intra.peff.net>
        <cover-0.2-00000000000-20230209T142225Z-avarab@gmail.com>
        <xmqqlel6mswo.fsf@gitster.g>
        <230210.86mt5lx0bq.gmgdl@evledraar.gmail.com>
Date:   Fri, 10 Feb 2023 11:02:06 -0800
In-Reply-To: <230210.86mt5lx0bq.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 10 Feb 2023 11:29:31 +0100")
Message-ID: <xmqqv8k9ibtd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> What's your intention of sending these?
>
> For them to be picked up on top of your jc/gpg-lazy-init.
>
>> I think we are already in
>> agreement that the churn may not be worth the risk, so if these are
>> "and here is the churn would look like, not for application", I
>> would understand it and appreciate it.  But did you mean that these
>> patches are for application?  I am not sure...
>
> I understood your "I specifically did not want anybody to start doing
> this line of analysis" in [1] to mean that you didn't want to have the
> sort of change that the last paragraph of 2/2 notes that we're
> deliberately not doing.

I didn't want to see "oh you are calling lazy_init here but you can
delay it even further" kind of comments that is wrong and wastes our
time.  

> I.e. that we'd like to keep the gpg_interface_lazy_init() boilerplate,
> even though we might carefully reason that a specific API entry point
> won't need to initialize the file-scoped config variables right now.

It is the complete opposite of what I meant.

Changing

	git_am_config(...) {
		return git_default_config(...);
	}
	... 
		git_config(git_am_config);

to

	/* no git_am_config() */
	...
		git_config(git_default_config);

is perfectly fine as a clean-up post series.

If we are moving away from git_config() callback style, and move to
git_config_get_*() style, the upthread already said it does not have
a good risk/benefit ratio, but if we were to do so, then we should
not leave some still using the callback style while others using
git_config_get_*(), which will lead to configuration read in a wrong
order and easily breaking precedence rules.

And if we were to move away completely from the callback style, then
I do not see a point to build such a series on top of the lazy init
patch, which is about staying with the callback style.

So, that is exactly why I asked the question after seeing it was
marked to apply on top of the lazy init thing, which did not make
sense to me.
