Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB641F404
	for <e@80x24.org>; Tue, 11 Sep 2018 18:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIKXPr (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 19:15:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42401 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeIKXPr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 19:15:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so27010278wrr.9
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8FEBgOnKhOkJ2AoJzcKLKNV+U1uEzd6TbeKyB3nrs98=;
        b=EUmpooRx274rey7Wwg2t2YNfBZWC1MXopdjSzIRUHQSn6s8+k/VJYguCRpzSa+Vhmx
         z9U7z6TPx3ITsdvHk/HTgVqvt5weHXGfHKJaLuAnBnuqnjFnQ/pF1rDOVJb8nrY03aKW
         U9/2r/eHDoFcD8Joajvo16jmt7P25qp43DDwqOc6WugA5utryTsgM1SYmhscCkO3jOSC
         M4MKYt+uW/4Omd2mHTa5RplyDe5qgRb+39e9q8PMCjs+DoJYqJ4X5/reJF0LeUtMfcZm
         gSgi54dfWrz0ZWzo9EU0UP3UwRbsb6Nxo52dLMo9VZkE+2yIV8UoSrdhlTpoVBzRxJNT
         kR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8FEBgOnKhOkJ2AoJzcKLKNV+U1uEzd6TbeKyB3nrs98=;
        b=iz6iIxuT8EOmsYkekXOIu5FvJnSqkr7xj27pWT6RyhwUd4RlGrlgFrLa9l2rzfNZ1/
         3KsO6b1aOaG1oqcYJ9xL+3GnG2ttBwQVk9qAUE48eAu2dyqDQwyD8+26mjup4+O2dhq8
         FnhgaGxAmDy+1uEKyOdkmQXR85wpgp+aqniUJzKhoYzkDh5mMsKLixoSv+ku3ywCiUug
         IoP2s1iC6RaycZnqAn5OO+TEUgGTAMkiGu6OOz7VyYYyTTYYeafgq0HWboEII+G3/tMZ
         AuqzWya2jlhI9l351GnQBM5kmQuB1r7Mr4TFxbdZvvUfvaK08IMcXdPptKNOG2RY60Lk
         tzjw==
X-Gm-Message-State: APzg51AucWoKXDj2JNzwn7M8q9QBRT3Gu9gEcEDc8sJrmUO14k/O5uXx
        PEAJh3yUnyukC2zmffn4I9o=
X-Google-Smtp-Source: ANB0VdZNwCoeB4uR+Zg4pymEuuhe0/bGPz0NfMoUO6I8Z4boD7F5GGU/N+IGnKx3F7eTpB7lF7oshQ==
X-Received: by 2002:adf:fd12:: with SMTP id e18-v6mr20513757wrr.280.1536689716155;
        Tue, 11 Sep 2018 11:15:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a11-v6sm18512898wrr.81.2018.09.11.11.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 11:15:14 -0700 (PDT)
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
        <20180911040343.GC20518@aiede.svl.corp.google.com>
Date:   Tue, 11 Sep 2018 11:15:13 -0700
In-Reply-To: <20180911040343.GC20518@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 10 Sep 2018 21:03:43 -0700")
Message-ID: <xmqqk1nrq4su.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Kicking off the reviews: ;-)
>
> Jonathan Nieder wrote:
>
>> --- a/http-backend.c
>> +++ b/http-backend.c
>> @@ -350,10 +350,25 @@ static ssize_t read_request_fixed_len(int fd, ssize_t req_len, unsigned char **o
>>  
>>  static ssize_t get_content_length(void)
> [...]
>> +		/*
>> +		 * According to RFC 3875, an empty or missing
>> +		 * CONTENT_LENGTH means "no body", but RFC 3875
>> +		 * precedes HTTP/1.1 and chunked encoding. Apache and
>> +		 * its imitators leave CONTENT_LENGTH unset for
>
> Which imitators?  Maybe this should just say "Apache leaves [...]".

I tend to agree; I do not mind amending the text while queuing.

>> +		 * chunked requests, for which we should use EOF to
>> +		 * detect the end of the request.
>> +		 */
>> +		str = getenv("HTTP_TRANSFER_ENCODING");
>> +		if (str && !strcmp(str, "chunked"))
>
> RFC 2616 says Transfer-Encoding is a list of transfer-codings applied,
> in the order that they were applied, and that "chunked" is always
> applied last.  That means a transfer-encoding like
>
> 	Transfer-Encoding: identity chunked
>
> would be permitted, or e.g.
>
> 	Transfer-Encoding: gzip chunked
>
> Does that means we should be using a check like
>
> 	str && (!strcmp(str, "chunked") || ends_with(str, " chunked"))
>
> ?

Hmph, that's 

	"Transfer-Encoding" ":" 1#transfer-coding

where #rule is

   #rule
      A construct "#" is defined, similar to "*", for defining lists of
      elements. The full form is "<n>#<m>element" indicating at least
      <n> and at most <m> elements, each separated by one or more commas
      (",") and OPTIONAL linear white space (LWS). This makes the usual
      form of lists very easy; a rule such as
         ( *LWS element *( *LWS "," *LWS element ))
      can be shown as
         1#element

So

 - you need to account for comma
 - your LWS may not be a SP

if you want to handle gzipped stream coming in a chunked form, I
think.

Unless I am missing the rule in CGI spec that is used to transform
the value on the Transfer-Encoding header to HTTP_TRANSFER_ENCODING
environment variable, that is.

> That said, a quick search of codesearch.debian.net mostly finds
> examples using straight comparison, so maybe the patch is fine as-is.

I do not think we would mind terribly if we do not support
combinations like gzipped-and-then-chunked from day one.  An in-code
NEEDSWORK comment that refers to the production in RFC 2616 Page 143
may not hurt, though.

Thanks.
