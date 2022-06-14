Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ED8C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 23:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbiFNXcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiFNXcp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 19:32:45 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4B4167F6
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 16:32:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id fu17so7262238qtb.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 16:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ih4WwPsx9vJpTryC5NG4TGA4+ENFyCIn8ghWXvjc3Mg=;
        b=8RwHNzSHEd4R5Fnb2I2eVIACsUUItA/xB+/wb8Nyx+0Iggiw2KX0sdyERjVt1RDD/h
         w+giu1uoWVrZHywN50q/E5aWYqCXXGGjo2E4xPZy1fu6ud0idFr+3qxpzqgvjFqNiDo5
         Fbjxelk9skcSuYoCkHXqImgvXDreM0f8C1jl/Jn/z89B6rQtaWo+51dHT0k5uujKyjwf
         7y5skdsaxwd2ndqJ0LymbVi+xLdIyGpkgxiliDTWa2CqXvT3FDcFGEF2GMNadrulko/f
         gsvrC99ShqoXGiEaFuV+I9wyKbdSASx6SxrJxQONN8kmyy+ZjcOwC9MdFcIBgeh9BtnB
         3URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ih4WwPsx9vJpTryC5NG4TGA4+ENFyCIn8ghWXvjc3Mg=;
        b=TX1gju3kudu+9c7s2ZDrSdpjbERfkfC3saB57hX3cE3dVN/5nirKlv7bykiK+bHj2I
         b809o1gyEZPxvC/WOmz/41Ah0/WzyT/RduHa/G8oBN+ek0Jm60hnSqNoK9q6NTPX+I5+
         aHCvnwtNNdiBCyjTc3vNsyCfwj28FdtVLFkdnFoS/F2yZGAY+gx+YRBGkr39m4OTS/of
         +g7FhKZ1zYNlU3xSO6hv/+VwVQ8bo7kGL3b6dqO/PqVrHRjLELV+UX6FwRoHwzAqs6Y0
         AsmPYww1QVd3GT6YI2VxDG0XpDKb99z/ldFD/o2Q7fWY4KARfGDoam7E6iYZuvjCJTNY
         8N9Q==
X-Gm-Message-State: AOAM531IMgZ39xdaiAOxb2b3HkmWYPpqwH0UrFWxulAYtL+rMbWHSzWp
        ya5pHyOzjNpQWY/swFa5gNvMxA==
X-Google-Smtp-Source: ABdhPJy/Ax7B3O2h9Vhdih+FphFP2pVd3XbuzL2jPoyoiV8YyNUzG2DR+QJFYC1w0iJ05zZczD3ihw==
X-Received: by 2002:a05:622a:607:b0:305:1ec1:5a9b with SMTP id z7-20020a05622a060700b003051ec15a9bmr6584423qta.216.1655249562396;
        Tue, 14 Jun 2022 16:32:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h9-20020a05620a284900b006a6d365e9b1sm10416614qkp.57.2022.06.14.16.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 16:32:42 -0700 (PDT)
Date:   Tue, 14 Jun 2022 19:32:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, derrickstolee@github.com,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com,
        avarab@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v3] commit-graph: refactor to avoid prepare_repo_settings
Message-ID: <YqkamW45+VbIfJI4@nand.local>
References: <Yjt6mLIfw0V3aVTO@nand.local>
 <9b56496b0809cc8a25af877ea97042e2cb7f2af6.1655246092.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b56496b0809cc8a25af877ea97042e2cb7f2af6.1655246092.git.steadmon@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 03:37:21PM -0700, Josh Steadmon wrote:
> Range-diff against v2:
> 1:  2c2bfc7b43 ! 1:  9b56496b08 commit-graph: refactor to avoid prepare_repo_settings
>     @@ fuzz-commit-graph.c: int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size
>       	initialize_the_repository();
>      -	g = parse_commit_graph(the_repository, (void *)data, size);
>      +	/*
>     -+	 * Manually initialize commit-graph settings, to avoid the need to run
>     -+	 * in an actual repository.
>     ++	 * Initialize the_repository with commit-graph settings that would
>     ++	 * normally be read from the repository's gitdir. We want to avoid
>     ++	 * touching the disk to keep the individual fuzz-test cases as fast as
>     ++	 * possible.
>      +	 */
>      +	the_repository->settings.commit_graph_generation_version = 2;
>      +	the_repository->settings.commit_graph_read_changed_paths = 1;

This version looks good to me. Thanks for working on this, Josh!

Thanks,
Taylor
