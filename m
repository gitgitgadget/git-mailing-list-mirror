Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B833C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C67E610CD
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhHYOvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241842AbhHYOvT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 10:51:19 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39D8C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:50:33 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id v1so13887778qva.7
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Id+TW3ssoyB2oFhXCycefugHt0wOdneGL5W6Zlunu8E=;
        b=pNrTku+MqAfsRiJD430UgjocWWYBwAfG0WTahLPu88HdYmYUtT+9Vp8pHlZiMB+Ik7
         6uip9YZcn39lCfJlcPLanidcGJmsbILX0W6JdT7b+CKDLiPn4ymsmn6KZIbeRwNbTHeA
         V9xx7Zs76DEsGABpZ8FacAIIUjhPcxfIgwahORMmfdLpZH/JYDyQXUrHVARpHCMSkCU3
         QGaL6MMxmw3NnJ8+T6ptDKNIFDsmOr7MDP5OJpHqkYWUONuWlZlvB2DluMdEbVOkgi6C
         fqZp9br76A+q2EWhRgPadtX+seIJZPlTVM20LVB/SUkAuEbu/39hNQqEZwUq7TV8iwjs
         bA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Id+TW3ssoyB2oFhXCycefugHt0wOdneGL5W6Zlunu8E=;
        b=OX7cG2lC3Dbl62oiYB89JFUPv0d45uovmde1mgF2zhAS5GyhaYT5XieuKSlyfEZWWd
         UWyMuNi2xgSZTi1z+C7moz7TInwEhud78yuho7I09E6b5GBs+O70KaH3TZayJObrN2Ha
         89Ok5fNbRRpGRj2X3A5D3VjJpVYHrIEvmeMsO1wiEehycg9r3KvEUWW9ZONBKomVY0ZD
         fvFLNsHsXeGx+FMEryqXq0q6BpX6sDc2/n8mo9sUMGDKUI9TPPjlUpHaDvGc+4v4aRIA
         KtoK8qSLHQTXXmkSSvw1KMyIdgyhM0Hv7T33BPPy0HAzy8fqMuFS4jKYjbTfeLwpchmM
         IZQg==
X-Gm-Message-State: AOAM531OXhon3PRYfJCAEDEnif5L8E72xMg9wZ5wmUXM5lr1LGMtY7OS
        BC9piyDe9uCP8zcdr8q+Cqs4WozuixE=
X-Google-Smtp-Source: ABdhPJy0oh6oLFi5pfev1oB56G5qTSUTgnAddAJJfUcMVGcFbwMhmo2GwO6crBgAXw8lDuG8YexNcg==
X-Received: by 2002:ad4:4d90:: with SMTP id cv16mr17393957qvb.25.1629903032444;
        Wed, 25 Aug 2021 07:50:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6d81:bb65:3870:d879? ([2600:1700:e72:80a0:6d81:bb65:3870:d879])
        by smtp.gmail.com with ESMTPSA id t194sm140585qka.72.2021.08.25.07.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 07:50:31 -0700 (PDT)
Subject: Re: [PATCH] ls-refs: reuse buffer when sending refs
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <ccd03e685af0f5cf25c68272a758fc88d115e37a.1629899211.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <705fee2c-7711-ac99-f692-ab08cd7b4e26@gmail.com>
Date:   Wed, 25 Aug 2021 10:50:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ccd03e685af0f5cf25c68272a758fc88d115e37a.1629899211.git.ps@pks.im>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2021 9:49 AM, Patrick Steinhardt wrote:
> In the initial reference advertisement, the Git server will first
> announce all of its references to the client. The logic is handled in
> `send_ref()`, which will allocate a new buffer for each refline it is
> about to send. This is quite wasteful: instead of allocating a new
> buffer each time, we can just reuse a buffer.

Reusing a buffer makes perfect sense and is a clear improvement.
 
> Improve this by passing in a buffer via the `ls_refs_data` struct which
> is then reused on each reference. In a repository with about 2.3M refs,
> this speeds up local mirror fetches by about 2%:
> 
>     Benchmark #1: HEAD~: git-fetch
>       Time (mean ± σ):     25.415 s ±  0.131 s    [User: 22.722 s, System: 4.740 s]
>       Range (min … max):   25.240 s … 25.543 s    5 runs
> 
>     Benchmark #2: HEAD: git-fetch
>       Time (mean ± σ):     24.922 s ±  0.110 s    [User: 22.404 s, System: 4.476 s]
>       Range (min … max):   24.825 s … 25.081 s    5 runs
> 
>     Summary
>       'HEAD: git-fetch' ran
>         1.02 ± 0.01 times faster than 'HEAD~: git-fetch'
> 
> Signed-off-by: Patrick Steinhardt <ps@kps.im>
> ---
> 
> Note that while this topic applies on top of "master", I've done the
> benchmark on top of my other optimizations for fetches. It's cheating a
> bit, but it's easier to see that the optimization does something when
> the remaining constant part is lower.

I don't mind demonstrating an optimization using the other work.

Perhaps this would be better grouped with those other changes?
I know that the text is independent and merges cleanly without it,
but it can be helpful to think about the effort as one unified
topic instead of juggling multiple, especially because I don't
see the other one needing many revisions.

> -	struct strbuf refline = STRBUF_INIT;
> +
> +	strbuf_reset(&data->buf);

It's nice that this is the only _real_ change, and everything
else is a find-and-replace.

> @@ -145,6 +146,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
>  
>  	memset(&data, 0, sizeof(data));
>  	strvec_init(&data.prefixes);
> +	strbuf_init(&data.buf, 0);
>  
>  	ensure_config_read();
>  	git_config(ls_refs_config, NULL);
> @@ -173,6 +175,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
>  				     send_ref, &data, 0);
>  	packet_flush(1);
>  	strvec_clear(&data.prefixes);
> +	strbuf_release(&data.buf);
>  	return 0;
>  }

Except, of course, these two lines.

I think this patch is good to go!

Thanks,
-Stolee
