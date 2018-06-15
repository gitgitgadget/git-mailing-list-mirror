Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EAFF1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 16:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965977AbeFOQEP (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 12:04:15 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42917 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965895AbeFOQEO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 12:04:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so10434627wrk.9
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LS3VPJJ29ngruHvbz7Ngz6xGbeTlk9Tn/i6gYtvZO3Q=;
        b=g+4onNm6dTNV8x2ydBclDZMBYufMgu7qPA4wbymRdIlVkInGLnPuvSFfJYhZjAoORj
         m5gzTSh3XcpShJ8v+sqcqCtelOiye54twGleO1zeeHNvbwLGNdbCc1o4wrm2rQvb1VIj
         XkJydPOw42ZM/I++v9UnGgFhWMTbDyEL8wt/xWYVTpdsOwJOiegEe6a1K/fAJ6ibg6gB
         436MCEG0nXVKS1/cqfI37Lg2KObofkP+3RTRUvMp8VhNVaiLGpIuwBVHwVztsuS4At58
         Npo86wqkHnK+m395MYxxqIsHGDMhYqM63AUj1zhicZL0DHipGJGIvob4TWvoRkiSe1mP
         tpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LS3VPJJ29ngruHvbz7Ngz6xGbeTlk9Tn/i6gYtvZO3Q=;
        b=f/Ve3i5VGUMcOlpjMb0iE8is15Nwy80jYPKdIKY1B4Wa08UcZxrReAzfVy+ppnoC4G
         lfeIqD42E2QN9hBbVftk4Wr/91Mw1b3gXtCSpQDFVMXw6wAkJYTygvGdipFbjCdZh+/u
         kObf+AordFDVFOo8cbU48yCBGGVecW3pK2nYMCEvbHYJV1R9HRrGUDcHswrkSlFmv5p0
         M1JK34CZfi2zmGIbV6Q7HrxqT6Di8wjBiojLjUhuK1N8UPljqS8Yw1dE2ZbxrCCzBNdi
         wi0ValE7vpVN1EJRLRVJPE/Oc8hAzesFq/y07WeR9bw4pk+NL3d17QIR0SDpylcZ2Bcu
         4ZxA==
X-Gm-Message-State: APt69E1TTQJOtQZ+CU6SYwk+7UYO5YYv82PVLc0NGdLIc/iadPGdCqCv
        uZSEUKRjg68XvSdRBi2UutI=
X-Google-Smtp-Source: ADUXVKLiKl+LRsxjGrl0/RM8BW7KxIHWKp2kNfk0mfED1Fc9C4n1hIFrdbaeAuE9lTWR1i+BiKaRbg==
X-Received: by 2002:adf:b297:: with SMTP id g23-v6mr2129591wrd.218.1529078652570;
        Fri, 15 Jun 2018 09:04:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s9-v6sm1468854wmc.34.2018.06.15.09.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 09:04:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCH v3 3/7] fetch-pack: directly end negotiation if ACK ready
References: <cover.1527894919.git.jonathantanmy@google.com>
        <cover.1529016350.git.jonathantanmy@google.com>
        <fdcd88ba460d1feddb40037ff5b935339a51368b.1529016350.git.jonathantanmy@google.com>
Date:   Fri, 15 Jun 2018 09:04:10 -0700
In-Reply-To: <fdcd88ba460d1feddb40037ff5b935339a51368b.1529016350.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 14 Jun 2018 15:54:24 -0700")
Message-ID: <xmqqefh82g05.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When "ACK %s ready" is received, find_common() clears rev_list in an
> attempt to stop further "have" lines from being sent [1]. It is much
> more readable to explicitly break from the loop instead.
>
> So explicitly break from the loop, and make the clearing of the rev_list
> happen unconditionally.
>
> [1] The rationale is further described in the originating commit
> f2cba9299b ("fetch-pack: Finish negotation if remote replies "ACK %s
> ready"", 2011-03-14).
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

This makes more sense to me; I was wondering where the prio-queue
gets cleared, or leaking it is OK, while reading the previous round.

Thanks.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 2812499a5..60adfc073 100644
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
> @@ -1096,6 +1096,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  		die(_("git fetch-pack: fetch failed."));
>  
>   all_done:
> +	clear_prio_queue(&rev_list);
>  	return ref;
>  }
>  
> @@ -1300,7 +1301,6 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
>  		}
>  
>  		if (!strcmp(reader->line, "ready")) {
> -			clear_prio_queue(&rev_list);
>  			received_ready = 1;
>  			continue;
>  		}
> @@ -1441,6 +1441,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		}
>  	}
>  
> +	clear_prio_queue(&rev_list);
>  	oidset_clear(&common);
>  	return ref;
>  }
