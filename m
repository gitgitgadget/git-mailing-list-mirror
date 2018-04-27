Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9911F424
	for <e@80x24.org>; Fri, 27 Apr 2018 01:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755737AbeD0Bmw (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 21:42:52 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33286 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeD0Bmv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 21:42:51 -0400
Received: by mail-pg0-f43.google.com with SMTP id i194-v6so281754pgd.0
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lmAg9ZnT4jpK4L1aSnBej9j5RD9bZnnJpP8K567an1Y=;
        b=PqkWU9uvfcdphYG841m+fpOU+V8/lkSb1spTunDG52L+1ksS0YtIxZES7jy/fZqvsJ
         wimepJd5z4XA1TRbkj03RXh71Oo0AYBMoObF03DIv9jdmVcnrQkimuvF3YqSIBAGuU/h
         SAN4Am4+uTiWzuQ3zXNjsZdUYkjwpM2v+BIbUbib6LNqAcrrAjTw8wrDjlAwhGEklvtz
         gYI4VYfHoD/8KpGmkxaf9G72wYcEzhlRtR2UGu182nL7nBD6FgpLJfZMP54gfXw0thhB
         QX3JkSE+WpR0badTe0B6SK1MWH/iK20XIbG1912Hrap3LlP3ITQXJScJhU3b1x+PB+wO
         ZAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lmAg9ZnT4jpK4L1aSnBej9j5RD9bZnnJpP8K567an1Y=;
        b=b9be/ju4sE6L+iNWNglNhQAJMFKxoq9h75aMNd7TcbZdgkr6rshQsYABLtZkIQwAP8
         TDQLx2cOpoqgum5VURX86KmEmXa24nzkBh++4mCWS4HNuMYwQN2li3KsU0+p6/e+dLKT
         Z4t572Hbk4nwndvbBFOi208JgD+aNZ8zBo6R4NCWU9rpDvypvjl/YwqYVArmRtQDShAI
         m1QbKrobUNzkt/D/hRyb0a8afWHtaWfQtaMdw/xDSC+VFgRtIxq62/epk+5TsO8f86QF
         m7zO9oQRQd4c1cYJdAABH9RkCuDxyvGYqYyvDttJuFUsRX5JTS+GWiWIbuNQzctZpsQH
         nEpQ==
X-Gm-Message-State: ALQs6tDpc5qrxiOqLnwMkmpzn6D7eSMNRNcEmKInpXld5n+PiI0JefTR
        x+bGEqBpUlSGN5AIm55mc6zE9g==
X-Google-Smtp-Source: AB8JxZqr1gLPkgxqplhj3t/3UAtaYPVfP9x7IYk4xMBuQuPo8/JgXH+F6Y/G0q16dUfbi/VASiIWQA==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34-v6mr375249pld.65.1524793370873;
        Thu, 26 Apr 2018 18:42:50 -0700 (PDT)
Received: from [172.22.44.62] ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id v10-v6sm191219pgt.33.2018.04.26.18.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 18:42:50 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] blame: prevent error if range ends past end of
 file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sunshine@sunshineco.com, szeder.dev@gmail.com, git@vger.kernel.org,
        peff@peff.net, bturner@atlassian.com, jacob.keller@gmail.com
References: <CAPig+cSH-y7ChDE_LW55M_wB=KhD7uJHXX=OvZ=1ri5KfYQ5Sg@mail.gmail.com>
 <20180426074502.78318-1-istephens@atlassian.com>
 <20180426074502.78318-2-istephens@atlassian.com>
 <xmqq7eot1nhl.fsf@gitster-ct.c.googlers.com>
From:   Isabella Stephens <istephens@atlassian.com>
Message-ID: <25cd86ff-a5c0-a968-62d2-4365e5e17a81@atlassian.com>
Date:   Fri, 27 Apr 2018 11:42:45 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq7eot1nhl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My intention was to modify existing behaviour as little as possible,
but I agree clipping to the first line makes a lot more sense. That
raises the question though, do we clip to 1 and treat -L,-n as a valid
input, or clip to -1 so that this case be detected?

On 27/4/18 10:50 am, Junio C Hamano wrote:
> istephens@atlassian.com writes:
> 
>> diff --git a/line-range.c b/line-range.c
>> index 323399d16..023aee1f5 100644
>> --- a/line-range.c
>> +++ b/line-range.c
>> @@ -47,7 +47,7 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
>>  			else if (!num)
>>  				*ret = begin;
>>  			else
>> -				*ret = begin + num;
>> +				*ret = begin + num ? begin + num : -1;
> 
> When parsing "-L<something>,-20" to grab some lines before the line
> specified by <something>, if that something happens to be line #20,
> this gives -1 to *ret.  If it is line #19, *ret becomes -1, and if
> it is line #18 or before, *ret becomes -2, -3, ...
> 
> Is that what we really want here?  It is disturbing that only line
> #19 and #20 are treated identically in the above example.  If it
> were "if going backwards by -num lines from begin goes beyond the
> beginning of the file, clip it to the first line", I would
> understand it, but as written, I am not sure what the code is trying
> to do.
> 
