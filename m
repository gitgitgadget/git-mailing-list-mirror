Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5061F404
	for <e@80x24.org>; Fri,  9 Mar 2018 19:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932230AbeCITlm (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 14:41:42 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33146 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeCITll (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 14:41:41 -0500
Received: by mail-wr0-f193.google.com with SMTP id v18so10069940wrv.0
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0QG3F8eXF5V40dFfS906vEQ1P+Bq6cstRVvcC1VIcBQ=;
        b=Ml55gJoPjajfYTfQVdjOMzsIz6TAXTFG6WP3se1yHDXIomTa8fx8LurHZ1krT1xt3D
         8x2wtrwEFujxEpqxSPwtN6i+gWLz1/0IeFN7by6HQCwwwVu/r47Zu6HI23ZcAN+NmkGj
         kx5d3IXPPYRIXCNdkyCAPa8DFy+1+iiwhnwp43+MXHJrRwCjsEs8vpMe0byfDne4OT1Z
         r+mESPIovDTPo8x5R2BRmfrgHrL4fILOJa/lo6387T8P99RBGBuQklrkBagNmkuJJnrS
         u84nsukoUTQwbV6hLPGgSaTXgJJoc/o4T9G3a0v8sSEifJsB/BDYGNZierLpyKsoAwVJ
         GElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0QG3F8eXF5V40dFfS906vEQ1P+Bq6cstRVvcC1VIcBQ=;
        b=YjFRM5V6kdwpRJfqAcsqWtKEbECZsyUiXFhubjR1BMZlklNMar/TxqbCpMuJf/KsWw
         NS8SaiR9LCtlnY90uTk5bdJrr7ctn1NhtK5pjYV0fuoQSeL3GS1jaK1ULNtw3EGDnrTc
         1rY5pS7fjX4jdGQYWLUy4pM9a4sz8Lg8EMSp3D1SyMLI25CiFAypVV2xwWEaX1GHd/O5
         hVDjJWfFvNc0cf3kn0zvg9zSS0CFXrAGoBlB9BHv3UXVFlKSgCUyTmHk0PwYRLv09drs
         5DTvRNEwRK1E5IH3sJ8SdqvT4dHsCI+jGnhJpL2YFdqph/sv38Gat3iqSoJ61+lE1Dmk
         YUVw==
X-Gm-Message-State: AElRT7FqJI96rpaANf8mg2i5avMysJMtMH6a4OxomNzdCRd7+yIRbWml
        xfGRq/p5J5oRRjkt9FTw81k=
X-Google-Smtp-Source: AG47ELubieF9Cs2rfBdxgKJivHqswdiTIcaQWmvRtQtwwPvaYJwenoEqLO0ripGMHv8wkZDRSWiRIA==
X-Received: by 10.223.176.171 with SMTP id i40mr10807423wra.57.1520624499653;
        Fri, 09 Mar 2018 11:41:39 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w17sm2116500wrb.12.2018.03.09.11.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 11:41:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takuto Ikuta <tikuta@chromium.org>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fetch-pack.c: use oidset to check existence of loose object
References: <20180308120639.109438-1-tikuta@chromium.org>
        <xmqqr2ouwgsd.fsf@gitster-ct.c.googlers.com>
        <CALNjmMq9gvRzkoYCfXppTVTR5UtvmBZ_4hVuBLB0t7YzR36Wbg@mail.gmail.com>
        <xmqqd10d6ser.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 09 Mar 2018 11:41:36 -0800
In-Reply-To: <xmqqd10d6ser.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 09 Mar 2018 10:00:12 -0800")
Message-ID: <xmqqa7vh595b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Yes. But I think the default limit for the number of loose objects, 7000,
>> gives us small overhead when we do enumeration of all objects.
>
> Hmph, I didn't see the code that does the estimation of loose object
> count before starting to enumerate, though.

Another thing the code could do to avoid negative consequences on
projects that look quite different from yours (e.g. the other side
does not have insane number of refs, but there are locally quite a
few loose objects) is to count how many entries are on *refs list
before we decide to enumerate all loose objects.  When the refs list
is relatively shorter than the estimated number of loose objects
(you can actually do the estimation based on sampling, or just rely
on your assumed 7k), it may be a win _not_ to trigger the new code
you are adding to this codepath with this patch.  I would imagine
that the simplest implementaion may just count 

	for (ref = *refs, count = 0; ref && count++ < LIMIT; ref = ref->next)
		;
	use_oidset_optim = (LIMIT <= count);
		
assuming your "up to 7k loose objects" and then experimenting to
determine the LIMIT which is a rough number of refs that makes the
oidset optimization worthwhile.

We need a bit better/descriptive name for the LIMIT, if we go that
route, though.

Thanks.


 
