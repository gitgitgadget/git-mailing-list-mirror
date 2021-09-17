Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4C4C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 05:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE8E61074
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 05:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbhIQFYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 01:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhIQFYl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 01:24:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2B5C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 22:23:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q23so6012618pfs.9
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 22:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Y5EKxP5Xpt5Ew8GNtqgVhnQcCpm6SvzrN4avt5HIveY=;
        b=ZB2hU5A2MTBYmr21HowoSdvJuvXE7SAUKng1URaQXupqVW6ckRaTX0/Ee8KUIRlIxE
         LfEHpurkuqT9qs3pXBK4tp/IdvBYMOo0G3BItqHob5hQgcyysT4RgiVuIziWWwLaRNe/
         SQPS+CfGWHgpJhEI7mxZw2JTW5PT1TiVUXGe1z0islpmNEaN9AVVHO2mCSyG/8XubXtb
         L45axzi3VmsTyLoDJthsRvwgABesCYZL/krSRdmnCGSJXvxzLjT8t25CIdMHTF1ZvHu7
         c6WP1zNhKjgrjEOGtbeZwQTB5WpIVqWUG41NG4X//KjIPCpQG8ZjXJDwCH3odKPytgas
         oROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y5EKxP5Xpt5Ew8GNtqgVhnQcCpm6SvzrN4avt5HIveY=;
        b=HvnD/s4KE2AtqD4kCxJPRCIDQViRel08eRkBCxysvvn570yzjnV2ZLcusqHdUVfdBD
         4KkSBunOWIOVu7P0P4pz2ZVhfYpp7fTNlAGIAdeYpUtuwAZXGtOiEDgACzwqHeo7JGLZ
         HuyxdND1baww2Qrqv4R+UWV6jd5Vf+aIxCKe9ZNUpfUY1qFFtOjSIOMoeTMx/Rn4/qcU
         gnGEHD9nqTNGKN6monY9evDkTT0yhbSChM4nu5qOFtQLCJFvgaaIruVuuv1+o0SlK6q6
         dwSYZ9ll64MFfJrnWdB2Pe3fGSNLb1igGx4UmpFt61xk8Rv0ewloytYlAuMvAgVaNqxI
         Vc2w==
X-Gm-Message-State: AOAM531GBxtF7R+E0G3g+tVOUEXjnoV9z8T0tw0lpwm9Iv33D32HDGXH
        c2P66YAY5TxOSHYDlZOxp+d6rBVJCbGTNQ==
X-Google-Smtp-Source: ABdhPJwUhGEJd9Tnzh6tliuuwoYtdRhD4/9YuUwwSEgT4TfRJ1RaBxn1WnvUHX1sA/mSCOr792NjoA==
X-Received: by 2002:a65:64d1:: with SMTP id t17mr8189121pgv.291.1631856199734;
        Thu, 16 Sep 2021 22:23:19 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-30.three.co.id. [180.214.233.30])
        by smtp.gmail.com with ESMTPSA id u9sm4914486pgp.83.2021.09.16.22.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 22:23:18 -0700 (PDT)
Subject: Re: Feature Request: Submodule Warning When Cloning Repos
To:     Geoffrey Knopf <gknopf@spideroak-inc.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <SA1PR17MB46101CC190E4CDDD00F2AD2C9BDC9@SA1PR17MB4610.namprd17.prod.outlook.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3ff1426a-73a4-731e-3b6f-269d9a900019@gmail.com>
Date:   Fri, 17 Sep 2021 12:23:16 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <SA1PR17MB46101CC190E4CDDD00F2AD2C9BDC9@SA1PR17MB4610.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/09/21 23.59, Geoffrey Knopf wrote:
> Problem:
> Easy to forget to clone submodules.
> 
> Existing Solutions:
> Always clone repos that have submodules with the "--recurse-submodules" option.
> Manually look inside the git ".submodules" file to see if there are any submodules and initialize and update them.
> 
> Request:
> When performing a clone, warn the user if there are any submodules that have not been cloned.
> Recommend that the user try the "--recurse-submodules" option next time or initialize and update the submodules.
> 

I don't think warning should be granted in this case. Maybe better as note?

 From what you wrote above, did you mean print the message when cloning 
any repo with submodules?

-- 
An old man doll... just what I always wanted! - Clara
