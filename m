Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7192022D
	for <e@80x24.org>; Fri, 24 Feb 2017 04:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbdBXESP (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 23:18:15 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36261 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdBXESO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 23:18:14 -0500
Received: by mail-pf0-f194.google.com with SMTP id c193so447465pfb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 20:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QYnHzpJGqi+RFdpmzqBAhQavWw+38er6LGdIJtpXvv4=;
        b=S7fZVO9e052he3LXJ5tQ5hPONtLHv2L+f7Z1tzbW/5mVOKDPSiqT3+GHLdcf9jolZZ
         CBph2tW40P945FZwNVB2z7F23mOocV/JBHvTbMF5aTVgpdy7Y9iEy+C72jYOGQAtlAo8
         31Rs4CC1EcOmTaZ7OBzSk10PStCIPAP5s1ocby8oSk8WJXXkE56AlvXXAxuJ7tYhs1KS
         ylsrKbQRo0DZySUbUoIHvfx4b71k8opFmCCVx3bddae9xRZXfr5efBJbTAu7cC597vmd
         ZtEHKMFTRQ6LGZsO8XBXiR7Odeo/Kj7i66zxX727qacso22lhleCztWoCF7CGCe0Stzc
         6WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QYnHzpJGqi+RFdpmzqBAhQavWw+38er6LGdIJtpXvv4=;
        b=hzG47YaFr8EC82DPNygQ5KqkkUZewKvgKk+6qhAfBQ7cPOtgwQatHs+WvJf26Xufsg
         mFpEDoxQ779CQ3v5uvspPrfbITTFnbb5j+0VaSLj87km0547DXRJer4QCXREk1g50BTn
         k5xOLFn4gkwpIEk0DK35EJ7n3eHgfPNPANIrl5aBGYdiIXx4iaEAkQMyqwNy3mnk5fw9
         cQOCdX/t3kaBi/omfi/nXtJ7j+NX5onoX1o2BFCq5ZZ4nQAzIzzva5PPTLj611lPjaR1
         VMFiNrAU8XmQicpkDSd76NQlz/3newLkNGNveOZtnJNoixYKkVgusmj+I4k4ta5ZCuLx
         fVvg==
X-Gm-Message-State: AMke39lAlGgky5GeLK5eaqUrvD3Upr1xqxaUG80khNB3mB6mE0McxoXTaa6u1OzUSny5OA==
X-Received: by 10.84.215.144 with SMTP id l16mr1061766pli.120.1487909865685;
        Thu, 23 Feb 2017 20:17:45 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id m12sm12335489pgc.46.2017.02.23.20.17.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 20:17:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] config: reject invalid VAR in 'git -c VAR=VAL command'
References: <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
        <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
        <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
        <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
        <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
        <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com>
        <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com>
        <20170223055831.u3yofkby3c56t7l4@sigill.intra.peff.net>
        <xmqqo9xt8jcf.fsf@gitster.mtv.corp.google.com>
        <xmqqy3ww5wbl.fsf@gitster.mtv.corp.google.com>
        <20170224004105.ayddcwlnpmq7tifu@sigill.intra.peff.net>
Date:   Thu, 23 Feb 2017 20:17:44 -0800
In-Reply-To: <20170224004105.ayddcwlnpmq7tifu@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Feb 2017 19:41:05 -0500")
Message-ID: <xmqqh93k5ijb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  	pair = strbuf_split_str(text, '=', 2);
>>  	if (!pair[0])
>
> Hmm. I suspect one cannot do:
>
>   git -c 'section.subsection with an = in it.key=foo' ...
>
> Definitely not a new problem, nor something that should block your
> patch. But if we want to fix it, I suspect the problem will ultimately
> involve parsing left-to-right to get the key first, then confirming it
> has an =, and then the value.

Backtracking will not fundamentally "fix" parsing of

	a.b=c=.d

between twhse two

	[a "b="] c = ".d"
	[a]      b = "c=.d"

unfortunately, I think.  I do not think it is worth doing the "best
effort" with erroring out when ambiguous, because there is no way
for the end user to disambiguate, unless we introduce a different
syntax, at which point we cannot use config_parse_key() anymore.

>> +	if (git_config_parse_key(pair[0]->buf, &canonical_name, NULL))
>>  		return -1;
>> -	}
>
> I think git_config_parse_key() will free canonical_name itself if it
> returns failure. But do you need to strbuf_list_free(pair) here?

Yeah, I missed that one.  Thanks.
