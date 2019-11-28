Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F655C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF322154A
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1+2CmUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfK1BfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:35:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32956 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfK1BfE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 20:35:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so7480648pgk.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 17:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9rAIWW3pX00t6QxMphAulutuEp0e8hGvYM+xrBKkBJE=;
        b=s1+2CmUU12Gs/i8JdYedrM6w+dpq4QB1kNKN5thph0FpgL9bTtySsdNNXsKMdJNhyO
         zRDNZkJBflsHbChKDb9Gbp3ZN9YtzvODcJ89YjTl7cx1MrmADqlLo98tjrQG84dBOS26
         RisZ+mPSSqhx1S+demsf7a2npfA9xReutdOz+HdUXqWmmcsqQRadBRAgjDW266FzRtnL
         YAwXEH8BVGuiAkCE+fgmekxOIca842fkPwS43ayAcLoPdiM1toaE+q3dl7lqUHAC9ix7
         YipOhEaDlb+anktohOO+E5iRGeCKfdKSlJgyBY6BTLOhri6wxir5fZ9A7FjnuS5acJy1
         Y9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9rAIWW3pX00t6QxMphAulutuEp0e8hGvYM+xrBKkBJE=;
        b=kWSaTbeVK7wqWcAqsLEVVp1YFikFXILIYyRL1Gsjg6U5QvV1GQ6bpQDvoPGx4umgGi
         ZwuxKAn1cJHVJOqCnRLUp3e13vEuV6jeHEFQiKPJ3Q7KGeuNlOXsN15/LPmWfaU8b93B
         RT7wgNbRG6WeN9kiYm7szmQCi2GOrQRCscampf5oe7t9u/XNypM1AEenPk+NEfQxQVoI
         z1qyJGeealxc9+BTSdBnNRgqXs3WiHQB5FUBqqzuOyIz+MMy0qCE9GgYJbjA3KsH2PwD
         ws30xV9pKrDDWuXu8XYQg0zYNXx4OcTZPs+Y5AKcmuDKTYPSoIbb5m6XudagEnW33dov
         /DvA==
X-Gm-Message-State: APjAAAV0nHpH8uhsIZpM8eHBgK56Kglx7u1fY7jZDA0o+wzcq5kTrh/R
        79Bet46W1c7zZB830pm75G4=
X-Google-Smtp-Source: APXvYqzNZPtNw8wX8ogoi5cyHpTOlbb5MqIvMadFIS8uKcdKmQgFqcrHRdQsZYWm0d6w7MJCRXmL7w==
X-Received: by 2002:a63:fc09:: with SMTP id j9mr8359634pgi.272.1574904903317;
        Wed, 27 Nov 2019 17:35:03 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id x13sm1113814pfc.171.2019.11.27.17.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 17:35:02 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:35:01 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ruud van Asseldonk <dev@veniogames.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] t5150: skip request-pull test if Perl is disabled
Message-ID: <20191128013501.GB76989@google.com>
References: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
 <20191127112150.GA22221@sigill.intra.peff.net>
 <55d0bcd1-1f15-46ff-42f1-be87eedc2e11@veniogames.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d0bcd1-1f15-46ff-42f1-be87eedc2e11@veniogames.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ruud van Asseldonk wrote:
> Jeff King wrote:

>> I think NO_PERL has historically mostly meant "do not build or install
>> perl scripts", and not "everything ought to run fine without perl".
>> We've generally assumed you can run vanilla perl snippets from the
>> command line the same way you'd run awk or sed (and the tests use this
>> extensively, which is why you have to set PERL_PATH again to run them)

We've definitely held the stance that NO_PERL doesn't mean to disable
perl in tests.  For casual use of perl in installed shell scripts, on
the other hand, I suspect it was more that we forgot about them than
that we had decided one way or another. :)

[...]
>> That said, most of those casual uses of perl in actual built scripts
>> have gone away because the shell scripts have gone away. It looks like
>> filter-branch, request-pull, and instaweb are the last holdouts. So
>> maybe we should be treating NO_PERL as disabling those scripts, too.
>>
>> But then, should we be doing more to make it clear that those scripts
>> are broken in a NO_PERL build? Who knows what happens if you run
>> filter-branch without any perl available?
>
> My understanding was that NO_PERL controlled the runtime dependencies of
> Git, and that the tests require Perl either way. Of course, without Perl any
> scripts that depend on it can't be used, but like you say, there are few of
> them left. I think it would make sense to not install those scripts when
> NO_PERL=1. Should I make a patch to change that in the makefile?

Yes, that sounds good to me.  (The status quo also seems fine to me,
but I like that this proposed approach would simplify things a
little.)

Thanks for working on this, and sorry for the earlier noise.

Sincerely,
Jonathan
