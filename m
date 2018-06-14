Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C981F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754841AbeFNR3U (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:29:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39260 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754644AbeFNR3U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:29:20 -0400
Received: by mail-pl0-f67.google.com with SMTP id f1-v6so3908899plt.6
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qLeK3yp33f0ffXWU588NKQLHT79fFD5IKjBycCF6TGA=;
        b=exfOFY27oVlBTh833a40y6La3XarTLt/0n/WeyJb8yQep2diCa1I8hZV1ebCCm0tBy
         Q/7DCxQorSMCERhZ78I9L8fL9DToLrmGzfl4Ym/I18uUnpHlbxU31omrMXJj+q/8qoTn
         edGAPRIMY3pLdKIJzp/5TClsrpSeyT+RhL7yHEqEUbu7uFtChmyumMHfDl4D8JezzHmd
         t+sLnKyZZeuukFydegBf4XkasR7FZCHnUVOd64Ziq8tabnZf/NbxX8Ck6nVxqGXBojn4
         Fn8mObrlEQbJlq3zWnEo/D5W+ybo27d5kFm3deTtR8IKt97nfC5kqJYyjbxPVL4fMhol
         YXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qLeK3yp33f0ffXWU588NKQLHT79fFD5IKjBycCF6TGA=;
        b=nw/+eMmDXs7+TjDMz78QIJaojxV8lkbOHNCh9DxprbROHY8ofPNA3IWCvxLL7HTBZV
         GC1sOzKBQrceXLkDQvzyWPLnIpIma5BwqzvFC5a6EaSdoOTqZ+TyG64VnE4OIYw+iRIR
         76E/tbrl9Td9cU7rXdIfd3Sdz7sDyYoMJYdwUXwgLs1oVHRj8mKEppMDiENrVYpKUdJw
         KBaOWBML0v5fLzllqEu2dyTc/Rt0EgbBmCYzETof0LpecemHzp1mxX2xxxau2XHf17bM
         jRkd366LKja9Hd/uH7y7Ix+pmYaMu2A17+XRuUtgv7LCas/6st/QACQLs5piKSrobP56
         q0+A==
X-Gm-Message-State: APt69E3jHJiH3E7ukGkh4Mv/LABkpHNxNHIgACcv3wDhhGu/aIe9yKlq
        z4hIGesAJyAFperLGtAxBntIBw==
X-Google-Smtp-Source: ADUXVKKEuVnz/68FnK2bUXfiD9Vm3mMECF9emRUztwArcqgZrONgJqOOHVZzQ+FzmwYn4BtkADqqVg==
X-Received: by 2002:a17:902:6847:: with SMTP id f7-v6mr3959409pln.173.1528997359434;
        Thu, 14 Jun 2018 10:29:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id f6-v6sm11271988pfd.112.2018.06.14.10.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 10:29:18 -0700 (PDT)
Date:   Thu, 14 Jun 2018 10:29:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 3/8] fetch-pack: directly end negotiation if ACK ready
Message-ID: <20180614172917.GB220741@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <cover.1528317619.git.jonathantanmy@google.com>
 <fda04a33c38907388fd6d2166730928d78774c22.1528317619.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda04a33c38907388fd6d2166730928d78774c22.1528317619.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06, Jonathan Tan wrote:
> When "ACK %s ready" is received, find_common() clears rev_list in an
> attempt to stop further "have" lines from being sent [1]. It is much
> more readable to explicitly break from the loop instead, so do this.
> 
> This means that the memory in priority queue will be reclaimed only upon
> program exit, similar to the cases in which "ACK %s ready" is not

This seems fine for now though ideally we would remove the global
priority queue and have it live on the stack somewhere in the call stack
and it could be cleared unconditionally before returning.

> received. (A related problem occurs when do_fetch_pack() is invoked a
> second time in the same process with a possibly non-empty priority
> queue, but this will be solved in a subsequent patch in this patch set.)
> 
> [1] The rationale is further described in the originating commit
> f2cba9299b ("fetch-pack: Finish negotation if remote replies "ACK %s
> ready"", 2011-03-14).
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 2812499a5..09f5c83c4 100644
> --- a/fetch-pack.c
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
>  		}
>  	}
>  done:
> @@ -1300,7 +1300,6 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
>  		}
>  
>  		if (!strcmp(reader->line, "ready")) {
> -			clear_prio_queue(&rev_list);
>  			received_ready = 1;
>  			continue;
>  		}
> -- 
> 2.17.0.768.g1526ddbba1.dirty
> 

-- 
Brandon Williams
