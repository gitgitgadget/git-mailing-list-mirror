Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9147D209FD
	for <e@80x24.org>; Thu, 25 May 2017 23:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163149AbdEYXdx (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 19:33:53 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33771 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161768AbdEYXdt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 19:33:49 -0400
Received: by mail-pf0-f176.google.com with SMTP id e193so180672420pfh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 16:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9GLJc7WJ81fVWnwcCXbiXF2sRY8y+X9yZb1x2ynNlV8=;
        b=hCINl78JyAVa+klI40DB3T1Bo0FcW4jqA50G0jl6l9PTb88sT0JGKfesA2H9oN4t25
         sSjxFw3aIRuv/tjtdsZx8vJn6X8CvgZpprmYB/vW0hy9DLZg1TGWSChhWByn4TjM1+ni
         jOTPzZ7YGYs4gx7xUkJQrPz0gHbVCI+4lISfGmPAS9R8lAj8UQ/a3aaeQrhtpTqVKvIO
         OGAhPW5WAOAfy1ZJrNWngV1e6/JrCit02QpXZjLTBL2pnu1+TFxNEawRDyWoEFY7HMR7
         XT2C8f0t+XsUoF0phr75vN5CX45xtagdPFuPQcmKhht4RI4rvbxAsEj8ct75l/U0aE/d
         /7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9GLJc7WJ81fVWnwcCXbiXF2sRY8y+X9yZb1x2ynNlV8=;
        b=t4ACpte+Fp+hTmipnjoaxCC/4HVwU4oJc8YOV5QLYMZ1P/JKFrruSNXUMmQhb51mOK
         iRHEJNDHRy/u/ZEsbiPYYPUIpgXg4Qcp+68UB8S83Sri1nWBZV830ImTbdVdLaNT062s
         4/aGp+KA0FNpMQ3/5N+EiOqg2qkpUFRlSEEJL+S4nmJAZqoGdHosabRokQV/nOOkb5jU
         DCRP7utASyJPytdbUEIHMriYRtnYdoKa60Xcb0FTagbbJwEGO1Bf4FvNQ91poQ/wAhqZ
         +Qzs8jP6QpZosiMFk26CsgJzsyY3/kL3vbaRRCw9sP81UwKk8GjHu2lM9H2tmkfazrxv
         QHZw==
X-Gm-Message-State: AODbwcDepr+wgalAP2Vq2y4ihnmqmPlN2XMbIiEuAZOynFn72ez7sFmf
        A/Ehc3z+8ESmVQ==
X-Received: by 10.84.194.165 with SMTP id h34mr53066008pld.65.1495755228209;
        Thu, 25 May 2017 16:33:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id s82sm19232276pfe.57.2017.05.25.16.33.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 16:33:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Tyler Brazier <tylerbrazier@gmail.com>, git@vger.kernel.org
Subject: Re: `pull --rebase --autostash` fails when fast forward in dirty repo
References: <CAAZatrCaoB7EXVrCvC9RKmO02G5xcp8GPBaJefHfv7zAXVpL3Q@mail.gmail.com>
        <20170523131231.zqjkymypbilv6tyf@sigill.intra.peff.net>
        <xmqqa863jiyf.fsf@gitster.mtv.corp.google.com>
        <20170525180407.ni2oed5wk3qsd2ch@sigill.intra.peff.net>
        <20170525182230.552dif62zqxuufk3@sigill.intra.peff.net>
Date:   Fri, 26 May 2017 08:33:46 +0900
In-Reply-To: <20170525182230.552dif62zqxuufk3@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 25 May 2017 14:22:31 -0400")
Message-ID: <xmqqpoewcy05.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Anyway. All this has shown me is that it's probably pointless to do this
> timing at all on Linux. Somebody on Windows might get better results.
>
> But regardless, we need to do something. Correctness must trump
> optimizations, and the question is whether we can throw out the whole
> conditional, or if we should just restrict when it kicks in.

Yes.  I personally do not mind going with the simplest approach.
The optimization thing is relatively new and we were perfectly happy
without it before ;-).

