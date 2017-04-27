Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3D0D207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 06:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162178AbdD0GkN (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 02:40:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33698 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162175AbdD0GkG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 02:40:06 -0400
Received: by mail-pf0-f196.google.com with SMTP id c198so6780340pfc.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 23:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7rUfo5q5e3B7TKYDvF1MjldZvdodsQN/w70JmsvOk8I=;
        b=to3SzVeUAz0XQjz3eDGLVYWeuKoO+TDVbLKauA1mWiZWlY2ePPAzv9iZxYUmKbw+qw
         DBwpNhC0mOGxHGtpY9z51QSztKmS/NRf3qXYyytnYs9IofXoPJMgpBmYcDMyG/eYtaUz
         YPXCCKh5D8skmm/ojzYhAtREQ3wBCXnk/dU/zHD5biSaqiIJaBl7647qD/8PEKtHnast
         Pug2JNXcyKi3RPMSzQ0HknH04Q1qTBHSFb3jTSSmFmNmMNg2UGo2yj5WqSTQeXS0Uc3r
         D5CIbOsbv9R2Zlomp2ezdZSIXTPSsPF/olIbDw5+upNiA4jlYD+TwI9jvKyR7ODMixTz
         ybzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7rUfo5q5e3B7TKYDvF1MjldZvdodsQN/w70JmsvOk8I=;
        b=UDtFlnL0gnSRWvZSjPK4YxD9SPdUJolBEYvY3ZU9gsB8krwO5paQV80Y3ZKOFbNvkP
         Mrfbo1Nog8bHmCXdnuTbxFdWKX7Pa60ZcdQ28dX5zEjATWcowNEz+F/amvdqjFcE8zZ0
         h17f3Ezxk3KMXTwgMarz39g9WLYSYeeBQwDYZalPZzDlbnMhthabHSUBEeuVTbnSS6Jo
         utOVsg2USrJn/q+RBd9P04EVF7n3AM7byg7nTd0s+cZqxy3BpThouxKnmIld10ETrGNL
         pO0ZqMDVN2KNYIPyCaOD6gETh8tEA9vQhHC1r1aPitAPr5bGP9UHDJ4vQfog0MM02nay
         Yr7g==
X-Gm-Message-State: AN3rC/5b6i47lCk883SlBJN4oxiIVZZ4CM2+AyCHKhTwWPcBYbzFh4/H
        R+2XhjXbgKJF2VI24/Qmhw==
X-Received: by 10.84.195.129 with SMTP id j1mr5087793pld.88.1493275206036;
        Wed, 26 Apr 2017 23:40:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id l85sm2264841pfg.123.2017.04.26.23.40.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 23:40:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 12/26] checkout: fix memory leak
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <be7ff5f9b303bb42f0d2a6c8f144bcc8342450cc.1493237937.git.johannes.schindelin@gmx.de>
Date:   Wed, 26 Apr 2017 23:40:04 -0700
In-Reply-To: <be7ff5f9b303bb42f0d2a6c8f144bcc8342450cc.1493237937.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 26 Apr 2017 22:20:27 +0200
        (CEST)")
Message-ID: <xmqqk266mjzv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Discovered via Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/checkout.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index bfa5419f335..98f98256608 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -251,6 +251,7 @@ static int checkout_merged(int pos, const struct checkout *state)
>  	if (!ce)
>  		die(_("make_cache_entry failed for path '%s'"), path);
>  	status = checkout_entry(ce, state, NULL);
> +	free(ce);
>  	return status;
>  }

Thanks for spotting this one and fixing it.  

In case anybody is wondering what the "only to leak" comment before
this part of the code is about (which by the way may need to be
updated, as the bulk of its reasoning still applies but at least we
are no longer leaking with this patch), back when this code was
written in 2008 or so it wasn't kosher to free cache_entry under
certain conditions, but it has been a long time since it became OK
to free any cache entries in later 2011---we should have done this a
long time ago.



