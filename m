Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEC1C433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 00:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349644AbiBEAys (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 19:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiBEAyr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 19:54:47 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63979C0364AC
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 16:54:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso7633986pjt.3
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 16:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3rnFwl0gpyXkmyc7Xkxu3ULSTRPIbZh3c9wNETb3U9U=;
        b=P0lDi0jYPhjiJvFwGNKacboyD9aw8ymrF/KNvMIvHh5kO59kdxRQICWiSEoNqNW4tk
         YA54vEqDMj4Fj2LNpOpYEuOO+EDUOySyc53VPZ3G1nDoBbADoc9vRp6rvWs7m59kJfGq
         8XZHTcDf5Bjrg6HMKzRGH9TKlbnWvGyrHhIdSyJQC3p/w/PPAbO2X1r3lJHnRR2Nfwv7
         JkmhxoqRUH0BvClsxvEn95Dm9lDDeBCZ6/aGLrttEXVlAoub7+JguxDuZErGiNpyKFRz
         bLKxl9WABcFVN29+KQ+rWVAonB7wjiu6O8nI2SUcqHVcGyytyNv5ieXQ9pw8rm0Lb6SO
         Hi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3rnFwl0gpyXkmyc7Xkxu3ULSTRPIbZh3c9wNETb3U9U=;
        b=0rAiv3rUBeqIk0u4U+tmC64Y/bvBRYfAGS9YSWqZGFf7+JRmI8BFEH8HRD2MzZkT+s
         +DOytafS0Uc9rdi3xwIdOEtvCjQobTvHDDc3F6BBxPLXf2TjJdKk5MEtZAyeDpxjz+9f
         q96g1EPNwBl2CV4Q5TDVqfhjpJI0Ni5X+BKYewm1npkIf9ErzBjDPtziTPeLqj1+N8Kd
         DWSNFXW4tip4esftATwBe9xHBcIxrSNxFU71M/RhkWQCXmi4ifniIvwckxEQ5TQjEyob
         9b4P2fc7ogRHWCuiMI575qt/VKYmb0bw8uG82HQk35vwMcR57RVY8/QakhhUO+zZQU2H
         1Ubg==
X-Gm-Message-State: AOAM530TXHkFqx16KxhKPwveO+IsJJUtH16UxVoD05zybBfmbKas8lTH
        tKntJGgfhlkni7xp0JFNpRx8E74D30zOZw==
X-Google-Smtp-Source: ABdhPJypWC6Dx0FTKqjE4z/2a/CumvQExndL/AI+HZ/sUy9/hQBvPgs9al9D9VBfCWTScODqUweyjQ==
X-Received: by 2002:a17:903:283:: with SMTP id j3mr3803834plr.146.1644022484531;
        Fri, 04 Feb 2022 16:54:44 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:8562:eb15:bb84:ce64])
        by smtp.gmail.com with ESMTPSA id 3sm10938485pjk.29.2022.02.04.16.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 16:54:44 -0800 (PST)
Date:   Fri, 4 Feb 2022 16:54:38 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: Re: [PATCH v2] clone, submodule: pass partial clone filters to
 submodules
Message-ID: <Yf3KztxONWk+R3K6@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, newren@gmail.com
References: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
 <8678e721c2ddd785e866df972af734e422b95039.1644021221.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8678e721c2ddd785e866df972af734e422b95039.1644021221.git.steadmon@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hmm, t5617 fails with GIT_TEST_DEFAULT_HASH=sha256. Not sure why yet,
but I'll investigate and send a V3 with a fix.
