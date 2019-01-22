Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FAA91F453
	for <e@80x24.org>; Tue, 22 Jan 2019 20:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfAVUuL (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 15:50:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44221 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAVUuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 15:50:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so28948748wrt.11
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 12:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pIyObgFWh8t1Uo1PWl6DJxXklZW4ptj5jLqP1CZQlSA=;
        b=Vq8EBDj1WfYBvdfRd2vPV90tQMs3Sw9XaNuUWVUPYB7yhTHIDD/zcXOXtPjv5KE7fq
         xocBaKAW6jpH4MJkIK3Y9RzGZlMDnrGTpUhQXfi5JdnL6Brfk06Up6eiFeP69d1TDNDY
         XJgnLphsh5w/Z6Ofl1jHbfKi9fJMUmhwkurGiF6gGaAfRpMSqNO1MtZvrjw77t9LtF+X
         FWJ96kvOQQWdzByHKDoo1Nfb1cbeICN7AtKts2b2+xUa6pHK9ovifCgbsLXOh4y98c3Y
         /G60U3MzsPtQXpeAC9ppmD2Jhnar0ZMMcopATQorUr+uqcN/2ONb0PruUNGndjUMWdog
         +JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pIyObgFWh8t1Uo1PWl6DJxXklZW4ptj5jLqP1CZQlSA=;
        b=j6YY8e7ublYS1hUsN4GlJLTnierc7iwrflKFnQVJH9OYvlzxX2gw3/oghbtLQA+I9H
         YgeKwnXcCRkvT0LXvEZHGBW6dZJ1la9VVwoIhX2+hUdKtNrivj8dNBPpSsmyhQ489ADl
         0LnV5KDQxHccvxzTLkGp+hpdqldvQuN2vZNyKoHr3y1PMmxG99jelSELEpXXPQAvjMws
         8DtOEnne2WUN69VT7gK434wNG8MEnAxcWbjKomZpxPtz13HIL8TzVeG/crJen/aruFa0
         YWkApMuUhoIhNP5gOTxuU2nCB14eqpo21LMC4uj6mVSJF6eqQdrYCTZJLeGW39HZazNJ
         pPIQ==
X-Gm-Message-State: AJcUukdQtSmDl0QjcUsPoXh0DjZH6YGNXhAmwerOaoLF9PBlMPHmvUUZ
        YWBuoVXjw+lt7DmjJNx1S6Y=
X-Google-Smtp-Source: ALg8bN5QdKoom8D1EtLRK2TpMOBx+hdJfDz3n1HwZ954XOXLfSBElIkxFS5yhmtnGA9Ct+8SsWYYrg==
X-Received: by 2002:adf:a357:: with SMTP id d23mr36031377wrb.195.1548190209212;
        Tue, 22 Jan 2019 12:50:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r12sm111452182wrq.3.2019.01.22.12.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 12:50:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] diff.c: simplify diff_opt_break_rewrites()
References: <20190122002635.9411-1-pclouds@gmail.com>
        <20190122002635.9411-4-pclouds@gmail.com>
Date:   Tue, 22 Jan 2019 12:50:08 -0800
In-Reply-To: <20190122002635.9411-4-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Tue, 22 Jan 2019 07:26:35 +0700")
Message-ID: <xmqqtvi0e7sv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> -	int opt1, opt2;
> +	int opt1, opt2 = 0;
>  
>  	BUG_ON_OPT_NEG(unset);
>  	if (!arg)
>  		arg = "";
>  	opt1 = parse_rename_score(&arg);
> -	switch (*arg) {
> -	case '\0':
> -		opt2 = 0;
> -		break;
> -	case '/':
> +	if (*arg == '/') {
>  		arg++;
>  		opt2 = parse_rename_score(&arg);
> -		break;
>  	}
>  	if (*arg != 0)
>  		return error(_("%s expects <n>/<m> form"), opt->long_name);

Good.  I was about to complain on the lack of "default" that catches
the error at the end of "<n>" in the switch(), but because this
follow-up validation is trying to catch "<n>" form (i.e. single
score without slash) whose "<n>" is malformed, and "<n>/<m>" form
whose "<m>" is malformed, which is kind of clever, but it is not
very easy to understand what is going on, it makes sense to get rid
of the switch() and make it if() statement.

It would make it even easier to follow if you did

	if (*arg == '/') {
		opt2 = ...;
		arg++;
	} else {
		opt2 = 0;
	}
	if (*arg)
		return error(...);

It makes it clear that opt2==0 means <n> form and not <n>/<m> form,
by having an explicit assignment while we parse what *arg points at,
without the initialization to 0 in the variable definition.

But this should be squashed in the original patch.  Having an "oops,
it was horribly unreadble---how about doing something like this?"
incremental is good during a discussion, and having a "what we have
seen is basically good and proven solid, but here is a small
improvement" incremental is good for code that is stable enough to
build on (read: at least in 'next'), but it is not particularly good
for a topic not yet in 'next' yet.


