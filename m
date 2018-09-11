Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD181F404
	for <e@80x24.org>; Tue, 11 Sep 2018 04:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeIKJQE (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 05:16:04 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34651 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeIKJQE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 05:16:04 -0400
Received: by mail-wm0-f45.google.com with SMTP id j25-v6so7014748wmc.1
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 21:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eHiZhweeZvWcL3JXoBzmvndKBlAxtnH9rXhCnlik4Tc=;
        b=f7sf+gF0XWHlTLEZLjWGLzjrzpyGkOD7a0QuZr/mcrZ8c2awPhkPJXnm8HCy+fhG17
         oJq8YZInti9Pzm5M7Ggj8TNGr9+ix1HyhtQb7ijIFzqUCbieW5OBUO2tZ0SSQFgN6fet
         ZZlNA1rzbvgXIOMJeX+dG+eOq0uT831Mj3NPUSMk440S7B00MSm7fSftXCnYis9ZFJ9/
         nkeHRAv5pU+9Q5BqpOIR7aFpQnLebmv9jF1JqGfYsYSEgC1zMIm/xTTk6usLyBjTOsUO
         tYiltqJjuEfoSB4l5NB4ig90HbXhxDOr0PuVq4IeeMNuwmG9IvNisfXokSFwwzoqtolD
         T8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eHiZhweeZvWcL3JXoBzmvndKBlAxtnH9rXhCnlik4Tc=;
        b=WVuRN+FlkP889pN/uW1TGKSoewGDLy6PBAwyIJcl2rDXbCZotdJ58fkiJ2rv7pZiy6
         +WTndwvCP4lT+w84jmd5qyX9CTHdKGGFJVlJ3mRZCciug3E6Agv9h5wDsJTdI0FcZ1UA
         Fd8PYgcBvLJ2Itv0UYM6XCuno9Kqb7jNm6/bClAqFXi/Vr1yZGfqLEGzTtuFZWmrfOhb
         L689FCPICGRM3uFeyiMXFI2I65z/Aw2WiRotfIY+QF3cqQYmNwI51eEwFyNKTSSJlYDO
         evzGMXIjsOwy+J8eZnOHxDgv0/xu4GLkcAboF4KhyKGL9miUw+Trr0LMtStzKmMAdQHh
         BdZQ==
X-Gm-Message-State: APzg51AVf8F+3AF6e4UrgJkJpEnDDyE0VE73uDk6dNUAVKEcSjodd3g5
        fYLtNt3IBl6yAr0ftT/XFHs=
X-Google-Smtp-Source: ANB0Vda7S/ddU1MP4P7wsuw0gOgjLABfwELlVzIQmMyvTBgjAt5Tjrg2DDioRcbhttNPEjTUlyU3PQ==
X-Received: by 2002:a1c:de05:: with SMTP id v5-v6mr2564939wmg.127.1536639522257;
        Mon, 10 Sep 2018 21:18:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w18-v6sm41103249wrc.38.2018.09.10.21.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 21:18:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: treat empty CONTENT_LENGTH as zero
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
        <20180910205359.32332-1-max@max630.net>
        <20180911034227.GB20518@aiede.svl.corp.google.com>
Date:   Mon, 10 Sep 2018 21:18:41 -0700
In-Reply-To: <20180911034227.GB20518@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 10 Sep 2018 20:42:27 -0700")
Message-ID: <xmqqo9d4r7j2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> RFC 3875 (the CGI specification) explains:
>
>    The CONTENT_LENGTH variable contains the size of the message-body
>    attached to the request, if any, in decimal number of octets.  If no
>    data is attached, then NULL (or unset).
>
>       CONTENT_LENGTH = "" | 1*digit
>
> And:
>
>    This specification does not distinguish between zero-length (NULL)
>    values and missing values.
>
> But that specification was written before HTTP/1.1 and chunked
> encoding.

RFC 3875 is from October 2004, while RFC 2616 (HTTP/1.1) is from
June 1999; I presume that 3875 only writes down what has already
been an established practice and that is where the date discrepancy
comes from.

This is a bit old but some of those who participated in the
discussion archived at https://lists.gt.net/apache/users/373042
seemed to know what they were talking about.  In short, lack of
content-length for CGI scripts driven by Apache seems to mean that
the content length is unknown and we are expected to read through to
the eof, and we are expected to ignore the CGI spec, which says
missing CONTENT_LENGTH and CONTENT_LENGTH set to an empty string
both must mean there is no message body.  Instead, we need to take
the former as a sign to read through to the end.

> Fortunately, there's a way out.  Use the HTTP_TRANSFER_ENCODING
> environment variable to distinguish the two cases.

Cute.

I'm anxious to learn how well this works in practice. Or is this a
trick you know somebody else's system already uses (in which case,
that's wonderful)?

> +	if (!str || !*str) {
> +		/*
> +		 * According to RFC 3875, an empty or missing
> +		 * CONTENT_LENGTH means "no body", but RFC 3875
> +		 * precedes HTTP/1.1 and chunked encoding. Apache and
> +		 * its imitators leave CONTENT_LENGTH unset for
> +		 * chunked requests, for which we should use EOF to
> +		 * detect the end of the request.
> +		 */
> +		str = getenv("HTTP_TRANSFER_ENCODING");
> +		if (str && !strcmp(str, "chunked"))
> +			return -1;
> +
> +		return 0;
> +	}
> +	if (!git_parse_ssize_t(str, &val))
>  		die("failed to parse CONTENT_LENGTH: %s", str);
>  	return val;
>  }
