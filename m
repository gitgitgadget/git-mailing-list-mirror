Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66F01F403
	for <e@80x24.org>; Tue,  5 Jun 2018 23:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeFEXaa (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 19:30:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45673 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeFEXa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 19:30:29 -0400
Received: by mail-pl0-f68.google.com with SMTP id c23-v6so2531451plz.12
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 16:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DPcWOUecHaWA+MbngwaonmM+m4rdBmba542gWnXJnFo=;
        b=dFlB+cjXFS0MKUG1K68Caj5l8F37YDeWWPoLWhIp6GpbxrYkwTrkJL/WjRc29pVUaX
         J3XrJXOIihJdboIGF8nz9/islwjyEp0DXItJI5ftYEQEYBf9SmdH/4Qj3tZj/f+N1uQi
         Ufv2Gi0OeqoDXRO+Ll8jWyO2YUOVCg3IsS5DTkS4DGYPoLy10qKe38TYWWrjATNqzwGy
         C259HLLoWvYznNTe1cS8QYYsReeBSAp2d65P7U7N3oYs9ciU4D6MbGCBpG25mYNFEfKO
         /65HMDLSZbKXYFgoJleR/Z/Z8DGrJ4MMa1k03R01xTkiEiWHlTnAgGUwnoBkNfPnkcDA
         Zsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DPcWOUecHaWA+MbngwaonmM+m4rdBmba542gWnXJnFo=;
        b=ujPrd9JfjpLVULfY1QH+B/Q8nXdpzeYqOfrBIdC8IXgXZ0VUOxO9sPqybRkT/yJG/Y
         VcuX+8FzhfjJicZVojtazN9KQRAzuXFFswJso1btOLGuRfJGLBv5hn+0J05uAYq0Joip
         4H+s7E0OJIbyDq44mxJapw7Cfc0M6lyumjkU7gA1aXN9hTh872IFHTubSc+utq2C+Tn0
         sv53nw3EhxwdtTpDDVeKHXRyogmKinGSb69OV1RdxnmB/28TBMS7vEEhED5vxEm3G2qh
         +HnoZMw7Z67yXV5B5OSoUjt7Axa1GS666dhJ9+F1K1GHq94CPf88EgZ+9KFXIzvZ4qDc
         71BA==
X-Gm-Message-State: APt69E396HKP8MNPX0e91cNxK8ZEaKsv1gh6Bz7waMo5DhkK4BCy9SZ6
        Y4NKdmrPfQ55eMN+lt3gL+k=
X-Google-Smtp-Source: ADUXVKIPDbFUohlmx8HzFTaMjsOEZfxzrrX3UhuIe5WAGCaYKOexk6S2aJqkfsGmswpO1mqfNJcarA==
X-Received: by 2002:a17:902:c3:: with SMTP id a61-v6mr637893pla.149.1528241429176;
        Tue, 05 Jun 2018 16:30:29 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a27-v6sm4031854pfc.18.2018.06.05.16.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 16:30:28 -0700 (PDT)
Date:   Tue, 5 Jun 2018 16:30:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Subject: Re: [PATCH 3/6] fetch-pack: in protocol v2, enqueue commons first
Message-ID: <20180605233026.GF9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <8265d9485a2bfe0e81d68495afd3733879add992.1527894919.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8265d9485a2bfe0e81d68495afd3733879add992.1527894919.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> In do_fetch_pack_v2(), rev_list_insert_ref_oid() is invoked before
> everything_local(). This means that if we have a commit that is both our
> ref and their ref, it would be enqueued by rev_list_insert_ref_oid() as
> SEEN, and since it is thus already SEEN, everything_local() would not
> enqueue it.
>
> If everything_local() were invoked first, as it is in do_fetch_pack()
> for protocol v0, then everything_local() would enqueue it with
> COMMON_REF | SEEN. The addition of COMMON_REF ensures that its parents
> are not sent as "have" lines.
>
> Change the order in do_fetch_pack_v2() to be consistent with
> do_fetch_pack(), and to avoid sending unnecessary "have" lines.

I get lost in the above description.  I suspect it's doing a good job
of describing the code, instead of answering the question I really
have about what is broken and what behavior we want instead.

E.g. are there some commands that I can run to trigger the unnecessary
"have" lines?  That would make it easier for me to understand the rest
and whether this is a good approach for suppressing them.

It's possible I should be skipping to the test, but a summary in the
commit message would make life easier for lazy people like me. :)

[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1372,14 +1372,14 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  				for_each_ref(clear_marks, NULL);
>  			marked = 1;
>  
> -			for_each_ref(rev_list_insert_ref_oid, NULL);
> -			for_each_cached_alternate(insert_one_alternate_object);
> -
>  			/* Filter 'ref' by 'sought' and those that aren't local */
>  			if (everything_local(args, &ref, sought, nr_sought))
>  				state = FETCH_DONE;
>  			else
>  				state = FETCH_SEND_REQUEST;
> +
> +			for_each_ref(rev_list_insert_ref_oid, NULL);
> +			for_each_cached_alternate(insert_one_alternate_object);

This is subtle.  My instinct would be to assume that the purpose of
everything_local is just to determine whether we need to send a fetch
request, but it appears we also want to rely on a side effect from it.

Could everything_local get a function comment to describe what side
effects we will be counting on from it?

>  			break;
>  		case FETCH_SEND_REQUEST:
>  			if (send_fetch_request(fd[1], args, ref, &common,
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 0680dec80..ad6a50ad6 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -808,6 +808,41 @@ test_expect_success 'fetch with --filter=blob:limit=0' '
>  	fetch_filter_blob_limit_zero server server
>  '
>  
> +test_expect_success 'use ref advertisement to prune "have" lines sent' '

nit: this adds the new test as last in the script.  Is there some
logical earlier place in the file it can go instead?  That way, the
file stays organized and concurrent patches that modify the same test
script are less likely to conflict.

> +	rm -rf server client &&
> +	git init server &&
> +	test_commit -C server aref_both_1 &&
> +	git -C server tag -d aref_both_1 &&
> +	test_commit -C server aref_both_2 &&

What does aref stand for?

> +
> +	# The ref name that only the server has must be a prefix of all the
> +	# others, to ensure that the client has the same information regardless
> +	# of whether protocol v0 (which does not have ref prefix filtering) or
> +	# protocol v2 (which does) is used.

must or else what?  Maybe:

	# In this test, the ref name that only the server has is a prefix of
	# all other refs. This ensures that the client has the same information
	# regardless of [etc]

> +	git clone server client &&
> +	test_commit -C server aref &&
> +	test_commit -C client aref_client &&
> +
> +	# In both protocol v0 and v2, ensure that the parent of aref_both_2 is
> +	# not sent as a "have" line.

Why shouldn't it be sent as a "have" line?  E.g. does another "have"
line make it redundant?

> +
> +	rm -f trace &&
> +	cp -r client clientv0 &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
> +		fetch origin aref &&
> +	grep "have $(git -C client rev-parse aref_client)" trace &&
> +	grep "have $(git -C client rev-parse aref_both_2)" trace &&

nit: can make this more robust by doing

	aref_client=$(git -C client rev-parse aref_client) &&
	aref_both_2=$(git -C client rev-parse aref_both_2) &&

since this way if the git command fails, the test fails.

> +	! grep "have $(git -C client rev-parse aref_both_2^)" trace &&

Nice.

Thanks for a pleasant read,
Jonathan
