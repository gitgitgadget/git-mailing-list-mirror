Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F34C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E299C2082F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsQOdZ5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgBJOSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:18:41 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35665 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBJOSk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:18:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id v2so1685345qkj.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZBXvZYUwLSHtSxZhexp/iHaOMuSIoPC0k6gXUClh3TE=;
        b=gsQOdZ5w1UR8MwMQ4qCwu5wZgwhx4uJagOZshU2bqNqLUvGxR47/fzy2/ovcckiAX/
         gwrwou4RoMM1l/CWPzoqRlQBmj6VRdonk8vSqmBshU6ruVeVt2oOLxxL2PZ4/0qDh+lt
         0n9GSAWy2Fz4SdaB/HRiaejkmkDgJGhrieSrxIWcv1XJYmP0z+pao4vSqrk9TJ/rHLwI
         rdb8nikVx3Qggz+3ZUBKo8rmiZcsnjrZyJgFMlb1ntXPtEwWHVLW7bqx4vjFHrOtYQFv
         dKMXaXbTVdXd4L69d2QEDAkZOaFwcdaWMPnA1xc3SYQ5NpKWfNZt/Iw1MTTCZ0x6uZNv
         7y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZBXvZYUwLSHtSxZhexp/iHaOMuSIoPC0k6gXUClh3TE=;
        b=W4NFUADWDarCHNPmc/FbOvTq2J4nH++lZPmnvErbeVIL8TiaLqKq4+YTHDcpeqiWmY
         t6CgiKoU93wOJ7GLdGPDj+dNMTeR+Gz5AE5c43/4JcrXP4iRn0pT8PtEJSV3brLYXgxV
         RDI6SnnR1NbdcymuWdFOgJ9H0fe+M2fuuYBjqdrEPGgDHV7sNvn6zVl/3ofYVI17qSLA
         qewQ6clJtOTE7/REAa9rVGUjdlHa6XjeCGJYp6YbjT/hAZwa3kOZubb8uzx6cmHjd7tr
         SPUjCEN4tEQpBdvXGxvXZhpwACmw4IwxZ0wurF6na4dmLQ5kf11V9ZnYOTH+SibRkuSk
         EydQ==
X-Gm-Message-State: APjAAAUEZ6sewuymgNF3L+nWoAIkWb/M3XBoDwflgmKnrr/v87qLPyZ1
        A3IreMCBbp2P8tBTjlaBoCbfk/37Bow=
X-Google-Smtp-Source: APXvYqxqM2na3aQeRDtpwFlPIKBjKDXJxwj7jmIIRZcXgyYUz+abdetu9Np9iGJ3DpddvOvhrGeHtw==
X-Received: by 2002:a37:4ce:: with SMTP id 197mr1501814qke.269.1581344318251;
        Mon, 10 Feb 2020 06:18:38 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3922:b15f:4fe8:fef? ([2001:4898:a800:1010:ea57:b15f:4fe8:fef])
        by smtp.gmail.com with ESMTPSA id d18sm194176qke.75.2020.02.10.06.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 06:18:37 -0800 (PST)
Subject: Re: [PATCH] pack-format: correct multi-pack-index description
To:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org
References: <20200207221640.46876-1-johannes@sipsolutions.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8d50143b-adb9-c642-5ca6-d51662c37dda@gmail.com>
Date:   Mon, 10 Feb 2020 09:18:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200207221640.46876-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/7/2020 5:16 PM, Johannes Berg wrote:
> The description of the multi-pack-index contains a small bug,
> if all offsets are < 2^32 then there will be no LOFF chunk,
> not only if they're all < 2^31 (since the highest bit is only
> needed as the "LOFF-escape" when that's actually needed.)
> 
> Correct this, and clarify that in that case only offsets up
> to 2^31-1 can be stored in the OOFF chunk.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
>  Documentation/technical/pack-format.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
> index cab5bdd2ff0f..d3a142c65202 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -315,10 +315,11 @@ CHUNK DATA:
>  	    Stores two 4-byte values for every object.
>  	    1: The pack-int-id for the pack storing this object.
>  	    2: The offset within the pack.
> -		If all offsets are less than 2^31, then the large offset chunk
> +		If all offsets are less than 2^32, then the large offset chunk
>  		will not exist and offsets are stored as in IDX v1.
>  		If there is at least one offset value larger than 2^32-1, then
> -		the large offset chunk must exist. If the large offset chunk
> +		the large offset chunk must exist, and offsets larger than
> +		2^31-1 must be stored in it instead. If the large offset chunk
>  		exists and the 31st bit is on, then removing that bit reveals
>  		the row in the large offsets containing the 8-byte offset of
>  		this object.

Thank you for finding this doc bug. This is a very subtle point,
and you have described it very clearly.

-Stolee

