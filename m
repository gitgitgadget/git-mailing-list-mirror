Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52D3C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC43A60C3F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhHCVM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 17:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhHCVM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 17:12:56 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D6EC061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 14:12:45 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id a13so41485iol.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KQDO4n6UY9JANGC4VObVpyY4mUNJEHrB8GK37EzJ7mw=;
        b=x9eqAW9tyqyVbO6Ql1xnOXITN+BSmnYT9RVC3zCystcryRFxAcdw7mUrc11GxoVmmb
         Bys4tV4XkISo/zOx67bWftPE8PoEyVfPzHlWYfpRPI6orIrKRh4kFYjYuz9vJlOEB7vt
         9VWjxmlni6OhkEpWpdSEE8m+YGg+a0HLIzy1KQyVbGVKTcdistSH+mGuoEiih0KORvPe
         cZuijwuHG9N8uHoCbr6XqTMrsVVQEA25PkC8Hw1gaT6ktKD6mlmF5XlpXA5qttx4kIZ0
         62FNVNXywjo3+K/N+Fc1/n3ldn2IyR7tYfJ0S5YaNgK3Ks4rdYKNPCTJqa1tjCYM2wub
         5yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KQDO4n6UY9JANGC4VObVpyY4mUNJEHrB8GK37EzJ7mw=;
        b=PJKoEbcAGt60hBfyxwMY0MiyBzUPgROxFesyyarZolkbSR/20+JaP3pW3mICyvvZj7
         jM70BlCRgFOc00OF4PeXL1d/yBvuO+M7uGBcGoZljR2iRmr2YQ2lw6dEAbb5AijyY/3T
         2QUh45FjFfTvi8bnbjpxSbPTB9dZEAgUuCJwwC5LZ+TBE9fOODXQivEEctDbu+Gxc4Ql
         w+UEZvotc0rIryjm68AmleRFnff234iRGw3vyNpMYF4CTDwiZX7/Nx4Pj57gFJ4BpoJM
         T99eKxpSQx/2xg6DuOozyURgub468gI+0dbzKDOx4q59VCpUmRnvJ3rLlur3YP5B2hU3
         Exjw==
X-Gm-Message-State: AOAM533H+ERgA7yiO4K8eKBrzRFEL6QXrZ9HCEKSvUpb1tMqDNE4HAem
        LKcvqJ7QWcYWT7hrNOkCJbFf5w==
X-Google-Smtp-Source: ABdhPJzkqb/Caa1RjBL/2PtGPjJF0crUqK52fIpfxuEIiipCmzn5mcZG+lZFfWvVqYGdLHzqTpDo7A==
X-Received: by 2002:a05:6602:1808:: with SMTP id t8mr941455ioh.165.1628025164718;
        Tue, 03 Aug 2021 14:12:44 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a92c:44a1:9adc:e4de])
        by smtp.gmail.com with ESMTPSA id z22sm158189ioe.52.2021.08.03.14.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 14:12:44 -0700 (PDT)
Date:   Tue, 3 Aug 2021 17:12:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] connect, protocol: log negotiated protocol version
Message-ID: <YQmxSxTswHE/gTet@nand.local>
References: <f79ab95af6da3da710da2112cfcae4a042b7f7fb.1628020616.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f79ab95af6da3da710da2112cfcae4a042b7f7fb.1628020616.git.steadmon@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 01:13:02PM -0700, Josh Steadmon wrote:
> [...] Therefore, log the negotiated wire protocol version via trace2,
> for both clients and servers.

Seems useful, thanks.

> Do people have a preference for logging this as an integer (and
> therefore having "unknown protocol version" show up as "-1", or should I
> add a protocol_version_to_string function so that we can format it
> properly? For now I've erred on the side of having a smaller diff.

I probably have a slight preference for converting the protocol_version
to a string and passing that along to trace2_data_string() instead. That
would let you more cleanly log "<unknown>", without needing to expose
implementation details like which enum has what value.

> diff --git a/connect.c b/connect.c
> index 70b13389ba..6e23e3ff2d 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -164,6 +164,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
>  		BUG("unknown protocol version");
>  	}
>
> +	trace2_data_intmax("transfer", NULL, "negotiated-version", version);

Small nit-pick, this could come between the two switch statements, not
at the end of the function (since we know what we are going to return
before we switch on version.

(I was a little surprised to see that these functions now have the
side-effect of writing to trace2, since I would have instead expected
to see new lines added at the callers. But this makes it more
convenient, and I do not feel strongly about it)

In any case, connect.c:discover_version() is handling the client side,
but...

> diff --git a/protocol.c b/protocol.c
> index 052d7edbb9..3791d8499e 100644
> --- a/protocol.c
> +++ b/protocol.c
> @@ -89,5 +89,6 @@ enum protocol_version determine_protocol_version_client(const char *server_respo
>  			die("protocol error: server explicitly said version 0");
>  	}
>
> +	trace2_data_intmax("transfer", NULL, "negotiated-version", version);
>  	return version;
>  }
> --

This function is used by discover_version to parse the server's
response. If you are trying to log what protocol was agreed on from the
server's perspective, I think you are looking instead for
determine_protocol_version_server().

If you aren't (and are only interested in the client's point-of-view),
then I am pretty sure that this latter hunk is redundant.

Thanks,
Taylor
