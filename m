Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAC9C4BA18
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 17:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4369520801
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 17:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2vB4vxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgBZRlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:41:21 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39357 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgBZRlV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 12:41:21 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so1540367pjr.4
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 09:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zCJ72VuXEdHcFl4ntHp74JNzuyP/X5RiccogN8pJ0uI=;
        b=c2vB4vxYaxmq82TxpEzc2P/bm+UyDFtnhnZOgesfij5i1A+PPwtf4nMMefk6m2quJI
         KNqOhsFzluOPYUQDSmrG0Q+AEyQQ3q72AiHDNa6qLmiHiDGRTTYbtat6z6qzQQRzTsiH
         2KuZCwsDrig1at1R5qRl7unTIavC9EuEXl8t4H0WJ/u/I+DtG7288jIBKgaEzwPeznaK
         GEkyCqYlOGyOw8xhCv6T85NyImiucqb6FVkIAYS9p14wJkYJwPCpA47sF/BZQSKqzrML
         M/3w/+4LryAl80GdVpC7s0ZtMh99uzPf4PD8CQLZEIUafuU0ZoiB4Qh/5m7ubJuq9EuU
         qDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zCJ72VuXEdHcFl4ntHp74JNzuyP/X5RiccogN8pJ0uI=;
        b=JqgKjeJ6/3xdVE5LcdcJTP7rJ2hFe0WCd6TOKwm9gv6Hv+5czp5wfvmc4z8Opzwlgu
         YcI0+SvErnXVFeFaokYXV+PL8YcZtJus2G+J6bel/iBzEBW0qferV46h8ovgAamWqUZ9
         PtDUSxa8pM0a+Zg9hybloFINjdxMalcxqAgXcmj8CzoWLwjWcngmk2FMUSIQk5+7xQjh
         Z9nxkVkAO1ahMWS8c8l63J07jhAfyUcLm4XWgKL4qUIB6i2Z0KSwuWp8M5mcbqMAnv2T
         ocmnoDmTYPC/YuT9BA1Zl1+8CYYda5I1GZhIlcsKFovvPaLXY+dYgu3+buG1JaKbV7qi
         MfQA==
X-Gm-Message-State: APjAAAUK7K/wF/efJTxK33LDREB5UffYJFkVoEgIruck+C/1jxEadb9C
        7eC3BMAfPj2ueOVQecaCl77zCtvH
X-Google-Smtp-Source: APXvYqzW8pJw6FthGXDjw8frkJ3sew+edFRUObGCNoexS2WIYip/amC1zX54ATATLWQR03+i56CyCg==
X-Received: by 2002:a17:90a:cb96:: with SMTP id a22mr223477pju.96.1582738880453;
        Wed, 26 Feb 2020 09:41:20 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id k1sm3707669pfg.66.2020.02.26.09.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:41:19 -0800 (PST)
Date:   Wed, 26 Feb 2020 09:41:17 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v6 0/5] Reftable support git-core
Message-ID: <20200226174117.GA103006@google.com>
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
 <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
 <20200221064026.GA11129@google.com>
 <CAFQ2z_NQn9O3kFmHk8Cr31FY66ToU4bUdE=asHUfN++zBG+SPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ2z_NQn9O3kFmHk8Cr31FY66ToU4bUdE=asHUfN++zBG+SPw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+Josh Steadmon, fuzz testing specialist)
Han-Wen Nienhuys wrote:

> You have convinced me that we should go with the 4-byte identifier.
>
> How about setting version=2 and extending the header by 4 bytes (which hold
> the 4-byte identifier). The footer would also be increased in size.

SGTM.

> BTW, could we document that a reftable consisting of just a footer is a
> valid table too?

Yes, SGTM as well.

Do you have sample reftables collected somewhere that you use for
testing?  Asking since that would help us set up some fuzz tests. :)

Thanks,
Jonathan
