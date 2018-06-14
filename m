Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EA751F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754757AbeFNReH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:34:07 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34964 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754616AbeFNReG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:34:06 -0400
Received: by mail-pl0-f65.google.com with SMTP id k1-v6so3929169plt.2
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6XDEd9rEV30hRvb2NMxYsO/+r4ZKay4J5A1MRdbj1IU=;
        b=Dy+T6LMEtVpSIj20KQL8s0An813gnm020ewwWol2b5m+yZsDr83cxOb15hKZyLGEDw
         v4fE0hjPhd5jW7vDxIy8vnmW5408+vQCTspDtUBHaPT2QDq33vCw/GU3aSfV4wQd8MpO
         cUs70c24LZFCuw1bSvJRy7RqHOrZjw+Nbw4UIj/05f6QmAnrd7mvhU+ic9rC6oAjED3B
         YLUQhc6b++vBc8vDl9RQQO8MCQUKIW0/WlHfQBfIan1jWjCrKmbCeFvcfgsPDvLgjx8W
         RhS3KThw4IQ46/au4YtKkV7EVgqfD4ici26x5WckC5sYLCK2XgllaZKLKxo5sm8JH0Sf
         injQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6XDEd9rEV30hRvb2NMxYsO/+r4ZKay4J5A1MRdbj1IU=;
        b=AgtCFZOaII588CBf3Q88EsJa5qf4NPCuck77kZUFc5o9lbNYBHiuQzSz/wJJgsw1do
         MeFgl2W5KGmKhzHNzFuGeweM6obFnQmSnnVoujp6YmGsg+GEg8XZPVVQi+nkCaMspikd
         PUIRW5NG/Lh6x3TUrlaj4Iy1gkxxfKEXRIvVgM4d1K3p39DTCTNYEtfaAmmezHZKxslC
         5DYZSLVpiUDTVZF/lBXHzK0X0Fj/K/lKnQsj/HbTW+p8d+mzy/sALL2uPxC1WZihDOqe
         i+cQU78UAGNERhF/WpGm2eBnsM31cUmiJzdyA9XKQGLgdOz02V3IxbwVOJmpzxvKu+a6
         Hacg==
X-Gm-Message-State: APt69E2M8jrE/MUQYK0rXFPcnM5WyxbZ2mbgIA1R9Mu+XlMPQRI4MZ/1
        CT6cmBss60WbFqe1ufUUX5vVkQ==
X-Google-Smtp-Source: ADUXVKIPzcXjyXY/CWKMVSDajyrt8BHmzwEECc/MbIAWnt86aHtEazuAKjE+JvewdgqvmivkjwJV8A==
X-Received: by 2002:a17:902:7105:: with SMTP id a5-v6mr3974413pll.171.1528997645974;
        Thu, 14 Jun 2018 10:34:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id i7-v6sm21634288pfa.34.2018.06.14.10.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 10:34:04 -0700 (PDT)
Date:   Thu, 14 Jun 2018 10:34:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 3/8] fetch-pack: directly end negotiation if ACK ready
Message-ID: <20180614173403.GD220741@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <cover.1528317619.git.jonathantanmy@google.com>
 <fda04a33c38907388fd6d2166730928d78774c22.1528317619.git.jonathantanmy@google.com>
 <20180614172917.GB220741@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614172917.GB220741@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14, Brandon Williams wrote:
> On 06/06, Jonathan Tan wrote:
> > When "ACK %s ready" is received, find_common() clears rev_list in an
> > attempt to stop further "have" lines from being sent [1]. It is much
> > more readable to explicitly break from the loop instead, so do this.
> > 
> > This means that the memory in priority queue will be reclaimed only upon
> > program exit, similar to the cases in which "ACK %s ready" is not
> 
> This seems fine for now though ideally we would remove the global
> priority queue and have it live on the stack somewhere in the call stack
> and it could be cleared unconditionally before returning.

Wait looks like a later commit does just this, maybe stick in a comment
saying a later patch is cleaning this up.

> 
> > received. (A related problem occurs when do_fetch_pack() is invoked a
> > second time in the same process with a possibly non-empty priority
> > queue, but this will be solved in a subsequent patch in this patch set.)
> > 
> > [1] The rationale is further described in the originating commit
> > f2cba9299b ("fetch-pack: Finish negotation if remote replies "ACK %s
> > ready"", 2011-03-14).
> > 
> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> > ---
> >  fetch-pack.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 2812499a5..09f5c83c4 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -517,10 +517,8 @@ static int find_common(struct fetch_pack_args *args,
> >  					mark_common(commit, 0, 1);
> >  					retval = 0;
> >  					got_continue = 1;
> > -					if (ack == ACK_ready) {
> > -						clear_prio_queue(&rev_list);
> > +					if (ack == ACK_ready)
> >  						got_ready = 1;
> > -					}
> >  					break;
> >  					}
> >  				}
> > @@ -530,6 +528,8 @@ static int find_common(struct fetch_pack_args *args,
> >  				print_verbose(args, _("giving up"));
> >  				break; /* give up */
> >  			}
> > +			if (got_ready)
> > +				break;
> >  		}
> >  	}
> >  done:
> > @@ -1300,7 +1300,6 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
> >  		}
> >  
> >  		if (!strcmp(reader->line, "ready")) {
> > -			clear_prio_queue(&rev_list);
> >  			received_ready = 1;
> >  			continue;
> >  		}
> > -- 
> > 2.17.0.768.g1526ddbba1.dirty
> > 
> 
> -- 
> Brandon Williams

-- 
Brandon Williams
