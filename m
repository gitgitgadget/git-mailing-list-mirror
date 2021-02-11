Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E9C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C43C64E30
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhBKCfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBKCe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 21:34:58 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D78C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:34:18 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id p12so1937056qvv.5
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r+gN2aO1mRWEXMTtPAqU6Eu0mXICD+8EM2uxj6uWqC8=;
        b=JV+Gxwkdj1inEhxcTHBPNXxinplfieX+a5XqpkY9J6lNedGoQFm6YS/7zgg/E837UI
         ECeQ+0XTdB///NcNcx1w2ovYiiwckQO7NjljWMoPrKBoWZ3VgDE4T/U4AR+bTrx/kPA6
         k4bdu33ofccFCKpFrkiMYebmPU0ZMlvOtc4oFSHnSNYKjGM40dKb5Ve9oLReApdseFs0
         NXEORd4EZpBnzGzmkCnTLgZ4/plfYVZ8Qe0FFylLZ43f68Ll33W+oEe67L9PxejT80Tp
         cmIdbmW6/+82HUdOT9dCxFLbt6uZTCjBhb1iK9gshUDwHEFUiDlDe8qaOLUNUJGCucR5
         j7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+gN2aO1mRWEXMTtPAqU6Eu0mXICD+8EM2uxj6uWqC8=;
        b=Bm2vNFNFoplsU9cbD/Ejd8XxTYEx0Y/luYUtEhOc/bHNYjU0YN1jD4DWpiFjEYGuWu
         tcABYoWYU7SYnGhwcGyCZ3GoaNGxLmB0KvDzWEGGxnNV7BcH573FoK5LVcuDziSHkJbR
         t68DfzTnFRFqJR9H0GC7iPmVA2bMoHA1CZgduvsLkC60tOABxjqzPDRJ79hrEZnEEOky
         s9ABawnWDJbeWs+SMZ4UfcCXDjfs1BSnFkhsFT1I1+DMZ40/fmsxjVTfHxDqRvUlQrYT
         Coq8ahALxA0VvgjKG1ZBcxfBImxQ1Ltg9wCa8dbT5pOonGjLyaNPhAy++FazI3F/ppbV
         LEIQ==
X-Gm-Message-State: AOAM532nZxERY8MCv7KoxgiX13v3sB3/zyfA/39zhLyO31m/4VlKr3P7
        MVgW0oByYQz/il354ccI9679FA==
X-Google-Smtp-Source: ABdhPJxug4gP5LNHcLk6IWTkag7i93SfVB/i1djKlf46tMckoYm/qF/0kObslX2M6TbFnbK1RkmR9A==
X-Received: by 2002:a0c:e641:: with SMTP id c1mr5176676qvn.47.1613010857804;
        Wed, 10 Feb 2021 18:34:17 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:666f:3d4:2894:5ee9])
        by smtp.gmail.com with ESMTPSA id y26sm2694711qth.53.2021.02.10.18.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 18:34:17 -0800 (PST)
Date:   Wed, 10 Feb 2021 21:34:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 1/9] t/helper/test-read-midx.c: add '--show-objects'
Message-ID: <YCSXp+YgDVCLL67Q@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <e36acb005d3563db772711207d2af3df03685bd4.1612998106.git.me@ttaylorr.com>
 <7b422082-d6a9-5e64-17a0-559da7777a08@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b422082-d6a9-5e64-17a0-559da7777a08@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 09:27:29PM -0500, Derrick Stolee wrote:
> On 2/10/21 6:02 PM, Taylor Blau wrote:
> > +	if (show_objects) {
> > +		struct object_id oid;
> > +		struct pack_entry e;
> > +
> > +		for (i = 0; i < m->num_objects; i++) {
> > +			nth_midxed_object_oid(&oid, m, i);
> > +			fill_midx_entry(the_repository, &oid, &e, m);
> > +
> > +			printf("%s %"PRIu64"\t%s\n",
> > +			       oid_to_hex(&oid), e.offset, e.p->pack_name);
> > +		}
> > +		return 0;
> > +	}
> > +
> >  	printf("header: %08x %d %d %d %d\n",
> >  	       m->signature,
> >  	       m->version,
>
> It seems a little odd to me that the list of objects happens after
> the header information. Probably doesn't matter in your test cases,
> but I sometimes use the test helpers to diagnose data during development
> and could see piping this output into 'less' and wanting the header
> at the top.

Indeed. In theory you could pipe to tail instead (or to less and
immediately hit 'G'), but I can't think of a good reason that this would
have appeared above the header when I originally wrote the patch.

Anyway, it doesn't seem that the tests care about where this is (they're
just looking for for a line that begins with the object id and ends with
its offset), so I think this could probably be moved without thinking
too hard about it.

> Thanks,
> -Stolee

Thanks,
Taylor
