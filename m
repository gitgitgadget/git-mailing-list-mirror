Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AADC33C9E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 04:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86E320721
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 04:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="S/rkBpJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgBCEiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 23:38:05 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53870 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgBCEiF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 23:38:05 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so5727646pjc.3
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 20:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hxa6U4mNdkjE8ZtxmMqaPcIckY0dr80EUOohVmlLy2Y=;
        b=S/rkBpJqmF5N6V+SHZc9F83WsR1U+MhbDMDrZowrMMuZ9hWqrtz5z5r18ul6hIn/QI
         LaJCLydrvl7qQbtF0Px9OozudyJt+QXxEnkPKT5rXUpDCtp5X3cO86Zf4WcRwc2vF3rn
         iXCeKvJ5v9dqYNIUyy3AfxIoTaEMhCUjJp9SZ7YPMtLPKAzIenafByRsFHTfP0WL+VsU
         lRNCdOoXrtKWgwmnWsnRnXLzjASHeHlCYRiHe+FbSVEF+Qz95uu0PtGZPqjyHxoRFLyu
         9cHlOIBLnzJCDVxQDR2UdW0Y+ituWVt/ls6GubT27KrlH7sOTbIl51OMJGe8OWG4A20y
         UTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hxa6U4mNdkjE8ZtxmMqaPcIckY0dr80EUOohVmlLy2Y=;
        b=AAdZkixRPJusWeJyd8oPzAU1K0sLOD8oPBm/D1rxoz1JbytcquvHHLzIeqft2YRMJb
         3d5qX4VPtzeivP++1fudb1wc2pPwiFV0RfYqiHRStTW9Hn0VZR6uxZUVTBFuNzK59GY6
         SpQNo7vqI/KB1H0SWwLabCc17l4Ba9K3d4sZ45WldVFsNWmAQfY+34vwug/ARtLXRstx
         9j6mZR0UYJNfxYPvVBbPwACrT+q4q/iRrFdFjpYc+a8n3uJYqWgD5nc7Itozi5H5E3JF
         PSsXpi2HX6/yal1+dnhkivY3KL2b67wTQQt5UBDKqxarIDwWf87rgzQYnIZw4zuFLw/F
         rAnQ==
X-Gm-Message-State: APjAAAX02rRSDHgD5SLFL/kxUXa3wdgbhytHg0oO5pbHklko2CGxDkmc
        AY/KJxiIN1t1GVSZX6OlFENC0w==
X-Google-Smtp-Source: APXvYqzWQTCYJjQ/Oz40x4N1vtVoNy80ZePEEKYlJXXIZkhrPjEaa39bgT/M9X0XN+PUwpIhhoAsfg==
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr26892853pjp.47.1580704684961;
        Sun, 02 Feb 2020 20:38:04 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:ac09:c6e5:fcdd:b79b])
        by smtp.gmail.com with ESMTPSA id c14sm18461265pfn.8.2020.02.02.20.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 20:38:04 -0800 (PST)
Date:   Sun, 2 Feb 2020 20:38:03 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 0/6] commit-graph: use 'struct object_directory *'
 everywhere
Message-ID: <20200203043803.GC23625@syl.local>
References: <cover.1580424766.git.me@ttaylorr.com>
 <20200131103008.GD2916051@coredump.intra.peff.net>
 <60a4d129-c6a9-1e5f-a467-7db0babbcffa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a4d129-c6a9-1e5f-a467-7db0babbcffa@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 08:22:42AM -0500, Derrick Stolee wrote:
> On 1/31/2020 5:30 AM, Jeff King wrote:
> > On Thu, Jan 30, 2020 at 03:00:40PM -0800, Taylor Blau wrote:
> >
> >> This series became a little bit longer than I was expecting it to be, so
> >> here is the high-level structure:
> >>
> >>   - 1/6 fixes a bug in a test that would cause a subsequent failure if
> >>     unaddressed.
> >>
> >>   - 2/6 does the first half of the removal by using 'struct
> >>     object_directory *'s within the 'commit_graph' structure.
> >>
> >>   - 4/6 does the second half by removing 'char *object_dir' usage in the
> >>     'write_commit_graph_context' structure.
> >>
> >>   - 5/6 ties 2/6 and 4/6 together by removing all path normalization
> >>     completely, fixing the uninitialized read bug.
> >>
> >>   - And 6/6 cleans up.
> >
> > With the exception of the patch-ordering discussion in the sub-thread
> > with Martin, this looks good to me.
>
> I agree. Martin's comment is a good one. I can't find anything else
> to improve the series.

Thanks for your review!

> > Patch 3 is a change in user-visible behavior, as it restricts how
> > --object-dir can be used (it must be the main object-dir or an alternate
> > within the repository). I don't _think_ anybody would care, as the
> > semantics of those options seemed kind of ill-defined to me in the first
> > place. But it's worth calling out as a potential risk. I suppose the
> > alternative is to make a one-off fake "struct object_directory" within
> > the process that isn't connected to the repository. But if nobody cares,
> > I'd just as soon avoid that.
>
> I think that this change of behavior is fine, especially because if
> someone writes a commit-graph to an --object-dir that is not an
> alternate, then that repo will not discover the new commit-graph
> anyway.

And thanks for the ack. I would be somewhat surprised if someone were
really relying on this behavior in practice.

> I do like that you state a possible work-around in case someone shows
> up with a legitimate use case for a non-alternate object-dir.
>
> Thanks,
> -Stolee

Thanks,
Taylor
