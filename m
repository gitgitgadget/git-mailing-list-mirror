Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CBBB1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 23:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbeFEXQi (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 19:16:38 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37614 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932203AbeFEXQh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 19:16:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id y5-v6so1233416pfn.4
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DiEh7yyuvN183LaGjdT0Tx2A+vI/cTsdxxdknvxYO1M=;
        b=cdoWDNwqdmcZPZRHuYZ5whbO8m3VeNu1gRgWbKLs7qeffuULeUZZPmM/3mKZyxgCJq
         Zt97KDUnOWMhQzULscxWzrG4bCzMKBLrGFtEDN76JVHjdQXWheaInNDbJcqg4YG5gzLw
         pDe9HZmYcFyPnJRMucFXnfbZSSaky4PfJdNFJppyIFWAURPFc2qCpwfBMZ6NVoSu7bSM
         wSXTE1VYOmJ5tbHvEJC75iX7PnZ1ZGnH5wvYJgwxh1686NZF1Sk81ZxqvOFcEoW1AKid
         3MOq7uUSK1O9BcwUB+UNe6gHqYMFboE72fLMQKHq8rlwefYEQukUjrfhF8KSoT1q+gY2
         Czaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DiEh7yyuvN183LaGjdT0Tx2A+vI/cTsdxxdknvxYO1M=;
        b=WB575H5ffGTW9of7RRHlf3m8jHMKuXdOzgaXtEla0EoyvP0mK/HAH/17CKBZimucM0
         YbZPECAlp+LPG/whT1fzo9rHRp/ngJdzXeCWXnERddAw7WiepOVH0kh6re+AbRPbFaeP
         1CtNF1u6pDjWBfLft/sioNih+G3fJ4WAO4ij88SMRpsnyJRNRqmpIA7SQ0JbvqZQd8eE
         oQkh+O9Sj3+A+AZpgxHPLjZ52vFJgacx27SFaRolM4bt1W9ATJiS+Uv+HxDXoelxiuB7
         fJ/ARqHi4x/8h4KKYGeMX5v19rKrsfdakoYnfzbb2PikXZNcjfr8tfvfcpu3bq1paj3q
         ybLg==
X-Gm-Message-State: APt69E0QTX7prizLdv5NumXtur4OSjgxgaLwEmq1IoYU65FkqptyOVXx
        KJlBIv7I6r/LbcdBiUf0rcw=
X-Google-Smtp-Source: ADUXVKI1p3Ih0uS8FVHJ3C41Ok/65UlnR3lUDb+or3C+RkcM68WQN6qtccL5olKUOhDXYYBcKO6NVA==
X-Received: by 2002:a63:ad08:: with SMTP id g8-v6mr499246pgf.74.1528240596401;
        Tue, 05 Jun 2018 16:16:36 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y18-v6sm25610462pfl.122.2018.06.05.16.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 16:16:35 -0700 (PDT)
Date:   Tue, 5 Jun 2018 16:16:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Subject: Re: [PATCH 2/6] fetch-pack: truly stop negotiation upon ACK ready
Message-ID: <20180605231634.GD9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <c79a6e6f96e2e453017669fabbed1a9fb4036cce.1527894919.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79a6e6f96e2e453017669fabbed1a9fb4036cce.1527894919.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> When "ACK %s ready" is received, find_common() clears rev_list in an
> attempt to stop further "have" lines from being sent [1]. This appears
> to work, despite the invocation to mark_common() in the "while" loop.

Does "appears to work" mean "works" or "doesn't work but does an okay
job of faking"?

> Though it is possible for mark_common() to invoke rev_list_push() (thus
> making rev_list non-empty once more), it is more likely that the commits

nit: s/more likely/most likely/
or s/it is more likely that/usually/

> in rev_list that have un-SEEN parents are also unparsed, meaning that
> mark_common() is not invoked on them.
>
> To avoid all this uncertainty, it is better to explicitly end the loop
> when "ACK %s ready" is received instead of clearing rev_list. Remove the
> clearing of rev_list and write "if (got_ready) break;" instead.

I'm still a little curious about whether this can happen in practice
or whether it's just about readability (or whether you didn't figure
out which, which is perfectly fine), but either way it's a good
change.

> The corresponding code for protocol v2 in process_acks() does not have
> the same problem, because the invoker of process_acks()
> (do_fetch_pack_v2()) proceeds immediately to processing the packfile

nit: s/proceeds/procedes/

> upon "ACK %s ready". The clearing of rev_list here is thus redundant,
> and this patch also removes it.
>
> [1] The rationale is further described in the originating commit
> f2cba9299b ("fetch-pack: Finish negotation if remote replies "ACK %s
> ready"", 2011-03-14).
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
[...]
> +++ b/fetch-pack.c
> @@ -517,10 +517,8 @@ static int find_common(struct fetch_pack_args *args,
>  					mark_common(commit, 0, 1);
>  					retval = 0;
>  					got_continue = 1;
> -					if (ack == ACK_ready) {
> -						clear_prio_queue(&rev_list);
> +					if (ack == ACK_ready)
>  						got_ready = 1;
> -					}
>  					break;
>  					}
>  				}
> @@ -530,6 +528,8 @@ static int find_common(struct fetch_pack_args *args,
>  				print_verbose(args, _("giving up"));
>  				break; /* give up */
>  			}
> +			if (got_ready)
> +				break;

Makes sense.

> @@ -1281,7 +1281,6 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
>  		}
>  
>  		if (!strcmp(reader->line, "ready")) {
> -			clear_prio_queue(&rev_list);
>  			received_ready = 1;
>  			continue;

I'm curious about the lifetime of &rev_list.  Does the priority queue
get freed eventually?

Thanks,
Jonathan
