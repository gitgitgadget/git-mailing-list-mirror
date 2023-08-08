Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A82CC04FDF
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjHHU64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbjHHUme (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:42:34 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47812599
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 13:16:07 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-589878e5b37so2647397b3.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691525766; x=1692130566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/xgVgDQldulrbnAGgGM52zFRABP8JaS+P0PBA5CLmI=;
        b=WhPHwtRzLcoJ0OI+8j6uayRnvhc4IgLHvA5zf+x6Y/F7UJP/6tR/c36NZSHbtsIIxU
         gqSAoR5eX/Pnn6sxP6sRzUoAHn3iNaU13SQfjw9j8VAFhoAiwdi6N9U8nR2zgZO7ony3
         USp22UogbBFOp1Ce+xCqK0D2F5YDtKsbcP0OyD90JOZ5XX4mmSb19AIFBxMyfuZ1EdyK
         r9l/9ZXv9gK2nYEOQezhmMRI3AgXU0AolrgaTDzvbpR20Qt+csD1asVrbMgPsl5mql57
         fHWe0X5iyXSJQlc21f0nhNoRI6D0GQ8lwbGFbxrANyMJVgGAJATDh7GF5D/l4MRTnW6I
         6Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691525766; x=1692130566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/xgVgDQldulrbnAGgGM52zFRABP8JaS+P0PBA5CLmI=;
        b=VIfWdnOBOL6tIzEyshB7FpMzHPfRLL9UTYHb7q9gMJ7DA+D5NIDo6ThG106PAIAeV9
         UcD1pXBpspgC64VF3HgrVD8cIw+rl9uL+8KIdj9ic5Pcsat/72x9Ixf+QiTw6y3DAW/j
         Q/ylpA+PMXb3dzoM/T8nFqPrDLR7wwWwkDH2FNXzz3nEl+RMXBZqHnygOqYz5er+4c4t
         j00IZvM7LUVHNbKQ2S9j77DWdY5EIIK/zA/NjmJfP9YX4rrze3VVpibUyo2N825TxxKF
         ETLWnfkD8K0BeFR1QC7lyxndGRePBjoYULvKl0NXmyvgnnBVNbVkflcJxFtf04/KbX4M
         fN7w==
X-Gm-Message-State: AOJu0YyiBDfsBJ1PYvdzPrppyC+HThbjpAjTIQK5r0Jo39nPAmiZ7NMI
        MFR+68imMcfV/vPq6yRHEgYJmqtGGe1C9DGi7/u6Vg==
X-Google-Smtp-Source: AGHT+IGceu1gBEWi701OyeHgU/EEAtnlw4VFCanpxw0VHrgkJ1L2wj2A9S6iw+lQSx4VQUaKzx4GQQ==
X-Received: by 2002:a0d:c884:0:b0:57a:50ba:b3a0 with SMTP id k126-20020a0dc884000000b0057a50bab3a0mr805060ywd.12.1691525766652;
        Tue, 08 Aug 2023 13:16:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m15-20020a819e0f000000b005707f542f62sm3494161ywj.25.2023.08.08.13.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:16:06 -0700 (PDT)
Date:   Tue, 8 Aug 2023 16:16:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] send-email: avoid creating more than one
 Term::ReadLine object
Message-ID: <ZNKihfNbEqJcCkXX@nand.local>
References: <20230808180935.GA2096901@coredump.intra.peff.net>
 <20230808181531.GB2097200@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808181531.GB2097200@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 02:15:31PM -0400, Jeff King wrote:
> Every time git-send-email calls its ask() function to prompt the user,
> we call term(), which instantiates a new Term::ReadLine object. But in
> v1.46 of Term::ReadLine::Gnu (which provides the Term::ReadLine
> interface on some platforms), its constructor refuses to create a second
> instance[1]. So on systems with that version of the module, most
> git-send-email instances will fail (as we usually prompt for both "to"
> and "in-reply-to" unless the user provided them on the command line).

Nice one ;-). Everything you wrote here makes sense, as does
initializing the Term::ReadLine object only once.

> Note that the tests in t9001 detect this problem as-is, since the
> failure mode is for the program to die. But let's also beef up the
> "Prompting works" test to check that it correctly handles multiple
> inputs (if we had chosen to keep our FakeTerm hack in the previous
> commit, then the failure mode would be incorrectly ignoring prompts
> after the first).

Thanks for improving the test coverage while you're here.

Everything here LGTM.

Thanks,
Taylor
