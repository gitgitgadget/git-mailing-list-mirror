Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8480FC433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 15:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4206621D1B
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 15:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgL2Por (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 10:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgL2Por (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 10:44:47 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6FDC0613D6
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 07:44:06 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id a13so6499623qvv.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 07:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GJN9MZu8z3UV9JHf20xtl0wdZxy0NjjQm4tyFUYcpM=;
        b=U1mK3wgrdWk33wikNk9ehGX3Ok69VLIV+OkrE+CKo/gjkPNbxh5uDBaHjaWIsd5B8h
         CaJnysSOkHvz/ZIUOwB9hIWMaOwnzVKeZ2jSeQyNyQYDnZ+Ga/ooNWipGpIXWOBbrcoe
         q8SOLGBgZgIKxeULPXbL165sOuw7XUvOsTmR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/GJN9MZu8z3UV9JHf20xtl0wdZxy0NjjQm4tyFUYcpM=;
        b=TIEiX+ux7eYk5eErGHjCUr1BEB2CDH4U7uiY4xBWLXqpVt5FEmGKpKddTSekAGOkET
         O9PeE9mvNia+uCgIx6PHcz4HozXDPPcz+l9FC35rEkJsvREQbGNB0RQx7fHCeB1hBzfO
         Df8w26lf38CZ1/hG6sFmsrR8NuNfWxzhAFBalxqq4nsMpY8imV7+40RWGc1fJny8m8rx
         IN/toIEl1q1Xra52WkO8bvxbT3LLSWhWBS/uR2qb5RbYVoLnALxkrHM4AeRpVkr0BNot
         G2flBkHhBQvcTHvVrUqxEsk0CFsMARjNp24J6Xr/2HYvXwYFlhz3M4gv2Wv7zEGz95NR
         Exhw==
X-Gm-Message-State: AOAM532cMEVDcnPmjsmKe/qhcKgY3k/N0kjRlV5clTBdTuqna9FOL4IX
        zljvbewUlg/aiSSqWQnDWcLMHVCeEi+xyVcG
X-Google-Smtp-Source: ABdhPJwd0rALTbXnZgDTL0Gz0knaX/ZvAROZPzONRscJlkMAAlpn26uPdE0hp/RDwoc9pwkw+c2yZg==
X-Received: by 2002:ad4:46e7:: with SMTP id h7mr52540395qvw.44.1609256645761;
        Tue, 29 Dec 2020 07:44:05 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id y10sm26208470qkb.115.2020.12.29.07.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 07:44:05 -0800 (PST)
Date:   Tue, 29 Dec 2020 10:44:03 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Stefan Monnier <monnier@iro.umontreal.ca>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Destructive access to an "objects/info/alternates"
 repository
Message-ID: <20201229154403.xutnk2aoawdrjfwx@chatter.i7.local>
Mail-Followup-To: Stefan Monnier <monnier@iro.umontreal.ca>,
        git@vger.kernel.org
References: <jwvpn2tdb0r.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <20201228190036.vnkgeu6puxmvgt5s@chatter.i7.local>
 <jwv8s9hd9cg.fsf-monnier+Inbox@gnu.org>
 <jwvlfdhbsbs.fsf-monnier+gmane.comp.version-control.git@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jwvlfdhbsbs.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 28, 2020 at 03:17:01PM -0500, Stefan Monnier wrote:
> FWIW, I just tried it with
> 
>     git clone --shared ~otheruser/nongnu
> 
> and got the same result.
> I also tried with another repository, still with the same result (tho
> different pack.idx names, of course).

I've tried several times to reproduce this, but I am unable to do so. You may
need to provide the tarball with ~otheruser/nongnu contents for someone to be
able to properly debug this.

-K
