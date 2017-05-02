Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 211F0207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbdEBELK (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:11:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36569 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdEBELJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:11:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id v14so30346747pfd.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eDN0QEjNU0tVDtHU9cDWVtZOUYDTTMQI2csQcf/uv2c=;
        b=Dtxk9PLi+vnyZbnU7GKvySvU2mWIBvhwRG6RgnDkmiB8vgk4XTsZAThfBPJej71rwR
         lFF3WkaIfMqmhvMtLd8eG2SmO8FqIPv7jm/TS+pfJNHtWlfHEHNYJ7EVVZ2z7Og7wOxm
         syCex9F9P9k+J3BjIEkHghx6xjTdJeXBauKewOOVwWX2yKyTvzoXZCQTH/oCaZl4CIsK
         LEIcw3//WEsQpH+dVycyUcSolZrJQ6BHXqDOIsppwWvQFH05n9kviP05QickjcnuVs2Q
         lUwhvtEDgUoBUpl82fOv7eb0QozKk74R9Xk3I0glXYdQItrQSPAzqwAQ+tQEq8JpBVMT
         e0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eDN0QEjNU0tVDtHU9cDWVtZOUYDTTMQI2csQcf/uv2c=;
        b=pbG3oZxNLny+Vi+ELbTios2eXqiAVqYb9zd4yRm+VuHdyDBXXkr1gBAHlsHECUv2NH
         mD7Pu+iFWtuhLpSaY3SjguYJwQVG7YhYunnLYSWLFn4okeg3j2rYlBRSZuLaAnnImIOQ
         uy3OJfO5A1yNOonuH1NxV4M74tniGVTtA0WkjE5EDMtADWdIyTeZx+zTP6PJiJgboWdi
         40UGuR4WvEhJALODSMKQ8Z7WvLjiqp+9uSo3wW8v/XAcGib84+NNTuZzC4E3IZyz2gXt
         4ljH1Dx4IDLwDIHvJfKDF95gsO+cXWmeK69toIrNb26YN6EoYJzCyGMW2VwycbN+YHwC
         WmXQ==
X-Gm-Message-State: AN3rC/7IffE1vYd7iKYkmecz8p8Fg2vRkVtlvvPeZYe9ZtlmXomB+WM4
        Fpq5NVgFufKmcQ==
X-Received: by 10.84.230.131 with SMTP id e3mr39416193plk.100.1493698268280;
        Mon, 01 May 2017 21:11:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id u8sm27093817pfk.103.2017.05.01.21.11.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 21:11:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 09/25] mailinfo & mailsplit: check for EOF while parsing
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <cover.1493387231.git.johannes.schindelin@gmx.de>
        <32a2d16902734c8794de61b5e86a0d2a6cf43fa3.1493387231.git.johannes.schindelin@gmx.de>
Date:   Mon, 01 May 2017 21:11:06 -0700
In-Reply-To: <32a2d16902734c8794de61b5e86a0d2a6cf43fa3.1493387231.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 28 Apr 2017 16:02:57 +0200
        (CEST)")
Message-ID: <xmqqzievdhk5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> While POSIX states that it is okay to pass EOF to isspace() (and it seems
> to be implied that EOF should *not* be treated as whitespace), and also to
> pass EOF to ungetc() (which seems to be intended to fail without buffering
> the character), it is much better to handle these cases explicitly. Not
> only does it reduce head-scratching (and helps static analysis avoid
> reporting false positives), it also lets us handle files containing
> nothing but whitespace by erroring out.
>
> Reported via Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/mailsplit.c |  3 ++-
>  mailinfo.c          | 15 +++++++++++----
>  2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 30681681c13..9b3efc8e987 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -233,7 +233,8 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
>  	do {
>  		peek = fgetc(f);
>  	} while (isspace(peek));
> -	ungetc(peek, f);
> +	if (peek != EOF)
> +		ungetc(peek, f);

I agree more with the first sentence in the proposed log message
than what this code actually does.  I.e. breaking upon seeing an EOF
explicitly would be nice, just like the change to mailinfo.c in this
patch we see below.

> @@ -1094,14 +1097,18 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
>  		return -1;
>  	}
>  
> -	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
> -	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
> -
>  	do {
>  		peek = fgetc(mi->input);
> +		if (peek == EOF) {
> +			fclose(cmitmsg);
> +			return error("empty patch: '%s'", patch);
> +		}
>  	} while (isspace(peek));
>  	ungetc(peek, mi->input);

The handling of EOF is improved, but is it correct to move the
allocation of p/s_hdr_data down?

Among the two callers, builtin/am.c just dies when it sees
mailinfo() returns an error, but builtin/mailinfo.c tries to be
nicer and calls clear_mailinfo().  Wouldn't this make that codepath
dereference a NULL pointer?

I think the moral of the story is that people tend to get sloppier
when doing "while we are at it" than the main task, and a reviewer
needs to be more careful while reviewing the "while we are at it"
part of the change than the primary thing a patch wants to do ;-)

> +	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
> +	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
> +
>  	/* process the email header */
>  	while (read_one_header_line(&line, mi->input))
>  		check_header(mi, &line, mi->p_hdr_data, 1);
