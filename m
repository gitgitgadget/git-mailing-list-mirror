Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7CDC2D0DC
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87B92075E
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/D8PWZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfLZOvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 09:51:41 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46930 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZOvk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 09:51:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id r14so19540080qke.13
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 06:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=02ra0tR6duEw6QV0UBUUsBK2UlbuRZIFZ6itMoAO/NU=;
        b=h/D8PWZEIHZj9WrjfrHfqnWB6ZIzt4ZBocAAd3Pq1++s0eOusgLRp9dXoJXrV17noG
         uUrvhAPbHiuOq7kaA26M+SXOYaM74jjV6Yn+wZf0D2FLpAlxsrKIXkXBsjRyv0JjpmUK
         aXwrTDUDIuv4+iCRqFxhKVn6CUZZ8zm/N+9k/YLP9XWsarUsfyuhVajBatEKdp/gCZCi
         o3iDVvFJ+B9JkSSJaCtk/55LJ9cNRHtMIqjDQT3hREIjzeuY5AEh8mAPRlMioyFp34aH
         ttDiasHhD6sL9H8s9hUtsVjpyJJqTdda95IA/ia1yNmQ3XxIJzEvpNArB7CdkmgF69XG
         yOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=02ra0tR6duEw6QV0UBUUsBK2UlbuRZIFZ6itMoAO/NU=;
        b=H7Nzk0ngNM1t5QWTsBvNSKObXqtEH9GAgHFYL3qEivOXRM5t/nBY+ArDTFMZrfOfDU
         ln0xOGKHlMRiWAzHFA3l0ji45xljpPxKpdkJ46HfdpY76JPA8EcPXhBE+Rts4VFq2Mc7
         KYYLyeJjnect+wL6lZA/TxbGD/xTGwKUP5Hoeoeiy3XCK+pma0BhGdybVjSAgpK6J0BT
         a+BxtKX0ybTYf/RVkGj7w2fldvO+Ce7DqwuIs8OVzcDaTIvzkkGaOG7sXjFadVyObLBV
         zavAb0enofWjKcP5VVX53ywdGaZ7K9FneulWNzt0/raEjoQWebT3Pv3RyhddiReqNetT
         XzxQ==
X-Gm-Message-State: APjAAAVJkPYvt6K0qRyF/pu0gpq7vAYbLh9MaTMM50Y8nggzooRKShC2
        LXWWY5lUFZkOeufJCa+Vwtdyex2k
X-Google-Smtp-Source: APXvYqyt5/Cthn8jRTAdWPpSjPLPtSZucSusNr8I2+cUQm/fababmRoUx5L73nwN7303vssc9GDP2w==
X-Received: by 2002:a37:a807:: with SMTP id r7mr30263886qke.346.1577371900044;
        Thu, 26 Dec 2019 06:51:40 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:d596:b1c5:69e0:b2e5? ([2001:4898:a800:1010:86cc:b1c5:69e0:b2e5])
        by smtp.gmail.com with ESMTPSA id 2sm8755377qkv.98.2019.12.26.06.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 06:51:39 -0800 (PST)
Subject: Re: [PATCH 00/20] SHA-256 test fixes, part 7
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e0076595-5cdc-2396-3f12-286ba84b1864@gmail.com>
Date:   Thu, 26 Dec 2019 09:51:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/21/2019 2:49 PM, brian m. carlson wrote:
> This is the seventh in a series of test fixes to make our testsuite work
> with SHA-256.  Included in this series are fixes to a variety of tests
> from t4054 to t5604.

Thanks for doing the hard work needed for this important transition.

This series looks good to me. I commented only on the parts that I
knew a lot about just to say "I'm sorry this was complicated."

Thanks,
-Stolee
