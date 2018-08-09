Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E0E1F46C
	for <e@80x24.org>; Thu,  9 Aug 2018 21:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeHIXfg (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 19:35:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45985 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeHIXfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 19:35:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so6311248wrv.12
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2STl5d5ACYWoC65Cdul0sEzMhNEDYqm94nJHBwClGFA=;
        b=adv+RM4ewsEEvS2BZQZ2xgcEzZOIIXpKBgtJ79MlTmCykLCKZEfOsax6pFvG1ZN/m0
         mpr8EZL9QQ4z2rZHBgB5e5F6I4CeIeYXvL3wjBnGdGznfzmuC5FBtKJvgWBXpjcr65s8
         +XcGxuIuHh/qnHcJoflZbGgMFg3SCczk3DaHuABM95wLL3D8+1rvH+QxKrljA8y8cJ30
         CiSykmwvZn9vU+vHMKvbjqlQrFu+1SkCXIrjxx/Fa3DqSafsqfaLtpBQtwddqsGyQiLb
         PhgpgQzUuVuJHkpoem9KtO7PIpDxaVvborL5yL/stKcFvTJIAaVz6JXoMbunecs7yGb0
         W/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2STl5d5ACYWoC65Cdul0sEzMhNEDYqm94nJHBwClGFA=;
        b=QXRSJ/rtUj8nUBQ3AcbSPIWFwnXJN+qUdkrS7i53/vzl7FBuAOEeHaBUpm7rIhWHMx
         zA9ShS0C0N+5MZ+ru5DOmjHXvYxuLV5qV9o87XYeXFeqijf+ucf2RpJa1Ix1xu28mzVe
         OWetfT547jqOECxjfpiRN79O3Y/GJ2Ls2EM5Du/f5rmx+jHRg23cgQ7038ohTk9YpzAO
         dchIimiZQwavXGPt/rXEXsxtzv/kVI8lQal0toH6F8Z0FlElhyzKTaNViPh8wDMkuNCU
         e5hhK5gao6mS0vzpHtHP6lYlq32tvkMKFXo22JAUzcFF7IEuOH3u0MAfvoxnraO4aEgc
         z8gQ==
X-Gm-Message-State: AOUpUlFOeKlNANrRhC8I/IDtoTCrrw1PcMuXReNtnbW9ZOmPryYvQaB7
        6siN5saEppBtenG5FIdS5CU=
X-Google-Smtp-Source: AA+uWPwUjJeyz1j0M/wv9t58nIzaiC5awJ4e8myvG2aGSSm3tIX1XXChqmyyz+94iaFAa3ZwVWFfMQ==
X-Received: by 2002:adf:ed8e:: with SMTP id c14-v6mr2393306wro.264.1533848937625;
        Thu, 09 Aug 2018 14:08:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4901724wme.36.2018.08.09.14.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 14:08:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking for GIT_TRACE
References: <pull.17.git.gitgitgadget@gmail.com>
        <20180809194712.GC32376@sigill.intra.peff.net>
        <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 09 Aug 2018 14:08:56 -0700
In-Reply-To: <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 09 Aug 2018 13:49:52 -0700")
Message-ID: <xmqqbmabb63b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Are you sure that it's not well-defined? We open the path with O_APPEND,
>> which means every write() will be atomically positioned at the end of
>> file. So we would never lose or overwrite data.
>>
>> We do our own buffering in a strbuf, writing the result out in a single
>> write() call (modulo the OS returning a short write, but that should not
>> generally happen when writing short strings to a file). So we should get
>> individual trace lines as atomic units.
>>
>> The order of lines from the two processes is undefined, of course.
>
> Correct.  But I am more worried about the "mixed/overwriting"
> breakage, if there is one; it means we may need to be prepared for
> systems that lack O_APPEND that works correctly.  I initially just
> assumed that it was what Dscho was seeing, but after re-reading his
> message, I am not sure anymore.
>
> I think the "do not trace the other side" approach you suggest for
> these tests that only care about one side is more appropriate
> solution for this particular case.  We then do not have to worry
> about overwriting or output from both sides mixed randomly.

A concluding sentence I forgot to add, after saying "this is simpler
and better to fix test breakage", was

	But if we really are seeing O_APPEND breakage, a mandatory
	locking mechanism like this one might be necessary to work
	around it (I seriously hope we do not have to, though).

Sorry for an additional noise.
