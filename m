Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7E8C2BB1D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D3F2076C
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="rr1dteLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392365AbgDOA2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732629AbgDOA2B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 20:28:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D093C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:28:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u9so213583pfm.10
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tk/qIwGOIFbE3RsQmP9UK3shWoUB9OXoZkhPFJwZZEQ=;
        b=rr1dteLfspoZUQs4dSSzxVl7oISXanptFYp5oZUQfCWgcyvTPpcjS2WZx3BvWPtoO+
         SzsuT1s5a2w7xCdip49hEwH2XL3o+GdGOC6Cn4Nv4l9rqMV/EiiufKSn6gRb+4PcaFzd
         sz1NZW9A7ws7zmNq8f/7/72KMz2Mp3s5gWYHw6vBguLNaybjJUk0/rrExMy6tIaSF4iu
         K17i9vbuE8jUVDjdMWpICaPGeu9GutEhDHKXbrARGQOAHFtAzc9IBrp08snp5t18FQcC
         7+6jYM51ezgjd6H6KSo6gvmhXh8fgcRYS3VOohMhfCLsJn6rZf69poRnpWBRt8MNcFRA
         pdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tk/qIwGOIFbE3RsQmP9UK3shWoUB9OXoZkhPFJwZZEQ=;
        b=MaBiEtj/JzLoKU8+npmQ/wGdmUeBKAHPF4KvtklxJGkYLRp1lCC2o9B5QmR8OTUiFf
         RQfEU4nWfIrCCi+pvUDalkdEJtf+sLfL11UVFynOYkkUiZ7orNfpK1QPjy8x8BC2FnPR
         T2AidYiOmUXWrQFXkwcSZ3Ft4PBsB6nG/Gj+eEeF4rq3CwzD3kGcl9fxQfg5rdwn0VCJ
         QAaOboUOfM05/j7/lzzG7QBwgi+TvTPaj+5uV4TOS2WTip3E/tIvtXHIvY3tfROLb4kW
         jUMdWn7cK2Ad8pMZTj40ea3i+ucoH7CMBVKikO5I5hX1nCIVNkRfWrOkbIakXHsmpvOg
         Q7MQ==
X-Gm-Message-State: AGi0Pub/UsN7ruSyhlNAeXzLcTWKiTqZ8maUKD0qfTiaWzMek6IRLzDj
        Ho7pnUjRLBRi1AMg/czh87AQ3Q==
X-Google-Smtp-Source: APiQypKpqLLOi0i4B+QL1Mj2p+rGGYpxONYQ0e31oG6FTYh7leDmXfeAt+XD0HNzCOaE0QySPf+V0A==
X-Received: by 2002:a63:f963:: with SMTP id q35mr1546145pgk.271.1586910480372;
        Tue, 14 Apr 2020 17:28:00 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g14sm6859156pfh.49.2020.04.14.17.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:27:59 -0700 (PDT)
Date:   Tue, 14 Apr 2020 18:27:58 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] oid_array: use size_t for count and allocation
Message-ID: <20200415002758.GC7457@syl.local>
References: <20200330140247.GA476088@coredump.intra.peff.net>
 <20200330140309.GA2456038@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330140309.GA2456038@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 30, 2020 at 10:03:09AM -0400, Jeff King wrote:
> The oid_array object uses an "int" to store the number of items and the
> allocated size. It's rather unlikely for somebody to have more than 2^31
> objects in a repository (the sha1's alone would be 40GB!), but if they
> do, we'd overflow our alloc variable.
>
> You can reproduce this case with something like:
>
>   git init repo
>   cd repo
>
>   # make a pack with 2^24 objects
>   perl -e '
>     my $nr = 2**24;
>
>     for (my $i = 0; $i < $nr; $i++) {
> 	    print "blob\n";
> 	    print "data 4\n";
> 	    print pack("N", $i);
>     }
>   ' | git fast-import
>
>   # now make 256 copies of it; most of these objects will be duplicates,
>   # but oid_array doesn't de-dup until all values are read and it can
>   # sort the result.
>   cd .git/objects/pack/
>   pack=$(echo *.pack)
>   idx=$(echo *.idx)
>   for i in $(seq 0 255); do
>     # no need to waste disk space
>     ln "$pack" "pack-extra-$i.pack"
>     ln "$idx" "pack-extra-$i.idx"
>   done
>
>   # and now force an oid_array to store all of it
>   git cat-file --batch-all-objects --batch-check
>
> which results in:
>
>   fatal: size_t overflow: 32 * 18446744071562067968
>
> So the good news is that st_mult() sees the problem (the large number is
> because our int wraps negative, and then that gets cast to a size_t),
> doing the job it was meant to: bailing in crazy situations rather than
> causing an undersized buffer.
>
> But we should avoid hitting this case at all, and instead limit
> ourselves based on what malloc() is willing to give us. We can easily do
> that by switching to size_t.
>
> The cat-file process above made it to ~120GB virtual set size before the
> integer overflow (our internal hash storage is 32-bytes now in
> preparation for sha256, so we'd expect ~128GB total needed, plus
> potentially more to copy from one realloc'd block to another)). After
> this patch (and about 130GB of RAM+swap), it does eventually read in the
> whole set. No test for obvious reasons.

;). This patch looks good, and makes immediate sense given your
explanation.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1-array.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sha1-array.h b/sha1-array.h
> index dc1bca9c9a..c5e4b9324f 100644
> --- a/sha1-array.h
> +++ b/sha1-array.h
> @@ -49,8 +49,8 @@
>   */
>  struct oid_array {
>  	struct object_id *oid;
> -	int nr;
> -	int alloc;
> +	size_t nr;
> +	size_t alloc;
>  	int sorted;
>  };
>
> --
> 2.26.0.597.g7e08ed78ff

Thanks,
Taylor
