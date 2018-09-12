Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079451F404
	for <e@80x24.org>; Wed, 12 Sep 2018 16:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeILVQJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 17:16:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50868 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILVQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 17:16:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so3046895wmc.0
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BvNZfGuEXIeA2DmNr51UvPuP9UjBXTHhBM0IoPraTu4=;
        b=eu2u5+Lt/AqKesFudZ4Cl0lnTgmv+TUz0+61QB8KTy0rYPCmYQsfR8fwAzWtV/8AIO
         G1DJpxO2bPfpEqyNkbvFDA8+7SgqZ6lxGouqzlVuOlf6mrVfYo1FyDnSsemBS5kYzjeO
         6s6b8VPANp9s+QAg4OonQACY4lfraQ73mJi6U/w8FtLnH9kIhqk5WLZ1+k5NtgyP3LM6
         i+YKYx044M8naPHdvMV4pDOboGxtfzwhrVGBe61Vo9eI94mzpCdl96Yn1SgyynTslR24
         0wDDKIR9dYos408IcK+XyafCtQTEAm4FiXdo+LoMhiMrx1t37ADAE3Cznr5yzkXFyPXG
         58kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BvNZfGuEXIeA2DmNr51UvPuP9UjBXTHhBM0IoPraTu4=;
        b=pbiIEkntfPhe7zXQqIcP1EXCT3r+VErKtaDXBbTBel7+5fAz9Oqk6ELetvKm3piRyj
         IaTaXwtTsCd7cAKkRLnMnXK8RRRzop2/sxfCdJF/fUNiiEdKpb1RKfl9DoSbe1tYKDzr
         n1htHcoVymjB20mduWI62zG4bmsV1PUiaCYOpiFpNvnLSqrNpZAbuVzRStN41PbtgyTl
         JfRNYmDTf8t6ItaRjN8m3ttq6IcPvqI01nioIvFgY6v0+ZsF11dbQ04XbEKwRunE7Xw6
         434l2KUTR8B4BXa1go2N3O6Q58gb2bFvqjEnT22hZXQNoczNyiJ8iCbAbh3CEf2Rj0b4
         yAfQ==
X-Gm-Message-State: APzg51DANY1yBDyWTqp0nlsZPeMs2fUpH2EXu9A/t9Rn0VuW8wnGtnF9
        krBbJfgkppbcAS98231K/5c=
X-Google-Smtp-Source: ANB0VdZGCH/E9TG+TKdT7jGnqI7VZ97NA/Fq/OpjzCvld/1u1ug4pRg5cOXNwxt4OFXzaxxBNaXXvA==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr2289377wmh.134.1536768655258;
        Wed, 12 Sep 2018 09:10:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b12sm1814714wrx.11.2018.09.12.09.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 09:10:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: treat empty CONTENT_LENGTH as zero
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
        <20180910205359.32332-1-max@max630.net>
        <20180911034227.GB20518@aiede.svl.corp.google.com>
        <20180911040343.GC20518@aiede.svl.corp.google.com>
        <xmqqk1nrq4su.fsf@gitster-ct.c.googlers.com>
        <20180912055626.GA13642@sigill.intra.peff.net>
Date:   Wed, 12 Sep 2018 09:10:53 -0700
In-Reply-To: <20180912055626.GA13642@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 12 Sep 2018 01:56:26 -0400")
Message-ID: <xmqqk1nqn1bm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I really wonder if this topic is worth pursuing further without finding
> a real-world case that actually fails with the v2.19 code. I.e., is
> there actually a server that doesn't set CONTENT_LENGTH and really can't
> handle read-to-eof? It's plausible to me, but it's also equally
> plausible that we'd be breaking some other case.

OK.
