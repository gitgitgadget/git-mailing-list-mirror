Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5161EC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235AB61208
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhIKQSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 12:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhIKQSp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 12:18:45 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C954C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:17:32 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id q14so5404699ils.5
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dlr39AwVDOc5H3iieK5oxSLE1HfnNtp3EuAA+k4TUMM=;
        b=l8A6j709dXfikAVlQxS/RJLDNBrY1MrJ5j/MLjKOyXRrnGz9zXggM+0OiTg4F8lWgg
         3CYlCFY0i79wdgkmwObsxVfY3I/VN4+0Ras8jSc+y9cij6NwFgwNH7y5GLNogobHcclf
         J40KRq03ub8XhZxfiGPtHPHFsxSjO5Xl7GYPHUPtn1qyOcuAD5QktWfs1qwbkVtSRfMv
         3RB/JT4cjrDdDE9eGBIK3U95w1tEfc9Q2G7ipVKa+/PsKD+3OLIrAuJIKGVCxuvT5xIQ
         WGRqzzD7jAmiLW3e8dc/BmcxWQ06JkdIe6tYjhcngIrW++RlzApFKhbFoOabIhlNFMFI
         S5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dlr39AwVDOc5H3iieK5oxSLE1HfnNtp3EuAA+k4TUMM=;
        b=la9wjDKumgPPKziA4FKgokao+9xWziwD+q0tpu0MWfMDp8kbscmE9azTCywTv8G5vU
         TcJOY/C+Xb8Y2nmZTjnl4D0gb610xpqOHKxPyJiB/+RkAvjDi+lvuyZ2+HbNM5Ku/qDU
         VemMKafwFFySM92f7EyC4CLoHjNN+NV/naObLpT9ftGyOZR++yy5aDBxB7ycQq6sQ/nr
         J65Hbx3y8Qjm192PBVwJ0dUrcqCKe5J3NkasQNBdKSz/C7Gvx0N8DyD/iR7+kKOTPcez
         OCwZaZJ9jKDzmDyAwr68zT+RNx4EGXIcd4MSdgQ99XjTWdnKoYT3HOYXByNc+dNVi3i7
         8I5w==
X-Gm-Message-State: AOAM531GUhQMEmoVdFKPo9RJh3lmGr5LENXFjjKtxHvmyFhk/W8V1H+H
        XUnLRd2Pu8//C60onLPVLWcN6g==
X-Google-Smtp-Source: ABdhPJyGrGCYUFSCiyXsEL0DXucbo7XQBtDWKUCrtk6COLSMn79m8UPM398Te6CfHEWoJPGQ7cK5dQ==
X-Received: by 2002:a05:6e02:10c4:: with SMTP id s4mr2049390ilj.207.1631377051897;
        Sat, 11 Sep 2021 09:17:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x5sm1053246ioa.35.2021.09.11.09.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 09:17:31 -0700 (PDT)
Date:   Sat, 11 Sep 2021 12:17:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/8] midx: expose 'write_midx_file_only()' publicly
Message-ID: <YTzWmhFxn04Jgk1U@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <4afa03b972a1885c60fbf3716f22a7ab58056383.1631331139.git.me@ttaylorr.com>
 <xmqqsfybn1ud.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfybn1ud.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 10:00:26PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >  	if (ends_with(file_name, ".idx")) {
> >  		display_progress(ctx->progress, ++ctx->pack_paths_checked);
> > -		if (ctx->m && midx_contains_pack(ctx->m, file_name))
> > -			return;
> > +		if (ctx->m) {
> > +			if (midx_contains_pack(ctx->m, file_name))
> > +				return;
> > +		} else if (ctx->to_include) {
> > +			if (!string_list_has_string(ctx->to_include, file_name))
> > +				return;
>
> What's the expected number of elements on the to_include list?  I am
> wondering about the performance implications of using linear search
> over the string-list, of course.  Is it about the same order of the
> number of packfiles in a repository (up to several dozens, or 1000
> at most unless you are insane, or something like that)?

You're definitely in the right ballpark. It depends on the repack
settings and size of repository, of course, but I imagine that roughly
1,000 entries would be the most anybody could ever pass (e.g., during a
`--geometric` repack, the biggest pack would have to contain 2^1000
times as many objects as the smallest pack).

Of course, you could just constantly be adding packs and doing
incremental `git repack -d --write-midx`. Seems unlikely to me, but if
it does become a problem we could easily read the values into a hashmap
and constant-ize the lookup.

But the scan is logarithmic, not linear, since the string list is
sorted.

Thanks,
Taylor
