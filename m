Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68DFC433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 16:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8083C22BE9
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 16:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbhAKQ2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 11:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbhAKQ2U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 11:28:20 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3153DC061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 08:27:40 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id h4so15065423qkk.4
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 08:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dEFGX0H2sRc+wTh7cLhloicpOBHM96xMY/YnOKRDuSE=;
        b=rBGjFzzeGVXZ1s0YneRkFCe8zRjGIZb30PVrhwfs6lv9onPV9A5aovjJ5jKQjViviu
         dLj8KJFaWXobLNt83bUN4uOd6uXQaRCthcDrdmflKIgiSk+Vw2QY1+MkLJB7Vn9SFRSs
         w7PpHb2HhK0Fl5wgiHX/qK8xzXInxo/19mEjKuZ+2T4SsqC1It2Tf+CHy+K1dxCq0IXv
         cPSLWcAvWXP06rF/T8pU6tStSiRVWUUWda6xNwvgokWy77ddQmfOv6IIJGclIgLyFfqM
         94OW6TUK8GKKOOES6nLiELJsIn5RnWUcMu63Cj7X8p56l7BNh6D7LIY/SGBt85lBP2Tv
         FHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dEFGX0H2sRc+wTh7cLhloicpOBHM96xMY/YnOKRDuSE=;
        b=XUB629DwbFjMI9pLf0uMkb4FmUfHPhl9OkKNDVYmRc15WFlkQAbtyv/VlgpaMeuFRm
         ZQP7nAqvi2STdsv6+Lqrjiu/kJ1wZManR4SWMZ9xz9Xl1LgCdmoiJtzhCSK1K1kP3K+n
         nMv19Sx0+IaxHY593Yc+Rztx4tla1OrxQ+Hvh4d1yWQu4T7bg38HhQOfCL/1vx1TndPt
         hjju/Urv/r09+byVA+wDr3mUb3l0KhVvWnXiCR4g6khISNTAiGhteFe3A5DNAjzFO2i7
         Wgdz2l08FdsZurjcRHoErL23pLcdjplTuAqNSNPGOLKmolIRb2/OYV32apcTaVF1fU4k
         M5rw==
X-Gm-Message-State: AOAM531pblhoPCceAltdC4BOKPWJLCemlefArv1nKYDoOOMP50o4/q8Z
        ohqS7AhNNmZKD2FVHe4in/iifw==
X-Google-Smtp-Source: ABdhPJzId+mu7rC8JfeHshUicC3FOBTY2LAlb/Wl9AtGQcJcqSMUADtoUSFziN4MLSS+5d82Dg+aaA==
X-Received: by 2002:a05:620a:804:: with SMTP id s4mr120375qks.158.1610382459381;
        Mon, 11 Jan 2021 08:27:39 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id c7sm10003qtm.60.2021.01.11.08.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 08:27:38 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:27:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        jrnieder@gmail.com
Subject: Re: [PATCH 18/20] pack-revindex: remove unused
 'find_revindex_position()'
Message-ID: <X/x8dXFfQUdpKeVn@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <d60411d524656f4680ac578765b2a8704325a060.1610129796.git.me@ttaylorr.com>
 <624d0642-b6c9-7c76-aeb6-d7e18b0aad1f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <624d0642-b6c9-7c76-aeb6-d7e18b0aad1f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 06:57:00AM -0500, Derrick Stolee wrote:
> On 1/8/2021 1:17 PM, Taylor Blau wrote:
> > -int find_revindex_position(struct packed_git *p, off_t ofs)
> > +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
> >  {
> >  	int lo = 0;
> > -	int hi = p->num_objects + 1;
> > -	const struct revindex_entry *revindex = p->revindex;
> > +	int hi;
> > +	const struct revindex_entry *revindex;
> > +
> > +	if (load_pack_revindex(p) < 0)
> > +		return -1;
> > +
> > +	hi = p->num_objects + 1;
> > +	revindex = p->revindex;
> >
> >  	do {
> >  		const unsigned mi = lo + (hi - lo) / 2;
> >  		if (revindex[mi].offset == ofs) {
> > -			return mi;
> > +			*pos = mi;
> > +			return 0;
> >  		} else if (ofs < revindex[mi].offset)
> >  			hi = mi;
> >  		else
> > @@ -189,20 +196,6 @@ int find_revindex_position(struct packed_git *p, off_t ofs)
> >  	return -1;
> >  }
> >
> > -int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
> > -{
> > -	int ret;
> > -
> > -	if (load_pack_revindex(p) < 0)
> > -		return -1;
> > -
> > -	ret = find_revindex_position(p, ofs);
> > -	if (ret < 0)
> > -		return -1;
> > -	*pos = ret;
> > -	return 0;
> > -}
> > -
>
> Not that this is new to the current patch, but this patch made me
> wonder if we should initialize *pos = -1 in the case of a failure
> to find the position? A correct caller should not use the value
> if they are checking for the fail-to-find case properly. But, I
> could see someone making a mistake and having trouble diagnosing
> the problem because their position variable was initialized to
> zero or a previous successful case.

*pos = -1 may be more confusing than clarifying since pos is unsigned.

It would be nice if there was a clear signal beyond returning a negative
value. I guess you could take a double pointer here which would allow
you to assign NULL, but that feels rather cumbersome as a means to catch
callers who failed to check the return value.

It does raise the argument of whether or not we should allow the
program to continue at all if 'ret < 0' (i.e., 'offset_to_pack_pos()'
either 'die()'s or returns a usable uint32_t), but I'm OK with the
current behavior.

> Thanks,
> -Stolee

Thanks,
Taylor
