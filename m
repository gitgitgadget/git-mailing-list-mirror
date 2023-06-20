Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23F5EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 22:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjFTWDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 18:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFTWDE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 18:03:04 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6369FE7E
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 15:03:03 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-791b8500a21so282784241.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687298582; x=1689890582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLpwR0N9SyTv4S4K1xXivbRNQf1CrILO680tW2Vz+eM=;
        b=QelygM0zuefXBYPF7efWJbA7cK4CFkskhktnZQRWREnS/D7+TkF3RHSSMcwiFof4LD
         Swkn1fVnBufXBvxenghCL/NaP8uepAPS2mWlWXUyApHR0bkUVYW6vRtwJ/8vcgAJqIc2
         xXBeb0ZpnTAMuM+qgwGcmslnZRTO1Aq3VqaheaP4c5XSuSex7AIIG82gXlyr/ghhbF3l
         KagHqZIBg+HSwOMYZpS1DU9jI9a5pobDdCXVCnMVIQnlBO8kT8wEDompDhmG/CAooy7e
         Z2+liwUEI730wtMUNIMBj0nrAwJu0UGyTwzxrPxc9F0uv5vUz7D+gUsfgLjRQ/TyBTyn
         V13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687298582; x=1689890582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLpwR0N9SyTv4S4K1xXivbRNQf1CrILO680tW2Vz+eM=;
        b=YO7+Sy1VooZ1WItSryXF40x1+mO3NpddnxcM7SPaoS142P/DszE7LKlGLpYUENFrZU
         YWpGAXvtdje/+ILp197E/wWY7DD/LY9RGmGP4qHwcQz+ZyQFkMlLDXryxmQa8eCXoL8L
         x5YlHA1x1OKaJNMkTkjA/Q0yk95icPdUr8frdGCYi+ZFwfIAEuAeuTqFHwP9xI6pNQSu
         lQH0GXehEnrUxMyy36ZzYQWWutut70qk4aLTELJz7DLNngGtY82oSpmInAXmPz49vcex
         sSHwd/RKYIbrC73CG1itCpLVe8Oeeel2B7YSW/w/p2BSy5IYd0JiM8b9bx7Q68OWkkpr
         TQMQ==
X-Gm-Message-State: AC+VfDyex0MLXb1rV3GamLBji7tndcUjJMF4HeEI3uG+X8VtbSK8JIVz
        /zVzGHehWuXCVzQfuql0xqLFBw==
X-Google-Smtp-Source: ACHHUZ6Xe1vIbQI2RlSVdAneJzCIZcEcL6cnHcjclKmsA2+pYWuVsXpee0x+O4rrRYKUI4xyaOSG7Q==
X-Received: by 2002:a05:6102:454:b0:440:afd7:cfe with SMTP id e20-20020a056102045400b00440afd70cfemr2865488vsq.31.1687298581886;
        Tue, 20 Jun 2023 15:03:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z202-20020a0dd7d3000000b00568c1c919d2sm727692ywd.29.2023.06.20.15.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 15:03:01 -0700 (PDT)
Date:   Tue, 20 Jun 2023 18:02:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] packfile: delete .idx files before .pack files
Message-ID: <ZJIiElehrukHlNy2@nand.local>
References: <pull.1547.git.1687287675248.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1547.git.1687287675248.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 07:01:15PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> When installing a packfile, we place the .pack file before the .idx
> file. The intention is that Git scans for .idx files in the pack
> directory and then loads the .pack files from that list.
>
> However, when we delete packfiles, we do not do this in the reverse
> order as we should. The unlink_pack_path() method deletes the .pack
> followed by the .idx.
>
> This creates a window where the process could be interrupted between
> the .pack deletion and the .idx deletion, leaving the repository in a
> state that looks strange, but isn't actually too problematic if we
> assume the pack was safe to delete. The .idx without a .pack will cause
> some overhead, but will not interrupt other Git processes.

I think that this specific case wouldn't cause a problem since we were
about to delete that pack anyway, but it may be worth emphasizing that
having a missing pack with an extant .idx file is not always guaranteed
to be safe.

> This ordering was introduced into the 'git repack' builtin by
> a1bbc6c0176 (repack: rewrite the shell script in C, 2013-09-15), though
> we must be careful to track history through the code move in 8434e85d5f9
> (repack: refactor pack deletion for future use, 2019-06-10) to see that.

Thanks for calling this out, I agree that the "regression" dates back to
a1bbc6c0176, since we can see that in git-repack.sh, we do:

    # Remove the "old-" files
    for name in $names
    do
      rm -f "$PACKDIR/old-pack-$name.idx"
      rm -f "$PACKDIR/old-pack-$name.pack"
    done

...removing the .idx first, which is the right thing to do here.

> diff --git a/packfile.c b/packfile.c
> index fd083c86e00..6b591ddcccf 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -381,7 +381,7 @@ void close_object_store(struct raw_object_store *o)
>
>  void unlink_pack_path(const char *pack_name, int force_delete)
>  {
> -	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};
> +	static const char *exts[] = {".idx", ".pack", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};
>  	int i;
>  	struct strbuf buf = STRBUF_INIT;
>  	size_t plen;

Looks good, thanks.

Thanks,
Taylor
