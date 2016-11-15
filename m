Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BDB12021E
	for <e@80x24.org>; Tue, 15 Nov 2016 17:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934108AbcKORnb (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 12:43:31 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35939 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934003AbcKORn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 12:43:29 -0500
Received: by mail-qk0-f182.google.com with SMTP id n21so144351517qka.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 09:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wQZq453kMzDyrMkLzbQzsojuJfZ+c2WQK3xYnCj6y2I=;
        b=M1JdgFG9vpZyMg6nR0axBihzlF1ayxnsG0+SoNlWSO51wt0z2xVW2rEOmebDIXmPkM
         4yvWKdms+S8Ge7i6C8n5fmQnTDkpAXmlcpOI8n5bFQLvyzmCOA/HB0u6SxAfQvvXxJGW
         CX0+4h/EdDmZd5DaXCObI7y2U5L1MS+vTD1nWaFqrAMD5S9919HYDr7t186w1kaj/Ll+
         FOpTTu5R3k2hoUL4/n1K+TFuHzgjSNtl2NH7U3NJFjA2rSgqnnRYacL+yJ8G9jYwD6I4
         wjKq36CpDkFTHg1RJri1vVoaDq5PeYenyM68rGh6GRopw4pLF0fd2sijg+JUAUjWKa3+
         5hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wQZq453kMzDyrMkLzbQzsojuJfZ+c2WQK3xYnCj6y2I=;
        b=AoaePG6nk74GgwhgDioqBQcC5thdiSfDvXXb7gpKqJcds2owSG0UZUiEQyguemBgK3
         QLl5rZB4BLi+YpnxY820oYjHm2rWjXok+3fPzqCUz7+yvlAEnjKxxeRXQwBQ38GuzOjy
         c7K2ogvqmL8bZXm6NjIjTR5apDqeAKSWj88Cqbw1lcxC+rQ8FmtjVKZ2+xI8jEXjO0MI
         m4kXEGbMqPpEgizMy6tgVpP8wCOg1J9Mspdqx3gUTOPzZx28ugAa5kXJPWXhIrpMrsK4
         QSnyW34hB+yNRFO09DuQiUTIbHLcwtRtVjZvQWZXEHAvTPCRhmxGTJYhbVBjWo6fYkDD
         bITw==
X-Gm-Message-State: ABUngvdQ6syRFGWVEcM7pZsSKiA3zDElWkijcjRxOBaPMkuDouDvzZx0aVsJAEXxp/vI7yGa8sKPhCtAgZLPMRVC
X-Received: by 10.55.20.164 with SMTP id 36mr22895455qku.86.1479231808351;
 Tue, 15 Nov 2016 09:43:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 15 Nov 2016 09:43:27 -0800 (PST)
In-Reply-To: <cover.1479221071.git.hvoigt@hvoigt.net>
References: <cover.1479221071.git.hvoigt@hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Nov 2016 09:43:27 -0800
Message-ID: <CAGZ79kawQOO98GFYZBnUhN_A8jKDVopTDHMjsM=rrG_5ekyidQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Speedup finding of unpushed submodules
To:     Heiko Voigt <hvoigt@hvoigt.net>,
        Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 6:56 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> You can find the second iteration of this series here:
>
> http://public-inbox.org/git/cover.1475851621.git.hvoigt@hvoigt.net/
>
> All mentioned issues should be fixed. I put the NEEDSWORK comment in a
> seperate patch since it seemed to me as if we did not fully agree on
> that. So in case we decide against it we can just drop that patch.
>
> Cheers Heiko
>

+cc Brandon who started building a series on top of yours.
