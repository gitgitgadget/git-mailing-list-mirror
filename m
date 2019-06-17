Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F721F462
	for <e@80x24.org>; Mon, 17 Jun 2019 01:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfFQBR0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 21:17:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46157 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfFQBR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 21:17:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id x18so5214747qkn.13
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 18:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IDljAAvc/p7AskdhywtlBD9zVb/lMrrciqBOd3/3bCQ=;
        b=htgj2wxYC0jPyaBidxMGw2SraFIBZgNxu/2YrPqmRWS5TVrBWrKWwfobTWIf9rEQQ8
         RLyOWHJjpIALSvuNGgT++o8r5i8KOjb8FH/bkgWRsdn+lJntTzYvxDztMQ/ZHxO6Cam4
         XTaflb9K42JHcmfvQPap9w80Xwq0koLfkm9gJXPsZNTjKV2U/VebTNIWTDTRFvAEvic5
         +3jqLONKoUAsM59AMSrwD3ZItWsZHPjDJ4kMYgzOV57/gniiDbXEkn1iOHkcHIYSXZcX
         Qx0ArirLuYnKqup6kAPb9z8ZGUl3mAv87s4CsQTfTUPXzBy5mgeyRYR8Tk1iLe8ku+dn
         GU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDljAAvc/p7AskdhywtlBD9zVb/lMrrciqBOd3/3bCQ=;
        b=qXn/Ex/75WoZBZNkmocrwP+8XeTK7KNe7XI/kEPm+TQiiXtyn4r2Sv2PDq8t2oC6SA
         lZ4geoeZq6+OU3kDzXmSTk+M87bcbkoERtmhVb117cmGEXhKqIbf8vZaPQrNXVVlbQnu
         Mh9/8YH9m413/Vmx8W57t/vhf3olsBbmLG6GT2J5EvTaUv//gG9ZYPSFGn5pwDnF8yvZ
         Xa5hD6Y3wZY+8jSLGSr3gDK0qIgec3oMUfBxIJqi+3sCee49sYmtbDIeQSZ0UJC6CiJZ
         XdQ00v5VfrwmPjv2UaTN1T93aXyaok0i9InxDm+nk2eXPk5aN36IriyV2hoPFmKcVksZ
         j6Pg==
X-Gm-Message-State: APjAAAWKKYV4tHMuc8W2c7C+FTSyQF+AR+kDUG1qkdqNSCyDmy/W/zTs
        VGGDpJMS+VKGSveQiD8VmRk=
X-Google-Smtp-Source: APXvYqxIsTjGKD7UbXLVFWEDSKqKZ2/QEGZcuK6mN9KWED1PdAascvuOwlCUPXoW1YhFMKtnWxSpow==
X-Received: by 2002:a37:a30a:: with SMTP id m10mr39561009qke.288.1560734245447;
        Sun, 16 Jun 2019 18:17:25 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id j19sm3165834qtq.94.2019.06.16.18.17.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 18:17:24 -0700 (PDT)
Subject: Re: [PATCH] fsmonitor: avoid signed integer overflow / infinite loop
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     benpeart@microsoft.com
References: <20190615161135.57269-1-carenas@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0915f2bc-5818-3bf5-34c2-7c783363cc34@gmail.com>
Date:   Sun, 16 Jun 2019 21:17:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190615161135.57269-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2019 12:11 PM, Carlo Marcelo Arenas Belón wrote:
> 883e248b8a ("fsmonitor: teach git to optionally utilize a file system
> monitor to speed up detecting new or changed files.", 2017-09-22) uses
> an int in a loop that would wrap if index_state->cache_nr (unsigned)
> is bigger than INT_MAX

Thanks for catching this. I wonder if there is a compiler setting or
static analysis that caught this so we can avoid the issue in the future.

Also, INT_MAX is ~2.1 billion, and the largest indexes I know about have
around 4 million entries, so it is unlikely that you hit this as a runtime
error. Still worth fixing!

Thanks,
-Stolee
