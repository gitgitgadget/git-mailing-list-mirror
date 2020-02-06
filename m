Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9023C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 01:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06FD20730
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 01:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9Y9QyUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBFBHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 20:07:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37158 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgBFBHK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 20:07:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so5021447wmf.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 17:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=De49Tkbw+jF4xxkqDk1b/VzNdNsF/qkGbTyF0cngW+U=;
        b=I9Y9QyUzpaaByV6rNch3Sx7rAK2NAizcStgweottEDvt2GTgqzgPAO1j6+D/iMoTSm
         15TzzcxogglYRmHmw6NSGhHKPIc9qLjSIub9100UjQr5qi9s+wbwnvDbFPGuuP0JDmH7
         t1e6HV5SympGT5Vc6g0MHlashInkRz7RbFZzSe0RNMinRXzFd5Ut6BsTvnAkv2H+oW4Y
         bpV14WTsASzgWyx1BcvdJvoOWEiIqECk4w4Gd+YYjqBkd9x1+yDgvW+T2IYggIsWEg05
         NetYs1ald/PhInb3Me8KYZRgxDZEX5T17b/wao5qGdN+39TduXzTZtUMH7JwxYmwsAPK
         N+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=De49Tkbw+jF4xxkqDk1b/VzNdNsF/qkGbTyF0cngW+U=;
        b=c7yOzFR0fGZgAVpdQtg2liqUWEIGROKwSyEV7eLy0PYQdC7HvAtTZwMAeBc8tksoX4
         Yh4BcK9uomiRWb0mO2EvjCrVQohIlFjQ2ZsYXrr4HVvU3wmrcKx6oX/bsLT1zug1rS90
         Rqa3qjq6aARuUaX2Q7nLBS6WmWUDqwiatxWG4JgvKCXBLXrFHzs3uBGXnRPRIFZRgZPa
         jSx6a0dDGr46JXKjvDdZ2sIKuhfg0vX8Vfw0zgR99Xhiw8CTN9zLozoGxph+wlmf1asT
         83SaIG1FSXOhGtpd424uQKpXxzdWjww3liyVimWRf/CyrUHZ2b2WlFM/cos6tHaRRgJ3
         V2dw==
X-Gm-Message-State: APjAAAWQd7C1OJSBdqD+/LlvStUyzUE1CJ0pVX2BNxQ+KdnU5YCRdenU
        gpOFuQxo6k8jX+OMqJlykVk=
X-Google-Smtp-Source: APXvYqwGGOt5wchMsd90b8uSVf/ej8676zx96UcTd95d0C7FrbMSGBNiAN0VtGr1yzjjp+SH4Je+Ew==
X-Received: by 2002:a1c:de55:: with SMTP id v82mr572672wmg.48.1580951228246;
        Wed, 05 Feb 2020 17:07:08 -0800 (PST)
Received: from szeder.dev (x4dbd62a5.dyn.telefonica.de. [77.189.98.165])
        by smtp.gmail.com with ESMTPSA id t13sm1992679wrw.19.2020.02.05.17.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 17:07:07 -0800 (PST)
Date:   Thu, 6 Feb 2020 02:07:04 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v7] MyFirstContribution: add avenues for getting help
Message-ID: <20200206010704.GN10482@szeder.dev>
References: <20200124210148.220007-1-emilyshaffer@google.com>
 <20200124212602.74194-1-emilyshaffer@google.com>
 <20200124215628.GI6837@szeder.dev>
 <xmqqh80kctcn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh80kctcn.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 03:44:40PM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Fri, Jan 24, 2020 at 01:26:02PM -0800, Emily Shaffer wrote:
> >> With https://lore.kernel.org/git/20191114194708.GD60198@google.com/ we
> >> now have a mentoring mailing list, to which we should direct new
> >> contributors who have questions.
> >
> > Why should a supposedly "open" open source project direct new
> > contributors to a mailing list that is not openly accessible, and even
> > reading and searching its archives requires registration?
> 
> Haven't we had that discussion when the mentoring list was launched?
> 
> I would not prefer joining a closed list of unknown people over
> coming up with a fake name and asking for help in an open list if I
> had choice when interacting with an established community as a new
> member, but I would understand it if preference of some people are
> opposite from mine.  The more important part, from my point of view,
> is that we offer choices (the proposed doc update illustrates
> three).

I remember a discussion about whether that list and its archive should
be open or closed, and I agree that offering choices is good.
However, since that mentoring list requires registration, we have to
carefully consider how to present it to newcomers.

Openly accessible knowledge is a fundamental value, and it's the
foundation of open source.  Therefore, we definitely should not direct
newcomers to a closed mailing list as the first option, it can only be
a fallback.

The text should list git@vger as the first option, since that's the
only open mailing list we have, it should clearly emphasize that
newcomers are very welcome, and should explicitly encourage them to
post their questions here, no matter how trivial or silly they think
those questions are, we'll be always glad to answer them.

The closed mailing list can be mentioned third as a fallback for those
who would prefer not to end up on public record right away or who have
any technical issues with posting to the main mailing list.

