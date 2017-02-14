Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FC11FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 19:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbdBNTfw (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 14:35:52 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33677 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdBNTfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 14:35:50 -0500
Received: by mail-ot0-f195.google.com with SMTP id t47so3366269ota.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 11:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qtvLQ+myvziffgtbQieujMZ8d4TW+ivpURNYGb5Bufw=;
        b=Gpz4FYqzekwnWw9J5y39W0pTtlROhssl1SsdNs4b7NH0tMVA/VRr27DIOP+jbCv4zh
         MM8/i+dY7t+IcPs7E3WE0DpvKkOKs7z0MHxg8RaVhIn7hls/21oO9Z/p2choW+EpB8rh
         xMdq9buQ80ySCHkVJtvfaZFjIZe57uNDzHKocb/yHdUpC12zwEnh3Dc2wbloSFKm/IFb
         apE9+P6ECZ4HI8oAPviylwfZJREIjVuvrXvTGr2Wm/rrovkjl+hQmtQd4G9QiOEalQTq
         aZIdIcGiM5kox5RbK1juGJBwdY1eKM7pIE+BnY2a9+uFVttjHYggSt6YdeSiChfKCClc
         JGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qtvLQ+myvziffgtbQieujMZ8d4TW+ivpURNYGb5Bufw=;
        b=A7BKdsQvDwUeCqVClRiLJnk4tME5gJgp66rCgo+5Vsngxj+z+Oc9qe/FlHhtDi+1V0
         ywa07nOcpDtQZYVO2tSERY2teE3El5vawngpgYS5pw1h39XxaefCQ1VjcHBWtDtf/eRL
         6I1Wc9fQ2iMVO1/xGKANC0+cHhQZyo2bK0WpZCscEUaR9YjJxAd7SWPTvZCEWRGD/e8t
         k7mqMCUOJ4SSs5LhPjxieefk/QSRbtIUA8bu3aOIKzimmYwZ+Mo7pQ+OAHSoiwrrMYCC
         wmjPp0ziLCMtv5bmk7tI1A2XBjjGOKWE0MaEalITki61sxrrxxuUKeQeseRsh03eSBxc
         HDXw==
X-Gm-Message-State: AMke39neg026haUxGOEOpQmi9T/zbiIy66OAvBIpAlkfdrw6OoAuZ6S+e3nI2nP4FYsxsg==
X-Received: by 10.99.251.17 with SMTP id o17mr34473685pgh.103.1487100950039;
        Tue, 14 Feb 2017 11:35:50 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id f3sm2798856pga.34.2017.02.14.11.35.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 11:35:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] show-branch: fix crash with long ref name
References: <20170214154816.12625-1-chriscool@tuxfamily.org>
        <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
Date:   Tue, 14 Feb 2017 11:35:48 -0800
In-Reply-To: <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 14 Feb 2017 12:25:26 -0500")
Message-ID: <xmqqlgt88t0r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This fixes the problem, but I think we can simplify it quite a bit by
> using resolve_refdup(). Here's the patch series I ended up with:
>
>   [1/3]: show-branch: drop head_len variable
>   [2/3]: show-branch: store resolved head in heap buffer
>   [3/3]: show-branch: use skip_prefix to drop magic numbers
>
>  builtin/show-branch.c | 39 ++++++++++++---------------------------
>  1 file changed, 12 insertions(+), 27 deletions(-)

Yes, the whole thing is my fault ;-) and I agree with what these
patches do.

The second one lacks free(head) but I think that is OK; it is
something we allocate in cmd_*() and use pretty much thruout the
rest of the program.

Thanks.
