Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ABBC48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145586113E
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhFURIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhFURIo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:08:44 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E86FC0619FB
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:57:28 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i68so32253693qke.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=siBEJe7oUaWMnRaFh8bNjyDkxuikxi/hFN/vd7vziMI=;
        b=SW1X1tU19ZOiKalhTLCLa+tls7fwgQHBeOa1T8Yx2a3MQ6TIJEAxk467HRYZYwSm3a
         ctj3evD41Zy2rLEA4nVnnsPBc8+Rkxr418YOayXzpEjMvNJ2r1iS3fBkdpIpjIplLDVe
         rjh2WJoBCkrgxOT3aGC9H0D1qulUaEiSagZi+2zOmeKMWdRcgRyuwbYqXUjjjwjXA0ec
         KsNRgUMJhj8JLVX4tUc1p20a6WsBLEyUAZDL3OTMCWbkw24JUInsXC0vyxa4abX9OS38
         UrykQmXg+8OAI0BsyYjNEqDN2tHD02umTY9ew0vfTP8FBTPeE8+OqU2yoZGOdS6F/kc6
         ulBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=siBEJe7oUaWMnRaFh8bNjyDkxuikxi/hFN/vd7vziMI=;
        b=Q6fcLkVfnnrQ4U+YfHGI3oMfizUrD+gF9rwybw5sNzKppsA/xIrT0MgBahWymjhAP4
         hEmSn1+4rGd6cYrgw+jVIy73FbN6nHJVBNtR082VmD1gWKLE58kJ3YdEmg24pOgeuOZ1
         XuufEe+9PAIHZvyfXYfSwZfseWMjYzL69dc1l6J4Gg7uJSkJYMcdYM8FiVYMGoGp9x+7
         74O3cOAafun4HlIs0wgOUUP4S1HMpTVHwCB9OO6DNO9dfopUkO8R3QHMl0K0WK8edkRF
         1hZTUMfE07pIU2laS48QcPqtBZFnzteh7rxNH22DIoKev5cM7r45jFTPzMZsMTqjsc0r
         Zz6A==
X-Gm-Message-State: AOAM5319tlKWkzznXD9wLX+BVCSrCGCdQfptJvb3U5pA1/lZb8/8yqxs
        pRYlenncacRLhJD7s55NkLg1mSSsRErCvg==
X-Google-Smtp-Source: ABdhPJxj32U8uN4565IfFA/GBXLDsOslYSr3mEbwBCZ3BGSlItOLFOZ7n86hhIKHmjmsMwFfeXls9g==
X-Received: by 2002:a05:620a:201a:: with SMTP id c26mr21533200qka.194.1624294646875;
        Mon, 21 Jun 2021 09:57:26 -0700 (PDT)
Received: from [192.168.0.109] (d-65-175-178-104.nh.cpe.atlanticbb.net. [65.175.178.104])
        by smtp.gmail.com with ESMTPSA id m2sm10316127qkh.38.2021.06.21.09.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:57:26 -0700 (PDT)
Subject: Re: [PATCH v2] blame: correct name of config option in docs
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
References: <20210618221104.42260-1-rybak.a.v@gmail.com>
 <20210619112912.76136-1-rybak.a.v@gmail.com>
 <744f5e3e-808e-3ea1-9f3a-892c3936dcbd@gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <662bf3a8-4690-0a32-275e-7298ccbb09c0@google.com>
Date:   Mon, 21 Jun 2021 12:57:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <744f5e3e-808e-3ea1-9f3a-892c3936dcbd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/21 5:37 AM, Bagas Sanjaya wrote:
> On 19/06/21 18.29, Andrei Rybak wrote:
>> As can be seen in files "Documentation/blame-options.txt" and
>> "builtin/blame.c", the name of this configuration option is
>> "blame.markUnblamableLines".
>>
>> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> Looks OK, thanks for contributing.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 

thanks for the fix.  =)
