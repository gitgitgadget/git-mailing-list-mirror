Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D291AC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 09:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FD76195C
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 09:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhC3JQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 05:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhC3JQs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 05:16:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF4C061762
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 02:16:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so23761987ejc.4
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 02:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=abqCxCO4pFw/Yp/dqIsHYXKKLWSP0lYakCTxmPZeZ4c=;
        b=FbsrTLwx5lic4YomBktT2YozxUjEl/JWca8Slwv069pHbZD9/xwF1eYExxhEmPFRUx
         4Nbf92dFJ6m61JDDgQY+MnXwNHuMHEjhRfYhCRmTwXN+yhzHEjo4ueeQEckGfhxNsy9M
         k5lU94n7e4WFvm3bt4i6zo5WHXNdttVwE/KOy0o3sr6RaDGfCqPxK7Qwe+k6xFSnzOwc
         VutI/gf37hbG9B0XYsGxiHSe0AQeoNYr58OHZxgRl5ZNdSsUq/s7MtEphtCUlPuT5uWy
         /J9PaMV7fLgZIUfOZ9lQ5YwzaxUw0HW48Vrpzaczy6NCKhw/83GfhsVf0BrYUf7Ga+/h
         vpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=abqCxCO4pFw/Yp/dqIsHYXKKLWSP0lYakCTxmPZeZ4c=;
        b=fHRGx8Vk+AINSfsCcdNIoYo5MLjXQUle/mvUCN13L2jB/n+XYU1YVwNO9C+iBkVhnR
         kXt21w0vlon2j2IRps8iz2qZ7PTWz4dRKeObzy2D7V11Bv5w/TQiP1KvBSCN54hCRokd
         lBeyZc3sBRn7Wih5Rym2amNJGAv6Yp0klrMqvKp+oy3C9vQ17nUkqw/1JM4dWwf3KUbC
         AAOU8OMUnbrXfWFZrP1VDMvX+rFgFs0gqraYseT5Fq4ZC1MNh0ETBczhCNAh8Cx6rgxN
         AKm/JV7YoZeeQqmWtnGKJwxWNcUAFko0AiCXKJ+Z7hR+kwU9U0hSBbErjiFmxYu8fafK
         1J6w==
X-Gm-Message-State: AOAM530chCzAm9X3cU286TBHOZKjjzIpM1/FbrC541G9Avv/NDeTAqcw
        d8hfDz3qEaNW77B2MYUQ2DY=
X-Google-Smtp-Source: ABdhPJwyBkKnRf4xdM+dhYc486S60zckUNXDmGvbbkY6t1kDbeY34OkAx6VfUJMWEKGDXZAUwO8ocg==
X-Received: by 2002:a17:906:fcb2:: with SMTP id qw18mr31293132ejb.434.1617095806765;
        Tue, 30 Mar 2021 02:16:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gb4sm9550502ejc.122.2021.03.30.02.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:16:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Clement Moyroud <clement.moyroud@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Running scheduled maintenance in quiet mode
References: <CABXAcUx0uWyk1e0UCaTwGt1VwVZkj1sV-OapSgZJOv3eS88eng@mail.gmail.com>
 <f5db297e-e0e6-3eff-37de-8efafe07482a@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <f5db297e-e0e6-3eff-37de-8efafe07482a@gmail.com>
Date:   Tue, 30 Mar 2021 11:16:45 +0200
Message-ID: <877dlpm26a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 29 2021, Derrick Stolee wrote:

> On 3/29/2021 12:45 PM, Clement Moyroud wrote:
>> Hello,
>> 
>> Now that Git v2.31.0 has the fix for 'git maintenance register' on
>> bare repositories, I've enabled it. I'm now getting a fairly useless
>> daily e-mail with a couple of hashes listed (no other info).
>
> Thanks for your interest in the feature! Sorry this is a
> frustrating experience.
>
>> I'd like to disable this e-mail and get the configuration to stick -
>> changing my Crontab with either --quiet or a /dev/null redirect works,
>> but the next time 'git maintenance start' is called, this will be
>> rewritten.
>
> You are right about that. We could alter the implementation of
> 'start', and the only downside is that you would need to rerun
> the command to avoid those problems.
>
> For now, you can stick to 'git maintenance register' instead of
> 'start' so the crontab schedule is not overwritten.
>
>> I could not find a 'maintenance.quiet' option (or similar) in the
>> config. Is there a way to do this currently?
>
> This could also be an interesting workaround. To be distinct from
> the crontab approach, it would probably be necessary to also make
> the `git maintenance run --auto` output quiet by default, too.
>
> I'm on the side of modifying the crontab schedule. I'd like to
> hear other opinions before starting the work, though.

The behavior of crond on *nix systems of e-mailing on output and
ignoring exit codes is probably one of the worst design choices of that
family of systems.

I think the only sane way to deal with that is to run the relevant
program through something like chronic or any of the numerous other
"buffer up cmd output and check exit code, spew if non-zero" wrappers:
https://habilis.net/cronic/

We could even ship such a wrapper ourselves, or ship chronic itself
(it's like ~20 lines of Perl).

Down the road of catering to cron's behavior in individual programs lies
madness. Instead being able to run your program, emit diagnostics output
and decide on the exit code at the end you end up having to decide at
any given leaf node in your program whether what you have there is
important enough to impact the eventual exit code, because otherwise you
should be quiet least cron sends an E-Mail.

You essentially end up re-implementing something like chronic in your
program. I've seen *way* too many such hacks of buffering output until
the end that could have trivially been implemented via chronic.
