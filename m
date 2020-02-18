Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6FDC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 19:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E1C2464E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 19:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOy069Kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgBRTg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:36:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37634 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRTg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 14:36:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so8482346plz.4
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 11:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1b3B/cnU36Oz+p9dlYzR48qDZgNZ3nplBdDI+AmuzjI=;
        b=JOy069Kk76DB+SdwoMvwAyvJElC1rExFJeSluKoXp5dwpihE9NT9FxsubkFt3PRucX
         fuf85CQs+h3OpmKrS7TL8gGslz/pQHrjB1XnMVmLo3Xlpc6EIu39l05Hdcb+UjWzdRWN
         JwUhmFAC0dZp7zRB63BzAsG9LAXnytj1f+4ZNGJosz/0VnqTdCSzDQxNzAOYteuFL52U
         q6Oa47ctTXzeT9OeY3ppLtjuExS2rcMcLVXQT58ReOB5ZQ4q5wpd9W9a4tiiy4WDpVS1
         KoJmiJY5xJxHZETPTDLemc1uXupwK48q5w0ozxul3MciYALHtnp3NsajI6GN4hETDPhE
         As8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1b3B/cnU36Oz+p9dlYzR48qDZgNZ3nplBdDI+AmuzjI=;
        b=nwNYi4xjF7zS9SdVzTXt0du4RFF9Y2fZhVJlTRJnccemrelP12AW7AYtTIyYcAcAO9
         IuQLtgFvijG3e8Fu5jcKISDFqcWTdqXaH6RLJBmaw3wgZqcIXytxZfKruD9WAzMzcfQr
         t3DapqhouGUOQPxCIPPHu7aU8aCdyaXKTt7y4m870KzAhoatOjmPDMFpt4cgFK4OjJkQ
         WQLbUe8HV+qVwBRf0O1EkY7vzkOSAzKbOOQNbEVWQFzeVRnmZWbF6nYlckuaW7CJlkpD
         pGpkuXvJ05COSG9HCmDx5hbpK0p9iJaWepvDSOr3pBS6UNm6Q1lrgooDI7YAvxlnlKln
         QnbQ==
X-Gm-Message-State: APjAAAWV39XASdfHRtia4dv0tMT9hBbtZdVvK+w6cFcO/kSr2hLsFpcY
        hpsu1m+jhaDZhw3lVe7ak2ap6u3i6F4=
X-Google-Smtp-Source: APXvYqxo9HRMWa7PkUx02huOKfPjdUTbv0d02wcSy0tgJBqvQgLNtr/DSXasxcGCO65bcvvyzSi8oA==
X-Received: by 2002:a17:902:ff08:: with SMTP id f8mr23281762plj.261.1582054618791;
        Tue, 18 Feb 2020 11:36:58 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:493e:b22e:e9c8:d09a? ([2001:4898:e008:3:d278:b22e:e9c8:d09a])
        by smtp.gmail.com with ESMTPSA id a35sm5794478pgl.20.2020.02.18.11.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 11:36:58 -0800 (PST)
Subject: Re: [PATCH v2 13/15] pack-bitmap: implement BLOB_NONE filtering
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182236.GM150965@coredump.intra.peff.net>
 <800e4714-200e-6256-5538-ef39f6d9246c@gmail.com>
Message-ID: <ffb700bf-862c-8a40-453b-9d7adb638798@gmail.com>
Date:   Tue, 18 Feb 2020 14:36:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <800e4714-200e-6256-5538-ef39f6d9246c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/18/2020 2:26 PM, Derrick Stolee wrote:
> On 2/14/2020 1:22 PM, Jeff King wrote:
>> +test_perf 'rev-list count with blob:none' '
>> +	git rev-list --use-bitmap-index --count --objects --all \
>> +		--filter=blob:none >/dev/null
>> +'
> 
> I wondered why you chose to extend these tests instead of using
> p5600-partial-clone.sh, but I guess this script definitely creates
> the bitmap for the test. When I tested p5600-partial-clone.sh below,
> I manually repacked the Linux repo to have a bitmap:
> 
> Test                          v2.25.0               HEAD                    
> ----------------------------------------------------------------------------
> 5600.2: clone without blobs   79.81(111.34+11.35)   36.00(69.37+7.30) -54.9%
> 5600.3: checkout of result    45.56(114.59+4.81)    46.43(80.50+5.41) +1.9% 
> 
> Perhaps results for these tests would also be appropriate for your
> commit messages?

And speaking of valuable performance tests to update: should we take
the loop of fetch tests in p5311-pack-bitmaps-fetch.sh and make
equivalent versions in p5600-partial-clone.sh? It would be good to
make sure that the incremental fetches also improve in this scenario.

Thanks,
-Stolee
