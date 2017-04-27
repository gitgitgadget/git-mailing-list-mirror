Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36571FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 06:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932342AbdD0GAv (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 02:00:51 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35672 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbdD0GAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 02:00:49 -0400
Received: by mail-pf0-f194.google.com with SMTP id a188so6447164pfa.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 23:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=euUO//RgwfYG4hI35BRq97goRGDfMXUFmU7zjZLppaY=;
        b=Aua6MhnuMMPQXC9iCUnd/HTTeaDYDrUks8ypJkArAMAI+zZzptdBgWdk7IMH/6n+Rq
         ggt7Lg+pSyxguYglKfYQjQQ32oI5LdvOM7ZTgEkXN/adlaiaccHoSp0Pt4YlH7Ni7lBk
         FUYhSWjb2qzAzpT3+z+Fkpk4E5JvQBbY0x48sALXPjc5c46Aae2dvNrk5ZwKRreyjgUZ
         FzSuIUQk7Atoy9gRCiwavwa/MTBqUHyuaOBUaPJT65n0DOk9jTmYbX7XMFpLinxudLMd
         BH//DOgCd+BUO1WlfTIM7PDkXhtunhchw3ELwsy0Gz9wbgth9j3ee9xm31h/HbGQtZfq
         n5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=euUO//RgwfYG4hI35BRq97goRGDfMXUFmU7zjZLppaY=;
        b=IJMn2pPLDa01zoRs9En0+algawXkiy5lSPmeknKz7BAYbxHjgABLOMCmOq+KXj/YLp
         8jPRGCp3a/HerZMIBvCroysz3Uetkpd33qwpRv51lonrtosrmeGF0VOrW1EjUqGD3J3S
         4xaRZpHMRhKvYDyVIr59LHvkKIpXBlKjSXWKqDxAQtxJXbLa5go96LFFaQObgK3pLX6h
         AdXxyuhMwC5nTIRCpyBICunR+IhB1UcFqIe2gfFgPrdmmkaHNz/GlU/ncJLK0CPlRnfE
         RVYgFON2tdzgblA1xdUtFoiUjJIznXOfNKCJ0XJKeE2NyBO7YZH3SvQ8232UL/pT43ZE
         UsuA==
X-Gm-Message-State: AN3rC/5tsbsuJmHmG43oMMcu1qD1kCV1Be/ofCOyBKa4LHXjFJxok4Cd
        ggtyZf4tp9HaGg==
X-Received: by 10.98.85.6 with SMTP id j6mr3836733pfb.31.1493272848868;
        Wed, 26 Apr 2017 23:00:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id g89sm2003092pfk.25.2017.04.26.23.00.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 23:00:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/26] http-backend: avoid memory leaks
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <366e4d805da9b4b610fe216537de5e4a4c3941ed.1493237937.git.johannes.schindelin@gmx.de>
Date:   Wed, 26 Apr 2017 23:00:47 -0700
In-Reply-To: <366e4d805da9b4b610fe216537de5e4a4c3941ed.1493237937.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 26 Apr 2017 22:19:47 +0200
        (CEST)")
Message-ID: <xmqq4lxao0ds.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Reported via Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  http-backend.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/http-backend.c b/http-backend.c
> index eef0a361f4f..d12572fda10 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -681,8 +681,10 @@ int cmd_main(int argc, const char **argv)
>  		if (!regexec(&re, dir, 1, out, 0)) {
>  			size_t n;
>  
> -			if (strcmp(method, c->method))
> +			if (strcmp(method, c->method)) {
> +				free(dir);
>  				return bad_request(&hdr, c);
> +			}
>  
>  			cmd = c;
>  			n = out[0].rm_eo - out[0].rm_so;
> @@ -708,5 +710,7 @@ int cmd_main(int argc, const char **argv)
>  					   max_request_buffer);
>  
>  	cmd->imp(&hdr, cmd_arg);
> +	free(dir);
> +	free(cmd_arg);
>  	return 0;
>  }

Hmph.  I find a "leak" of a resource acquired inside the main
function and not released when the main function leaves a lot less
interesting than the other ones this series covers.

When the "return" in the first hunk leaves the function and also
the same block of the if () statement breaks out the loop, we also
fail to call regfree(&re).  Shouldn't we be cleaning it up as well?

