Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE6941F404
	for <e@80x24.org>; Sun, 25 Feb 2018 01:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeBYBlI (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 20:41:08 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42929 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeBYBlH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 20:41:07 -0500
Received: by mail-qk0-f194.google.com with SMTP id b130so15265741qkg.9
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 17:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dD4n/WC/7BaDvKW/6eJMSUp02MgO5UvN6CuMwZAdS4o=;
        b=BXEOs7eYKPo2Vz9EHN8Sso1sNu4+Ic4UC2JBdjs8+wWqxwRznsjFa7fzpm5tyNATt7
         PHq3EnLtUPVew+f6Ba4rnH8QwzDDBy7Xda2TN041IOI7kB4kAiOkkfnYJYBM35MkEOG5
         fgF0rnIRkQNW0aMqmmuHftDZUARXeW4yhECvnpXxxbi3H7E8YSPi2NY04I4bK07nlMRZ
         44b35VBVDpfQaWrwGqXS+r0uouqS/oXnUJNibSJUMbVHWevmkmotRzU6GlaJHaj/uA5U
         V1KwMmLtIoU/HuofdTrZZIPs0BDWVh3I+CluFOXlaL1iKtfrZwXOeL9OELEFQp16zUwR
         3Q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dD4n/WC/7BaDvKW/6eJMSUp02MgO5UvN6CuMwZAdS4o=;
        b=NdQFaZ6bUuvTNz/PWLPcXUTdIPByA3xp3iNQOJlwdSmlkCkUxF2dAFnbKEoGsrd04L
         vtgnEicIP4QwkrUrllxTw6F1/yuguaKt86O3MyL4n3435VVF+Atimeewpay5rMTZdO9i
         XiZUnEcCTyBgO4ui0qoakNFr6jqwY1V9k1CZScoJLI0hrv9cAYuJnfF9Z0webkahcK90
         5zUH4uqjFeEkO1uQOUMowJG5D4Ti0TFTYkSyJOHmMKOehmF6ABg0ZaOGhCYtY0KMznBl
         yyOZc5avdll9PwuOWOQuM07GJ745KX5pgvn5ofXj25ddmiuo1KLVxjFq0/Mh1XJsLWIb
         JTpg==
X-Gm-Message-State: APf1xPCYGwXGqKzRHB/DLa+K7sQ05SAxOx7UEKa6S3tHc+jXva8OzN+E
        EO8B6W+etok0EzFujgnjQiE=
X-Google-Smtp-Source: AG47ELufQWLt0vxJC468+GkpkONkQJrcIA6LU7+maCuM6CRjuFAXcyWJpqy+lIpNCz0tiop2Yv9YTw==
X-Received: by 10.55.122.194 with SMTP id v185mr10580483qkc.41.1519522866260;
        Sat, 24 Feb 2018 17:41:06 -0800 (PST)
Received: from [172.22.150.178] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id y58sm3521656qtb.92.2018.02.24.17.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Feb 2018 17:41:05 -0800 (PST)
Subject: Re: [PATCH] revision.c: reduce object database queries
To:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
References: <1519522496-73090-1-git-send-email-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e70fe6eb-994a-66b0-3c20-d19ea6635e07@gmail.com>
Date:   Sat, 24 Feb 2018 20:41:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1519522496-73090-1-git-send-email-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2018 8:34 PM, Derrick Stolee wrote:
> In mark_parents_uninteresting(), we check for the existence of an
> object file to see if we should treat a commit as parsed. The result
> is to set the "parsed" bit on the commit.
>
> Modify the condition to only check has_object_file() if the result
> would change the parsed bit.
>
> When a local branch is different from its upstream ref, "git status"
> will compute ahead/behind counts. This uses paint_down_to_common()
> and hits mark_parents_uninteresting(). On a copy of the Linux repo
> with a local instance of "master" behind the remote branch
> "origin/master" by ~60,000 commits, we find the performance of
> "git status" went from 1.42 seconds to 1.32 seconds, for a relative
> difference of -7.0%.

I do want to add that the exact same "git status" performance test with 
the commit-graph feature goes from 0.29 seconds to 0.21 seconds for a 
relative change of -27.5%.

Thanks,

-Stolee


