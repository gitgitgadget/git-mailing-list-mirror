Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6165EC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E351D24197
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jMMG9DYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505536AbgJUUwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505533AbgJUUwP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 16:52:15 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE50C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 13:52:13 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t6so1891032qvz.4
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OUX3EmckT38r0xkFw12YoMyWgyWOHbnLoSkZ9qMt80I=;
        b=jMMG9DYsZCM0kFio8cdfRmYT7V/+Zr7iY7LwR3cPeFwFi4qGdChrNi+LdueHbw7tDd
         8RPg2kZLtL7MVGoeYd6Wmz75Q+IpMYtJjJsi8KlosXkjmAYfm+Dxf0G8CFVbDwAS64PH
         i1kExLvpUl0Clvs7A+Ey2oL8hHgFLS/nv4xVgUgvFKS9pf2DowC6GjfkTzpw/7gGEucH
         Xrd73A3B24SBQJ9MXOZAqxPK494ItEeoQfLrsaBJktQ7WPd0xxQHhclPnT1+L539I/Lp
         pndYCZgyaYdylWSTyk1wY4NHtvf4zrmAS5M4DkltJRFKwnssmAmQheJzP+Le4wz2ioDv
         6oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OUX3EmckT38r0xkFw12YoMyWgyWOHbnLoSkZ9qMt80I=;
        b=iIiMWTO1aR/FksRDpNNpeuKlKc8GAhz2EedLGg8uYAc/CwZir22cQjIN3BVFmU0ffN
         fdM/T8ENTmM7YCx8lSg4FB+PlAzffG9aGPfAny4pjUfaGUByhtT3vfbJliBmMg4rFSFD
         YdMfV6eXEa1i5Fxov/jgJpucHg56hWRA5NmWbRejpETu33E/FBNJ+dxpC7CbM/odEMzN
         Jgt6JObiw1CI0mpm+rSPxrAlNVVc42FUkrVSBMFzVktHhUNpb779wwdLELJ7cpm16G0J
         PGtY3A4SYXOddoBAPs/eM+1nasoBplOoeDieV+zJ14JKrezBLWc2mAjS9GI+oc6E3YaI
         Z0pg==
X-Gm-Message-State: AOAM5330mia3AJK4Lns70Me1zjH3CUSQXFi0NIh24Cj0zw7Z+i6INGaA
        hMQE+EKPCNxt9SORGNXO0KplFg==
X-Google-Smtp-Source: ABdhPJy4YLsx3xSzJS/qZoA03UeN8p4YtFrhwEZtKz6OTeM0HxtdQFS6VQ/W1GckKowvvKwpmTp12Q==
X-Received: by 2002:a0c:edb1:: with SMTP id h17mr4316108qvr.7.1603313532838;
        Wed, 21 Oct 2020 13:52:12 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id 61sm2019985qta.19.2020.10.21.13.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:52:11 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:52:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>
Subject: Re: [PATCH 0/2] fsmonitor inline / testing cleanup
Message-ID: <20201021205208.GA1270359@nand.local>
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.767.git.1603303474.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nipunn,

On Wed, Oct 21, 2020 at 06:04:32PM +0000, Nipunn Koorapati via GitGitGadget wrote:
> Credit to alexmv again - I'm rebasing these changes from a couple years ago
> for contribution.
>
> Full comments are available here -
> https://public-inbox.org/git/01ad47b4-aa5e-461a-270b-dd60032afbd1@gmail.com/
> To summarize the relevant points

I'm fine with both of these patches, but it may help to have a bit
more information about how they will be used. Presumably more patches
are coming that make use of the new public functions, but it'd be good
to know a little bit of why these changes are necessary.

Thanks,
Taylor
