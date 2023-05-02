Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FF5C19F20
	for <git@archiver.kernel.org>; Tue,  2 May 2023 21:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjEBVwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 17:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBVwb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 17:52:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44B1988
        for <git@vger.kernel.org>; Tue,  2 May 2023 14:52:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24e2bbec3d5so887986a91.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683064350; x=1685656350;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rwi+Bqyji5hT1hqOOG20FrdhQjeT9Yg0Ne+eDYAS/Sg=;
        b=W6heGtkbr5WOr6oBGdsoA2gH4IxeKHpBqObXdzxMAdpeXAuWViUBORspdu6Oq2W9i7
         CrRIarGvGqn6X79YyEX6rMQ9CMuJcIAn6QrBCPg9l/V5yF7O13MeAXjcG9wZS1BhRSBM
         qsaPsxX66jf3e5zP/FbSlZFOI/1CV0LHONVXcTO6Q9ks++wWn6lnW2vzMkXDrmdq2Fgt
         8Q14vHJA343vwFol20ZfFQZRDLP9NVIqazQtjuFOv5cSYfG5vuG81DMor2dGzQlLdTWU
         PPQYzWzSYvAYvB6Na53sL1b5XQm9ipr5c0fEcuVoKiqiBK6agARAsqskLwlrNnxb5Q0H
         z/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683064350; x=1685656350;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rwi+Bqyji5hT1hqOOG20FrdhQjeT9Yg0Ne+eDYAS/Sg=;
        b=MqJL2Art9ZKqkSr4g7Cqe50r4zq+YCAoUR8j1Bmendc1SH1/6+Noz5IrObeLMGPeBx
         2ILaYb/anaznzICjzIy677h8E30/4DIaaGMe7cyWT7lHJX1XHg2DO18A1KCjKQV5q9P5
         Jiaz4fRPzoR28xj2Bkd4XvqwuTxYWzy3epH0Es6Hxuct0BIVT85ie7zmAYon0pKL5vr/
         yW7I86jlH8yDmnCMbhfOoUmszJMlKeXvJkX5MAUmw6ZqgJ4Xjy14RyAdqYa1RZgw5sAk
         T/aGtzUIO2EhCUl0xJ42juBNHHGCjty1w7Q6PJrTKWORbxDZo5i9pkpEZVuO5V8mmW4s
         PMOQ==
X-Gm-Message-State: AC+VfDwSbdhqebZR2trhkOCHu+wkzovUspOgpAugb+3gLk1haExMqvFn
        TNutchvsDkP+JiBjFgA/YMY=
X-Google-Smtp-Source: ACHHUZ5ez5dkYDJ8EZUnya3R8wBTvp6QvaiTWe1m17CdQc7npdd71Ky4+rXtk16NP581xsCOKszxlA==
X-Received: by 2002:a17:90b:1a86:b0:234:28ac:ec4a with SMTP id ng6-20020a17090b1a8600b0023428acec4amr18292203pjb.2.1683064349617;
        Tue, 02 May 2023 14:52:29 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id ms17-20020a17090b235100b0024de93877acsm5379126pjb.47.2023.05.02.14.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:52:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH 2/6] credential-store: move related functions to
 credential-store file
References: <20230502211454.1673000-1-calvinwan@google.com>
        <20230502211454.1673000-3-calvinwan@google.com>
Date:   Tue, 02 May 2023 14:52:28 -0700
In-Reply-To: <20230502211454.1673000-3-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 2 May 2023 21:14:50 +0000")
Message-ID: <xmqq1qjyz9ib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> is_rfc3986_unreserved() and is_rfc3986_reserved_or_unreserved() are only
> called from builtin/credential-store.c and they are only relevant to that
> file so move those functions and make them static.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  builtin/credential-store.c | 19 +++++++++++++++++++
>  strbuf.c                   | 19 -------------------
>  strbuf.h                   |  3 ---
>  3 files changed, 19 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> index 8977604eb9..4776118331 100644
> --- a/builtin/credential-store.c
> +++ b/builtin/credential-store.c
> @@ -73,6 +73,25 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
>  		die_errno("unable to write credential store");
>  }
>  
> +static int is_rfc3986_unreserved(char ch)
> +{
> +	return isalnum(ch) ||
> +		ch == '-' || ch == '_' || ch == '.' || ch == '~';
> +}
> +
> +static int is_rfc3986_reserved_or_unreserved(char ch)
> +{
> +	if (is_rfc3986_unreserved(ch))
> +		return 1;
> +	switch (ch) {
> +		case '!': case '*': case '\'': case '(': case ')': case ';':
> +		case ':': case '@': case '&': case '=': case '+': case '$':
> +		case ',': case '/': case '?': case '#': case '[': case ']':
> +			return 1;
> +	}
> +	return 0;
> +}

Both the moved ones being static means we even lose the declarations
in the header file.  Very nice.
