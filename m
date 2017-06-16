Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F0B1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 21:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbdFPVzg (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 17:55:36 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35801 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdFPVzf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 17:55:35 -0400
Received: by mail-pg0-f41.google.com with SMTP id k71so25424724pgd.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Cvg7MzLf3G3oLJIR3DnU6SffQDbvPxiDyOBorayHl+E=;
        b=IMqiWPHgrNJjAKPAOMh3rteb0Wngem3sPF7GN0rw4cIdmx0/yRbpIaRjwx1ceHfYU0
         HQgriU1KoRe/rMsu3wzAZ/TqxyVKxzqCPrbnQfC5mZ+t4EjDgWMZkkhHYWveiVMu6+A5
         zOw5fuKENAq9/RVhAEfezZJTdp81a4Z4HodHubZ969jj4SO4QLXwfYZYTI47J1Y2dx6A
         WYRVo0gfRKvxCp78cRokRXrMDH2YWejbJR+iVIN88LWFUw4P1hQYC8YfvUDd4s4H45mA
         s5RhFId91SgLF5K2itu/HdxXEA0puAUYYcHXGPGM2iu9yP3gOMu14awbRaNGS36mV/Sb
         V5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Cvg7MzLf3G3oLJIR3DnU6SffQDbvPxiDyOBorayHl+E=;
        b=eSNto3tMiDzDTAYyX4dkuBSYz35J4V0dHC4zvfzo3fE1xwFO102/DMbcPNz1/Os+5I
         fGfZHQ4Em1BNPzyFw4dFSdgsFswuMZSKlMisu7Q9b1ZUjxzIl7/9DfVwJXJI2SaE9e7O
         K3KZSIuV9h3LkWOFu6xlb+NvFrwECMkqF329pvlkv5dkKWZodsEdEQ3L7RoxRP4cxjlN
         yugilvpdNr9MmhUnLIEf762E3phwSNpvOIcNGbzWNrQASBVx7R2deu1Jl+RmI+syFRm+
         wSkqFFg681KLGpq0S4CRkR4NOrWfUbXlWQPUmmkLI3KONHTJPcIhxYHCUyXiBIMmLScz
         O5Dw==
X-Gm-Message-State: AKS2vOzy0w+aTPpiylTaVt5hXAvr4k2S06YVta5HC6nFt1DbfLIqZO3Z
        xsMvz2zcvv2fnA==
X-Received: by 10.84.238.137 with SMTP id v9mr15713007plk.154.1497650134613;
        Fri, 16 Jun 2017 14:55:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id i186sm3162157pgd.55.2017.06.16.14.55.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 14:55:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/5] remote: eliminate remote->{fetch,push}_refspec and lazy parsing of refspecs
References: <20170616192837.11035-1-szeder.dev@gmail.com>
Date:   Fri, 16 Jun 2017 14:55:33 -0700
In-Reply-To: <20170616192837.11035-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 16 Jun 2017 21:28:32 +0200")
Message-ID: <xmqqa857wqay.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> 'struct remote' stores refspecs twice: once in their original string
> form in remote->{fetch,push}_refspecs and once in their parsed form in
> remote->{fetch,push}.  This is necessary, because we need the refspecs
> for lazy parsing after we finished reading the configuration: we don't
> want to die() on a bogus refspec while reading the configuration of a
> remote we are not going to access at all.
>
> However, storing refspecs in both forms has some drawbacks:
>
>   - The same information is stored twice, wasting memory.

True (but a few hundred bytes is nothing among friends ;-)

>   - remote->{fetch,push}_refspecs, i.e. the string arrays are
>     conveniently ALLOC_GROW()-able with associated
>     {fetch,push}_refspec_{nr,alloc} fields, but remote->{fetch,push}
>     are not.

This is a more real issue.

>   - Wherever remote->{fetch,push} are accessed, the number of parsed
>     refspecs in there is specified by remote->{fetch,push}_refspec_nr.
>     This requires us to keep the two arrays in sync and makes adding
>     additional refspecs cumbersome and error prone.

You haven't told us which way you want to dedup.  Are you keeping
the original and removing the pre-parsed?  or are you only keeping
the pre-parsed ones?  As long as you want ALLOC_GROW() ability, you
need to maintain the invariants in three-tuple (foo, foo_alloc,
foo_nr).

>   - And worst of all, it pissed me off while working on
>     sg/clone-refspec-from-command-line-config ;)

Your feelings (or mine) do not count ;-).

I do not think we would terribly mind if you only kept a list of
pre-parsed form, with some mechanism to keep an "error" entry in
that list with its original, so that an error can be reported with
the refspec as the user originally gave us (which may mean the
"error" entry may have to keep the original form, since it wasn't
correctly parsable in the first place for it to trigger an error).

> So here is my crack at getting rid of them.

You still haven't told us what "them" are.  Parsed form, or the
original?  Let's find out by reading on....

> The idea is to parse refspecs gently while reading the configuration:
> this way we won't need to store all refspecs as strings, and won't
> die() on a bogus refspec right away.  A bogus refspec, if there's one,
> will be stored in the remote it belongs to, so it will be available
> later when that remote is accessed and can be used in the error
> message.

So normally we only have a list of parsed ones, but optionally there
is a list of malformed originals that are before attempted (and
failed) parsing used for error reporting?  That sounds sensible,
especially given that we can recreate the original textual form from
correctly parsed result (which allows us to report on other kinds
of errors as necessary).

> This applies on top of a merge of master and the fresh reroll (v5) of
> sg/clone-refspec-from-command-line-config:

Thanks.  Will take a look (but not immediately).
