Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057B7C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75EE600D4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhETCXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 22:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhETCXr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 22:23:47 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCCFC061761
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:22:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 27so9480206pgy.3
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0Nsy14m08J6BLzLgTDKp0labBZi1ETyBbgCIiUaT/6A=;
        b=LJmOvkjfW5ObVFbj0X95XSetP+Cp8iNNl0AULT3uXvb+cTvZvDyYCGC2bFDtB/eK5C
         hZ5w2CZSvmcT94EGGyiTdojwr32h8Zw7KnNReRQaP+QGtqLwttD6c3zT2TPh8b2nlw7K
         5XjjA3ERRGiZ3GJ6qKVhhhbo0qNcM71tmag7TMHOhIXq861QiP7pLdq4lZlHqpmpGHQG
         DmqWh+mO2j12T6G51N3LusJG9g/IVavp+KdXyArIf26NKhT3BLutn7a2y7Pn3BZQethn
         uOZ5TuP/vVqdmFdaGCy1A0jtyi8ZJZBKlsuT2levxkAwD7b+07zotS+mvDWjv+kbfbDu
         VKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Nsy14m08J6BLzLgTDKp0labBZi1ETyBbgCIiUaT/6A=;
        b=kS6ePFuRVCcXY1yh+u8+EG19bOn7W62GF1aOPSYnAuzfIXetfkbEXM9wQWeUY7QVkv
         o7N/Fk0ldx20jMB4hRmsr06hvai7OdPDTxwEq36NdExuF5lU5OMmBYwlVRucVKhFmwFu
         i2yunNsVr3WeuveHWEwH6g5aUZHqLjnnRGvwY0+ayGRrsZkqTOsw2qPYrfsugQmSMFpr
         FN3pD3zMaSjCgaDzdHt4V7CNdmgAI0NbOO6lTSV82saRXJ/iV2LNG9lnqUjLBqchrDKr
         n7pVODQEmsDSz1HqlRJgWpiNLwMD9BA3kGLkZvmKDPW1GcL3YUwB7Gv45MA1qiF6OdhV
         VHIg==
X-Gm-Message-State: AOAM531Lsg71g3YiJnWnUNeNo7Ps0LSZTItcvY8m3ISlQo0VviqideKW
        UPmyx5DjsqNKrCSe/5mkXxs=
X-Google-Smtp-Source: ABdhPJxe/u/IpthOlslAlPD4DC8ZY8jadW5sw1B7eV8/EGtzn0/H+5NW1rO0AhCtir3fUBMMn6FJ3A==
X-Received: by 2002:a63:a019:: with SMTP id r25mr2141400pge.139.1621477340850;
        Wed, 19 May 2021 19:22:20 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-65.three.co.id. [223.255.225.65])
        by smtp.gmail.com with ESMTPSA id ck21sm604568pjb.24.2021.05.19.19.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 19:22:20 -0700 (PDT)
Subject: Re: [PATCH] fetch: improve grammar of "shallow roots" message
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, gitster@pobox.com
References: <20210518061855.57478-1-alexhenrie24@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <626174ae-ff25-8f07-4d67-705bbe3f7d68@gmail.com>
Date:   Thu, 20 May 2021 09:22:17 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518061855.57478-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/05/21 13.18, Alex Henrie wrote:

> -					warning(_("reject %s because shallow roots are not allowed to be updated"),
> +					warning(_("rejected %s because shallow roots are not allowed to be updated"),

 From descriptive to null-subject past tense, right?

-- 
An old man doll... just what I always wanted! - Clara
