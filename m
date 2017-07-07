Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A4E202B1
	for <e@80x24.org>; Fri,  7 Jul 2017 16:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbdGGQuI (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 12:50:08 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35191 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdGGQuH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 12:50:07 -0400
Received: by mail-pg0-f66.google.com with SMTP id d193so4693130pgc.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Z4ivVmyUE4ual30kworYWHbGG8cSgpUDzlDTNHclw2U=;
        b=DYEgm18aPEguRBKwH8yHNrFDwR6b1e8I6hvJA+iKexbMt9jM77DLuuMzHGLJAQdN2j
         qxv4V76c3MfuezG81BsgwaqW3fUDxikLmvx95xzlkPOcrtoKcj8rY+UZWY7hJwfxGgvO
         W/0BmU9EppnWBSNMZI6Ij9Fdd60knqf+lUuX8JVXiwMM8zhuzIQCIeH53tOP3uDEbNGu
         FNShdHzrd2iPGVTxrtqCvpBx1886i0pnSpYgpfc49Q2HeeGSI6qejhevwi6u9vN1N2pl
         4TwGcBvlQo5hqfOKc2glfOO/2rhZFdDyxJ1PXOeYcNtlmgQEB/REa+SLbYp6N+vu7Mfs
         Ulyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Z4ivVmyUE4ual30kworYWHbGG8cSgpUDzlDTNHclw2U=;
        b=oOoZd5zC/tVv/VwfGzz/EZyUBuJsPaeRhn5aApwdc1/uC12NaXWvdAeFqzPBX50/Qq
         FWW3YNWZ9W73cTScSCHLZa+y7bxK4lVCS5JGFzdAKUf36aJInZomQyXhWTHjL7gj1iVg
         TnJPxHVH1xE7pw2CqFg0E2JeQ/JL2YxDuXuYldirgnfFW5s6qE0mOhYNBiaH11Ceek4l
         aehxI03KcqufxDcaucZNCahn7L4J4pmxhuW3t6InC27Y/CZopXMruslXjP7W+lpGJbc/
         +Oj5z6rm3ow5DWo8/yCT6xt/Yib88L4dg3vXBNCbUfSzzWIS1tFjSIAeINRZX0lFFOrh
         3SMw==
X-Gm-Message-State: AIVw113N9Z4q5BvRuIhCnFIdHfIV2b5FffTGVZBll1APTwUtA6yaH8zR
        ADKjO1T4H2dH9Q==
X-Received: by 10.84.236.14 with SMTP id q14mr3940432plk.254.1499446206417;
        Fri, 07 Jul 2017 09:50:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id i126sm11623671pgc.6.2017.07.07.09.50.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 09:50:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [RFC/WIP PATCH] object store classification
References: <20170706202739.6056-1-sbeller@google.com>
        <xmqq7ezldlhe.fsf@gitster.mtv.corp.google.com>
        <c9a6f3f0-e338-a200-6b57-48b5d926d31c@gmail.com>
Date:   Fri, 07 Jul 2017 09:50:04 -0700
In-Reply-To: <c9a6f3f0-e338-a200-6b57-48b5d926d31c@gmail.com> (Ben Peart's
        message of "Fri, 7 Jul 2017 10:56:30 -0400")
Message-ID: <xmqq4luochtv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> For more API/state design purity, I wonder if there should be an
> object_store structure that is passed to each of the object store APIs
> instead of passing the repository object. The repository object could
> then contain an instance of the object_store structure.
>
> That said, I haven't take a close look at all the code in object.c to
> see if all the data needed can be cleanly abstracted into an
> object_store structure.

My gut feeling was it is just the large hashtable that keeps track of
objects we have seen, but the object replacement/grafts and other
things may also want to become per-repository.

> One concern I have is that the global state refactoring effort will
> just result in all the global state getting moved into a single
> (global) repository object thus limiting it's usefulness.

I actually am not worried about it that much, and I say this with
the background of having done the same "grouping a set of global
state variables into a single structure and turning them into a
single default instance" for the_index.  Whether you like it or not,
the majority of operations do work on the default instance---that
was why the operations could live with just "a set of global state
variables" in the first place, and the convenience compatibility
macros that allow you to operate on the fields of the default
instance as if they were separate variables have been a huge
typesaver that also reduces the cognitive burden.  I'd expect that
the same will hold for the new "repository" and the "object_store"
abstractions.

