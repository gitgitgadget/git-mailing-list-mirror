Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDC5C3F6B0
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 21:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiHXVAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiHXVAN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 17:00:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE126A4A4
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:00:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso2857176pjh.5
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=oODNe5pCFoj1KY8NCx/H14YPLSg8Qx1/kWlwlgOkIVo=;
        b=dsqsUtCqk3eYwxPkthWA4VO0O8bypxM9oXZUVtInNAqhZYDluMwxeMu0e34zUvE/nz
         qP7zS6IRGq0fwwcsIdkwn3bHg1ycJapg6x7aD2dNu584CakciJ/PEMqVr36fs+vLrPQk
         NkeXB2vFf9phlsUWGIr9Jqg5veoJOK2AUdEQlM01lG/rA6zL/xBy35l1ZS4vJRkuEDD+
         +jtvb+ihewFZTFBd7NzlkhW2l7S0FBokzkAYJQOtDQZAXmIvprPmx6s9+ah321axcPnE
         yFap3MY3KNVK9CYkfoWcOuGd+rTDDiySCuaFAr14CaeLF9lzu46bSc1I8wUh0ZEesKHP
         /Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=oODNe5pCFoj1KY8NCx/H14YPLSg8Qx1/kWlwlgOkIVo=;
        b=JiiwQEiYvMmPt7fnwSeX4Cqbzo79J2amf1rAV9GusZgxLveq0XvLbp6OS3/mCvRxa5
         hYDp3CHL4ehyJNyg+Po/XTTSIGb5cX/G+Nls2P3OVUGYyRK7HxGXEtsh3ozPmBbnHzLp
         DARcO3XWDf8qT3JCfZ59RanAHoVfyxdsYChfbhUNjgHvNlUQ8p8DXgOGtIg/liyGBuJS
         96tQYrL+9Pl03M8C/nkaFFyh4ajAgw/ul4/WULR076YM2BEBH4OZ8Iady2mqeeYgOH5e
         +HEh65IzzC66knJftLSkxHhjcHC1F7SGYqP4I6Hu6GPWG5pzo6PHdKli4eRMVYBAWqqc
         c9HQ==
X-Gm-Message-State: ACgBeo3llN/6tw6VIcXL3uHbIH2XI4UmbUno34nzw7tTbNZ6xw71P9bo
        /cQUnGYk9koLHDXRqP3FdXM6ebRMwj4=
X-Google-Smtp-Source: AA6agR4my0AdM+ckZD7hoN9b3HRu457rhKMcI2tBvGu53MR6Nh0mrYtFCdKUKsDo00mvzdW6LYCcCg==
X-Received: by 2002:a17:902:cf0c:b0:172:a41b:63a8 with SMTP id i12-20020a170902cf0c00b00172a41b63a8mr712262plg.161.1661374812309;
        Wed, 24 Aug 2022 14:00:12 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b0016c09a0ef87sm9384233plg.255.2022.08.24.14.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:00:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] range-diff: optionally accept a pathspec
References: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
        <064b147451b04051a413b532cd97ae764ba68027.1661258122.git.gitgitgadget@gmail.com>
Date:   Wed, 24 Aug 2022 14:00:11 -0700
In-Reply-To: <064b147451b04051a413b532cd97ae764ba68027.1661258122.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 23 Aug 2022
        12:35:22 +0000")
Message-ID: <xmqqh7215pd0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `git range-diff` command can be quite expensive, which is not a
> surprise given that the underlying algorithm to match up pairs of
> commits between the provided two commit ranges has a cubic runtime.
>
> Therefore it makes sense to restrict the commit ranges as much as
> possible, to reduce the amount of input to that O(N^3) algorithm.
>
> In chatty repositories with wide trees, this is not necessarily
> possible merely by choosing commit ranges wisely.
>
> Let's give users another option to restrict the commit ranges: by
> providing a pathspec. That helps in repositories with wide trees because
> it is likely that the user has a good idea which subset of the tree they
> are actually interested in.
>
> Example:
>
> 	git range-diff upstream/main upstream/seen HEAD -- range-diff.c
>
> This shows commits that are either in the local branch or in `seen`, but
> not in `main`, skipping all commits that do not touch `range-diff.c`.
>
> Note: Since we piggy-back the pathspecs onto the `other_arg` mechanism
> that was introduced to be able to pass through the `--notes` option to
> the revision machinery, we must now ensure that the `other_arg` array is
> appended at the end (the revision range must come before the pathspecs,
> if any).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

It is excellent that this now takes pathspec to sparsify the
history.

The implementation looks, eh, a bit dirty with obvious repetitions
in the "..." case and two-ranges cases.  Three-arg cases sort-of
looks different but that is because the original one does not even
bother to ensure argv[0] and argv[1] are objects, while the new one
does, so they are essentially doing the same things.

> diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
> index fe350d7f405..0b393715d70 100644
> --- a/Documentation/git-range-diff.txt
> +++ b/Documentation/git-range-diff.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  	[--no-dual-color] [--creation-factor=<factor>]
>  	[--left-only | --right-only]
>  	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
> +	[[--] <path>...]

OK.
