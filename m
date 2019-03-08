Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E071720248
	for <e@80x24.org>; Fri,  8 Mar 2019 01:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCHB01 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 20:26:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38188 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCHB01 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 20:26:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id g12so19607684wrm.5
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 17:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cPf/4KmSN2N1eHRq3BEmmmLmsKDu+fmQUWKEQnIk6qU=;
        b=VIA8jLuPlcGs2e/f33IgnJDvcuCtM96na/Qz9vRMEXAhhbBE6KpPE23znFP5AKn5/w
         yUbPSXCSjr+rN+YGiAx0+dNP4nyswaCXhS94w5ltMX0nRo+GiVwHJxXbf6yyyFln4kr3
         3mZbXZN/vvDhnIpIoRkwgPSVBXOo5liJDJYS4mbE6qjr6Ch1ZQ34POyCrJp2PxNoM2R1
         59jVxmV2IFhiWmWIKQyrRZe1Ll3fHFFbAdCJjDh/hkbhawfQwE2O7O+TlUabNAttwY9/
         lPE4/Af5Zhh5xw2zwQ0XMyvdAnTYCmQJd0VGoF12/iLRdxUbJ5HbR5xr7yo/0Xrc04NT
         AqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cPf/4KmSN2N1eHRq3BEmmmLmsKDu+fmQUWKEQnIk6qU=;
        b=gCBOfeTPkvi+PCCabpC+GefPPsr7N3vimENpXxl0Wd/z3sUwMec955Jd5IUmy5DkkL
         XsiraSs/xjt6xObDUp0G66yTi+6VCvcM1Y9wDsp7kZYGmhpASDgLWgoJj2gfYUce85od
         2C+LZuldFsGXlhZ8VmJ1uRDZ6j9S8sacBFcbxqky+wykz7JamStmYsMUUcbsgqK/BwlX
         4OpPR1G8GYSfvDpfoebURpzTobbRxtUFRNUi2bkz1nmCEN8G86t8cBEA0hmhv7kA3EZV
         SuRjAKPCbJ77+VsjVU3CoSzbyCBlEHh3DyzZ6zQZRopD1AeS/6U3NOXhfLncukxuezZB
         9vvQ==
X-Gm-Message-State: APjAAAVPwF2S8xlo5d3oE+q0nOdPDXPu6M2CZV4J6gPpLpSgV+S6qiPo
        bkUyP2iMUzioNn4RT7PacXc=
X-Google-Smtp-Source: APXvYqxfCdqvVbVFuD1MO1Zwb0V7K2ljiPLoKIvSsII/DtpXggxAAjy9sKoD0PrdreaA9Iz84ICEmQ==
X-Received: by 2002:adf:d08d:: with SMTP id y13mr8008027wrh.99.1552008385425;
        Thu, 07 Mar 2019 17:26:25 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w3sm8355152wrl.22.2019.03.07.17.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 17:26:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Joey Hess <id@joeyh.name>
Subject: Re: [PATCH] convert: avoid malloc of original file size
References: <20190307195657.GA29776@sigill.intra.peff.net>
Date:   Fri, 08 Mar 2019 10:26:24 +0900
In-Reply-To: <20190307195657.GA29776@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 7 Mar 2019 14:56:57 -0500")
Message-ID: <xmqqa7i6kvgf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As discussed there, I do think this only solves half the problem, as the
> smudge filter has the same issue in reverse. That's more complicated to
> fix, and AFAIK nobody is working on it. But I don't think there's any
> reason not to pick up this part in the meantime.

Yeah, I agree that the reverse direction shares the same issue.

I am not sure 0 is a good initial value in this direction, either;
I'd rather clip to min(len, core.bigfilethreshold) or something like
that, to avoid regressing the more normal use cases.  

But let's queue this and see what happens.

Thanks.

>
>  convert.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/convert.c b/convert.c
> index 5d0307fc10..94ff837649 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -731,7 +731,7 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
>  	if (start_async(&async))
>  		return 0;	/* error was already reported */
>  
> -	if (strbuf_read(&nbuf, async.out, len) < 0) {
> +	if (strbuf_read(&nbuf, async.out, 0) < 0) {
>  		err = error(_("read from external filter '%s' failed"), cmd);
>  	}
>  	if (close(async.out)) {
