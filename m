Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CEC41F404
	for <e@80x24.org>; Wed,  7 Feb 2018 20:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932104AbeBGUxo (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 15:53:44 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34760 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932099AbeBGUxn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 15:53:43 -0500
Received: by mail-wr0-f196.google.com with SMTP id z6so2537009wrb.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 12:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NWKWG7AD0ZRVw/39e8wRR950zKVBM1y55ikZD7kNhXo=;
        b=jHiGdfPc+96L8gP3Ji0x5/cu6CUMFKHWLs5PvGD3hNki8u+PHsIjw8e36XaLVJans0
         1AvT7nrfKZ6vSdR0GRcba5og4k7hnmGExbrPVXt328Rjt7qFLMUB9fiFv/MKArFGQu+Z
         tAyWYPZSjcTqugvjM/ZeDko7BHKahFEx+ymICewLxyW+nu/+8B2UR+ppWF6BVDESJ2gY
         i3Xfj5ZyqJepDVjw/4UNJJvpUmwiv+DkqgMnfvg34vXfF4MsrSKdoevwyuJVAM9X9nJB
         EY1TNjQ3AlYd2DqCQgcc9ZGB+lbgeoSwa/MftNQNkxNQ0MwfRBYZkxyFpDRli/swqKna
         JrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NWKWG7AD0ZRVw/39e8wRR950zKVBM1y55ikZD7kNhXo=;
        b=PVvzRXu5CbZ7qcLh/uSR6nxzbgczaoOTKKGN6PT34ZlwjKfbdIpJ69+0rJwhY7168W
         DG3YMlPKWO3R9dFHaRSZz8Duins5uBC5j2jvyfrwU+pur/G1pqE3kkDfPPJ9bnHgJ2v+
         S0zCKpqTYNCgOPJvyH3T63y+zutbysGoAFportNTpmqjru2bJuHDSeHbj3ULk1H9DB6N
         hBOYnGO7mxwX9qZeKqX+ME0y/cLZ4FEHQ5MnFsM0mgfLmVeYlWkzX+oMsW5y1shF1Cu0
         nG5C7C598VL2EQ6vpqfOYIn5hKa4BKsuHQeYkVjtFdxdrmN14DiIr1FETz/G08yTZJlp
         8rww==
X-Gm-Message-State: APf1xPBr/cuYRY2klQZEGbr6OZX2khhgusyVha6SJxSGX5SXZOnt2vOJ
        l+UtTcbnd05y/mmdFmkgC5TroyxD
X-Google-Smtp-Source: AH8x226kEsG2WfnBah/qgKo7nPPT61CJPAOm8C/mNPa3dIPeMm3wTmTQj1Jrf1larJVN+fgxp7N06w==
X-Received: by 10.223.160.176 with SMTP id m45mr6711081wrm.119.1518036821520;
        Wed, 07 Feb 2018 12:53:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l2sm2330384wre.6.2018.02.07.12.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 12:53:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        mhagger@alum.mit.edu, Mathias Rav <m@git.strova.dk>
Subject: Re: [PATCH] files-backend: unlock packed store only if locked
References: <20180206203615.68504-1-jonathantanmy@google.com>
        <20180207144251.GB27420@sigill.intra.peff.net>
        <20180207103245.d500efb67cc73cf31087f4be@google.com>
Date:   Wed, 07 Feb 2018 12:53:40 -0800
In-Reply-To: <20180207103245.d500efb67cc73cf31087f4be@google.com> (Jonathan
        Tan's message of "Wed, 7 Feb 2018 10:32:45 -0800")
Message-ID: <xmqq372c7c8b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Wed, 7 Feb 2018 09:42:51 -0500
> Jeff King <peff@peff.net> wrote:
>
>> But this all seemed strangely familiar... I think this is the same bug
>> as:
>> 
>>   https://public-inbox.org/git/20180118143841.1a4c674d@novascotia/
>> 
>> which is queued as mr/packed-ref-store-fix. It's listed as "will merge
>> to next" in the "what's cooking" from Jan 31st.
>
> Ah...thanks, I didn't notice that.
>
>> I actually like this double-label a bit more than what is queued on
>> mr/packed-ref-store-fix, though I am OK with either solution.
>
> Same here.

I do agree that the double-label approach is more future-proof way,
especially if we anticipate that there will be more code after the
"attempt initial ref transaction commit" block before the
packed-ref-store is unlocked.  On the other hand, introduction of
the locked_cleanup label can be done as part of such a change that
adds new code that needs to be skipped, so I am OK with what is
queued there.

Thanks, all.

