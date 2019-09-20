Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20731F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404086AbfITPfP (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:35:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40164 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404034AbfITPfP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:35:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id y144so7706242qkb.7
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gWKJKmJQZvLVRCJJuG27uFkO2xEkuMxtCzDr64xXc48=;
        b=mSSbWckKUT00QCmspyJMEM771TYVms0UkFQXmoej6EAfB3F2xtGlI2camagw7lHgoS
         TWiY3UlS+sheFqeEFNKs+KgAUHCAZoFMiv7uAI7GAV+VJlS5tMdO1WP+hqCtUfM4Ld2i
         j0d8YITFC+7XdOjEk8XU9t92Iy30A1isgIKcBEtilImz47Hn7JCVFjlKZ+FXkTwUhPJ6
         QQwlxlfysuBtoQvH/vFeU7UbFqBuHTJQDz2YOLUxFjwqleOW01dCaocq6z0cdjAVWcEE
         8hD0EXWRNtRPss/VzDxIE3DbNrPSQKdkK8PrTY0ELqMxbHz5s2Vum3rpCROp4DfeQzy2
         3/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gWKJKmJQZvLVRCJJuG27uFkO2xEkuMxtCzDr64xXc48=;
        b=IuaUqUaGPkOzoNZLw9LvwLOjr2ZdDi5mCzfDvZvljlX6TZ+L5030jC2oUtqhx2FDVS
         QFimtgk524EXTWrW9zJclhGcgSMPPbR3ypCZ5d/tv3y8IcCAjsT1+8FS0bqWqZfckU1u
         eOBukdRGCXg8Ot0R/HK0Kg0grT5gEEKKsiYLCNQYAz/5IiM2+0UO6Md55VJn5UeXSjNa
         KZgKvxFzRwWF7nHeop2f+CjvrODdRzfOUV52cn8DpkT+zcdpLtZ4p8A7b4ecV1MePWG2
         OQSbjHWea3Tj4PzISg83t8W8Uvu3L3FUO6RKwzza4HXJs2rPPm1BCuFCLrpPZ2VwDGlS
         bxAw==
X-Gm-Message-State: APjAAAVJUw7y1ofyI9v4mX8omXXWyZ40HNRQwY82g3s8qI3Xru9/6Mfw
        zURu40xNAkAw635m7VeXedTovlCnLrw=
X-Google-Smtp-Source: APXvYqwhakDlf9wbBBYsJzUF5sGeCmKBVmyyoCceK5ES+sjk1YT8PUGSOHOFYIZwoVkRRbTHoScmBA==
X-Received: by 2002:a05:620a:6cf:: with SMTP id 15mr4362730qky.112.1568993714286;
        Fri, 20 Sep 2019 08:35:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:142:491c:a46c:6a48? ([2001:4898:a800:1012:89d6:491c:a46c:6a48])
        by smtp.gmail.com with ESMTPSA id h68sm1160462qkd.35.2019.09.20.08.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:35:13 -0700 (PDT)
Subject: Re: [PATCH 15/15] name-rev: plug a memory leak in name_rev() in the
 deref case
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-17-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f354882e-885b-baba-60f0-8dfeba273bfc@gmail.com>
Date:   Fri, 20 Sep 2019 11:35:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-17-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 5:47 PM, SZEDER Gábor wrote:
> The name_rev() function's 'tip_name' parameter is a freshly
> xstrdup()ed string, so when name_rev() invokes...
This patch 15/15 seems to be the same as your 14/15, and
we should use your _other_ 15/15, right?

Thanks,
-Stolee
