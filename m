Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C071F404
	for <e@80x24.org>; Mon, 26 Mar 2018 13:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeCZNIH (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 09:08:07 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:41604 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeCZNIG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 09:08:06 -0400
Received: by mail-qk0-f170.google.com with SMTP id s78so19923541qkl.8
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7mLy39hSyp3stQ1vvoMynutNkGwVpxKig/Rsn+pA2Bo=;
        b=MNYMJ/S73kRQjCchV6LXoAAlbHRuWlAUlY6WmyHAJxuGXbysMOhBmuMQaXrP7iXg9Q
         7li1iaX4qMUhuvuNzhiF/9eLYZTXZMyEbKAveVQv5ixHlPjVVgsYNg3J90IiaTCRidJe
         Gzw5Kp3Ik8gNrQ/tLQqaxFf/NBXiQeukH9OGo02BpcEUB3Xl+7MmtU82AS5apHOCjMWB
         +EmblxA5wZWMqGt1FsFx3E/+TwhLmMVd8ug1A3L/K1bJEHESg+CvTQ/naUdVWNtbKWV3
         pdAQFoWlwnRWpJS0f1783tK9dxM0ziGXzvvupcNhgGGcJYEN2pQ70/naszIFAKzMYSyV
         AwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7mLy39hSyp3stQ1vvoMynutNkGwVpxKig/Rsn+pA2Bo=;
        b=R1pVRDkXkTIV/Aez8GI/HY6v9iWChVYYHNIr+cRtgDlxRAtBiHc4gTKXZMdVfDFXzC
         a1S9EmS/LDyE5lTBiuE4U2aP2RlT5ScWGadOchOY/qlNUZFdBVggVYI5BrUndIl+0e7O
         fZgpRd1ZKCkxFWDvKKWIy9kv0Aoj5PkKc1Q/1OVgp2tZZ3GpJvH62rLYOSpKp0hoBpYg
         3kGc3D8XrhKaqiCNm5QC+M0faQiPFQ5mEWPOKC0/6QQ9b9mmajzUjtfNvawewHWeONnC
         VZ1+wiVS+mxGEc0bsNPFepGc1KAtHaZu0Xq18J0dIByAbyUThHN3+2JJrGLCV0FHBXKx
         p2NA==
X-Gm-Message-State: AElRT7GkkLCXnDLd2k9TtIHF9W+t2++EUb9AA/uM827cmAfYanwBBCav
        XO2SgP03k3kiaeHsrZUFM3E=
X-Google-Smtp-Source: AG47ELvUAeRY42o5bZfpOl6yb9IzyA5rAgt5PbAJnh3nJ0SR3jsFGs9gCVEzP8w0M6BHH3k9GuJm/w==
X-Received: by 10.55.42.15 with SMTP id q15mr55904623qkh.9.1522069685686;
        Mon, 26 Mar 2018 06:08:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id f197sm11587408qka.3.2018.03.26.06.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 06:08:04 -0700 (PDT)
Subject: Re: [RFC 0/1] Tolerate broken headers in `packed-refs` files
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        ethomson@edwardthomson.com
References: <cover.1522062649.git.mhagger@alum.mit.edu>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f8d0f3b6-69b3-ba42-c39c-551814caf335@gmail.com>
Date:   Mon, 26 Mar 2018 09:08:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1522062649.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/26/2018 8:42 AM, Michael Haggerty wrote:
> [...]
>
> But there might be some tools out in the wild that have been writing
> broken headers. In that case, users who upgrade Git might suddenly
> find that they can't read repositories that they could read before. In
> fact, a tool that we wrote and use internally at GitHub was doing
> exactly that, which is how we discovered this "problem".
>
> This patch shows what it would look like to relax the parsing again,
> albeit *only* for the first line of the file, and *only* for lines
> that start with '#'.
>
> The problem with this patch is that it would make it harder for people
> who implement broken tools in the future to discover their mistakes.
> The only result of the error would be that it is slower to work with
> the `packed-refs` files that they wrote. Such an error could go
> undiscovered for a long time.

My opinion is that we shouldn't maintain back-compat with formats that 
may have been written by another tool because Git wasn't strict about 
it. As long as Git never wrote files with these formats, then they 
shouldn't be supported.

You are absolutely right that staying strict will help discover the 
tools that are writing an incorrect format.

Since most heavily-used tools that didn't spawn Git processes use 
LibGit2 to interact with Git repos, I added Ed Thomson to CC to see if 
libgit2 could ever write these bad header comments.

Thanks for writing this RFC so we can have the discussion and more 
quickly identify this issue if/when users are broken.

Thanks,
-Stolee
