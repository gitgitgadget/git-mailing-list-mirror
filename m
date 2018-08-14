Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF9CC1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbeHNXlk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:41:40 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33029 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbeHNXlk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:41:40 -0400
Received: by mail-wm0-f43.google.com with SMTP id i134-v6so4156661wmf.0
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5pGp0ViKnzVK8+R3PyCHgsHcTE5lddFjRtE+m9XshYc=;
        b=b9E7tGnpNeGIV24XdAzFI7Ps1XhMm/7dha1txZ1CbWAiXtcAaG0E8yNzPV5x9bwzDG
         79opidhwAvNUnHc2PspePy6n+9iFjEVW6j2cug/DC8fFk/u9fRAUikYiKqXz05Nes7EG
         PUH35P1zK0P1eWAIqpIoHkzHNPUz1iewvAVgUlV+h1o2O28CoQOtBp5DCeibaUMKhiSS
         ji70+z/khrFDf7zxTqHh4V8bhbNgFoxG4MXD1IbiJh23wgticgkM67eeQ/Ltj8AV6AGo
         PRNog1O8VkjSjbNzR4pOYqQi3d+RTfWCL500ZSTvBKx8xUYGlsVNE0DZK6umrpEIFEUQ
         A23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5pGp0ViKnzVK8+R3PyCHgsHcTE5lddFjRtE+m9XshYc=;
        b=bORk7w1QYW/J2KROCrEubzZD/Twql3oowRogT0pdTy1TV5r2iuBnSNtdF1yvkFlKek
         YQIK0DCtZ04wU27ynkA+Jpib4K+MwdkwD9+cHbkDwEhr8eS7hy4v4pESRDrBapUQuDCf
         OiCn/xEke+snwtO2r5FeNmkeusA/HJbfdPOqxVNtvrWiQhStQ5PaRxVwXozrC9HTbRw3
         bsC0Rj6cxzqkYlL4w3gbPzj+7QNqZBgbOOZ7CO2OxySRNQoFw+HZPIj/njCG0nqS/n4J
         gNXeDHZNLjdBfMkzvuEZigrQMW8BTfMmbzwf1javeXpbUooq4SPjnJEOUynXPAzm5K9t
         VXxw==
X-Gm-Message-State: AOUpUlEWZLyMx11naY3PqugEqNbJu+aceCE5hRAqmT60I5otB3pbMipG
        sq7L65PUejBVvrzBbn6vylo=
X-Google-Smtp-Source: AA+uWPzRRBgFmEmZwQ/RD7TOsf0kUykwz31pELH/djWr35oq3Qqc+Hgmi3h/DJqwVyg6gO4zjx2Z1Q==
X-Received: by 2002:a1c:497:: with SMTP id 145-v6mr12191401wme.157.1534279961293;
        Tue, 14 Aug 2018 13:52:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n5-v6sm83724wmh.1.2018.08.14.13.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:52:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
References: <20180804053723.4695-1-pclouds@gmail.com>
        <20180812081551.27927-1-pclouds@gmail.com>
        <20180812081551.27927-3-pclouds@gmail.com>
        <20180813192526.GC10013@sigill.intra.peff.net>
        <xmqqk1ot3n4h.fsf@gitster-ct.c.googlers.com>
        <90d1bbf7-91a3-74ac-de65-1eb8405dc1f7@jeffhostetler.com>
        <CACsJy8DQmOCD2a5QFUiyPuoPZLq-QEejLhWACKpsJLvK5ERAMg@mail.gmail.com>
        <CAGZ79kZwVpCBMkBKuYpwZFgAN50wZub_fyzWrAsE=ksuc-aCgQ@mail.gmail.com>
        <CACsJy8CTNeR8Bchj37yNL+mWp1Y5rhD6QV2Gf06CPLHVXd8TDQ@mail.gmail.com>
Date:   Tue, 14 Aug 2018 13:52:40 -0700
In-Reply-To: <CACsJy8CTNeR8Bchj37yNL+mWp1Y5rhD6QV2Gf06CPLHVXd8TDQ@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 14 Aug 2018 20:51:41 +0200")
Message-ID: <xmqqeff0zn53.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> These trace messages are made for human consumption. Granted
> occasionally we need some processing but I find one liners mostly
> suffice. Now we turn these into something made for machines, turning
> people to second citizens. I've read these messages reformatted for
> human, it's usually too verbose even if it's reformatted.

I actually actively hate the aspect of the slog thing that exposes
the fact that it wants to take and show JSON too much in its API,
but if you look at these "jw_object_*()" thing as _only_ filling
parameters to be emitted, there is no reason to think we cannot
enhance/extend slog_emit_*() thing to take a format string (perhaps
inside the jw structure) so that the formatter does not have to
generate JSON at all.  Envisioning that kind of future, json_writer
is a misnomer that too narrowly defines what it is---it is merely a
generic data container that the codepath being traced can use to
communicate what needs to be logged to the outside world.
slog_emit* can (and when enhanced, should) be capable of paying
attention to an external input (e.g. environment variable) to switch
the output format, and JSON could be just one of the choices.

> It's not just sampling points. There's things like index id being
> shown in the message for example. I prefer to keep free style format
> to help me read. There's also things like indentation I do here to
> help me read.

Yup, I do not think that contradicts with the approach to have a
single unified "data collection" API; you should also be able to
specify how that collection of data is to be presented in the trace
messages meant for humans, which would be discarded when emitting
json but would be used when showing human-readble trace, no?
