Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31041C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03781207ED
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIK9qgns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgERRMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERRMx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:12:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA00BC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 10:12:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f13so10936982qkh.2
        for <git@vger.kernel.org>; Mon, 18 May 2020 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A+Gh2QzO0GvXTIn5mzvvTS/bg690HKNt2dAJfmg3q6M=;
        b=mIK9qgns5PZE+6mtC9pXZjW1mll4eJXtoSKxaHFJdupprpffzoS9vX4PS4VhKf9y6P
         HdIblftOXEbpclQ7pPTWUfg1enS8lej2+vCJ4xJjRxGjlSBvxroRWnWY8tLpW4PYcJr8
         oS0gjJRQbvLoz+KueuY0V0dy6tBNj5K2/SSx68Fo+Z1josMOQV4uEU2anqae6wF8G+um
         BSS/OQVM+iKV6kHdFB/fSmWU++Gw8h9jmwe9hB52s6b0uFNlL/GtN2FKZHi7dweIfPTX
         cTFUSiq77KbXp4sBQE4O9v0vfFmNJCIjuzWp7afX6Gp6eYfPhbWhLFs4cv0WvdKh6C45
         wd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A+Gh2QzO0GvXTIn5mzvvTS/bg690HKNt2dAJfmg3q6M=;
        b=nPZMrQZMlp6R8L0kBPxPDuawGrswKY5LrZgKu/HzgqGITeNELBVDgHExrs2A7eibL3
         nXYEppO9O8CqX3QUsRAhXwoFC4vVMyBqjDSx+CNUiiOXbTHcDv6mPJYMS8YEt9plxx7m
         sJ2oFEPWZqksSBoThfZ6ACpcnybCgGKFtmRT4+Pi45SZmzqShbAKHQCkQ23LS/XY/4Ha
         HZLzV48JHksVma9GcKKfZ5Rf9Bd/2Q9n7LKzpsUv+hPncPJOlE3fREoI92W5qFV85VmH
         FYsMo4IRAPiDaDwnikGiAz91SAOC4VRqaRtg4DvbS+FhYoHNPTgbizvhICScdRzwWiUg
         FRfw==
X-Gm-Message-State: AOAM531u4aP/HK6vwS2xuE8/t6YsVswywvitPu0Y6CjnF9OOCxsifQWR
        ELC5VndPfA/KJYNHNozb9C0=
X-Google-Smtp-Source: ABdhPJz6h72s0vs28zhh0rK2JKgYvMDRBKPnMjKn+yHh1EV0JGyu4HRWOeUs+g40URIdld5Xw5Lgbw==
X-Received: by 2002:a05:620a:634:: with SMTP id 20mr15884176qkv.15.1589821972924;
        Mon, 18 May 2020 10:12:52 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id t12sm8482249qkt.77.2020.05.18.10.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 10:12:51 -0700 (PDT)
Date:   Mon, 18 May 2020 13:12:49 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Force Charlie <charlieio@outlook.com>
Subject: Re: [PATCH v2 7/7] stateless-connect: send response end packet
Message-ID: <20200518171249.GA2462058@generichostname>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <cover.1589816718.git.liu.denton@gmail.com>
 <4b079bcd83ea80b8a0e81b0c1e3d5e083efeb9c6.1589816719.git.liu.denton@gmail.com>
 <20200518164308.GC42240@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518164308.GC42240@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, May 18, 2020 at 12:43:08PM -0400, Jeff King wrote:
> On Mon, May 18, 2020 at 11:47:24AM -0400, Denton Liu wrote:

[...]

> > @@ -446,6 +447,13 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> >  	if (reader->status != PACKET_READ_FLUSH)
> >  		die(_("expected flush after ref listing"));
> >  
> > +	if (stateless_rpc) {
> > +		if (packet_reader_read(reader) != PACKET_READ_RESPONSE_END)
> > +			die(_("expected response end packet after ref listing"));
> > +		if (packet_reader_read(reader) != PACKET_READ_FLUSH)
> > +			die(_("expected flush packet after response end"));
> > +	}
> 
> Having two packets here surprised me. We'd have already received the
> actual flush from the server (as you can see in the context above).
> Wouldn't a single RESPONSE_END be enough to signal the reader?

Yes, having a single RESPONSE_END is enough. I sent a flush packet
because it seemed appropriate when I was writing the patch to end all
messages with a flush but I suppose that's just cargo culting. I'll
remove it in the next iteration.

> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index f73a2ce6cb..bcbbb7e2fb 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1468,6 +1468,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
> >  	struct fetch_negotiator negotiator_alloc;
> >  	struct fetch_negotiator *negotiator;
> >  	int seen_ack = 0;
> > +	int check_http_delimiter;
> 
> This flag was more complicated than I expected, and I'm not sure how we
> can easily be certain that all necessary paths are covered.

Essentially, any time we're in a path where state is set to
FETCH_SEND_REQUEST or FETCH_DONE, we know that we've finished processing
the current request and we can check for response end packets. Of course,
the one exception to this is the first iteration of the loop when we're
transitioning from FETCH_CHECK_LOCAL to FETCH_SEND_REQUEST where we
can't check for response end packets since nothing has been requested
yet.

> E.g., in FETCH_PROCESS_ACKS, we'll always be reading a response via
> process_acks(). Why do COMMON_FOUND and NO_COMMON_FOUND check for
> end-of-response, but READY doesn't? I think the answer is that we'd
> continue to read the same response via FETCH_GET_PACK in this instance.
> 
> I just wonder if there is a better place to put this logic that would be
> more certain to catch every place we'd expect to read to the end of a
> response. But I suppose not. We could push it down into process_acks(),
> but it would have the same READY logic that's here. I'll admit part of
> my complaint is that the existing do_fetch_pack_v2 state-machine switch
> is kind of hard to follow, but that's not your fault.

I debated between the current implementation and doing something like

	int first_iteration = 1;

	...

	while (state != FETCH_DONE) {
		switch (...) {
			...
		}

		if (args->stateless_rpc && !first_iteration && (state == FETCH_SEND_REQUEST || state == FETCH_DONE)) {
			if (packet_reader_read(&reader) != PACKET_READ_RESPONSE_END)
				die(_("git fetch-pack: expected response end packet"));
			if (packet_reader_read(&reader) != PACKET_READ_FLUSH)
				die(_("git fetch-pack: expected flush packet"));
		}
		first_iteration = 0;
	}

I think that this catches _all_ the cases without fiddling with any of
the state machine logic.

[...]

> Also, it probably should be check_stateless_delimiter() or something.
> There could be other helpers that support stateless-connect besides
> http.

Yeah... I forgot to change the check_http_delimiter name when I was
doing cleanup. Whoops.

> Speaking of which: this is a change to the remote-helper protocol, since
> we're now expecting stateless-connect helpers to produce these delim
> packets (and failing if they don't). I kind of doubt that anybody but
> remote-curl has implemented v2 stateless-connect, but should we be
> marking this with an extra capability to be on the safe side?

I think that we're probably safe from breaking anything external.
According to the gitremote-helpers documentation, 

	'stateless-connect'::
		Experimental; for internal use only.

so I think that gives us a bit of leeway in terms of the changes we can
make to the stateless-connect protocol. They've been warned ;)

Thanks,

Denton
