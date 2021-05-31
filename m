Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F337C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3959A610C9
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhEaG5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 02:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaG5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 02:57:38 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B914C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 23:55:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r1so7635387pgk.8
        for <git@vger.kernel.org>; Sun, 30 May 2021 23:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=90Z7Vna1e/x8QPQ1gDkKLt7O3eGgeCYF4wIEbTC49tA=;
        b=kfTtZlh4hSEMRJIlGvdvkVPTsfdAGUSnbLYI84hwAvrsh5Iul9YZWAvvbUEJgPZJ/r
         SPzMayXPZojknjoWaYkmezGAaesdOipZSDtnp5TAWDWPU5ffydFzVyvOikKdHa5/9yGn
         E3RrzsKnls/YdEkBqa0efhKkLcduefoVFWduNvTd3T8p1eMNBDHqgT8NwJ3CYz8Qx8MZ
         T1qA54uYQB6DwiErBJmxIQJSROEsHGZL7usnzXfB+s/r45E7kMn5lPYKEtF99FdWciL6
         NIuZVv86A3J3lKEbIzacHspvWzSmHd/Z2YoBUUJx7CSdk7tXDKCtC8Gv6Vv00wd/9qnB
         FQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=90Z7Vna1e/x8QPQ1gDkKLt7O3eGgeCYF4wIEbTC49tA=;
        b=Ti+I6JGXv8NXHE2pFGlbleMF4aMjSEcOY9ae6S2uZbsNqE1X1WJAQrK+LPANC4zV4d
         GiBo0DFVXv9A3T8kFKlqnFMz6BTZRjnCQLM9MD5J+KhSpILDqjl1PnTjD3+PhE00MdCT
         kYZ7i/rVfpHMGClUXgm7A4sbX8/VtlQAFdzK9VC6wZ4LCy5wMfBBYh3aVaGeT6Y06YIC
         QY4KDGSOvlVd3ZPzHo1uHTdnozBEyIyEiffTb7D+WFwO0NJoWWpM/kOEYe64Mr7u21rY
         IlDoWwE90Pe2z2QANJ3OnfcvS1rDKHYMaF0Hco6HXsOzngq6yMB2huCK8TIopSpZKbXk
         iFzw==
X-Gm-Message-State: AOAM530AMgFtcvx/dK7EolF859oHgJb3VIhok70A5hC7JXBEk4dhK58y
        D1E0UeMgxBKZYp9aQbdwqyb40/F/1ag0Tg==
X-Google-Smtp-Source: ABdhPJyN7nDbLCmikFkxnjY6dGIGJEkOxSGRv184F3R2cZp1uchLbFRHr6whbM2GFW8vwgVZjBQJvg==
X-Received: by 2002:a63:1d2:: with SMTP id 201mr21513747pgb.3.1622444157721;
        Sun, 30 May 2021 23:55:57 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-67.three.co.id. [180.214.233.67])
        by smtp.gmail.com with ESMTPSA id r1sm1906451pjq.2.2021.05.30.23.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 23:55:57 -0700 (PDT)
Subject: Re: [GSoC] My Git Dev Blog
To:     Atharva Raykar <raykar.ath@gmail.com>, git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
 <B932C097-1B91-4D59-9CC7-1B91C86FA1A1@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <2691ddbb-940d-34e2-6865-85890a96ec90@gmail.com>
Date:   Mon, 31 May 2021 13:55:53 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <B932C097-1B91-4D59-9CC7-1B91C86FA1A1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On 30/05/21 14.07, Atharva Raykar wrote:
> Hi,
> 
> On 22-May-2021, at 22:12, Atharva Raykar <raykar.ath@gmail.com> wrote:
>>
>> [...]
>> I will update this thread every week when I make a new post.
> 
> A new blog post is out at: http://atharvaraykar.me/gitnotes/week2
> 
> Summary of what's in it:
> 
> * Deliberate and not-so-deliberate things left behind by developers
>    -- and why they are valuable (especially for my first patch)
> 
> * My work as putting cherries on top of other people's cakes
> 
> * A debugging blooper -- showing my mistakes in the hopes that
>    there is something to learn from it
> 
> The usual things apply: feedback and discussion is welcome.
> 

I think it's better to post link to each blogpost as separate threads, 
because we can discuss each posts at its own merit.

-- 
An old man doll... just what I always wanted! - Clara
