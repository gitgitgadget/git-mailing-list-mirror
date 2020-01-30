Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AE2C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF332082E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+oaib8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgA3XbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:31:02 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:46930 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgA3XbC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 18:31:02 -0500
Received: by mail-qk1-f202.google.com with SMTP id y6so3004197qki.13
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 15:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=USPnnTqbTy7pNgSHxEKzuZszGXfveS46y4TxttbGYjU=;
        b=j+oaib8ra0jDX4ChbcrrYNe18c4TK1lX+ag8URFP1UB8BkQczJWwi2eIxYUwM5w0KW
         N/9FohQFPJ+x5ILlMkYb5aYV9o40Dtj7lgA1zxmHVkIs9cBVhE+T9pJyGxcOT9/+ADcW
         HMsI0zjlgZwe0AKorgKwEmOgHWU3dNPpaMHAn+vIFNsdaAN9WHa2JHnDjReHtO8PhhNF
         NdzmyaFs67FixmU4AbAQ35SxF34evwixw8bM76vxBIuj2TOVoByWjcwQ7cDBPRbqMT/5
         ZZmaz8e4sxhCHSz4aADQ3SKxTIuQfx6Sa5t8fsR+59wAu60Eto/qBLiUCp+VVt484TmX
         0vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=USPnnTqbTy7pNgSHxEKzuZszGXfveS46y4TxttbGYjU=;
        b=Y42qXr9rDLBh/IyA6pn6uLlu/65ObqcTVbS1Ez2zBzd39D9HSD9QQDJH8iljS/9AHV
         tQKjdldxSkCG4nMNdM4JoVXShg7ttkL7N0EAfkpw2Vzu8Dmv1wOvgH/wJBSUJIs9WzEJ
         Zewgc7/r4XIKfeCYIcgQcFtVZUUyD58OpBupeXC06sS2AOrgbVKUNtEE3YoUry/zqmo9
         afcJQEBQMCLeZcWuI+ogyqc4vZ9slaFlbc0pCh6blRjp9hT6kIisCWDX0RFITZXBDr7C
         I/AEI11DLMCC2VNKfWT/qYhcjOXR1/ijs5T4vtjSmnHXEmVv5rgplBmImKnVJ7otlE/G
         EK/g==
X-Gm-Message-State: APjAAAXqgprONnaB4tt6VQMahMmG+MaB6xXY4XrgCbrT65W9Yhr1L59y
        oiPDfXEMq22VLpRRzHl6AWFg11xdADv5GebAfdP2
X-Google-Smtp-Source: APXvYqwwL8b1wWsnG6Lshm8nKum/Vsirr1TWhe8ppxaTZbUjugr2uufXzWfm2TwiN9mJF7CaYpe82JRAJ+Fe4lYFUQKO
X-Received: by 2002:ac8:4d94:: with SMTP id a20mr8050156qtw.66.1580427061249;
 Thu, 30 Jan 2020 15:31:01 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:20:02 -0800
In-Reply-To: <20200130055136.GA2184413@coredump.intra.peff.net>
Message-Id: <20200130232002.203193-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200130055136.GA2184413@coredump.intra.peff.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: Re: [RFC PATCH] diff: only prefetch for certain output formats
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ah, true, "options->detect_rename" would be overly broad.
> 
> I actually don't think it would be that bad to put the logic in
> diffcore_rename(). If we wait until the right moment (after inexact
> renames have been resolved, and when we see if there are any candidates
> left), it should just be a matter of walking over the candidate lists.
> 
> Something like this (it would need the add_if_missing() helper from
> diffcore_std()):

[snip]

> @@ -538,6 +539,25 @@ void diffcore_rename(struct diff_options *options)
>  		break;
>  	}
>  
> +	/*
> +	 * At this point we know there's actual work to do: we have rename
> +	 * destinations that didn't find an exact match, and we have potential
> +	 * sources. So we'll have to do inexact rename detection, which
> +	 * requires looking at the blobs. It's worth pre-fetching them as a
> +	 * group now.
> +	 */
> +	for (i = 0; i < rename_dst_nr; i++) {
> +		if (rename_dst[i].pair)
> +			continue; /* already found exact match */
> +		add_if_missing(options->repo, &to_fetch, rename_dst[i].two);
> +	}
> +	for (i = 0; i < rename_src_nr; i++) {
> +		add_if_missing(options->repo, &to_fetch, rename_src[i].p->one);
> +	}
> +	if (to_fetch.nr)
> +		promisor_remote_get_direct(options->repo,
> +					   to_fetch.oid, to_fetch.nr);
> +
>  	if (options->show_rename_progress) {
>  		progress = start_delayed_progress(
>  				_("Performing inexact rename detection"),

And also the equivalent code in diffcore_break() and in diffcore_std()
after both these functions are invoked (in case nothing got prefetched,
but the diff still requires blobs).
