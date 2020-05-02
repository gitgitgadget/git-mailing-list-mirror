Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E62BC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 21:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6359206F0
	for <git@archiver.kernel.org>; Sat,  2 May 2020 21:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slp1mGZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgEBVxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 17:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728523AbgEBVxy (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 17:53:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0483AC061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 14:53:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h11so5138931plr.11
        for <git@vger.kernel.org>; Sat, 02 May 2020 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EuL2bUBfTo7kxXjBkELrnPP5nOTtgqMKMpVfiZZcLgc=;
        b=slp1mGZ2oliXhr0+rhassrMXHXUKlbyCAEldWIkn90ibpjW3yHKExbsTVdu2yMlsAE
         UD45Dt8DrZoR9Xl0XAW57CptMlcx+Wo/ySY7glpZuYCEsNh9sdQxJayYuM+NSIaBFIim
         8zKzNZrRN+1QjG2Ga/u4brXvUtyYXyEFxisQCY21nnhWDTDH8I2lUzbB16uXzFmeGMq/
         1jYFoFk3V4odksuAHBCSZ3+2BtF2ou2Bb3UHE0q0dhFWbKbvLj0g6xu6JVNk6hUWr0aP
         U57DX73HMulL00U6mv7x056+ORYyPLi3ulGOm5/VgJ21jRZsDm8KV3aU2wxqdtoglN4w
         IEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EuL2bUBfTo7kxXjBkELrnPP5nOTtgqMKMpVfiZZcLgc=;
        b=ikZSEr9/cyRpDGYJpGyM9iDf2rOVNf3NdX2nQIRTB1pl80N7Ow7m3DRc+vjuX6x3Fo
         hPzVuutisc7bjCINlRgJL0eFG9OMjJspF5IJOI7P1CSiBJLpLKLytwfsUeveSp8DnhDG
         CNIjgJFLhl48ihbjbsk29EslL4spwWDWOAmaMo43gsdHh/6hXNOsqmL8wDPUZPQIgPOJ
         P+jsfuUwxI/yLWgc6dmbepmbI0O+AzMtlyrw7v8HmVer/o3w8/uP7TQfLdPK7mb7rwzt
         g8Df9qcJjZmJd0sO2sXaBroFs7rVeCAggALHnzIw5rUIIc+givkXvok/8lTmLVb8yVHL
         Sq/A==
X-Gm-Message-State: AGi0PuZhP3T9+bwcVPA1PyX2MszIHxEuJwN0sylgY8b68aw3Q2mPfKYD
        PpOTEEyybLEfa4csTrMovII=
X-Google-Smtp-Source: APiQypJzKFGyn4JF0EeR9XoyPDn6A5SPmwuB2CtjD8tM3CoAETysdL/PLUywGEhsz7ndRVsheoCQ5w==
X-Received: by 2002:a17:902:8205:: with SMTP id x5mr1291549pln.82.1588456432185;
        Sat, 02 May 2020 14:53:52 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z60sm2997967pjj.14.2020.05.02.14.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 14:53:51 -0700 (PDT)
Date:   Sat, 2 May 2020 14:53:48 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v10] credential-store: ignore bogus lines from store file
Message-ID: <20200502215348.GC41113@Carlos-MBP>
References: <20200430160642.90096-1-carenas@gmail.com>
 <20200502181643.38203-1-carenas@gmail.com>
 <xmqqo8r6jc8i.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8r6jc8i.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 02, 2020 at 01:47:09PM -0700, Junio C Hamano wrote:
> 
> What I am curious is if anything breaks around this test if you lost
> the extra "!strchr() &&" check.  I suspect that this test will pass.

correct

and with the strchr I am introducing a regression (compared against 2.26.0)
in cases where the '\r' gets appended to the path and therefore gets ignored
for matching (unless useHttpPath is true, which is not the default)

will add 2 more test cases to cover those, and guess we are going to 11 :(

Carlo

PS. thanks for all your patience and reviewing
