Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496AFC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 11:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF47610C8
	for <git@archiver.kernel.org>; Mon, 31 May 2021 11:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhEaL2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 07:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhEaL2q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 07:28:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A24C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 04:27:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q16so5086722pls.6
        for <git@vger.kernel.org>; Mon, 31 May 2021 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hE6Q8yVS27QI3nOphvfNv31AZTlH+YokIJRtBYLBkfU=;
        b=NMAxlQJtajKYkiUdUYnksN8p+4TWJccfPpDQgCfexo+ufyNPPM5I2CgAasKrMLq3BA
         we4JUBOQfEDBrFdbpdfUDE3VpgDMNBzL8txX21Nz3tCr/Xzf+RINPoIsyZCyJTKGSlvx
         Wg9BgmIvbNw4kysALuuhZ8o4vhsNQjaxA7n65ov5MJESL0khpTCcpVie0NUg+Dg4BuNR
         VbBbSa/ZHvAgANYj5+jc7RJH+DHUJ4l2EgxNNa2S77oALEyki5Id2zGDRP6j6nhJShYu
         Pz3w2kovLreazSuqk1gy5M9XCt+tUb3uT/QQZ6kokvClxKhS11Qxy1AKWZEmeqd+4JRO
         KFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hE6Q8yVS27QI3nOphvfNv31AZTlH+YokIJRtBYLBkfU=;
        b=dEDcqtlhh32mMh+eqycnVjBzKo+TOZ8newtRdJMgS92QWiVpCHisS+ZzkFXZG8SO/y
         55grpJOrChOrECDr/76FUSnWpOwBjWmCZOIcqXRko/ay0RKErSmRAVBzq3gz+jMwy0ck
         zsQju1Gz/ZSgKXo3qG7rhyVf4Y3E/rOjAnVxsa+L4nE0r+r0WLlY3v5w8heqBtn8V+Fz
         lOqhCyIxGWpsBBdsi6XgF0vZUVTbBm0XJzot/YjUxgLrLcgR6dvIW3Q9Y+LMSCFPzmUc
         V7z5qrwQjhCjlMeI/uHLPk9VztyhhpE61AuboVdIaPUBkIFl4Fu0jOQGUosyOWCQBpLW
         Y+7w==
X-Gm-Message-State: AOAM531+9hW+//vMC9uFNiKEwFU7MwSP+okRcb5kZwzr0EXjZ22uKFHM
        eCR82fr4aN5doYo0mhUoKD9fsSrJ68hgcQ==
X-Google-Smtp-Source: ABdhPJyREbsNJtgcJ59sVcKSfbyv3ksIatHy2/K2fvAAMdYgzJ/BCFdqOgyq3MBZdP0AqNdWhdhdbA==
X-Received: by 2002:a17:90b:358c:: with SMTP id mm12mr11012815pjb.178.1622460424313;
        Mon, 31 May 2021 04:27:04 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-74.three.co.id. [180.214.233.74])
        by smtp.gmail.com with ESMTPSA id d24sm509727pjv.49.2021.05.31.04.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 04:27:03 -0700 (PDT)
Subject: Re: Default behavior of git pull
To:     Mathias Kunter <mathiaskunter@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <7a97ac78-f405-2dca-2998-f03637cc8255@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <92682abb-3062-4613-399d-a3279afb8f0b@gmail.com>
Date:   Mon, 31 May 2021 18:27:01 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <7a97ac78-f405-2dca-2998-f03637cc8255@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mathias,

On 31/05/21 16.18, Mathias Kunter wrote:
> Wouldn't it make sense if "git pull" would by default also pull the 
> branch with the same name from the remote, in case no upstream is 
> configured?
> 
> If I can push to a remote with a simple "git push", then I'd also expect 
> to be able to pull from that same remote with a simple "git pull".
> 
> Does anything speak against this?
> 
> Example:
> 
>    git clone $url
>    git checkout -b fix-1
>    # do commits
>    git push           # push to origin/fix-1 (works)
>    git push origin    # push to origin/fix-1 (works)
>    # other people push to origin/fix-1
>    git pull           # pull from origin/fix-1 (fails)
>    git pull origin    # pull from origin/fix-1 (fails)

IME, I did git fetch first before I did git pull, unless I have repos 
that I didn't intentionally want to contribute to (just collecting 
them). When I choose to work, I always create a branch, then submit 
PR/patches from that against mainline.

Since you do centralized workflow like above, I advise you to integrate 
from remote with git fetch + git merge.

And you asked whether plain git pull can work. It is yes, provided that 
you don't do any local work on remote-tracking branches (such as 
mainline or hotfixes).

-- 
An old man doll... just what I always wanted! - Clara
