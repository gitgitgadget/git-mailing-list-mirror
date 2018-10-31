Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D5A1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 05:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeJaO1o (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 10:27:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46672 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJaO1o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 10:27:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id 74-v6so6794310wrb.13
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 22:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JqficJhWhagUKq1l87GwIvdu7TbcuIAC4SBDUYrKHFY=;
        b=S9bmcc8O1ASFH3b7g8iKoZJpfHfTFtuZP332qoQlqJWE6iezK4R5X0zbJNA9BJOT0F
         12cf9MNYbA6BgdpiX8Iof7XtUESGHtGFaUCHaz+8zbvK7SWbmmd+XMsn+q4bW00eCMym
         Us0cQaI56dfxi9nrvLt2OiDbbDnfImp8YcpzN6uwB5Aic88f6HwqOYxtu6pND+lKbS7N
         6QgmpQGrum2EXt6jGVdxpuhqUxHyqINhEEbehe8c5aCMXovg/VXhein0yIxObstf034Q
         3MXLQfv6mn41xM/dATr2XryQd0c7QFrTV3l5qHx6aPlz/5FUWsnYjyFVHzYxYV/ldi0g
         oHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JqficJhWhagUKq1l87GwIvdu7TbcuIAC4SBDUYrKHFY=;
        b=ap0N0MnYT0Ta0GkQ55MKyLJDSFPmQP+0uToOCSUIWVKhyipA4ptB0uterDXAnXFZFl
         nFpOy8y8pTjH1o3bHTKHuz011Z5y/2BkyziKLqgW00ZODbEhYJ0o8FAsXN0trAH2R4ia
         4F/ElDyGHIjzob7Wacude+UJuiiX/hpuAPpdTjQoipyzvmuKHGbSvUEEifhSk6TknqVJ
         1ITFNOv6x0steW/uHM5AjQsNKuVH3VvhYSGqr7Ico8tAzXVal/82fhIGxsXVfUqIFre8
         3PitcYKkwotaXxH4rTfR6ZR6gSjHkFi+yuBL9glDdy+VJRGm0/W3oQeYfnIh2/0gAmc5
         n1+w==
X-Gm-Message-State: AGRZ1gJQk1dH4VG+BMk3fACvz+DpvnxvImjRbKXJDFSSLoyRJO37NKxs
        vP6ofpfjXcHvrDQ2eseMDGs4n0RKFuA=
X-Google-Smtp-Source: AJdET5d+QSRsLV4GXhUCLu0FpUrUvyf2xD5ianCT0OlxeC0870vQjp7moUb1pUCOPxSKZIVpvrMonA==
X-Received: by 2002:adf:e4c9:: with SMTP id v9-v6mr1151707wrm.227.1540963869564;
        Tue, 30 Oct 2018 22:31:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j6-v6sm20915606wmd.29.2018.10.30.22.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 22:31:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/3] check_stream_sha1(): handle input underflow
References: <20181030231232.GA6141@sigill.intra.peff.net>
        <20181030232312.GB32038@sigill.intra.peff.net>
        <xmqqpnvqyc9x.fsf@gitster-ct.c.googlers.com>
        <20181031043051.GA5601@sigill.intra.peff.net>
        <xmqq36smybbq.fsf@gitster-ct.c.googlers.com>
        <20181031050338.GB5601@sigill.intra.peff.net>
        <20181031051316.GC5601@sigill.intra.peff.net>
Date:   Wed, 31 Oct 2018 14:31:07 +0900
In-Reply-To: <20181031051316.GC5601@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 31 Oct 2018 01:13:16 -0400")
Message-ID: <xmqqk1lywulg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 31, 2018 at 01:03:39AM -0400, Jeff King wrote:
>
>> Phew. I almost just deleted all of the above, because now I think I'm
>> ready to write that comment you asked for. ;) But I left it since maybe
>> it makes sense to follow my thought process.
>
> So here it is in a more succinct form.

Thanks.

> +
> +		/*
> +		 * Unlike the loose object case, we do not have to worry here
> +		 * about running out of input bytes and spinning infinitely. If
> +		 * we get Z_BUF_ERROR due to too few input bytes, then we'll
> +		 * replenish them in the next use_pack() call when we loop. If
> +		 * we truly hit the end of the pack (i.e., because it's corrupt
> +		 * or truncated), then use_pack() catches that and will die().
> +		 */
>  		if (status != Z_OK && status != Z_BUF_ERROR) {
>  			git_inflate_end(&st->z);
>  			st->z_state = z_error;

Reads well.  Will apply.
