Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29E6C54EEB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 19:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8660A216FD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 19:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3EWHHgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgD0TDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgD0TDE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 15:03:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC5C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 12:03:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n24so7322647plp.13
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n0RTJYueB4eFolGqpRMy+cdSizv1p8BL9WNkR+oZrtk=;
        b=B3EWHHgGEvAdfr8fq51owFS1c7oDf3PozsaSoT8lqP2xEE3mErITl4lrbdcAL9NZpL
         R1zD9ySg58JboPNF7Z8PQU2yV19dOIv9Ton7Upa5EtYHH7BTK2KCEah9h0Ecw8bPspU9
         veqgkquDYzBcB83UwWgT+fNNK86xB/LhF8m9gjq1KpHQ/EMxV7+R+1+OiYNHWQn08OpC
         qRJSamkvecf+ZBJ54bYGSpO3mJIXHfhv5wQKr89H4X9rJCT4oRpzQ8+Bi7hF0LhuJ0RX
         SvFtF+WLU9W5rKyjB9DpALVrJv2q2+C2EBL9L6IJcY716P8juPGY8Da/bTK5BVmeTVF7
         qXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n0RTJYueB4eFolGqpRMy+cdSizv1p8BL9WNkR+oZrtk=;
        b=K10jl9s9hApEjFeJrcWshjvi6NrGM0ZnticeejANzIIXq3AzAyCDOWGZv6RnkMk1rq
         IM76YhkCLfP5KkB8sS3QECAga25pYFVMpVsxHgILKDYLxo2BHFuZ0IFVuVI5yIC1NQyI
         0tLwRYvC9Uvf72tFjjOs3d/KuSp2ltIA626bpJRyIdWAgHUcnbHNSSLSWMY32qBq3TKL
         DcMvS2tyua/d993LmyFtJoE8CtHD9gn8ke2vlYMA3SoGui+N0q/Uko7ji+1HPUmBc+QQ
         m2dGCM57uS9BKrytQXkWRHeod1w6jEKoJ8exS4oQiq8xKiVQ850nBXj6bo4d2yzs1TdC
         82jA==
X-Gm-Message-State: AGi0PuZSO1peUqTSBEGMYN49bzVXWSCJe++rKxuZ9m8FSVOYaITjnJVq
        I2nggqLOt2w/DOJN8XmD3ML3gw==
X-Google-Smtp-Source: APiQypJvE2WRYg2A330oNDf95IJjOljNdqJj/AkAXWaF7ikglWPIe3JOvMpMlT2fXmNP5yJV/1DXNg==
X-Received: by 2002:a17:90a:3287:: with SMTP id l7mr166566pjb.126.1588014184092;
        Mon, 27 Apr 2020 12:03:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id u15sm11384177pgj.34.2020.04.27.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 12:03:03 -0700 (PDT)
Date:   Mon, 27 Apr 2020 12:02:57 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bugreport: collect list of populated hooks
Message-ID: <20200427190257.GA77802@google.com>
References: <20200424233800.200439-1-emilyshaffer@google.com>
 <xmqqsggs9ngo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsggs9ngo.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 09:52:07PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Without a definitive list of hook names within the code, we compile our
> > own list from the documentation. This is likely prone to bitrot. To
> > reduce the amount of code humans need to read, we turn the list into a
> > string_list and iterate over it (as we are calling the same find_hook
> > operation on each string). However, since bugreport should primarily be
> > called by the user, the performance loss from massaging the string
> > seems acceptable.
> 
> In this iteration we no longer are collecting the hook names into
> string list, but just formating the findings in a strbuf, no?

Right - I'll fix the commit message for round 2.

> 
> > @@ -33,6 +35,53 @@ static void get_system_info(struct strbuf *sys_info)
> >  	get_libc_info(sys_info);
> >  }
> >  
> > +static void get_populated_hooks(struct strbuf *hook_info, int nongit)
> > +{
> > +	/*
> > +	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
> > +	 * so below is a transcription of `git help hooks`. Later, this should
> > +	 * be replaced with some programmatically generated list (generated from
> > +	 * doc or else taken from some library which tells us about all the
> > +	 * hooks)
> > +	 */
> 
> Yes, I recall that we discussed adding some annotation to
> documentation and extracting this automatically.

Right, we did. I think I was hesitant to move on it because I had
https://lore.kernel.org/git/20200420235310.94493-1-emilyshaffer@google.com
on my back burner and wasn't sure how the hook architecture would look
afterwards.

I'm not sure I know the right way to move forward (which is why I left a
NEEDSWORK) - my strongest preference is to leave it as is and wait for
the linked RFC and related work to land, at which point this code will
need a rework anyways. But if we're very interested in generating an
enum or something from the docs rather than letting this gross char**
land, I can do that too.

 - Emily
