Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7450FC388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A5D208B3
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="FTPqUF6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503384AbgJURRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408844AbgJURRb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 13:17:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29AC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 10:17:30 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id a23so3178259qkg.13
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dPZ2/j1OMiDF9EQA536aK+fOFIPC2mnIP1dt4f0KnpA=;
        b=FTPqUF6eVrmc3tKBInm6R0yO6qmWEGkNU+1D+gMbao9rsboVHxgGffZPV3mbPvxfzM
         5TcQ3Ym2+IENz0l+C4Tv3O3wQG1anSUpSXWIdgsKSSzo3+VIOuPnz02yNhCc7DGEoHJA
         2znm/v6hRqIeh46aFSgfUQ9+hB9ceh1nYkyqSX6fsrB8YsOMTHM24GPEg8UYg1tIN5xP
         QhnYdzF3TaK+AVhmjL2eTHMm1pRHFC2rovqQth/PC5iw5xrFmGlp0ONPGnBTqbWto0MA
         C1S7Gm0RVlHyojiLK2hVIe4qRzM0jpWjsqL1ptHsn5q5dmOMbSfCCftDoe/sYuOLUJX0
         sC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dPZ2/j1OMiDF9EQA536aK+fOFIPC2mnIP1dt4f0KnpA=;
        b=H9vWkfCH6zXTYq91pNGT2d8+BtsHljoAeQ8FOXDNM4zVDvhw8bi/2wLuDmprVauNA1
         TDNBBTc5wHRGMkiBSABOazafj3+aedSwWkGo+56SfsePxG9ST6dHAjP6CxR+rdftFeUI
         TkziOc/rq3DPS+zLUOKu6xowYX6dyNxcDM/c/2slrfVsTk3C8b7YOzyTNJUgl3YH0iVT
         QFn7FuYBavc34ooMjDfT8hAR/+Tu4AOG/oOGlbm9O3M/VJ9je9zTrhyAYKiutSqYFx2t
         iN7QEyEXI5x/+7MoG3vY5fENaE7IUoyN0g+A+uwi4o3aQkI9PQnpir96YfoMT+UEXcRL
         DUgQ==
X-Gm-Message-State: AOAM533mIIhLuDSkzR6LGoWhMCtmyogstHMOuaf9XmrhAGj7Uhz6HTjO
        Henp+FqLu+vySrakNEy5Iy+1TQ==
X-Google-Smtp-Source: ABdhPJwddC6JuYNlVIUK+Q/oEEMdroxmW1Jc+iWnaYyhsWkHTEXdHeBlyve4QDJKMzVErhBKI+aMWw==
X-Received: by 2002:a37:86c5:: with SMTP id i188mr4139414qkd.173.1603300649878;
        Wed, 21 Oct 2020 10:17:29 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id z26sm1641049qki.40.2020.10.21.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 10:17:29 -0700 (PDT)
Date:   Wed, 21 Oct 2020 13:17:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: remove duplicate rollback_lock_file() call
Message-ID: <20201021171727.GA1237181@nand.local>
References: <pull.894.git.git.1603286675709.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.894.git.git.1603286675709.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, Oct 21, 2020 at 01:24:35PM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/sequencer.c b/sequencer.c
> index 00acb12496..baff51035e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3689,7 +3689,6 @@ static int do_merge(struct repository *r,
>  				NULL, 0);
>  		rollback_lock_file(&lock);
>
> -		rollback_lock_file(&lock);

Looks obviously good to me, thanks.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
