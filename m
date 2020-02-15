Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E1CC35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480E8206D7
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="RadYNjtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBOAWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:22:36 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54288 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgBOAWg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 19:22:36 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so4507722pjb.4
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 16:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NpjAW50TvasOEj02AjprmW4r+hNOJXBgygxMIBZhjMw=;
        b=RadYNjtNqjLQ6vDXq8BAYnc8IP8UjeIOLpifwp1Hu+H1qAdG0lf++L+Lf0UJipASTb
         iT0YuVGM5CbU8mRg45Q1sQnnQN6oWqnb95JJ6jKhc4NkU71ZGH6XZMpt4+1Qcfm+IKr9
         UQRb6fQ/DlcTVqF2Y0/Gm9qckJzigf2TtVXdXaMVwoIXnwN0X2e1IpuBJWJdB1inArjT
         AYCnZr6VCH0OyPleki9BLej6iXrMzGvjkYZe9iYk5udd8AX206gEQIY7UpLJTZWMIu5H
         c0K9NDffgi5RsKqbQBGr7+b+aeHWMZhfDOh/QfXEeVdeTp1kroOmqfa8kHMJJPG5gVZl
         GfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NpjAW50TvasOEj02AjprmW4r+hNOJXBgygxMIBZhjMw=;
        b=l563y3APoRwZxnIP+eDch+AxopYHNCoqYcOE2mGJqxHeG/9ZyLo6sI4c7TOOqTBYv1
         2P/A5TWFTXXYM3z95YtwJSc8wk8UisPa2Pgr/7Q32kDKm4j+QwV9hcSsaZ3yUtU0Lq/8
         Ra7RgMzDufMp1Xore5P8GahVYDHcOlpZr7oVyU+ZaoaRNo8FXBiU42nym8QMxs26BdpG
         ibJFdvLZuv+zVByy96uAFP/203AQc5lpBCGMPEJKGttrem9IXe468SMdK8QUyu+n/h8p
         sN6/xEjWEkKfLqglibn+8tWHmoojYL7THnpjbK5L/AEDO1H0biCT6ahXW/uCTtOOjwOF
         6kLQ==
X-Gm-Message-State: APjAAAUamuS2xvxCN/JGRYwf6qS01DD2gqJBJu85c1Y5w3KCbymTfcmm
        S2WMJk4JLKZXFp0VV9ciRPItRv34kab4ww==
X-Google-Smtp-Source: APXvYqzQ3/tRjmZvptnLZxOn2Si72YZ/ssrte312IpMzuAuR2o/jN9lV/qAdS3584J4+Bc26jo9DcA==
X-Received: by 2002:a17:90a:b009:: with SMTP id x9mr6662916pjq.124.1581726154074;
        Fri, 14 Feb 2020 16:22:34 -0800 (PST)
Received: from localhost ([2600:100f:b02c:92d4:11e2:3a54:273f:b5fe])
        by smtp.gmail.com with ESMTPSA id w14sm8228617pgi.22.2020.02.14.16.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 16:22:33 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:22:32 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/15] rev-list: fallback to non-bitmap traversal when
 filtering
Message-ID: <20200215002232.GF11400@syl.local>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182213.GC150965@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182213.GC150965@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 01:22:13PM -0500, Jeff King wrote:
> The "--use-bitmap-index" option is usually aspirational: if we have
> bitmaps and the request can be fulfilled more quickly using them we'll
> do so, but otherwise fall back to a non-bitmap traversal.
>
> The exception is object filtering, which explicitly dies if the two
> options are combined. Let's convert this to the usual fallback behavior.
> This is a minor convenience for now (since the caller can easily know
> that --filter and --use-bitmap-index don't combine), but will become
> much more useful as we start to support _some_ filters with bitmaps, but
> not others.

Yeah, I think that this convenience is worth it early on instead of
lumping in these changes in a future patch.

> The test infrastructure here is bigger than necessary for checking this
> one small feature. But it will serve as the basis for more filtering
> bitmap tests in future patches.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/rev-list.c                 |  4 ++--
>  t/t6113-rev-list-bitmap-filters.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>  create mode 100755 t/t6113-rev-list-bitmap-filters.sh
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index e28d62ec64..bce406bd1e 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -521,8 +521,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	if (revs.show_notes)
>  		die(_("rev-list does not support display of notes"));
>
> -	if (filter_options.choice && use_bitmap_index)
> -		die(_("cannot combine --use-bitmap-index with object filtering"));
> +	if (filter_options.choice)
> +		use_bitmap_index = 0;
>
>  	save_commit_buffer = (revs.verbose_header ||
>  			      revs.grep_filter.pattern_list ||
> diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
> new file mode 100755
> index 0000000000..977f8d0930
> --- /dev/null
> +++ b/t/t6113-rev-list-bitmap-filters.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +
> +test_description='rev-list combining bitmaps and filters'
> +. ./test-lib.sh
> +
> +test_expect_success 'set up bitmapped repo' '
> +	# one commit will have bitmaps, the other will not
> +	test_commit one &&
> +	git repack -adb &&
> +	test_commit two
> +'
> +
> +test_expect_success 'filters fallback to non-bitmap traversal' '
> +	# use a path-based filter, since they are inherently incompatible with
> +	# bitmaps (i.e., this test will never get confused by later code to
> +	# combine the features)
> +	filter=$(echo "!one" | git hash-object -w --stdin) &&
> +	git rev-list --objects --filter=sparse:oid=$filter HEAD >expect &&
> +	git rev-list --use-bitmap-index \
> +		     --objects --filter=sparse:oid=$filter HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> --
> 2.25.0.796.gcc29325708

Makes sense.

Thanks,
Taylor
