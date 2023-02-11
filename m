Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F50C636D4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 01:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjBKB4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 20:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKB4X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 20:56:23 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BAE3B3D4
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 17:56:22 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id c29so853868pgm.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 17:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfvWAiRKuOJctu4OYkxgjHdMbOFrfW64YL6K74x+1zw=;
        b=npt+sYRGDdPftEBQHRRS4MOkQma+Dhbk/6rmbVnEodVLgX1zrNAn8tr1zNkNoT4hII
         dfi7Bsk8QPNf9eycYKWUhaNbAElzSssswPrANnO+RNPhTJbdv6QS9PgujwKBgak8cpCP
         Lui4veiHvsiAZyJdiLiVJH+jeRZ86isB0THt2JESPnyVHj2/u0ivPcHqmWnHVsQ+ga4p
         mJdlXals35ZRrdwqiLJEDnYdonA5Jk31OWv5NngDcuPpCwiDDviD0X2bhGIpCwmHZYi9
         Lvp+YXkhpGeNLSZ85oWOYtYauf1RQlqpuMcZCQue0jOPci8BhgmaJTTtKeWUF9bbBZeW
         vJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfvWAiRKuOJctu4OYkxgjHdMbOFrfW64YL6K74x+1zw=;
        b=Y3aZBhycIbnJN4ERoVSGHJ4pzRNbSHZQjJLKWxrvqFBL0LRByAqmyWRTHu6rucyQRF
         upbnXfMhj7exOvUxDkmdEEVA4UtJRxxubs5TvNriHSWXMwqZTbGADU5L5H8Uur6walx/
         1991tibgymgSEnAtAoERs0G/GpnsNHUCuAyiBS6Xk+jsQraB3S0Kc2zj1a8vhJegVYAP
         K7k6ClEBDyyk9cVbVDIwZ+WMHioz884+zWBD7v22qaPtzjf3LvnWa265sqKMeA0Ge+Ms
         swVrz8jURA9AEjf2r2OqMEDYSTGvt7rAWRM259jAAdm+M4NrXBHhznZTc8hKey1GlHVw
         dH+w==
X-Gm-Message-State: AO0yUKUAt6rM91NCYx8wRH7mlakxtCTq0+ptVu0VTpcxQlXu/2r7ezBz
        R1a8cSBbhMEoWrfm6P1WhkHwramVTPY=
X-Google-Smtp-Source: AK7set9jIz7T38GJaVPAhaPLB5WFiqSg+z24A7DspWswUz7sHiKYhLCZeBQmQbCkwEDDC0LQX2iQ6Q==
X-Received: by 2002:a62:14d0:0:b0:5a8:5dcb:b775 with SMTP id 199-20020a6214d0000000b005a85dcbb775mr5893828pfu.14.1676080581522;
        Fri, 10 Feb 2023 17:56:21 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7928e000000b0058d8db0e4adsm3952852pfa.171.2023.02.10.17.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 17:56:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jade Lovelace <lists@jade.fyi>
Cc:     git@vger.kernel.org
Subject: Re: BUG: git config --global --get ITEM ignores
 ~/.config/git/config when ~/.gitconfig is present
References: <CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com>
        <xmqqsffdf0ji.fsf@gitster.g>
Date:   Fri, 10 Feb 2023 17:56:20 -0800
In-Reply-To: <xmqqsffdf0ji.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        10 Feb 2023 17:33:53 -0800")
Message-ID: <xmqqmt5lezi3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jade Lovelace <lists@jade.fyi> writes:
>
>> Then:
>>
>>  » git config --global --get user.name
>>  » git config --show-scope --show-origin --get user.name
>> global  file:/home/jade/.config/git/config      Jade Lovelace
>
> With "--get" replaced with "--get-all", what do you see?

Ah, nevermind.  With "--global", we seem to read from only one,
giving the ~/.gitconfig precedence over $XDG/git/config, even though
without "--global", we will read from both.

The code has been behaving like so since its inception at 21cf3227
(config: read (but not write) from $XDG_CONFIG_HOME/git/config file,
2012-06-22).  I am not sure if this was designed to behave like so
for a reason (which unfortunately is not clear in the log message of
the commit), or a bug that was caused by the authors who were too
focused on the writing side of the equation (which must pick just
one file to write to).

My gut feeling is that this is merely a bug that we can fix without
worrying too much about users screaming at us complaining that they
relied on the current behaviour.  Without --global we do read from
both, so with with "--global" the behaviour is inconsistent.

Thanks for a report.
