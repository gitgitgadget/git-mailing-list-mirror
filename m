Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8781920248
	for <e@80x24.org>; Mon, 15 Apr 2019 13:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfDONcN (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 09:32:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44298 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDONcN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 09:32:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id w5so18992155qtb.11
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5J4iYlJokMBGoL1I3obeHQFA0xbgh69IQH8Fp9H8g2M=;
        b=X3xKqXHAPLYVWSUcuk3j4ZqVqOdVnHO8MXiG/O05sJB53KSedBUpD42ikkip2hvk0I
         JWcJjZToF/7EmvrswcvKlmGiFt6vhBlAN3eMIRZtZE1fNQCs1MtLLBely5l7FShsOuFi
         nCuO+STvedkQtRrftF6+CRRUYXLZ4RjIwMSm6zQCXJ8giMnGJdIZhS9dbunMs7rzRIpQ
         4VhbpSZNJm1kv3g4DT3XloTzEf6k7YQNlkIkzH/224Fhu/7Gx2eqlqB37Ejmjs25rR3z
         iPaLKwNNhueWQSLPzcvNbtVsvpa3XcXzSvEOgXMZd8JOMdAiZIwXsP31xTjdTF91OizW
         Oweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5J4iYlJokMBGoL1I3obeHQFA0xbgh69IQH8Fp9H8g2M=;
        b=uMFdryx/hRvOCWgNQYjwewJxIF19p63qDxJSCJeRlohpYiw/VIJ3sk6jjxCcXeojo8
         mZRxAB8qmAL/57+ERy9sD69E0g9IvoR9G2Q2LMwPxtbhjizcgMNlbem/Iw+4cfxSmmzb
         cEjorKeF/6CWCR8fYNCUIR0uf8bkP+Y3KwqptSZtrxl4rVUP5xtiGndh6IG/pscFYs4h
         avqj0Tqpt2WVC3YHRLlZn46LaNg0MnYHQeR2Am/jlz9rBbXvj5NjhZLGd1FtyZLYgMTl
         Fme+it38a2ceKHMvaq0hf7nZUpAsbTIeNmx20sTFkOS0uDfdyK51XNpS9T9tix8pGdUm
         gSYw==
X-Gm-Message-State: APjAAAXQ/hdNJionm/ME5u6UlK0EJvWgPqaNtwldKWnofhGzzMODgRTd
        jFnzTiQ/kklLk+hspaMyTL5LdQ==
X-Google-Smtp-Source: APXvYqzhtbfsZnWHWkZIID9mPoGGFkVZjgGrlPPpJNPh7WMIVQpYkTrlntMFKyJsnso2nxxMiFvN9w==
X-Received: by 2002:ac8:2f59:: with SMTP id k25mr62466721qta.254.1555335132155;
        Mon, 15 Apr 2019 06:32:12 -0700 (PDT)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id v129sm28080474qka.77.2019.04.15.06.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 06:32:11 -0700 (PDT)
Subject: Re: [PATCH v6 3/6] blame: add the ability to ignore commits and their
 changes
To:     Michael Platings <michael@platin.gs>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
References: <20190410162409.117264-1-brho@google.com>
 <20190410162409.117264-4-brho@google.com>
 <878swhfzxb.fsf@evledraar.gmail.com>
 <CAJDYR9Q-ixsxWyMrm7aCojTv33SOj3+ALPwJYo9DJE7vLU=DEA@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <7378e4c5-b86c-a7c2-c2df-3beaff0c5970@google.com>
Date:   Mon, 15 Apr 2019 09:32:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAJDYR9Q-ixsxWyMrm7aCojTv33SOj3+ALPwJYo9DJE7vLU=DEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/19 6:42 AM, Michael Platings wrote:
>>> +     the `blame.ignoreRevsFile` config option.  An empty file name, `""`, will
>>> +     clear the list of revs from previously processed files.
>>
>> Maybe I haven't read this carefully enough but the use-case for this
>> doesn't seem to be explained, you need this for the option, but the
>> config file too? If I want to override fsck.skipList I do
>> `fsck.skipList=/dev/zero`. Isn't that enough for this use-case without
>> introducing config state-machine magic?
> 
> The difference between blame.ignoreRevsFile and fsck.skipList is that
> ignoreRevsFile can be specified repeatedly. This is useful if you have
> one file listing reformatting commits, another listing renaming
> commits etc. Or maybe a checked-in list of commits to ignore, and a
> personal list of commits to ignore. However sometimes you're going to
> want to *not* ignore those commits, so you need a way to discard the
> previously specified options. To accommodate all operating systems an
> empty string seems the best way to do this.
> 

In a previous round of reviews[1], this style was recommended.  It's 
based on what credential.helper does.

The main thing I've been using the --ignore-revs-file="" for is to turn 
off my default ignore list for debugging.  =)

Thanks,

Barret


[1] 
https://public-inbox.org/git/nycvar.QRO.7.76.6.1901181038540.41@tvgsbejvaqbjf.bet/
