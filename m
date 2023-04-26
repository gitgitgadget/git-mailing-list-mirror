Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2125C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 11:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbjDZLI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDZLI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 07:08:58 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100241702
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 04:08:57 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b992ed878ebso22691144276.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 04:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682507336; x=1685099336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLy5+Wsl4weFQpfeNe+i5NH2qeU1AN8vhj4+CKr1dYM=;
        b=CnXVlcXYdCC4soVvM7RO/I9maqm3oztNNrdl/waygygIzsrFwwVaPF75SM/tCnakX6
         MY2Ha43LLiTrxKW60VBdrnAqgoiMj8u0zEPQbF+efj+V3CjKjrf2NCDd+f9aXFcQHiUm
         SMeKEQxiGzzCuxN1ZpT0dQ/zoTGBuOKCjYwQArYsJKtlXXKCH+ZYbVi0qcDyJI2baCpg
         gXM1Rtw/aMM6kGl10RyWmOp/iuCmy0ovXMM+kpcSEXGCnrS6GD4xyfTTJMynpGujSMd4
         P/NNsnwHyrrHtiZdp99A4EmVvRKl/B9/ero8nE8l7ihEDRnQGgOwgFBLDjrBvhEnBhRk
         rVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682507336; x=1685099336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLy5+Wsl4weFQpfeNe+i5NH2qeU1AN8vhj4+CKr1dYM=;
        b=VmiXDH9zS4rpTWI6T81qiYfRMpsioITDqEGYesxo4WgFyOx6MBo5V4ZCWZai8suVDD
         I6QU1Hc0CUqxp2ECnM2Sqqem3NrprrLeprvgU0xkKpTgHINwNndLoW9BBuwaOxUiOCa+
         oQ90dg6EkbndBcm6gSIPUY9bOlQhjsOV5gk/mQob5KISqUZoiH413Pf7QW+Rb6u2YFZ+
         9H1zyMFhZFj8Pv5lTWqLEQyJJu8k4u8YcdRdT7XC3iaOo6aq6rWaRTFVhHBuNDQRTnUu
         KM7sILDN5+vQFtwTzxYFKaCOvJRjD08f7/q9Hdlca7flsUbFed5zv8kLGEsHaYF4V696
         mbWA==
X-Gm-Message-State: AC+VfDz7yyBZ8pN9Ebs3JHf8bQJHhfGpyoMynk1r3Pwg4EAeG7ESfgDL
        n76ZgaKSKkPlPIE/8xhcuWkU
X-Google-Smtp-Source: ACHHUZ7qid9bUeLDgLQ9lNTLk8IZSVnXY+qBWf0ERDY7LIlea2Jroo6fmagqg028llYj2kXOIq9bKw==
X-Received: by 2002:a25:fc14:0:b0:b96:d880:be8c with SMTP id v20-20020a25fc14000000b00b96d880be8cmr1313251ybd.13.1682507335880;
        Wed, 26 Apr 2023 04:08:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8842:abce:33e9:20d2? ([2600:1700:e72:80a0:8842:abce:33e9:20d2])
        by smtp.gmail.com with ESMTPSA id b65-20020a256744000000b00b9a13df8939sm590022ybc.24.2023.04.26.04.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 04:08:55 -0700 (PDT)
Message-ID: <41273b5d-f4f8-2dce-94d1-37a9b56ed1ea@github.com>
Date:   Wed, 26 Apr 2023 07:08:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] negotiator/skipping: fix some problems in
 mark_common()
Content-Language: en-US
To:     Han Xin <hanxin.hx@bytedance.com>, git@vger.kernel.org
Cc:     xingxin.xx@bytedance.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>
References: <20230424022318.80469-1-hanxin.hx@bytedance.com>
 <cover.1682473718.git.hanxin.hx@bytedance.com>
 <abbb1bc0b35d03e13249ec2e5bb8229a0a123685.1682473718.git.hanxin.hx@bytedance.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <abbb1bc0b35d03e13249ec2e5bb8229a0a123685.1682473718.git.hanxin.hx@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2023 12:05 AM, Han Xin wrote:
> Fixed the following problems:

This might be a good time to reference the change from recursive to
iterative:

  The mark_common() method in negotiator/skipping.c was converted
  from recursive to iterative in 4654134976f (negotiator/skipping:
  avoid stack overflow, 2022-10-25), but there is some more work
  to do:
 
> 1. prio_queue() should be used with clear_prio_queue(), otherwise there
>    will be a memory leak.
> 2. It does not do duplicate protection before prio_queue_put().
>    (The COMMON bit would work here, too.)
> 3. When it translated from recursive to iterative it kept "return"
>    statements that should probably be "continue" statements.
> 4. It does not attempt to parse commits, and instead returns
>    immediately when finding an unparsed commit. This is something
>    that it did in its original version, so maybe it is by design,
>    but it doesn't match the doc comment for the method.
> 
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
> ---
>  negotiator/skipping.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/negotiator/skipping.c b/negotiator/skipping.c
> index c7d6ab39bc..b06dcb197b 100644
> --- a/negotiator/skipping.c
> +++ b/negotiator/skipping.c
> @@ -85,7 +85,7 @@ static int clear_marks(const char *refname, const struct object_id *oid,
>  }
>  
>  /*
> - * Mark this SEEN commit and all its SEEN ancestors as COMMON.
> + * Mark this SEEN commit and all its parsed SEEN ancestors as COMMON.

Ok, the doc comment is updated here instead of starting to parse
commits. Since this is the behavior since it was first introduced
in 42cc7485a2e (negotiator/skipping: skip commits during fetch,
2018-07-16), this is the best thing to do.

I notice from a second glance that we are only walking the commits
that are marked SEEN, so we are only visiting commits with respect
to a previous walk of some kind, which provides some explanation.

>  	while ((c = prio_queue_get(&queue))) {
>  		struct commit_list *p;
>  		if (c->object.flags & COMMON)
> -			return;
> +			continue;
>  		c->object.flags |= COMMON;
>  		if (!(c->object.flags & POPPED))
>  			data->non_common_revs--;
>  
>  		if (!c->object.parsed)
> -			return;
> +			continue;
>  		for (p = c->parents; p; p = p->next) {
> -			if (p->item->object.flags & SEEN)
> +			if (p->item->object.flags & SEEN || p->item->object.flags & COMMON)
>  				prio_queue_put(&queue, p->item);

This is the incorrect check for the COMMON bit, because it is
a positive check (we add the common bit after we pop a commit
from the queue) _and_ because we could add a commit multiple
times before it is first popped and that bit is added.

Instead, we need

			if ((p->item->object.flags & SEEN) &&
			    !(p->item->object.flags & COMMON)) {
				p->item->object.flags |= COMMON;
				prio_queue_put(&queue, p->item);
			}

and at the start of the loop we need to add the COMMON bit to
the starting commit. We also need to remove this bit from the
main section of the loop:

  		if (c->object.flags & COMMON)
			continue;
 		c->object.flags |= COMMON;

because it does nothing if the COMMON bit is added before
being added to the queue.

I'm very suspicious that this change did not trigger a test
failure, since the behavior is quite different from the previous
version. Of course, the recursive-to-iterative change was first
to change the behavior, so I'm not surprised that it isn't caught
by tests. What kind of tests can we introduce to harden our
coverage here?

>  		}
>  	}
> +
> +	clear_prio_queue(&queue);

Good to clean up this queue.

Thanks,
-Stolee

