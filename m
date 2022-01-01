Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F2AC433FE
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 20:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiAAUIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 15:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiAAUIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 15:08:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4D1C061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 12:08:39 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so16267201wmd.5
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 12:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CnDbzTeBzsi/miKOpdEYGOhbQcDMBMXlmz4jS63ckqg=;
        b=mxJc5F9ZPiBtDUiQcgLKaLzjxMqn+nogRHmB9hMEnIVvidATeCQ0PMIrJSUwSsGwSW
         LngRIIww2SuaYJibsLDqnLO5IhRxAJcSVTgCLxiJdjYuwD/d0WtJoq0xUMFBzKqOjMl8
         SPoeIcAjpQdnjm9+53AkHXicVZFfOIpmG0fjJjGFiPt/yjE+kpJrI0V7pR1N0gxC+9jj
         9O0alAPu87c4lbtx9Z5M09cFIOC3qgSxPXqw80XLw5mHRB7gAPnHoPwtIoQzjUXQs/Yd
         6Et45gmq2NkGaL1UhY/X4WJsP1sAfDGMxrxYVVqEFOPGgBqgPJz00xypM1LJlA2XXh/P
         w+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CnDbzTeBzsi/miKOpdEYGOhbQcDMBMXlmz4jS63ckqg=;
        b=dpmHGW+Qe7qzQw2bTKzi4rvl/nyNi3cGf8iSP14m0+rMowH59dM4CPARRCJqIZM5kF
         5xW6zvfLQ18Qf4q+/MHxksrPgcaoMLU8kqvta21dASOL7Pznudu8VO6XtC/j8Tz3zVdI
         Qtlx4DOxcFznyxc392n6wVzAlQ7zfu09j0LbyR/qgRWrc/2lj0DnxOhubUi8nn47R9Ds
         5zf1I/O2eYRUeAnkemWT/hiBBI2nsjc3zH6e8UKblVfTDS042GHvMAS1B3anXTXScfpI
         f+AD2T54twk7E3pEghtzRLRs55bT33SS3vcJ2UYMaZ9xvoYcqpQrTHpuF4U6I7SDraxZ
         MXYA==
X-Gm-Message-State: AOAM532/5Megveq1Zl8HLdUbUkjBQzJvzRwHstc+E7AKYzdvC2TEhNul
        VAO3J+NTIOA60yjikNG8Suw=
X-Google-Smtp-Source: ABdhPJwlHj3VbOZYXP8YnoFcIlaxVEx3aOlToifahiL/vNNpwEYEpHJkVpmC7K/eNUeFgyp3qXJElQ==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr13178005wmj.77.1641067718305;
        Sat, 01 Jan 2022 12:08:38 -0800 (PST)
Received: from gmail.com (62-47-8-46.adsl.highway.telekom.at. [62.47.8.46])
        by smtp.gmail.com with ESMTPSA id 14sm33046681wry.23.2022.01.01.12.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 12:08:38 -0800 (PST)
Date:   Sat, 1 Jan 2022 21:08:36 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 6/8] merge-ort: allow update messages to be written to
 different file stream
Message-ID: <20220101200836.msaewswefs5uvkyq@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <32ad5b5c10da7204dc4a2d3ca74f8d73745925a7.1640927044.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ad5b5c10da7204dc4a2d3ca74f8d73745925a7.1640927044.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 31, 2021 at 05:04:02AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> This modifies the new display_update_messages() function to allow
> printing to somewhere other than stdout.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 7 +++++--
>  merge-ort.h | 3 ++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index 6237e2fb7fe..86eebf39166 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> [...]
> @@ -4271,6 +4272,8 @@ void merge_switch_to_result(struct merge_options *opt,
>  		trace2_region_leave("merge", "write_auto_merge", opt->repo);
>  	}
>  
> +	if (display_update_msgs)
> +		merge_display_update_messages(opt, result, stdout);

is it intentional that the previous patch doesn't have this call?
