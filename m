Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF8C35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55632206CC
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="OXbovz0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgBOAmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:42:19 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54253 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbgBOAmS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 19:42:18 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so4533385pjc.3
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 16:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TYxvehk8dCURQCbfwk8AtWhZQ1TaQiyAfY1W2eHxRmM=;
        b=OXbovz0sfk75aI34Rens7hhsVBtBRXhBXS0c3KZaZH3r+qH/uUycdSfNuSG6tWh3EQ
         blHUSOKCTMkmEAADmzu1AY6PI9mZ/1SeVYKSRJgvhiBL1dLe2wF6Fa69okx0BARnW0E9
         fs+OnS3n8jdoVPtLf56Oe7/ecQ8kOTbV8onV8DsgOwQRdmvRtnribPSL7ubCsh8p07el
         qE8W6xqicXB+7CTb0yo326fK1z5wA8y1v3npPXRSwiqRsjipwOIrEr/77fZWvcaS7KNe
         0uamMuo4imyd1NX+Pts1Ux5AbLHU7/hiyXWzPHqFU6Q+8bDhWznQxMjjAiC1mwsMD5Zk
         tLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYxvehk8dCURQCbfwk8AtWhZQ1TaQiyAfY1W2eHxRmM=;
        b=JTccPefOee0i9jc7nrKOlf1VrEvnPVhuFbGEQaJUu90wLlSZjq/on/0tztRoY00mUK
         htuX5eQx2ij54D3MebA4RA9dOBZru3TU5b5vfIbJ13bm3n2voo/jkj8bsVlzP+UaBWoR
         JxJ62yHKRN+FMxYKs2l0AO5oNVwAl4po1YcyB2fvz4JNJdx/8GmqmPlJ78pVioM20x53
         AcCTFIHx0m+iT9CUKaZrIN4u2IL2fCT5+6jqwmetgqi6h+FdDpyAeMr3/edkOlhJo28y
         crhcG17FCglb4Z+6+WO7T8e0kO5DVYBYwCMqgKGOZToMXjZMoYFQKomncULqkx0+VSqV
         s0zA==
X-Gm-Message-State: APjAAAXXOKbamwLbzhaEUJWrlO4ouJH+VB7pmf5Y2T2F1Exad0buTIPy
        y4iISA4MK3DATOxYJmlqsDA5AQ==
X-Google-Smtp-Source: APXvYqz1rtetx5nMxBZRbgfDXZhTvpXf1Ebq6ZC4oQhlWrhc68u96AZANvR6oxYXOJKSR+vLs+U0GQ==
X-Received: by 2002:a17:902:6809:: with SMTP id h9mr5802701plk.32.1581727338098;
        Fri, 14 Feb 2020 16:42:18 -0800 (PST)
Received: from localhost ([2600:100f:b02c:92d4:11e2:3a54:273f:b5fe])
        by smtp.gmail.com with ESMTPSA id z4sm8184568pfn.42.2020.02.14.16.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 16:42:17 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 14 Feb 2020 16:42:16 -0800
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/15] rev-list: make --count work with --objects
Message-ID: <20200215004216.GA15192@syl.local>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182220.GF150965@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182220.GF150965@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 01:22:20PM -0500, Jeff King wrote:
> The current behavior from "rev-list --count --objects" is nonsensical:
> we enumerate all of the objects except commits, but then give a count of
> commits. This wasn't planned, and is just what the code happens to do.
>
> Instead, let's give the answer the user almost certainly wanted: the
> full count of objects.

This makes sense: I've often worried about introducing
backwards-incompatible changes in newer versions of Git, even for
behavior that didn't make sense to begin with.

Of course, backwards-incompatible changes *are* something worth worrying
about, but I don't find that the behavior was sensible to begin with, so
I don't have a problem "breaking" it if "breaking" means making
something nonsensical behave correctly.

> Note that there are more complicated cases around cherry-marking, etc.
> We'll punt on those for now, but let the user know that we can't produce
> an answer (rather than giving them something useless).

Yep, sounds good.

> We'll test both the new feature as well as a vanilla --count of commits,
> since that surprisingly doesn't seem to be covered in the existing
> tests.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/rev-list.c       | 13 +++++++++++++
>  t/t6000-rev-list-misc.sh | 12 ++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 38c5ca5603..9452123988 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -253,11 +253,19 @@ static int finish_object(struct object *obj, const char *name, void *cb_data)
>  static void show_object(struct object *obj, const char *name, void *cb_data)
>  {
>  	struct rev_list_info *info = cb_data;
> +	struct rev_info *revs = info->revs;
> +
>  	if (finish_object(obj, name, cb_data))
>  		return;
>  	display_progress(progress, ++progress_counter);
>  	if (info->flags & REV_LIST_QUIET)
>  		return;
> +
> +	if (revs->count) {
> +		revs->count_right++;
> +		return;
> +	}
> +

Hmm. This puzzled me at first. Do you think that it could benefit from a
comment?

>  	if (arg_show_object_names)
>  		show_object_with_name(stdout, obj, name);
>  	else
> @@ -584,6 +592,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	if (revs.show_notes)
>  		die(_("rev-list does not support display of notes"));
>
> +	if (revs.count &&
> +	    (revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
> +	    (revs.left_right || revs.cherry_mark))
> +		die(_("marked counting is incompatible with --objects"));
> +
>  	if (filter_options.choice)
>  		use_bitmap_index = 0;
>
> diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
> index b8cf82349b..383f2c457d 100755
> --- a/t/t6000-rev-list-misc.sh
> +++ b/t/t6000-rev-list-misc.sh
> @@ -148,4 +148,16 @@ test_expect_success 'rev-list --end-of-options' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'rev-list --count' '
> +	count=$(git rev-list --count HEAD) &&
> +	git rev-list HEAD >actual &&
> +	test_line_count = $count actual
> +'
> +
> +test_expect_success 'rev-list --count --objects' '
> +	count=$(git rev-list --count --objects HEAD) &&
> +	git rev-list --objects HEAD >actual &&
> +	test_line_count = $count actual
> +'
> +
>  test_done
> --
> 2.25.0.796.gcc29325708

All looks good.

Thanks,
Taylor
