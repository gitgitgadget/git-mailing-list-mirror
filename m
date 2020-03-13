Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3017C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 00:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C38A206E7
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 00:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAIMHWUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCMAyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:54:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36540 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMAyk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 20:54:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id j14so8421880otq.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 17:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i9zCZJHoeGE+C4MnpDu3C4Nm8405CuSUtryOcLCwwJY=;
        b=tAIMHWUgkR2q6T+p+zUDHaZeWlSET1kF7lTBTjg9yU6ZEkXIuUIGw7sYiLnLT2W9uM
         cVc3vgzzbqXQvq2pL2EydzZFOIb/qoi6qWBnJQJeAmXKl0i6bh3kEjPEKBAwe28+TgsA
         QHZaxRNYFcL2JOorhhvOsBaqCpA8x3ARXnvV4bMDJFLo8xKlY3SERpDjqPybp1oZBOJO
         sePfr3vtILukzH/LHKBQEOX10vO76sWJntO3O+JFARDb7jv2seDCtSWmUoBlGy0Y6P0l
         ++6ukNRVCCB57nGs06wEW78RRrIKTlNiodWW5dqcN3UC8Aeoyg3S01HnL5jaylb+Aik9
         M/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i9zCZJHoeGE+C4MnpDu3C4Nm8405CuSUtryOcLCwwJY=;
        b=CXTFN4PE8vKp/UdNRbcjoDi4WOzBnGJSRmblPUADCemfQEEo4h+dfBAKL6TZVLLAWo
         +HUX6CX+NWFyN8bxIDbrAzrV3+pt9CtEla+ERZDC6yvgcj4Oz0STD07LQObS/JSGz31I
         U+zc7r2atTj47/x677Vc0ickeKn6bjvCWpPfq3zuCbXxl85j42myJ7yCmvJ9k+Fmpsc+
         x0j04VrfjbHxKseK56jGk8lLmXbDKyqZA5K9XpVYIUE7e1O53Vnmmu6Te0UhdU2Y8b6y
         gNoLQLP7mzqvXJd5sG4pxCQxi9B/aXTGFQXJuyYxNJQ6lvGu3UxJqiZuAQvdvJsyVZI1
         MdwA==
X-Gm-Message-State: ANhLgQ2/uTxLowQ1SYatbx+OqUOJ2Iy9aFGGhbiMI48ADF5qDNFRPyJH
        3EGlVgWFs+K/0zv66BQnnFE=
X-Google-Smtp-Source: ADFU+vvo210H89mD4389rxAOWSCzujs6jjQRYSxYRrvfYyJne0Lt993jiV5BdUB9mW2RJM1b7ZGckw==
X-Received: by 2002:a9d:24a4:: with SMTP id z33mr6664914ota.105.1584060877945;
        Thu, 12 Mar 2020 17:54:37 -0700 (PDT)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k25sm13203672otl.34.2020.03.12.17.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 17:54:37 -0700 (PDT)
Subject: Re: [PATCH] connected.c: reprepare packs for corner cases
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com
References: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
 <xmqqzhcle23x.fsf@gitster.c.googlers.com>
 <20200312211638.GA872402@coredump.intra.peff.net>
 <20200312212613.GB872402@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7378a863-7e2a-455e-4635-e07938ef3381@gmail.com>
Date:   Thu, 12 Mar 2020 20:54:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <20200312212613.GB872402@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/12/2020 5:26 PM, Jeff King wrote:
> On Thu, Mar 12, 2020 at 05:16:38PM -0400, Jeff King wrote:
> 
>> There we see that same reprepare happen in 882839, which is the child
>> fetch-pack. The parent fetch probably needs to reprepare itself after
>> fetch-pack completes.

I agree with you and Junio that where I put the reprepare was non-
optimal. The initial reason to put it there was that I found where
the error was happening, and thought that placing the reprepare there
was the best way to prevent this error from popping up in another case.

The result of a fetch failing and saying the remote did something wrong
is quite alarming, and I wanted to avoid that from happening again in
the future from some other path.

But you're right, it's better to be as correct as possible.

> Actually, it's not fetch which is running fetch-pack, but rather the
> remote helper itself. So I think the simplest thing is for the
> remote-helper layer to do something like this:

I appreciate your root-causing this into the multi-process nature of
fetch. I will update the commit message to include your details,
especially about how it does not reproduce over file or ssh protocol.
 
> diff --git a/transport-helper.c b/transport-helper.c
> index 20a7185ec4..25957e9a05 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -14,6 +14,7 @@
>  #include "refspec.h"
>  #include "transport-internal.h"
>  #include "protocol.h"
> +#include "packfile.h"
>  
>  static int debug;
>  
> @@ -672,6 +673,7 @@ static int fetch(struct transport *transport,
>  {
>  	struct helper_data *data = transport->data;
>  	int i, count;
> +	int ret;
>  
>  	get_helper(transport);
>  
> @@ -710,13 +712,18 @@ static int fetch(struct transport *transport,
>  	if (data->transport_options.negotiation_tips)
>  		warning("Ignoring --negotiation-tip because the protocol does not support it.");
>  
> -	if (data->fetch)
> -		return fetch_with_fetch(transport, nr_heads, to_fetch);
> +	ret = data->fetch ? fetch_with_fetch(transport, nr_heads, to_fetch) :
> +	      data->import ? fetch_with_import(transport, nr_heads, to_fetch) :
> +	      -1;
>  
> -	if (data->import)
> -		return fetch_with_import(transport, nr_heads, to_fetch);
> +	/*
> +	 * We may have just received a pack through the helper sub-process;
> +	 * refresh the pack list.
> +	 */
> +	if (!ret)
> +		reprepare_packed_git(the_repository);
>  
> -	return -1;
> +	return ret;
>  }

This code looks correct, and should be the fix for the short-term.

I wonder if we could do something more complicated in the long-term,
which was recommended to me by Jeff Hostetler: add the pack to the
packed_git list once we've indexed it. That way, we don't reprepare
and scan the packs one-by-one, but instead we insert to the list
a single pack that we already know about.

Thanks,
-Stolee
