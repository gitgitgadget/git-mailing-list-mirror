Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82634207FF
	for <e@80x24.org>; Thu,  4 May 2017 04:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbdEDEWZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 00:22:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33130 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753463AbdEDEWY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 00:22:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id b23so469128pfc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 21:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EhfJttuTXnJzMiZhgFQzGt+HL/JBzrKSct2SeTjBxOQ=;
        b=lSYSY1GX81/Isrt0RCo8IVFz7rH/3rrcPJpi+YeAK87WbQLnlEMNp3ToZwZTBBh1Qt
         3mHGLMhzGtAb5vELb/Bh07LGyaH2b5NCTWrOcAcsjrMA3Jet9PEgngqEopp0DnkXE+Gl
         S1ZdxeDRMFM3sSeGxaMhHPPmQtlWgvMGtp3TpZrO5LiAHSC/Zjf3s2qgSkOE7FDb34A5
         hLmqM77nTbwi6uKClWWRElV3UfLfInSt+DVwdmZMNWhOEoYFZGKZMrTHs8BkI16bJTwz
         rs7kHBlsTzM5Xrd+U6O/QdPFOInKj679I4VOHsg46uRIe6bUdUezV3cWgsyFVjjDvpeV
         cUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EhfJttuTXnJzMiZhgFQzGt+HL/JBzrKSct2SeTjBxOQ=;
        b=qTl2vmqGg6Cr9awRDhu4oSgSvpwiiVbsQtcTrAb8i93djfzKrteJ2kK7yTvKYUJT9A
         atqxCnPutEaRHRnm/PqRidaIdhe7AqB4pFL/RWCyVeDspCVasWKB7SmyrxqTQc6YPQYf
         XCUXjXMId8F8lUiL1iKFTnyytNqUMOfO4t1PxmwO//XchX7fXjLA1oqMkh9S/fRnQSmt
         prg5IjdOfwShWOiqwV4ITFvu3lD2/Hcpb4q4Mt8H1KI4wEPOaYKYt4FelhUXIZh0fI7y
         KqY0SpKt2yl52sc0XLBpQcj0vBrG6y3BFwrhELz2+S3Pe5BppPW683YtvIGZktCah/PF
         QrPQ==
X-Gm-Message-State: AN3rC/5Q8mlyF50t/RcrzEUvytcTdyXbCL/bh8/5yk1ydH4IKJzlilDF
        lUQqsdFeA6MJew==
X-Received: by 10.99.113.75 with SMTP id b11mr42387027pgn.173.1493871743301;
        Wed, 03 May 2017 21:22:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id b8sm1074568pgn.51.2017.05.03.21.22.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 21:22:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 23/25] name-rev: avoid leaking memory in the `deref` case
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <cover.1493387231.git.johannes.schindelin@gmx.de>
        <9e897d6f263bcf9a2b2bab613946fe1bf452eb91.1493387231.git.johannes.schindelin@gmx.de>
        <xmqqd1bsdjmw.fsf@gitster.mtv.corp.google.com>
        <xmqq8tmfexg6.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1705021433060.3480@virtualbox>
Date:   Wed, 03 May 2017 21:22:18 -0700
In-Reply-To: <alpine.DEB.2.20.1705021433060.3480@virtualbox> (Johannes
        Schindelin's message of "Tue, 2 May 2017 16:00:44 +0200 (CEST)")
Message-ID: <xmqq60hhb69x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 1 May 2017, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> >
>> >> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> >> index 92a5d8a5d26..a4ce73fb1e9 100644
>> >> --- a/builtin/name-rev.c
>> >> +++ b/builtin/name-rev.c
>> >> @@ -28,6 +28,7 @@ static void name_rev(struct commit *commit,
>> >>  	struct rev_name *name = (struct rev_name *)commit->util;
>> >>  	struct commit_list *parents;
>> >>  	int parent_number = 1;
>> >> +	char *p = NULL;
>> >>  
>> >>  	parse_commit(commit);
>> >>  
>> >> @@ -35,7 +36,7 @@ static void name_rev(struct commit *commit,
>> >>  		return;
>> >>  
>> >>  	if (deref) {
>> >> -		tip_name = xstrfmt("%s^0", tip_name);
>> >> +		tip_name = p = xstrfmt("%s^0", tip_name);
>> 
>> I'll rename 'p' to 'to_free' while queuing, though.  Without a
>> descriptive name, it was confusing to view while resolving conflicts
>> with another in-flight topic.
>
> Good point. I also used `p` in builtin/mktree.c and setup.c. While you
> seem to have renamed it in builtin/mktree.c, I think setup.c also needs
> the same fixup.

Yes, no question about it. I just left it as-is as I saw it is
likely to be rerolled anyway due to other issues ;-)
