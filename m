Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42BB0208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeHHSht (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:37:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39672 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHSht (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:37:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so2526981wre.6
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/UYm0NmHtYmIqN4DUKhUFxbs6xxvqR1Xzk+xxAsTMM8=;
        b=Tz7xV4LW8SIcT3Mse9ovvz7boo7s7OH9/150m89qSHjtsio3BO+S+IRgiOVbnAABjh
         n7+xn8+hsDNIelnJ0Tjbt2M9iZzA7ibE5gLejzoD0VWAK1iOvMHOzerQZexhWeM2943u
         C8RAeclIy0HpYyfGn9/l+ROjk/N2TSBcOtZAy4mHeb6mO+zq4AHv14G+z5AFlH6GfVb9
         XKrMxqcc4UoBMut4uLPYLxSGWfNziMIqKySyADZPD+nZcPz4ZvDbd0gg7jnS7S/O8108
         pcGo2/pDj/Qc0m3nu+x3CRQZdPf/aHix3/3z0WwaE7VGjl3/WxyA3tjg7wT3vnruzbP/
         jHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/UYm0NmHtYmIqN4DUKhUFxbs6xxvqR1Xzk+xxAsTMM8=;
        b=Acem/b/73cFgHDiZXzAKNTcYDiWhyTSEnAEc4OC9uTjtE/GVZWxYnP1eUEKQDQhT0N
         QbaWLMPM2TCZ+MTwXoMzLJzFp2Po0Lev/3Ln0dlMmqI/DzZwWYGbW1/vhkLQs6yviYte
         NyNYCAiJOQLG6WrXsegqdRJYtlbgNw3mJuFyhZclUV/JSNy51s+Om86jf2k5gPhURRF4
         mhViGT6VqNBonIpwhPasiOCBYqgBvfCvdTohqC9npjck4U9e8/M49mlflEBiYHlmPPlW
         xjqvd8//4pKTEAeRVf9lDLI2xpZTVApGe3cIxtUKDh9QQI5YqyJ8bpWpWsChBN72n8JR
         nBVA==
X-Gm-Message-State: AOUpUlEPCXIUm4AUE47tUveFOk99DlTeJYxMgxNXKgmZW+aZZ/GKn5x7
        uz+Xf7QpA1W/4z3Cs0TuV8GKmNEy
X-Google-Smtp-Source: AA+uWPxIdE+uxYNL1E/X52aopia0Qv74NPyTCcTkp92qU4yU2aisVvbNbh1hXbJVcfXNQTnRBot8ug==
X-Received: by 2002:adf:f910:: with SMTP id b16-v6mr2490968wrr.28.1533745044413;
        Wed, 08 Aug 2018 09:17:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k12-v6sm4646032wru.38.2018.08.08.09.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 09:17:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] repack: repack promisor objects if -a or -A is set
References: <xmqqzhxxki84.fsf@gitster-ct.c.googlers.com>
        <20180807232304.181764-1-jonathantanmy@google.com>
        <20180808155045.GB1607@sigill.intra.peff.net>
Date:   Wed, 08 Aug 2018 09:17:23 -0700
In-Reply-To: <20180808155045.GB1607@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 8 Aug 2018 11:50:46 -0400")
Message-ID: <xmqqin4kj0j0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think that the for_each_packed_object() interface should visit items
> in pack order.

Yeah, that may make more sense.  Any order is more logical than the
object name order (which by definition is random, so useful only
when you want them in a random order), and pack order will give us
locality of accesses.

>    For traversals using bitmaps, we have a "name hash cache" in the
>    .bitmap file, which stores the 32-bit hash of the name. That lets us
>    put similar names next to each other without actually knowing the
>    names.

I forgot about that one; it is a neat trick.  As .primisor packs are
intentionally kept apart from the remainder of the repository, and
because .bitmap wants to have a single pack, we cannot just read
the .bitmap file for this particular application, though.

