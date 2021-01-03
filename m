Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BF3C433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 11:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC56D20780
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 11:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbhACL62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 06:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbhACL60 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 06:58:26 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1BCC061573
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 03:57:46 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id l207so28948523oib.4
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 03:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FEk4Q/YLO4NSBtwg3H5Vxeop6IkFu8qX5YL2RdyB/Vc=;
        b=RABSWywLWCErb9HBoZ3ivKsFN1ZBt627iSsitgLqaIXk0c/3wR+QYwbFkCsvJLNru3
         wAZhWwD4i3BFUQt3FVayFtoIDOiHcW47iJ91AI4fJXAabXRmuxJ+ss2RrmfiDfc2xZGa
         O79U2PNUsSMVthg3pKYdnOpKOCP5s8apKxbpddMZKam6/Od9PXfI+WG4YtcVnDo56aQK
         dREozjXz8/sOc3/A/BLAr0SGijajxAeRpLXzdVOvgULJdDStJL4VwZM8f+zkiO7SWvjL
         rO9SFq0rdnR7vZoQdK9ktS7JfWnhO1Pk7J/caneWyw7JDZd55F49MA4HAWAGN/5z4t7b
         t3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FEk4Q/YLO4NSBtwg3H5Vxeop6IkFu8qX5YL2RdyB/Vc=;
        b=lJRUPgGlDt401JOiVo+fwZkOfSM0Yd+T+dvkFpcfXMve8MK+8iToTvN3nFc3Z+1iX2
         qYSp70C2x/1GbGEmNN6FedHHmx+fWVSiNzk5rasU8YqXdgmzPOYVLcvFwF/vNnPldcvq
         i4ah2LCUzZKPTLSRnWg5LHw7Q62oSZFZd1Ya74oeceiNK7/+I88HB81rUnQdoRkO+tJY
         Pll4L/FaWAHxTN7H/F7UYge+STrvoAViV2jFzbTH/VqwhjeyC+nilL1Nof+DtPAN5RoA
         FARYJu7zfCZ8RqfsRACd0d4FJm7ij64SJVmjMSDC8I2wcYR0tD0I6CnIxirg8nejR+kn
         zSJw==
X-Gm-Message-State: AOAM5338z+DRFirT5MRvs/8v1B3JAMIZ6ggBFS0t2L9nVifHYMPJA6Eq
        YSEEvEDb3Y4YAko3MvkuMvi2Dmu4CzXUzA==
X-Google-Smtp-Source: ABdhPJxVquF3NKIOIFxHgTertyVAu9FFd9qiWADFabm1wXASKkRCTiIB/ERaASjBJJx+WS1SXlOMRA==
X-Received: by 2002:aca:4c1:: with SMTP id 184mr15891757oie.157.1609675066038;
        Sun, 03 Jan 2021 03:57:46 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v4sm12860456otk.50.2021.01.03.03.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 03:57:45 -0800 (PST)
Date:   Sun, 03 Jan 2021 05:57:43 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Yaroslav Nikitenko <metst13@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <5ff1b137e3eab_1c01e208a5@natae.notmuch>
In-Reply-To: <CA+RLzGCfqNdup1cmz3W4iBzbsxe9SD7E+Ju4svNFvhe6ohJqjA@mail.gmail.com>
References: <CA+RLzGCtp2T=8DG74geBs67X5vUvhwRP4FMZ6MJv+E+Pj=YbWw@mail.gmail.com>
 <5ff0c58422038_90dc208ea@natae.notmuch>
 <CA+RLzGArUrxC-Kbng3qGpRZUrZXKZj3zD3Hcut=XrUY-i-eYAw@mail.gmail.com>
 <5ff0ed59489bd_a76d2082f@natae.notmuch>
 <CA+RLzGCfqNdup1cmz3W4iBzbsxe9SD7E+Ju4svNFvhe6ohJqjA@mail.gmail.com>
Subject: Re: git-dir requires work-tree; documentation improvements for
 working directory
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Nikitenko wrote:
> However, I think that this is a bug in the implementation or the
> documentation. It's not highlighted anywhere that the repository must
> be non-bare for git-dir to work without explicit work-tree (an
> opposite is stated in general).

core.bare=true means no work-tree, so to me that behavior follows from
the documentation. But others might disagree.

> Should I write a letter with [BUG] in its header for that to be noticed?

The mailing list is a little more quite than usual, probably due to the
holidays.

If nobody else responds in a week, try again.

Cheers.

-- 
Felipe Contreras
