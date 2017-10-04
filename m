Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD7F20365
	for <e@80x24.org>; Wed,  4 Oct 2017 13:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbdJDNUk (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 09:20:40 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:50071 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbdJDNUB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 09:20:01 -0400
Received: by mail-qt0-f174.google.com with SMTP id o3so19066626qte.6
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9cd6HzijSt5cv5+zmDm+8BSx+QsH+YPdcKrc6K8MVuA=;
        b=kgHKEcP27H0Fqfoah0i6j5CfjrXJwqT1MD9q+AZIHWo0qZ6kgwS5fA0mFePketax3g
         bCBux7W272zPM2SQaE0h9lpdvOWjfEo2w5nZwl1vu95oxyHxlAY9RTVN60ZM3ndsuRvx
         zicJdR32Rq/jc/QDtMs1buv//95XS9UpecQyfpELUxEmoirq9KER4Qk0nwieZZBX+ts/
         W4wu3WM5a/3h6XMwQzpcbuuNS8oJP36e/7cBtGxjZgmhG6EX1ffv0EP+LlSTU9WLWK0O
         Fef3pSf5PxbqCVtwPzvfMUQAfpBbu+WXUXjj55CTveJYvGgHlJf/7tOcdx4gjVi6bq9H
         g4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9cd6HzijSt5cv5+zmDm+8BSx+QsH+YPdcKrc6K8MVuA=;
        b=aAOP8qDvRKBRNK+N6B3yOWYxqmJQf03LHYbQJoOdP6gV9P6qxEDabEPDCLCJQWBXfz
         m3f3+o5gO/HNNFWVe1lrrJqApr+jGMbiuy4ba5VledGh/EsMwATLz+BZpFRzNmFF47JP
         poEf/0pkWjrP4/7f4NAw4C5/zlU6MtJapfWXxvjgjvn2FWgKfBTWCha90Kw3MPcNXbsk
         THf28iG1m9tTg2Xh2/jHXr5eWcRh43YOxywNqTqw1pE7QSkENl208RQ/kqmxLYPQw3nU
         Qn6yokgI9W0rXM/4HZK9IZW+/AY4s6aZh5Vwq0baF+PWdpDylUKuUecVsLBFi6CW22Iv
         XAfg==
X-Gm-Message-State: AMCzsaWHFCUA5RUZFiJI6/gACUOlx6fXiBMynLGnuut65ynxTstMpQ/e
        s2Z2FcdXeWixj+s39hPJjTg=
X-Google-Smtp-Source: AOwi7QAXRvg930oePZS+6TNSpyb4U/PLgGOfwTAaxGzfbFAnKdVN8+ZzURlH7yDif6zBwGzv6xKR+g==
X-Received: by 10.200.46.188 with SMTP id h57mr20905924qta.9.1507123201015;
        Wed, 04 Oct 2017 06:20:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id b57sm10494293qtb.3.2017.10.04.06.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 06:20:00 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] sha1_name: Unroll len loop in find_unique_abbrev_r
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, sbeller@google.com,
        Jeff King <peff@peff.net>
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20171002145651.204984-4-dstolee@microsoft.com>
 <xmqqtvzfcuoy.fsf@gitster.mtv.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a6653525-94f2-fd7d-8c27-9334d473a556@gmail.com>
Date:   Wed, 4 Oct 2017 09:19:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvzfcuoy.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/4/2017 2:07 AM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> -	exists = has_sha1_file(sha1);
>> -	while (len < GIT_SHA1_HEXSZ) {
>> -		struct object_id oid_ret;
>> -		status = get_short_oid(hex, len, &oid_ret, GET_OID_QUIETLY);
>> -		if (exists
>> -		    ? !status
>> -		    : status == SHORT_NAME_NOT_FOUND) {
>> -			hex[len] = 0;
>> -			return len;
>> -		}
>> -		len++;
>> -	}
>> -	return len;
> The "always_call_fn" thing is a big sledgehammer that overrides
> everything else in update_candidates().  It bypasses the careful
> machinery set up to avoid having to open ambiguous object to learn
> their types as much as possible.  One narrow exception when it is OK
> to use is if we never limit our candidates with type.

I do not modify get_short_oid, which uses these advanced options, 
depending on the flags given. find_unique_abbrev_r() does not use these 
advanced options.

> And it might appear that the conversion is safe (if only because we
> do not see any type limitation in the get_short_oid() call above),
> but I think there is one case where this patch changes the
> behaviour: what happens if core.disambiguate was set to anything
> other than "none"?  The new code does not know anything about type
> based filtering, so it can end up reporting longer abbreviation than
> it was asked to produce.  It may not be a problem in practice, though.
>
> I am not sure if setting core.disambiguate is generally a good idea
> in the first place, and if it is OK to break find_unique_abbrev()
> with respect to the configuration variable like this patch does.

I do not think that type-aware disambiguation goes through this code 
path, since it requires giving different parameters to get_short_oid(). 
Test t1512-rev-parse-disambituagion.sh has a test 'core.disambiguate 
config can prefer types' that verifies this behavior.

> I'd feel safe if we get extra input from Peff, who introduced the
> feature in 5b33cb1f ("get_short_sha1: make default disambiguation
> configurable", 2016-09-27).

I look forward to more feedback. Thanks for taking the time to look at 
my patch series.

Thanks,
-Stolee
