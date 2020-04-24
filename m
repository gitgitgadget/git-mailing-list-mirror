Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02043C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7AE206D7
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dWSxnXyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgDXQf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXQf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 12:35:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B6C09B046
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 09:35:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j7so4848487pgj.13
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TP29hyKDCFkThe3FOZ6CPO6R93lNnUS0HiNukwNzZlg=;
        b=dWSxnXyHWCST3jNNDdmhY9SAMqMyHTI1m4DTSxvoQw8XtsVqb55N3sFP+YNa51XkEy
         hVc8+vuk2+Wmh538C/7V3Hh1M3OLvFu6aD9Q8DGrYe+tKaUcQ510lwythKNq7IDpMi8o
         GZchUDJA/x5afjuFRNieY1WBsyaJ5XVWRZUXMqCBx1cGv/edSDeS/0SI5MTbcJke3MKT
         2TR4/vJXVN51ZmDIDz86XwRRoiyeTRTxmB+Dgo2RoNj4NEr7H1AF5HO+CCaHXCovJp9B
         XW5FsGF0taJaxrz+O8wihoEf+ViccRzbNMAE+rLzBri4mow4cIAGng0YNVAaUJ1LnWlq
         DnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TP29hyKDCFkThe3FOZ6CPO6R93lNnUS0HiNukwNzZlg=;
        b=r2MjCPjCgMvT7h81uLlxgEASAosqPzbqnnlSKxqCcWycUevjX1l0bcifM6XFVZKDiB
         LxzI8kFPQsDMwdtHOVuqfULEnqzrnhl7v6j0PLeQyQtDAsAc+76tiLnaov4Bv5/uJTEp
         gwwowJLrN2cMsP3t3keffddqUopaE3QVGMFz7EgKsCx7QBjKBeRHwqRsZLh6WAZxy2uQ
         4dgkOmb7cypenqHzRO1uA90vkJyCABMGSfFnZEwcGW/B39lo7PkdEZwkzGoWiZMxHJYI
         Oh+E94OhCgnFdAn4UiOyNssLgmigvTI/z3UKqFbJ0EqQKRnv/3aVpVyJMHLSQIy6r8Gf
         BXkg==
X-Gm-Message-State: AGi0PuYJAY8LczJh9mwsHHQPqKy27R3QPk+k45oorh7M1bgCO0fysXmf
        QAqi8wCskGRnWj8++1PstWVUjg==
X-Google-Smtp-Source: APiQypJcZ2uX8qLYKvV67jfPaaimVoOIqijcvgDE5AMI64gITGjuO+eweVJ6a518PRW9gveRuUe7QQ==
X-Received: by 2002:a63:d906:: with SMTP id r6mr10273949pgg.416.1587746155642;
        Fri, 24 Apr 2020 09:35:55 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i11sm4816278pgi.1.2020.04.24.09.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 09:35:54 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:35:53 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com,
        dstolee@microsoft.com
Subject: Re: [PATCH 4/4] commit-graph: close descriptors after mmap
Message-ID: <20200424163553.GA58219@syl.local>
References: <cover.1587677671.git.me@ttaylorr.com>
 <e05db264cb50760cab222157b436e82adeaeadc8.1587677671.git.me@ttaylorr.com>
 <xmqq368tg8po.fsf@gitster.c.googlers.com>
 <2232c379-d0ec-0b52-96b4-379438642785@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2232c379-d0ec-0b52-96b4-379438642785@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 09:17:16AM -0400, Derrick Stolee wrote:
> On 4/23/2020 6:04 PM, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> >> From: Jeff King <peff@peff.net>
> >>
> >> We don't ever refer to the descriptor after mmap-ing it. And keeping it
> >> open means we can run out of descriptors in degenerate cases (e.g.,
> >> thousands of split chain files). Let's close it as soon as possible.
> >
> > Yikes.
> >
> > Sorry, I should have looked at the use of mmap in this topioc more
> > carefully when we queued the series.  It is an easy mistake to make
> > by anybody new to the API to leave it open while the region is in
> > use.
>
> You are right. I was new when first contributing the commit-graph. It
> was also easier to miss because we only had one commit-graph open at
> the time. Adding in the incremental file format led to multiple file
> descriptors being open.
>
> However, this idea of closing a descriptor after an mmap is new to
> me. So I thought about other situations where I made the same mistake.
> Please see the patch below.

It's new to me, too :). If I had known it beforehand, then I would have
written the fourth patch here myself. But, I didn't, so I am grateful to
Peff for teaching me something new here.

> > With this fix, with or without the other topics still in flight, I
> > do not think no code touches graph_fd.  Should we remove the
> > graph_fd field from the structure as well?
>
> I agree that this should be done.
>
> Thanks,
> -Stolee
>
> -->8--

For what it's worth, this didn't apply quite right with 'git am -3 -c',
since it didn't seem to recognize that this was your scissors line. If I
edit your mail myself by replacing this line with '-- >8 --', then 'git
am' applies it just fine.

> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Fri, 24 Apr 2020 13:11:13 +0000
> Subject: [PATCH] multi-pack-index: close file descriptor after mmap
>
> We recently discovered that the commit-graph was not closing its
> file descriptor after memory-mapping the file contents. After this
> mmap() succeeds, there is no need to keep the file descriptor open.
> In fact, there is signficant reason to close it so we do not run
> out of descriptors.
>
> This is entirely my fault for not knowing that we can have an open
> mmap while also closing the descriptor. Some could blame this on
> being a new contributor when the series was first submitted, but
> even years later this is still new information to me.
>
> That made me realize that I used the same pattern when opening a
> multi-pack-index. Since this file is not (yet) incremental, there
> will be at most one descriptor open for this reason. It is still
> worth fixing, especially if we extend the format to be incremental
> like the commit-graph.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c | 4 +---
>  midx.h | 2 --
>  2 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 1527e464a7..60d30e873b 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -72,9 +72,9 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
>  	FREE_AND_NULL(midx_name);
>
>  	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	close(fd);

Right, we want to close as soon as we have mmaped the file.

>
>  	FLEX_ALLOC_STR(m, object_dir, object_dir);
> -	m->fd = fd;
>  	m->data = midx_map;
>  	m->data_len = midx_size;
>  	m->local = local;
> @@ -190,8 +190,6 @@ void close_midx(struct multi_pack_index *m)
>  		return;
>
>  	munmap((unsigned char *)m->data, m->data_len);
> -	close(m->fd);
> -	m->fd = -1;

...and not down here. Thanks.

>  	for (i = 0; i < m->num_packs; i++) {
>  		if (m->packs[i])
> diff --git a/midx.h b/midx.h
> index e6fa356b5c..b18cf53bc4 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -12,8 +12,6 @@ struct repository;
>  struct multi_pack_index {
>  	struct multi_pack_index *next;
>
> -	int fd;
> -

:). Even better!

>  	const unsigned char *data;
>  	size_t data_len;
>
> --
> 2.26.2

This looks great to me, and thanks for being proactive about the fix.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
