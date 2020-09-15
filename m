Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7876C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 04:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F682078D
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 04:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0kFbXfLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIOE0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 00:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOE0L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 00:26:11 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7022EC06174A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 21:26:11 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ef16so1121586qvb.8
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 21:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LNqT9S07NHYtfTYGEl1GysZkwybd9gfKXsu436FVd2U=;
        b=0kFbXfLZYZynNkdyo8EKmB7l7xkMZJ1/qBe4WSZmE7zrxDtXHgkWomhptv6GfZDRQY
         CFq/SR18iZ47XUFzmPiDqNH8e2acZNHZi/Cg5fyHlLnWNXrkSyUImWkxvseZeb0k6DeW
         BpAoui4Fy9wDbiKaKNemvcdiekY92ukcsLSgDYyGZBZvz8Xc4F+NPH/ZYlIItoHg++ex
         WQrpVUkJ1QM8STeKh4tm8BDzeYb4KwZ2L2RY9YAU7RXK8V2t3hNoSXWhGurjYC22HzL6
         uTTVKpEUCMEuIp/3zD4/Lggethe/8Q+7+ygwqdbybeVNZz4Cyjleg6OTd6msWJIQt+aA
         qt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LNqT9S07NHYtfTYGEl1GysZkwybd9gfKXsu436FVd2U=;
        b=Hq7T1wU0GQrTe4Y3g0pq0Qga9hGNaH/LW1l3Dib3kf0jmIGV8hlfn8KK2KIJBVDy2g
         mJ4qJsY5JqSZJ3vbNiZvWWQfEFPaJ+kjZ/PKVcOpwiceqF3aWC/dcFwkE3HB6dCEc+V3
         G2iS6EKeuXGCnjZho0Xc+bzrSwMsU9MoRJTHf4XUcGIw3H7B2rSgze/oGLsc0pnmY6Fz
         sIaqS0+vaKjrBN61m6XV44muYeGsejZelYXTmv94yCKWmibOMHNx7YftWwHgOl5qMjkx
         ePPNN40ghLyV7XDcrI6W6lH/d+hzh0GfkyBGCaPOyWTlwcBeruNCxXSnG1aZpml+eR0k
         da7A==
X-Gm-Message-State: AOAM533hWHX4KdSrAoV7pDfh2klTCCAc4gupNW914VDW8dMgJLXX/miM
        XrRcc5DR6aGvVh1fWy/+iErr8w==
X-Google-Smtp-Source: ABdhPJwFGh6XF6cQklxmGpAY33Q6Ly85FS3bANU50KHc56OyE/V8P4UhRVa8aqKuFdaPOxrCA9OSuQ==
X-Received: by 2002:a0c:8ecb:: with SMTP id y11mr114905qvb.51.1600143970660;
        Mon, 14 Sep 2020 21:26:10 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:bc05:1f7d:98e:e354])
        by smtp.gmail.com with ESMTPSA id u2sm16387164qkf.61.2020.09.14.21.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 21:26:10 -0700 (PDT)
Date:   Tue, 15 Sep 2020 00:26:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Conor Davis via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Conor Davis <git@conor.fastmail.fm>
Subject: Re: [PATCH] commit-graph-format.txt: fix no-parent value
Message-ID: <20200915042607.GA19144@nand.local>
References: <pull.733.git.1600142634326.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.733.git.1600142634326.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Conor,

On Tue, Sep 15, 2020 at 04:03:53AM +0000, Conor Davis via GitGitGadget wrote:
> -      of the ith commit. Stores value 0x7000000 if no parent in that
> +      of the ith commit. Stores value 0x70000000 if no parent in that

Thnaks for fixing this up. This dates back to a9aa3c0927 (commit-graph:
fix documentation inconsistencies, 2018-06-28) which mentions the
correct value in the commit message, but uses the incorrect value in the
patch itself.

For what it's worth, I can hardly blame the author of a9aa3c0927, since
I had to flip back and forth between the two a couple of times to
convince myself which one was which.

Anyway, this is obviously correct. Thank you for your contribution!

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
