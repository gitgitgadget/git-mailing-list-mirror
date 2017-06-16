Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB08F1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 22:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750907AbdFPWAy (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 18:00:54 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36313 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdFPWAx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 18:00:53 -0400
Received: by mail-pf0-f175.google.com with SMTP id x63so27886392pff.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pzlVGAs6+hpFbh7uk/Mx9MGbr1emXwtFeTa+JUJ+H54=;
        b=pB0C8dAY2pN4cLQGt+csnDtTwL/Jg2fIKddLBkJKu10nVWJvdOjkBAJgFupRam5jbD
         Ko6ZZ4uR+dKXZgdNxoHqEKSWfut4HpTIYwGe78pDWc+W9OSK972Dk0oDue6Qi7Bz803b
         Ct+BVcDPGnOTE9LTTqBOIDWU/CgAYyFKAQr+SUAXcbBBQY0csrhvUspWzcPSlBIlueUd
         VK/YWVK0YQQvp6/lozEmmD2LzEItCZZ72nJQ2kWf3mELakA+3YPO3C9y8RrGq/pB3ysB
         axWfZQtecAfaJUVlCjpEq1vC0Gp0zt1ZDdexCdbA0oOvY5pTKxj3K8e3wkgNVIQQsDiU
         MnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pzlVGAs6+hpFbh7uk/Mx9MGbr1emXwtFeTa+JUJ+H54=;
        b=SmbMAjGFfGHf9X1Y/Dx5yApZ2Ckr9jJ3MDprwggYq60JF7XlYqu4Ic/03dgbwLCXHy
         4GFLkKe9FUK98UelLauTtlnIGK0iXdD6l20KmlN6AXG++enrjS0/7PdqJNBLdsKt8+3D
         OldiigaFyBPv662ox38Wm+WI4cr7DzCJaOiVCWVPA13aHmeAmPBebzN2Zs9oow12MQP1
         cFOyHUk6Wb2OVlhvhoDREfOIG77HytJ7QSV17zJn/I/YdyrCXiqkDgt82WEybMO9YpkO
         fLNQR9ARHU41WC3/wLFD2iv3W8h9Za5Dk/Osr0l9sZhIHoBNu+/ehdb0ySdgni5dbnHD
         Yk5Q==
X-Gm-Message-State: AKS2vOySooiMIw7+1t8GZeOUd4eCUFq3TUeq04cHe8iBcxtgiu5o1ju3
        HMyYM4K5GjAgRg==
X-Received: by 10.84.198.129 with SMTP id p1mr15195001pld.225.1497650453213;
        Fri, 16 Jun 2017 15:00:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id n63sm6619195pfa.62.2017.06.16.15.00.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 15:00:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] remote: don't use remote->{fetch,push}_refspec
References: <20170616192837.11035-1-szeder.dev@gmail.com>
        <20170616192837.11035-2-szeder.dev@gmail.com>
Date:   Fri, 16 Jun 2017 15:00:51 -0700
In-Reply-To: <20170616192837.11035-2-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 16 Jun 2017 21:28:33 +0200")
Message-ID: <xmqq60fvwq24.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> diff --git a/remote.c b/remote.c
> index 336db8298..a021decee 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -919,6 +919,26 @@ char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
>  	return query.dst;
>  }
>  
> +void strbuf_add_refspec(struct strbuf *sb, const struct refspec *refspec)
> +{
> +	if (refspec->force)
> +		strbuf_addch(sb, '+');
> +	if (refspec->src)
> +		strbuf_addstr(sb, refspec->src);
> +	if (refspec->dst) {
> +		strbuf_addch(sb, ':');
> +		strbuf_addstr(sb, refspec->dst);
> +	} else if (!refspec->src)
> +		strbuf_addch(sb, ':');
> +}

Hmph, don't we support wildcarding (aka refspec->pattern)?

    ... goes and looks ...

Ah, even when we set the .pattern bit, we retain '*' in the string,
so the above is correct.

The last one looks a bit sloppy; shouldn't it be inspecting the
.matching bit?

