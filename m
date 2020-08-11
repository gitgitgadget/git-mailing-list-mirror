Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CD2C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D6A206DA
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ScLu3M1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgHKTBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKTBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 15:01:42 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E5BC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 12:01:42 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cs12so6512997qvb.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7PkWVw8afdlxaQe0Bcy1J9bE1lILmttoKnFeLAg7rDQ=;
        b=ScLu3M1lNpihlAT+HKBdU98aYNDO8OnYzBUIV5JZCO4ZfGu/xwspjyj2NTFQgKm2uc
         opmrlqdn/fDPlkEFQ9ZTXpVwr/Se4623g+iFtwz+pfIN+Fbeft6rFOwecRVizsYKTbHn
         e01XW5SNRZ4v7oQnYqLKLA66j6TlNJNnr8EzwiJGzE//AM5PLMDyl/6WmhDz5p5VsmlU
         ENsnSLKwhsSConOn+bXUrRsOjxaytJapmQLkJjBwXRf3ah9ObXFxevfBG+/oeXTalRrB
         yrvdDWU7c4r3mZPaoOUjcKnNSzwzG1kiHSnYM8deA6rdMSTmj6Yfz/SvCGWz6sNDjYO2
         9wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7PkWVw8afdlxaQe0Bcy1J9bE1lILmttoKnFeLAg7rDQ=;
        b=eXCG2MyhdJ6gYwVVwWwrqkdYRQYpr7SwJEewIgqy8lhchZhm7wBeH6ELiTGeb9RRej
         4tNLb76+0B3FIAmO9frqfdZE7Izixl09Y1b/cSAFytYrRZYNK1ShXo4WUWHsC6/yLqew
         GPLTpcE2QG3oP3ExDXX5qNRfUJG6/kqhqNK+0Rfq8GCT92eVTDsjZs5i9Xq+rfLYZQoZ
         n565wsK0527aMvKXQBkiH71aXLafXP+o9gpAE9Ky47+pKg0M5PRyjSc9m+nAaC62Jd0g
         3fcQU4LV/vBCzPbxwvEmX1Cn0afy5w7NOF9ol50AEBPB7NMWygNV3mN6wYOdVPYOWqpt
         rHTA==
X-Gm-Message-State: AOAM530op0EgwTvojGzZpG9iDQ9n8EcCXv0Tl6brFN4e5ZTUaGsPzSNS
        1EZ4cJJFjmY1+IRlrD7mFJTPnw==
X-Google-Smtp-Source: ABdhPJyqUSjqtFrboZexXjWycA6VIN5yog1cubCds479Zh8frzMHwVauAs6RuCxf6yfQxyBg2/5/Rw==
X-Received: by 2002:a0c:b51c:: with SMTP id d28mr2839651qve.71.1597172501731;
        Tue, 11 Aug 2020 12:01:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id p4sm17718786qkj.135.2020.08.11.12.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 12:01:40 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:01:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Antti =?utf-8?Q?Ker=C3=A4nen?= <antti@keraset.fi>,
        Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>,
        git@vger.kernel.org,
        Jussi =?utf-8?Q?Ker=C3=A4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
Message-ID: <20200811190139.GB34058@syl.lan>
References: <20200811131313.3349582-1-detegr@rbx.email>
 <ebdc0bc7-f48e-9f38-328d-b1181ac974d7@gmail.com>
 <20200811153621.GD19871@syl.lan>
 <20200811181537.qt7jkoxy7qn3k7mo@haukka.localdomain>
 <xmqqsgct9fi1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsgct9fi1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 11:58:14AM -0700, Junio C Hamano wrote:
> Antti Keränen <antti@keraset.fi> writes:
>
> > On Tue, Aug 11, 2020 at 11:36:21AM -0400, Taylor Blau wrote:
> >> Ack, I noticed this too during my review, but apparently forgot to
> >> comment on it. I'm puzzled by the first '..*'. If you're searching for
> >> any non-empty string, how about '.+' instead?
> >
> > That's true. Good point. I pretty much copy&pasted the 'todo count' test
> > so I didn't give this much thought. I'll fix this.
>
> Please don't shorten ..* into .+ if you are writing a portable sed
> script---stick to the BRE.

Sure, and sorry -- I didn't know that we cared about the difference
between BRE and ERE. Do you prefer ..* over .\+? Both should be
supported in BRE, if I'm reading [1] correctly.

Thanks,
Taylor

[1]: https://www.gnu.org/software/sed/manual/html_node/BRE-vs-ERE.html#BRE-vs-ERE
