Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3666C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 13:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE0861185
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 13:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbhIPNLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 09:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239837AbhIPNLG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Sep 2021 09:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631797785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8QYEjsql1eKwq1U/yWwm1fvgbkO6To3MTFvyCk1vxo=;
        b=LW7RxA4K7IDRtsQ6FOKf4xWRjACjrexIwsahv2eWAHRC1JOydcTwsYl6fKoXLt943j9/qJ
        /OGBW7Me7FVPXXSCCj4R8Rlm2HnrbwIBmqNIOMWmSyE4Ymt5RE4Ubq1Sx/C0QUctWd4BVr
        zgDoSyOBM1th571cIOXu3COAHFckyt0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-38ptPYWAMnug5BdqDa_Fdg-1; Thu, 16 Sep 2021 09:09:44 -0400
X-MC-Unique: 38ptPYWAMnug5BdqDa_Fdg-1
Received: by mail-ed1-f72.google.com with SMTP id h15-20020aa7de0f000000b003d02f9592d6so5342266edv.17
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 06:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+8QYEjsql1eKwq1U/yWwm1fvgbkO6To3MTFvyCk1vxo=;
        b=G21FCuIKDXeFfva2RhwYwkOqUjKG9hqRk5C1WvjM9OQkqL7vdGxcHcN4i0agvkHLqU
         i+kHLfD7eeHduAxrAFcKQVzlko2cLCAjxK9/CQmpg/Jb7FHB1asyVkzF6LkTxxjG/2OS
         MF0sJoWwLhgwLmdVPSMFBbzDOCUrnZemYKklObRjyYOcEZvYmj9z1wqU5aw6LS1tU/kg
         K0091Df1WNRubdfzBv09ouo3wCgfu1PexnRfvf6afrxGXqaBiwAMsf+8DNj0XdIF3HHS
         u/gPfAFs/18Vlwfw3rGIG8tKGLkjzWZs4OXaz9ThZEjuqYL3TLu387KFn+F3cYQZfY8I
         8CWg==
X-Gm-Message-State: AOAM530iYzqlkfd3TXFDN3qxXAAVNW0lglPR2RiddvwLJiip7p6s2QOH
        Y+7w+0YRbR6mwWZQM2PTv8tkDZcwbSDmVvcNb0yRk1x0q4vOSB6jA3dy7xoitfXKgoqyK0XGni9
        Oi7WFcyg9fZ7J
X-Received: by 2002:aa7:db4d:: with SMTP id n13mr6467234edt.398.1631797783171;
        Thu, 16 Sep 2021 06:09:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAjLh+tJ+wCZ+Kkq7fb64mA45DKjt+AL6Mt2f9dvtHYUj5swyn/SrK6vxPZXkqgj0SsCgkPQ==
X-Received: by 2002:aa7:db4d:: with SMTP id n13mr6467211edt.398.1631797782956;
        Thu, 16 Sep 2021 06:09:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a5sm1446460edm.37.2021.09.16.06.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:09:42 -0700 (PDT)
Subject: Re: [PATCH 1/2] request-pull: simplify "remote or HEAD" variable in
 warning messages
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ryan Anderson <ryan@michonline.com>
References: <20210916113516.76445-1-bagasdotme@gmail.com>
 <20210916113516.76445-2-bagasdotme@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02a3f76e-cb59-e4c7-21f2-3772be3cad09@redhat.com>
Date:   Thu, 16 Sep 2021 15:09:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916113516.76445-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/09/21 13:35, Bagas Sanjaya wrote:
> In order for waring message "Are you sure you pushed 'remote or HEAD'
                ^^^^^^

warning

Otherwise,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> there?" to be translatable, replace ${remote:-HEAD} (variable access
> with defaults) in the message by referring it as $remote_or_head.
> 
> Cc: Ryan Anderson <ryan@michonline.com>
> Cc: pbonzini@redhat.com
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   git-request-pull.sh | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index 2d0e44656c..9e1d2be9eb 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -116,15 +116,17 @@ set fnord $(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "${remote:-H
>   remote_sha1=$2
>   ref=$3
>   
> +remote_or_head=${remote:-HEAD}
> +
>   if test -z "$ref"
>   then
>   	echo "warn: No match for commit $headrev found at $url" >&2
> -	echo "warn: Are you sure you pushed '${remote:-HEAD}' there?" >&2
> +	echo "warn: Are you sure you pushed '$remote_or_head' there?" >&2
>   	status=1
>   elif test "$local_sha1" != "$remote_sha1"
>   then
>   	echo "warn: $head found at $url but points to a different object" >&2
> -	echo "warn: Are you sure you pushed '${remote:-HEAD}' there?" >&2
> +	echo "warn: Are you sure you pushed '$remote_or_head' there?" >&2
>   	status=1
>   fi
>   
> 

