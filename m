Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B2EC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC04061208
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhFHAuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 20:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhFHAuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 20:50:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F017C061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 17:49:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g24so10875650pji.4
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 17:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EbH9+S+kXOPwj6DNC+zwrUbFAXYwVp6RW5ypmVCWFzo=;
        b=kBDc7RxljeEdMIqL7f71VSxXqObv1b5Ek+3Pq6D3qtT0xVyPtqYu2YI2pPv6yYvpbr
         1AzG7n3I79fMqwFzialhebBFpwADgBgynnFD9yMt51iSw/DFnDTXAnpazTVf0L4U5Vzv
         fZTzKlM7dgpsx2ZWFgq1mtne6t+DlfVVVbguTYS/mCDwXX5TgxO0hAkTS5CROzmp2I2y
         5dBKDr8/N3sftCChn9Xz0ws2LqfFwjOQf8VWRKhAAM6qDBVnWJY8+uQjZ0pqh9drByx1
         TPfAtM37845ukU9SdRjfYSqlx8DXaLUHW7niNOSUAOKzkGy/3Vgnu0Nr4e84Be+ki5of
         QN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EbH9+S+kXOPwj6DNC+zwrUbFAXYwVp6RW5ypmVCWFzo=;
        b=M01nlYT5PVkU+pUeDJ1Zu59zH7vkKZYsRB4FJNx3jUHzsCt04w+llZYoryEY7YLiqJ
         fzDnmN7JMnfM8im6TG8xIxd2JVhi4aggt1IEhQc4MPrmMOfVlbgxA269NNxQ2Tud6JDv
         JGUOPDbtVPXAMFcUcGF0PmdFOdSTOsxJVEUb003nheaXBAE3IbFJNn54f7XI/K87MPFC
         eOanO80K3jV+IoRdoBbFSUPtoVN7TbYGifbnydqrVQVSJi1GowqD7adLbz1+kWPeIZMQ
         JA5h4t6KDbkih3xa55qSi2YNqa8oB7aUKQX8PDSReAms/+JQ9+SZPCG8ivKrkT9gqkBc
         zJCA==
X-Gm-Message-State: AOAM532aeYAqfX+uaOnY1uSwk7nU02JiiwMc4RQXCvIWOldBsOQgB3Lp
        ydOzdE8Q7CMwfDP2TtSzhousHg==
X-Google-Smtp-Source: ABdhPJxgdopdOEygHDL/fgGQHTltwoB8CNAZagcEdNRduaVoNwzfSHICgTPXwWC9yVPy7ULPXe3zVQ==
X-Received: by 2002:a17:90b:305:: with SMTP id ay5mr1886503pjb.0.1623113342574;
        Mon, 07 Jun 2021 17:49:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:2096:9338:a9c3:81da])
        by smtp.gmail.com with ESMTPSA id z22sm9642530pfa.157.2021.06.07.17.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 17:49:01 -0700 (PDT)
Date:   Mon, 7 Jun 2021 17:48:55 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] promisor-remote: support per-repository config
Message-ID: <YL6+d3u0I8WC0FS0@google.com>
References: <cover.1622580781.git.jonathantanmy@google.com>
 <d8f5fa9b9fab73c2e0923ccf38d5bdb15f7b7a70.1622580781.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8f5fa9b9fab73c2e0923ccf38d5bdb15f7b7a70.1622580781.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 02:34:17PM -0700, Jonathan Tan wrote:
> 
> Instead of using global variables to store promisor remote information,
> store this config in struct repository instead, and add
> repository-agnostic non-static functions corresponding to the existing
> non-static functions that only work on the_repository.

Nice!

> diff --git a/promisor-remote.c b/promisor-remote.c
> index bfe8eee5f2..5819d2cf28 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -5,7 +5,11 @@
>  #include "transport.h"
>  #include "strvec.h"
>  
> -static char *repository_format_partial_clone;
> +struct promisor_remote_config {
> +	char *repository_format_partial_clone;
> +	struct promisor_remote *promisors;
> +	struct promisor_remote **promisors_tail;
> +};
[snip]
> -static struct promisor_remote *promisors;
> -static struct promisor_remote **promisors_tail = &promisors;

Nice, so all the old globals are contained in a data struct now...

> -static struct promisor_remote *promisor_remote_new(const char *remote_name)
> +static struct promisor_remote *promisor_remote_new(struct promisor_remote_config *config,
> +						   const char *remote_name)

...which we use during promisor_remote creation now.

> @@ -135,59 +140,63 @@ static int promisor_remote_config(const char *var, const char *value, void *data
>  	return 0;
>  }
>  
> -static int initialized;

Very happy to see this pattern vanquished. ;)

> -static void promisor_remote_init(void)
> +static void promisor_remote_init(struct repository *r)
>  {
> -	if (initialized)
> +	struct promisor_remote_config *config;
> +
> +	if (r->promisor_remote_config)
>  		return;
> -	initialized = 1;

So it's not a "call once, set global state" anymore, but we are also
careful not to trample any existing state on the 'struct repository'.
Nice.

> +	config = r->promisor_remote_config =
> +		xcalloc(sizeof(*r->promisor_remote_config), 1);

Hm. Am I the only one who doesn't like assigning from the result of an
assignment like this? ...Based on 'git grep "=[^=]\+=[^=]"' yes, I am the
only one :)


Overall this patch looks OK to me, but I see that there are some changes
suggested for the next version, so I'll hold off on a reviewed-by so I
can have a look at those too.

 - Emily
