Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38C0C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 21:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiHBVwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiHBVwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 17:52:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C013C15A11
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 14:51:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so76041pjk.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 14:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=7uyCsuZhfdSrzyouZWDS8vjZaA48MhNk3OLZ4/j8dJU=;
        b=s4VvDWmjqGX022JAUi4m5NofT2eUf5YRyuo9AVzhZBX6LKZPTdR8TXNj2vNwixUNjQ
         IVlbNSAUcmu/04p1LMRRDuH7Zbcxio481MCsgBuxxPnJ4yEo6q7kLNKXAiroSs8AoXhF
         2rjNcjuO5NoICHmoBK/jaia6MxZutcgn1J5kUdQaE5z6mkXsM+K3xaG7BKzchhzPzWSw
         lmjaIovKjMHYIrOAeD/SFkF0jT3bpziTuUYUNK/LvxJOEws2lMGvSKA78b3YR2BSOh8p
         +b2Pzj5af2OsK8MHXtTDZP0wjxB9RrW0wnvETiOZA9Av1fDknxyZl8GpTaz4L4YHyWpE
         3faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=7uyCsuZhfdSrzyouZWDS8vjZaA48MhNk3OLZ4/j8dJU=;
        b=uBHs3FXRS6WTYFMYj08EOhjAsJJ54IiQ6v3+n7sWH2BHfn6Z9jY4BCx7gjGF5jgHpc
         VZHn+k7cuMFbjmczV00AXnEeokUxmwoHSwie8i/0v3YxUtNpbth8+QKj3cLGG+J89Ws6
         0fBo0n1H19YsysViadMDZBXQGq76DFwdaT5aecX7l/ZByf/xxhgJuZna6KCYAfpo91Ui
         yoUPopcrO4+ktCD0FX/0GMB6ZUNp9I48N0z/HQczpstSTfSoTKWvtpNWeklEhHsuA32g
         C15nAQUDca2KR0FU9zOUyjtZTlKwPBtHKLOIHDuc2Q+SWkfL/2SmGhpyZEszyy/htEt8
         9y4A==
X-Gm-Message-State: ACgBeo2XhyYOnAt4eYY4SJx1XqFD5VLhlSywG0GcR0c34ZAPdHwGYhbd
        iXXoqK2Wx0VVpcFfkGVz8vs4B0VhSkmoTA==
X-Google-Smtp-Source: AA6agR656GPUt5Z5Ssf1jrTZm6aVJerOP9eelF8dRprICNbB76zogKybBwmiE3CPPykceE5lCp3SXA==
X-Received: by 2002:a17:902:8c87:b0:16e:c739:5a81 with SMTP id t7-20020a1709028c8700b0016ec7395a81mr19269687plo.150.1659477119125;
        Tue, 02 Aug 2022 14:51:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:e494:e2de:c190:f480])
        by smtp.gmail.com with ESMTPSA id w4-20020a17090a1b8400b001f32f242020sm10063612pjc.43.2022.08.02.14.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 14:51:58 -0700 (PDT)
Date:   Tue, 2 Aug 2022 14:51:52 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: add tracing for negotiation rounds
Message-ID: <YumceAg8txkKIuDf@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <a16d86e1ced104bb331bb9e7055037a3a2821352.1658787182.git.steadmon@google.com>
 <xmqqilnkyeom.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqilnkyeom.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.07.25 16:07, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Currently, negotiation for V0/V1/V2 fetch have trace2 regions covering
> > the entire negotiation process. However, we'd like additional data, such
> > as timing for each round of negotiation or the number of "haves" in each
> > round. Additionally, "independent negotiation" (AKA push negotiation)
> > has no tracing at all. Having this data would allow us to compare the
> > performance of the various negotation implementations, and to debug
> > unexpectedly slow fetch & push sessions.
> 
> Quite sensibly argued.  I do not necessarily see the current code as
> "broken", and "fix" at the beginning of the next line may not be an
> appropriate word to describe this enhancement, but I think it would
> be nice to have such numbers.

Reworded that sentence.


> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index cb6647d657..01a451e456 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -299,6 +299,7 @@ static int find_common(struct fetch_negotiator *negotiator,
> >  {
> >  	int fetching;
> >  	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
> > +	int negotiation_round = 0, haves = 0;
> >  	const struct object_id *oid;
> >  	unsigned in_vain = 0;
> >  	int got_continue = 0;
> > @@ -441,9 +442,19 @@ static int find_common(struct fetch_negotiator *negotiator,
> >  		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
> >  		print_verbose(args, "have %s", oid_to_hex(oid));
> >  		in_vain++;
> > +		haves++;
> >  		if (flush_at <= ++count) {
> >  			int ack;
> >  
> > +			negotiation_round++;
> > +			trace2_region_enter_printf("negotiation_v0_v1", "round",
> > +						   the_repository, "round-%d",
> > +						   negotiation_round);
> 
> Not an objection, but all the hits to existing calls to this
> function show the data in a format as vanilla as possible without
> frills (presumably to make it easier to mechanically parse the value
> out when needed???), and the "round-" prefix we see here somehow
> looks out of place.  Doesn't the fact that the record is in the
> "negotiation_v0_v1" category and has label "round" clear enough sign
> that the value presented is the negotiation_round?

True, fixed in V2.


> > +			trace2_data_intmax("negotiation_v0_v1", the_repository,
> > +					   "haves_added", haves);
> > +			trace2_data_intmax("negotiation_v0_v1", the_repository,
> > +					   "in_vain", in_vain);
> > +			haves = 0;
> >  			packet_buf_flush(&req_buf);
> >  			send_request(args, fd[1], &req_buf);
> >  			strbuf_setlen(&req_buf, state_len);
> > @@ -465,6 +476,9 @@ static int find_common(struct fetch_negotiator *negotiator,
> >  						      ack, oid_to_hex(result_oid));
> >  				switch (ack) {
> >  				case ACK:
> > +					trace2_region_leave_printf("negotiation_v0_v1", "round",
> > +								   the_repository, "round-%d",
> > +								   negotiation_round);
> >  					flushes = 0;
> >  					multi_ack = 0;
> >  					retval = 0;
> > @@ -490,6 +504,7 @@ static int find_common(struct fetch_negotiator *negotiator,
> >  						const char *hex = oid_to_hex(result_oid);
> >  						packet_buf_write(&req_buf, "have %s\n", hex);
> >  						state_len = req_buf.len;
> > +						haves++;
> >  						/*
> >  						 * Reset in_vain because an ack
> >  						 * for this commit has not been
> > @@ -510,14 +525,26 @@ static int find_common(struct fetch_negotiator *negotiator,
> >  			flushes--;
> >  			if (got_continue && MAX_IN_VAIN < in_vain) {
> >  				print_verbose(args, _("giving up"));
> > +				trace2_region_leave_printf("negotiation_v0_v1", "round",
> > +							   the_repository, "round-%d",
> > +							   negotiation_round);
> >  				break; /* give up */
> >  			}
> > -			if (got_ready)
> > +			if (got_ready) {
> > +				trace2_region_leave_printf("negotiation_v0_v1", "round",
> > +							   the_repository, "round-%d",
> > +							   negotiation_round);
> >  				break;
> > +			}
> > +			trace2_region_leave_printf("negotiation_v0_v1", "round",
> > +						   the_repository, "round-%d",
> > +						   negotiation_round);
> >  		}
> 
> Having many duplicated calls to "leave" makes the whole thing look
> somewhat confused.  Is this primarily because we have too many
> "break" that breaks out of the loop?

Yes, although now that I look at it again, I believe as soon as we
finish the do-while, we know that the round is over, so I believe we can
just put a single region_leave there. Fixed in V2.


> > @@ -1603,6 +1632,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
> >  	struct oidset common = OIDSET_INIT;
> >  	struct packet_reader reader;
> >  	int in_vain = 0, negotiation_started = 0;
> > +	int negotiation_round = 0;
> >  	int haves_to_send = INITIAL_FLUSH;
> >  	struct fetch_negotiator negotiator_alloc;
> >  	struct fetch_negotiator *negotiator;
> > @@ -1659,6 +1689,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
> >  						    "negotiation_v2",
> >  						    the_repository);
> >  			}
> > +			negotiation_round++;
> > +			trace2_region_enter_printf("negotiation_v2", "round",
> > +						   the_repository, "round-%d",
> > +						   negotiation_round);
> >  			if (send_fetch_request(negotiator, fd[1], args, ref,
> >  					       &common,
> >  					       &haves_to_send, &in_vain,
> > @@ -1686,12 +1720,20 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
> >  			} else {
> >  				do_check_stateless_delimiter(args->stateless_rpc, &reader);
> >  				state = FETCH_SEND_REQUEST;
> > +				trace2_region_leave_printf("negotiation_v2", "round",
> > +							   the_repository, "round-%d",
> > +							   negotiation_round);
> >  			}
> >  			break;
> >  		case FETCH_GET_PACK:
> > +			trace2_region_leave_printf("negotiation_v2", "round",
> > +						   the_repository, "round-%d",
> > +						   negotiation_round);
> 
> Hmph.  Doesn't this logically belong to the "FETCH_PROCESS_ACKS"
> case arm?  We "leave" the current round when we did not get "ready"
> and "enter" the next round by moving to "FETCH_SEND_REQUEST" state,
> but at the same location when we did get "ready", we can "leave" the
> current (and final) round and move to "FETCH_GET_PACK" state.  I
> suspect the code structure and control flow becomes easier to see
> when expressed that way.

That works, but then we also need an additional region_leave in the
FETCH_SEND_REQUEST case where we jump directly to FETCH_GET_PACK. I'm
not sure which way is more intuitive, but I've gone with your suggestion
for V2.


> >  			trace2_region_leave("fetch-pack",
> >  					    "negotiation_v2",
> >  					    the_repository);
> > +			trace2_data_intmax("negotiation_v2", the_repository,
> > +					   "total_rounds", negotiation_round);
> >  			/* Check for shallow-info section */
> >  			if (process_section_header(&reader, "shallow-info", 1))
> >  				receive_shallow_info(args, &reader, shallows, si);
