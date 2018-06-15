Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66491F403
	for <e@80x24.org>; Fri, 15 Jun 2018 21:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756339AbeFOVOe (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 17:14:34 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37055 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753735AbeFOVOe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 17:14:34 -0400
Received: by mail-wr0-f194.google.com with SMTP id d8-v6so11158462wro.4
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hEod1k7phHRt0yMLX2d87nFiTCVVkqZR7TANGbnM8OI=;
        b=XnihoZpd53SGU1dreAWm1A3E+aLhUQdTEG4CJMHZUl263hrTpj3p6iXTQsmCznc/kE
         fyNh5FDhFVbmQ4sU719byvIKD7+6dYqhXRYXurVq6ZTadtzGbkUc9xUeFIjyx1gQ+bFE
         Fd8fhkiqE0qJvYfjdhSntmkVYecahnXCQvZTThQaIEDnTLRYM3yReHGLEyGCQJYjgXUn
         +DlBt4ZobmbiYuiELDeIJrAADTsghK6pQyF562k4nHkfHEhcjbpRBFGL7pg0z+eyEoIS
         MkpRMTM4tDVx+CEj2jC/NtLhWl49cMMiPWb1F1hHDLxxghHMylgm4vO3Y3iURNPRUk+W
         Vmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hEod1k7phHRt0yMLX2d87nFiTCVVkqZR7TANGbnM8OI=;
        b=rO1K6mLu/hqvInU/XCYvLEgLz73IA405iIiGaLtGIeoaYBuQTyz0hpxxUdlRTMfCqG
         IUAEZeYgd9YpgNAWSjMPgR1NLDCtoO/+c5leR6yGqVyrCLCgDykxNJzD8CL0wV6TAQur
         UivTusnoVuIohtx2ySUvBw9LaGmiIcasdtWgb5XOsX3bgGZsWttNKBp2fcKj9gbAozSA
         fBTPLXPYC8TLbH+Q89LDjuqKuTh1XWMjd5hsOzYUzthncId/5XJxr0Z3/nHjYG+eMBkz
         QbfltgVeZ83W2ZOKrW0LtqT8nF9XGfYYmkXDLtcBTIJzff1T7B52bhI96ICN3QjUnIGF
         d6KQ==
X-Gm-Message-State: APt69E3RaZx/0EfIyNQX589ZnP90sFb/F45GWOtIpolRiFgskAzyk9ER
        D0mjGZlEUaK1CQEZm3wwjcM=
X-Google-Smtp-Source: ADUXVKK2HZ55ypvlllcCxZdsoo1n95BxLAbWncCrGdn9fxYccFoFP4RjGKMwxA/aAmJ1I5KJvt8K5g==
X-Received: by 2002:adf:b0da:: with SMTP id j26-v6mr2773128wra.3.1529097272692;
        Fri, 15 Jun 2018 14:14:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b124-v6sm3410906wmf.11.2018.06.15.14.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 14:14:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 2/8] upload-pack: implement ref-in-want
References: <20180605175144.4225-1-bmwill@google.com>
        <20180613213925.10560-1-bmwill@google.com>
        <20180613213925.10560-3-bmwill@google.com>
        <xmqq602jzriy.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 15 Jun 2018 14:14:31 -0700
In-Reply-To: <xmqq602jzriy.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 15 Jun 2018 14:08:53 -0700")
Message-ID: <xmqq1sd7zr9k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The story would be different if your request were 
>
> 	git fetch refs/heads/*:refs/remotes/origin/*
>
> in which case, you are not even saying "I want this and that ref";
> you are saying "all refs in refs/heads/* whoever ends up serving me
> happens to have".  You may initially contact one of my friends and
> learn that there are 'master' and 'bo' branches (and probably
> others), and after conversation end up talking with me who is stale
> and lack 'bo'.  In such a case, I agree that it is not sensible for
> me to fail the request as a whole and instead serve you whatever

s/whole and instead/whole.  I should instead/;

> branches I happen to have.  I may lack 'bo' branch due to mirroring
> lag, but I may also have 'extra' branch that others no longer have
> due to mirroring lag of deletion of that branch!

