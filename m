Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F058C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 04:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB1E206DB
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 04:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc9M4m4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgBMEpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:45:49 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42902 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgBMEpt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 23:45:49 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so3228580lfl.9
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 20:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qYfFyUSA62z+6N8ghTKn1dY6ubhrdDMgUpbJyOA/hFs=;
        b=lc9M4m4wJcD/8Q8133tDdwLn50WT6B4OX6ccA0LVhN212Oc8rsdijLK0RXQmUZ/AaQ
         HxXev3rZMFIVuT6SsvR8+pBcCMeQkYn8haTCrEe5oFFzWw/0oHqMgiyBlMfi9gcFMiLj
         wO4X4XLNRQr6xPwMhBtM2fH6TtKEAw5FellSzSgqXamMZPup4ykK6AJEkfo9diuzCZL1
         /OemusxxZHoy53ctzCcTS8rS60lsKamMOQxTYeVjs8nTIXnbSAVAVT78AhyKEPrU94A6
         z6PoDqVHvLWbaWPpR2Urned6dWzDz1lXNRp8ZwkczQ4f1gxA4Vu1gX2YFkMlHJ0LPSs0
         O2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=qYfFyUSA62z+6N8ghTKn1dY6ubhrdDMgUpbJyOA/hFs=;
        b=Zv43KLtgdnHVVsz9UhLCyJmvoED01buNryUTsLqTbaInPLtIiSv0hcMrKZpyYRR4Go
         EraAvnO3HxQ4rgU543j0YBbZqsBnIhPH2F+5fkPJiEGedboJh1dg4wk8o0qTRgxUTZXl
         eI1xpozmQduwIoJVDUIcmfNE0qwJa4EtJDwOgI/KSQSucXF7lSrsg63goNXUYq3kYYYP
         pfOG4AgV227vxonBFB2HqbgiVAvGhvmwvqrp4hU6LUdljYYPsQDyzYnymtH+ryPI88pN
         fZUdeXesvvYsWtw9oxwZeE1YwD3ah+RmZBreJOBurXODRm0PPLWkHGGZdrA+0wvrSkoU
         DS7Q==
X-Gm-Message-State: APjAAAVMpYSO90TMGEbuK0eE8NQXD0R8k5eSNaeKR6x85wqB5/Q1Heyf
        HTMf4S5RujUu540HHLbZblaD/Szw
X-Google-Smtp-Source: APXvYqxmX27TOQJJL4MuGby+7Yc4IwsFtREgcRDl4lSp/svzwSpHoQ1m3ctLCa7VrJYY2TXBAo+evw==
X-Received: by 2002:ac2:46fb:: with SMTP id q27mr8388444lfo.76.1581569146659;
        Wed, 12 Feb 2020 20:45:46 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 138sm476134lfa.76.2020.02.12.20.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 20:45:46 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Aleksey Midenkov <midenok@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git tedious verbosity
References: <CAHk66ftUsKU2+Uhy-a7V5QcRdO7ShcYUk28qz7WAm28wGFmPOg@mail.gmail.com>
        <CAF8BazCpFyr_tpayWVtbk7V2LAtXaVmEKTCRQbgLYg4AvmvLvQ@mail.gmail.com>
        <20200211195549.GE2127797@coredump.intra.peff.net>
        <20200211195627.GF2127797@coredump.intra.peff.net>
        <87k14se849.fsf@osv.gnss.ru>
        <xmqqblq3vhp0.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Feb 2020 07:45:45 +0300
In-Reply-To: <xmqqblq3vhp0.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 12 Feb 2020 09:28:11 -0800")
Message-ID: <87sgjf2iyu.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> It says:
>>
>>    All advice.* variables default to true, and you can tell Git that you
>>    do not need help by setting these to false:
>>
>> If there were an option to set that default to 'false' (advice.default
>> maybe?), it'd have answered the demands of the experts, I think.
>>
>> -- Sergey
>
> This was recently discussed.  A quick search in the list archive
> would have found this thread, for example:
>
>   https://lore.kernel.org/git/xmqqwoa122h1.fsf@gitster-ct.c.googlers.com/

Thanks for pointing! Still ability to configure the default looks both
simpler and more flexible to me.

-- Sergey
