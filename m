Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A52AC433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 15:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7457A2078B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 15:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgIAPUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:20:33 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33978 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbgIAPU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 11:20:28 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BgrNn1r9Qz1rtyS;
        Tue,  1 Sep 2020 17:20:24 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BgrNm6ZbPz1qv2D;
        Tue,  1 Sep 2020 17:20:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id HBPURUd-3K64; Tue,  1 Sep 2020 17:20:24 +0200 (CEST)
X-Auth-Info: dLPheYq6pUXVGsUwsfoiwfGwjxXoRb7f1Z06yF9QVGeeMy0k3TEO/KPlxvEXyqga
Received: from igel.home (ppp-46-244-164-241.dynamic.mnet-online.de [46.244.164.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  1 Sep 2020 17:20:24 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 8A42B2C28DB; Tue,  1 Sep 2020 17:20:23 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] xrealloc: do not reuse pointer freed by zero-length
 realloc()
References: <20200901111800.GA3115584@coredump.intra.peff.net>
X-Yow:  You were s'posed to laugh!
Date:   Tue, 01 Sep 2020 17:20:23 +0200
In-Reply-To: <20200901111800.GA3115584@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 1 Sep 2020 07:18:00 -0400")
Message-ID: <87o8mp8qx4.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 01 2020, Jeff King wrote:

> diff --git a/wrapper.c b/wrapper.c
> index 4ff4a9c3db..b0d375beee 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -120,7 +120,7 @@ void *xrealloc(void *ptr, size_t size)
>  	memory_limit_check(size, 0);
>  	ret = realloc(ptr, size);
>  	if (!ret && !size)
> -		ret = realloc(ptr, 1);
> +		ret = realloc(ret, 1);

Since you already know ret == NULL, you could just say malloc(1), As
written, it looks like a typo (why use a variable to pass a constant?).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
