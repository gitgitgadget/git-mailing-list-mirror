Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4AEC11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4293620828
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8aTXd90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgBXPJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:09:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42920 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgBXPJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 10:09:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id o28so8920415qkj.9
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ds90v8Pysx1JBbugv7KB7tbgQXT4HK/AzXP5q2k8pO8=;
        b=k8aTXd90toZeQNJPzBD87SENEmbQ1At/Bspa7KbgowgGcXQTH3kT5z2HtCLRohlDJD
         AsRMyASbp+0AuD80xivDHPXxKz2bc21bBpIIZeBS0zmfoIN2aJwWhzHlAnmowq+dms7y
         E61uMRHO9KWSMbO5IoNFFyemb/Nj835gXeLkHwc4Af9AnfDK9fGmjI4quKIRQTZs+nf1
         gdPrWXP4vhskn02KYu4Ve1rdSID7htYUWSB4Se4Z4Zr7V7HeqpMKB5V7TF9OcwjBpCC2
         rzG0slrSj/xKKCDKnlnzZ018/fvMX/JBbQPzS8jZLuwHlpsjVgjm8UEA9mmSPgSGCNcy
         JEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ds90v8Pysx1JBbugv7KB7tbgQXT4HK/AzXP5q2k8pO8=;
        b=aC7zncreJFxInxbXRGPt7NIYGmbvKmjoRaxf5nTIdqjl7VZEeY1KBpmUKjQTmQXJD4
         g0n+OdFd1ENuKEW4Cc3q6T+KovuTjXdZOtblqA2+xFA210MU8usSBFn4veuTN09a7/0f
         YFnPFOplteGAwi5ENNbRVcWwTl6NgZqiKDoOfYXr2eXDvHXdE9z9h1A2GOvwZtO8AJUH
         mGp+5Pd5g7peWWkC1xhWeW/HrcrSyRys9V6lBhqPZxqDjzaMp5v+hl2hUf4uT2STUC/D
         8Ft330VcR8UWpTWGqzAcgEl3zM9PjGYKlNhVEV3ceKmp2nu6W4pHp26psQPhP6LXQkeO
         nCag==
X-Gm-Message-State: APjAAAXWpd7LKAsiLZxgWX5byMRvL9JHGNPj0X7sp3DX0xGrpSAAoumW
        L4A52VyGtCLG97ndTPzWMJpJxQ==
X-Google-Smtp-Source: APXvYqzIHIhKzZhITw7ob2IJbbgCGiEFTobwmUkITUQJs99aXNGvxNFAy9l5eSNi+M2Fm3B+cpl4pw==
X-Received: by 2002:a37:9f92:: with SMTP id i140mr3905566qke.353.1582556987164;
        Mon, 24 Feb 2020 07:09:47 -0800 (PST)
Received: from ?IPv6:2620:0:1004:a:6e2b:60f7:b51b:3b04? ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id t55sm6346882qte.24.2020.02.24.07.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 07:09:46 -0800 (PST)
Subject: Re: [PATCH] blame: provide type of fingerprints pointer
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <22735441-50e1-5f00-ba12-539b3e9e4916@web.de>
From:   Barret Rhoden <brho@google.com>
Message-ID: <ddaa7ab8-c07b-7718-815f-12ff048a89f7@google.com>
Date:   Mon, 24 Feb 2020 10:09:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <22735441-50e1-5f00-ba12-539b3e9e4916@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/20 11:56 AM, René Scharfe wrote:
> The fingerprints member of struct blame_origin is a void pointer that is
> only ever used to reference objects of type struct fingerprint.  Declare
> its type to allow the compiler to do type checks.  We can keep its type
> opaque in blame.h, though -- only functions in blame.c need to know the
> actual definition of struct fingerprint.

Reviewed-by: Barret Rhoden <brho@google.com>

Thanks.

> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>   blame.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/blame.h b/blame.h
> index 4a9e1270b0..089b181ff2 100644
> --- a/blame.h
> +++ b/blame.h
> @@ -16,6 +16,8 @@
>   #define BLAME_DEFAULT_MOVE_SCORE	20
>   #define BLAME_DEFAULT_COPY_SCORE	40
> 
> +struct fingerprint;
> +
>   /*
>    * One blob in a commit that is being suspected
>    */
> @@ -52,7 +54,7 @@ struct blame_origin {
>   	struct blame_entry *suspects;
>   	mmfile_t file;
>   	int num_lines;
> -	void *fingerprints;
> +	struct fingerprint *fingerprints;
>   	struct object_id blob_oid;
>   	unsigned short mode;
>   	/* guilty gets set when shipping any suspects to the final
> --
> 2.25.1
> 

