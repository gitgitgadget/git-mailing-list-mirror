Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391021F404
	for <e@80x24.org>; Wed, 21 Feb 2018 21:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750752AbeBUVvS (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 16:51:18 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33584 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeBUVvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 16:51:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id s206so2307433wme.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 13:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FR4+SIBfFbEapYFdGto9+dT18CNfLxvcO7hesEr//AM=;
        b=m3TCBt2I4YCBtgvobLxkuMs0YDTgcpRKnAe/EMHc5azpSJn7iDjUr3Sx+KvvXTbU8f
         41tNpWuG8ualx/AHTQp36tb9eapbS6K4zGk0kik+xScllO3RjZ0M49bjaemg9CDcWuMA
         rIqnKOWf8VauKzSjn1dJs3wIDA576Y9EsiuOBCxjQaxAAVWJ6YfEGFdnXJVsPBzNXkXl
         V85hoOriWlCHfYKsJvoe8lfe8wS8A5Icu2GU16/kALea7q0So7C1G1lsksDDjzWmMS+B
         9m7btt6+4946FnvJqMbSJdBrc6gtiDYSlXzzBLrChZXwg1ZsJ81VOcozCtU+xacs4w5D
         YOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FR4+SIBfFbEapYFdGto9+dT18CNfLxvcO7hesEr//AM=;
        b=p+8+cXxITdYb9K2N1xZXyk6E3jWwTXkMDL2WRFsi9KEEdYGIUNoAXuV/9PLbzhwkbe
         yxG4sPrnxZMqBeHsI4y16ldzTizuFITaR6sNmlaqlb36HOi3cc7xg7TLJuc41pyoSA58
         AXsiaI15+C5UDZOyhlGE5bywwkzWFV/PQ52P855vI2YNK2NbnnxDg3vHM1piacLK2te+
         cRT6OrYO+TUvp0e4A+21YrpcbUYjRx2xS3g/C18HuGDBC35AGn6BgjH6GCgw0/4K5TzS
         TjkVq0USQHbeTYqBHGdDpEnGl+uEsNJXFYen7vP8VwKUxiVz07tuyaNLEpe2+umKCTwU
         CFyA==
X-Gm-Message-State: APf1xPA3bcPigdiRQeqepCRNJ/zuJnj5TFAfP7SMW7SOUNOqN+SvLiLs
        2+gEnI4PmmbmQmX6X6sOtHM=
X-Google-Smtp-Source: AH8x224aCw8JVo3SvjXFlC9XNuD9EcjW+Ci/YW7AT7g14xus8on+CCYX+/HUvUzSEbwZAqbs3liOxg==
X-Received: by 10.28.184.8 with SMTP id i8mr3384493wmf.52.1519249876434;
        Wed, 21 Feb 2018 13:51:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n24sm31960864wmi.21.2018.02.21.13.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 13:51:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sunshine@sunshineco.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/27] object-store: move packed_git and packed_git_mru to object store
References: <20180216174626.24677-1-sbeller@google.com>
        <20180221015430.96054-1-sbeller@google.com>
        <20180221015430.96054-6-sbeller@google.com>
Date:   Wed, 21 Feb 2018 13:51:15 -0800
In-Reply-To: <20180221015430.96054-6-sbeller@google.com> (Stefan Beller's
        message of "Tue, 20 Feb 2018 17:54:08 -0800")
Message-ID: <xmqqy3jmxb8s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +
> +/*
> + * The mru list_head is supposed to be initialized using
> + * the LIST_HEAD macro, assigning prev/next to itself.
> + * However this doesn't work in this case as some compilers dislike
> + * that macro on member variables. Use NULL instead as that is defined
> + * and accepted, deferring the real init to prepare_packed_git_mru(). */
> +#define __MRU_INIT { NULL, NULL }
> +#define RAW_OBJECT_STORE_INIT { NULL, NULL, __MRU_INIT, NULL, NULL }

I do not think it has to be this way to abuse two NULLs, if you
faithfully mimicked how LIST_HEAD() macro is constructed.  The
reason why it does not try to introduce

	struct list_head x = LIST_HEAD_INIT;

and instead, uses

	LIST_HEAD(x);

is because of the need for self referral.  If we learn from it, we
can do the same, i.e. instead of doing

	struct raw_object_store x = RAW_OBJECT_STORE_INIT;

we can do

	RAW_OBJECT_STORE(x);

that expands to

	struct raw_object_store x = {
		...
		{ &x.packed_git_mru, &x.packed_git_mru },
		...
	};

no?  Then we do not need such a lengthy comment that reads only like
an excuse ;-)

