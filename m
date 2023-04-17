Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E26AC77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 22:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjDQWUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 18:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDQWUE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 18:20:04 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F01A46B0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:20:02 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fc337a650so183638167b3.4
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681770002; x=1684362002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1/JMejXiymPu9q66AGPxKq+kxIZCr7Y6CovY512Y1E=;
        b=f3rFiz+LiQ8HK3Ng2hlSZeQPRVrVy+QaVO4oM8QCY/CIqGE/H5QZUWWohIrvj3s5g4
         +Iju1ay3xU3uKinO0vrEPcn2AfuYQ5XKzPyVfYmHDfQHjH3gdTLnsvaVzxtIpT8abHpK
         /BdnVt+eqRiUfB+hRdVCC+yjGE/P7+6o5WDU6d7IjxbHIKQclcNpFa+Rh3Xb+c8v+yYd
         /cGoL/b52RELClxgG0VHFvFdjy+MyzD2wzT8O9pIDBZx5SEO3ZowHqOsCdUbTudAmlis
         svd5N41Fb0hpuqqG1j7R2cHiVPiJEluKve/TMISJkr3mjE4WOpsM1jVcbM8V4CpVynPD
         S0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681770002; x=1684362002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1/JMejXiymPu9q66AGPxKq+kxIZCr7Y6CovY512Y1E=;
        b=Vi2wl30tR0tuZOhlH7V3z9CmSrIGesA+pJZ1vSbmd42+AG48ZPCfohSuGzbbB87e7N
         GceguLB0w0Btd72WGEpMpRipowgPBdzpTYxzinfdEpRXEMj2nEybbjd+ADEgCa4ZMX8U
         NTLbUYcTIKfvqyTm/AVFBNq9cKxV4DSCsSWOWY9rXTEsJUkfSGRZlidI0qW4XYnJWg9R
         F3kjqfOfb/p2SehVY0g75DVnvWtzi1JV6xnJEHvYBhqa8va67Bh6YrUR5GGslgpfO52l
         5b8NHpiCuTGgqHzJZbF3EDFdELegCVwqzWU4DxUYoXOW35EzXNcSdjh/JpB/pvnyvj++
         /hyg==
X-Gm-Message-State: AAQBX9c0U2nNOPqtso6R0CUwgJXmEn7J2naMK3E9m+XJcAllngnUh6Yu
        5pdwTqC0VTpNOsg+5Pe+1Sv5xg==
X-Google-Smtp-Source: AKy350YE+oZXv3hlou4+kPI6lrX+Z05teeK6uESRlx6pdxkjKZSG9aiRnKfPgTwM2jl2mLK4FRE2Nw==
X-Received: by 2002:a0d:efc4:0:b0:552:6ffc:6688 with SMTP id y187-20020a0defc4000000b005526ffc6688mr12404884ywe.12.1681770001681;
        Mon, 17 Apr 2023 15:20:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a192-20020a811ac9000000b0054c19f4d6d2sm3377205ywa.29.2023.04.17.15.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 15:20:01 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:20:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/4] fsck: create scaffolding for rev-index checks
Message-ID: <ZD3GEIsPptxRetUV@nand.local>
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
 <6bc3c56453ee2d0263210c233dbc946b5dbdcb4d.1681748502.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6bc3c56453ee2d0263210c233dbc946b5dbdcb4d.1681748502.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 04:21:38PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> The 'fsck' builtin checks many of Git's on-disk data structures, but
> does not currently validate the pack rev-index files (a .rev file to
> pair with a .pack and .idx file).
>
> Before doing a more-involved check process, create the scaffolding
> within builtin/fsck.c to have a new error type and add that error type
> when the API method verify_pack_revindex() returns an error. That method
> does nothing currently, but we will add checks to it in later changes.
>
> For now, check that 'git fsck' succeeds without any errors in the normal
> case. Future checks will be paired with tests that corrupt the .rev file
> appropriately.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/fsck.c           | 30 ++++++++++++++++++++++++++++++
>  pack-revindex.c          | 11 +++++++++++
>  pack-revindex.h          |  8 ++++++++
>  t/t5325-reverse-index.sh | 14 ++++++++++++++
>  4 files changed, 63 insertions(+)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 095b39d3980..2ab78129bde 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -24,6 +24,7 @@
>  #include "resolve-undo.h"
>  #include "run-command.h"
>  #include "worktree.h"
> +#include "pack-revindex.h"
>
>  #define REACHABLE 0x0001
>  #define SEEN      0x0002
> @@ -53,6 +54,7 @@ static int name_objects;
>  #define ERROR_REFS 010
>  #define ERROR_COMMIT_GRAPH 020
>  #define ERROR_MULTI_PACK_INDEX 040
> +#define ERROR_PACK_REV_INDEX 0100
>
>  static const char *describe_object(const struct object_id *oid)
>  {
> @@ -856,6 +858,32 @@ static int mark_packed_for_connectivity(const struct object_id *oid,
>  	return 0;
>  }
>
> +static int check_pack_rev_indexes(struct repository *r, int show_progress)
> +{
> +	struct progress *progress = NULL;
> +	uint32_t pack_count = 0;
> +	int res = 0;
> +
> +	if (show_progress) {
> +		for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next)

It's going to take me a while to get used to these declarations inside
of for-loops!

> +			pack_count++;
> +		progress = start_delayed_progress("Verifying reverse pack-indexes", pack_count);

I wonder if we want to count over the sum of objects in packs rather
than the number of packs themselves. My worry would be that a rather
large pack would make it appear as if nothing is happening when in
reality we're just churning through a lot of objects.

> +		pack_count = 0;
> +	}
> +
> +	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
> +		if (!load_pack_revindex(the_repository, p) &&

I was going to comment that I wasn't sure if `load_pack_revindex()` was
the right thing here, since we don't care about validating the
on-the-fly reverse indexes that we generate.

But I see in your 3/4 that you are comparing the values on disk to those
in memory, which is very nice.

> +		    verify_pack_revindex(p)) {

Inside of verify_pack_revindex(), it says that a negative number is
returned on error. Do we care about disambiguating >= 0 here? IOW,
should this be:

    if (!load_pack_revindex(the_repository, p) || verify_pack_revindex(p) < 0)

?

All looking good otherwise.

Thanks,
Taylor
