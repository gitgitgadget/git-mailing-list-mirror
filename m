Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5666B1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeB1SGX (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:06:23 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42938 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeB1SGW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:06:22 -0500
Received: by mail-wr0-f196.google.com with SMTP id k9so3376840wre.9
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 10:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MTKb1vcON/zsx9gVp9We8vKC4w8kHlhehuh9pQ2r8to=;
        b=rws/906q0Q6q6avf0Rp2mQV0AoYZx8sm1Sf9wEcNnktGzFUYQY1TecFPaZ81/Obz9r
         9GYc5R0U9ucz4Vm7j33cJjaTIU6BTnaJDREvwHK8AnxpO8qiUi5i5Tiv5hpBbwJe2GIn
         8NSAafdyZI0SAcpMhxsRnOkjiSVD8MZtHSF8LqDV85klU95ZVk2DiA9eM41dOZkuQzsg
         arrWkNOSqQ5Aqk8gdvaHXwcHKnLEio3YtzZZlLgokTdtzj08SNvhwgJxlPOCkp6/Lmbm
         9ULKn3Zg2vrPw4iUigvvfx8DrtzIMC9wNosAu79bPLNIT8bj1nntmxjyi5Yhht7EfluG
         yJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MTKb1vcON/zsx9gVp9We8vKC4w8kHlhehuh9pQ2r8to=;
        b=YUJrnVfctNoPMgO0PGE8+VzO5Tf30h4nh9Try9gV7ZGq/UTG7jry9g6T631CvYkkPT
         yLSH1zu5HiB7dlHRHOfcKCgH2jFrcp11ZZdoJ7ulNlVHhglFszmysi+/Oj590mJzCnrL
         8VuzDCaIcPGrcWGMSWbZBKfrHsAEBp+nw/MiOotvGTLsMmtUneonF8RYViNQUOM/2Mvk
         x3Ut0ccASQCmBUe60gX60NFX04N6CFek8pjmoqjej6PxOFgXVNqw5aGn/rygva6OpzfZ
         SeOaRHNYAvIynXReTD2ZfWaZLsuVQB6C+pnCly3Xb7kAflC+jOlvznPy/KgEEhk7tlCq
         x5xw==
X-Gm-Message-State: APf1xPAwSf9kFAWEl48iSWxj4TCXh5vW8reqCiwuZ/qAKGw3+o97OrFn
        KWr88WemWNzlblea1od5MfN3MkPi
X-Google-Smtp-Source: AH8x225Pnrrv8X27bspEbe3E3Eibgyn/70S0cR9Tz6S/nr4ggBYHPl7YXwQtfaTiL70U0MX5GuyrzA==
X-Received: by 10.223.177.202 with SMTP id r10mr15692889wra.97.1519841180892;
        Wed, 28 Feb 2018 10:06:20 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k11sm3293966wre.81.2018.02.28.10.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 10:06:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] protocol: treat unrecognized protocol.version setting as 0
References: <20180228005059.GA251290@aiede.svl.corp.google.com>
        <20180228010233.GA45342@google.com>
        <CACsJy8Cn2hcodoR8ksRBY9qf7MmJaP+KAzYqv6seeR9s-Be8Hw@mail.gmail.com>
        <20180228012207.GB251290@aiede.svl.corp.google.com>
        <xmqq7eqxm22w.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 28 Feb 2018 10:06:19 -0800
In-Reply-To: <xmqq7eqxm22w.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 28 Feb 2018 09:55:03 -0800")
Message-ID: <xmqqtvu1kmzo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> I wonder if it's better to specify multiple versions. If v2 is not
>>> recognized by this git but v0 is, then it can pick that up. But if you
>>> explicitly tell it to choose between v2 and v3 only and it does not
>>> understand either, then it dies. Not sure if this is a good idea
>>> though.
>>
>> Interesting thought.  Something roughly like this (on top of the patch
>> this is a reply to)?
>
> I am OK with that, i.e. allow the user to tell us what is acceptable
> and pick from them, as long as the blind "we do not know so let's
> fall back to v0" is removed.

Sorry, but "as long as" was a bit too strong.  I am not convinced
that the "treat unrecognized one as if it were 0" is a good idea for
the reasons I gave in the my earlier response, but I am not yet
convinced that erroring out is the best solution, either.

So s/as long as/but it may be better if/, perhaps.
