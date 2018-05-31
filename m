Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CD561F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeEaFIE (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:08:04 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34906 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeEaFIC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:08:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id x9-v6so10159921pfm.2
        for <git@vger.kernel.org>; Wed, 30 May 2018 22:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IEoZZbJHAruYn087AyfUN+qvrgtWz37gCUCseVNAzmg=;
        b=zbL5NAMCHo3JKeeuJLfHzBUDljuJnq9q/7QFzYMoQUkERzQxubdoIQKXQuCd0Q5o4x
         rA1vz6O8ihYlwau33mzpbC3/v+uywM9L8zxqszvLfm550cbHgjP/2wG1ztlzBnQCDAAq
         v0Q4lKq4V4be9x6IAP3M96khvUua14141TUZfDpzms34OTRHz5OPzHGHtQaN7Sm6V5AJ
         Y6y8l76P4HXWhq4wjZ+DX5rKCZX3y5a0W1mfU+jd7VqliPOfX1iiS+3DPVw5U9nmZ/+T
         rnW/a9nTRpIrQnmcBo5aXtV8y7HpYESYBKd0Jrsz1sNaNcmaglauxokXRPbSa/gfDwcY
         j9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IEoZZbJHAruYn087AyfUN+qvrgtWz37gCUCseVNAzmg=;
        b=TwA/AB/ybU9y+VlfCh8X5nhOQ7q1Ycr5sxxl3Gg+lcOACO46+IwZWlldWazIXPoVtI
         xL+Ml1IGXYF0TTl8MSmZOFQ66slnna5c+dZv763ogK9iNAup2K0vtY2h2qUNM9sXff2T
         o994AYh3KMEPyMRm3uMAXEYrPW0Zd0cAhqAAvuFSpTw1SIb6e2Kdz/ng0DxOwhRt0HSa
         fYmEgdsIf0jfd0IKAu6EJ0NuF869Yx6Yk6EhLHXp/MNyVPobJa+NQObSuPja7kzo2VZY
         RZ8ymOOI+Y1us+ryQT9rLrLpNjSRbCWZMAVK7KOCSupN61jeDWNUMuzJo7bRNdbi0K/+
         MyvA==
X-Gm-Message-State: ALKqPweRSW56fjPS3Bt1tuF8thcz8y4ugxROE3YSSKc3KIQc3ykQVGhb
        9oizs8SyqaZd+3MnpgWuDq1iEQ==
X-Google-Smtp-Source: ADUXVKJb8OCPI6pg2XZZBLdYC5pM/2cI5BzvWwmyv6Rlr/YifYTfIlkRh5Az5JCNUf6N4g32Q8j8mQ==
X-Received: by 2002:a62:6c87:: with SMTP id h129-v6mr5372005pfc.179.1527743282357;
        Wed, 30 May 2018 22:08:02 -0700 (PDT)
Received: from [172.22.44.62] ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id m18-v6sm47903853pgu.67.2018.05.30.22.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 22:08:01 -0700 (PDT)
Subject: Re: [PATCH] blame: prevent error if range ends past end of file
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <xmqqzi1iwz7l.fsf@gitster-ct.c.googlers.com>
 <20180529053037.38015-1-istephens@atlassian.com>
 <20180529053037.38015-2-istephens@atlassian.com>
 <CAPig+cTCDP0zJonDFXyv6Kue5y4PMPaveyjfvfTVNoifzYg-Og@mail.gmail.com>
From:   Isabella Stephens <istephens@atlassian.com>
Message-ID: <6c715a0c-2ad1-b2dc-d3d5-d4175632236c@atlassian.com>
Date:   Thu, 31 May 2018 15:07:57 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTCDP0zJonDFXyv6Kue5y4PMPaveyjfvfTVNoifzYg-Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/5/18 6:45 pm, Eric Sunshine wrote:
>> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
>> @@ -152,6 +152,16 @@ Also you can use a regular expression to specify the line range:
>>  which limits the annotation to the body of the `hello` subroutine.
>>
>> +A range that begins or ends outside the bounds of the file will
>> +blame the relevant lines. For example:
>> +
>> +       git blame -L 10,-20 foo
>> +       git blame -L 10,+20 foo
>> +
>> +will respectively blame the first 10 and last 11 lines of a
>> +20 line file. However, blaming a line range that is entirely
>> +outside the bounds of the file will fail.
> 
> This documentation seems misplaced. Rather than inserting it after the
> discussion of -L/regex/, a more natural place would be just above
> -L/regex/ where -L<begin>,<end> is discussed.
> 
> However, I am not at all convinced that this behavior should be
> documented to this level of detail. Doing so assigns too much emphasis
> to what should be intuitive, thus wastes readers' time wondering why
> it is so heavily emphasized. At _most_, I would think you could say
> merely:
> 
>     A range that begins or ends outside the bounds of the file
>     will be clipped to the file's extent.
> 
> and drop the example and discussion of the example results altogether.
> 
> In fact, because this new behavior is what most users will intuitively
> expect, it might be perfectly reasonable to not say anything about it
> at all (that is, don't modify git-blame.txt)
Thanks for reviewing Eric. I've submitted a v6 patch in response to your
feedback.

I agree that given the behavior is intuitive it's not necessary to
document this change, so I've reverted the change to git-blame.txt
entirely.
