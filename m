Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E6CC43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575C821531
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckMqs9QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgJHIYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 04:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgJHIYu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 04:24:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00677C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 01:24:49 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d1so4408168qtr.6
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQjPNDaKjFTTVHP7Xc4EUS65a7Jq/MEVNXRFlTcu88M=;
        b=ckMqs9QAyYpbP1z0XjzLheym5PLeMi2btlMLYN0lyd4B3gHmHXlOoCIZIFZVLyyJbm
         J+kKFVDAwosAc2udW0OFzXnmSKndmJVhhKkk72z/Kgn7mB5pDNFRkv3etkpTFBKmIpL7
         l7MskdBcOJQgxKSQlR4CsOX13TtbFX+NzoRJvsOWdjuu6W2xAK99TC8FFLJVC6Y6xfKc
         z7zg2dzswFmCZa5h7i2BRpAm02uk5Gv2g/JmTQ47G/LRH3cdXy1TuGTNGEAZ3dZW7I7Z
         Cr9vNmsFItrpYUF9KhoxLRb/PRF6F2XEgueyd/F1UhNd2snJ/RfPFd1kr9VY/OqAEQOe
         8rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQjPNDaKjFTTVHP7Xc4EUS65a7Jq/MEVNXRFlTcu88M=;
        b=WvJ+3ruwCsh/bOCxSlw4rmLTOgSOEtqYgmiY/04Ld3IlRw2ajJZihxHY1iV30nH8Qc
         vWaSwJYpkI6ySLa1NC5YeIHLjBDh6SY2QPL1LnSYrEIVssjihVOuKnwMAbwRFgozB9/i
         tC8nGKDpjsiw1LSeCsMm6qb3QcYNj1St0aTy61I27vdE7EIDeNjj/eKAQ6ruOveDQ4tu
         AIdYylIaHOsCzO8tcoe91XSIMD4JJM/ndVwd3NibfU7TR2oraqr5hk3iZ+MFji8yMrI3
         CqExbOuH7hPPKjDHWtAMGYD0fM3xjWm5AMM5rRtbql4LTiyKnzLRBZAe1LFlMno3XxAf
         RotQ==
X-Gm-Message-State: AOAM530YQ3ePlOkXvVvfshZzifIjPSjVphhBw0uhuQu4ILQxFQdNRG5S
        CAg/vealnIlqrdz3y843FxY=
X-Google-Smtp-Source: ABdhPJxjYMpKVRs48G4OeDo8wIZTK8agEt7lGO8Eo4VIoU8h9xQ2ePZXdFyuKsxCsyJCvoctJzQGug==
X-Received: by 2002:ac8:588e:: with SMTP id t14mr7070798qta.44.1602145489201;
        Thu, 08 Oct 2020 01:24:49 -0700 (PDT)
Received: from partizan.lan ([46.98.122.162])
        by smtp.gmail.com with ESMTPSA id j31sm3598352qtc.33.2020.10.08.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 01:24:48 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org, serg.partizan@gmail.com
Subject: Re: [PATCH] git-gui: Basic dark mode support
Date:   Thu,  8 Oct 2020 11:24:39 +0300
Message-Id: <20201008082439.6013-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007110751.237kem2mlnb7hbrk@yadavpratyush.com>
References: <20201007110751.237kem2mlnb7hbrk@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The commit message could be improved. It should first describe the 
> problem it is trying to solve, why it is worth solving, and then tell 
> the codebase to fix it. The details of how it is done can be learned 
> from the contents of the patch, so they are not as important.
> 
> How about the message below?
> 
>   The colors of some ttext widgets are hard-coded. These hard-coded 
>   colors are okay with a light theme but with a dark theme some widgets 
>   are dark colored and the hard-coded ones are still light. This defeats 
>   the purpose of applying the theme and makes the UI look very awkward.
> 
>   Remove the hard-coded colors in ttext calls and use colors from the 
>   theme for those widgets via Text.Background and Text.Foreground from 
>   the option database.
> 
>   Similarly, the highlighting for the currently selected file(s) in the 
>   "Staged Files" and "Unstaged Files" sections is also hard-coded. Pull 
>   the colors for that from the current theme to make sure it is in line 
>   with the rest of the theme colors.
> 
> No need to resend. I'll use this message when applying unless you have 
> any suggestions or objections.

I have no objections, please use this message.

I'll try to write better commit messages in the future.

--
Regards,
Serg Tereshchenko
