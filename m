Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C357C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D83760EB9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhHKEyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 00:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhHKEyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 00:54:08 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0765AC061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:53:45 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r19-20020a0568301353b029050aa53c3801so1976544otq.2
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=/PDW/vZZTzj34Egte2gVxJ5/zE0q+pxyiEa4RK77628=;
        b=r5OWG0RfwBkPa6eDKl6c9rHcKp1JXLtupbWmRoi9kMIM8etmyT0C1Nf12U+nI6IECh
         Odvqe5DAHZp2sLDPhJo8lwah8vF9/o0xDmC1oWhGxMxyr4XRWolTdUAnzeqlpzALD9Tu
         j+NJ2sGNHBYx/IDZlAQOi9jAVgP8HIu3W1wyOs3G6wAU1kF0SrwBWe/Gdyh4mFi5FV8U
         iSpkbAXnWVWOvSUHym+PDJCZiNUVVPMszE49d/XekuvkRnIzGOZso8jsAVtAgipvUIHO
         uts7SCMweIN41Cf1w6GbBn/53M2cWUQIQa4H66BOckBf29RCg8Al9buzBSIAyy8NP5jS
         VEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=/PDW/vZZTzj34Egte2gVxJ5/zE0q+pxyiEa4RK77628=;
        b=a/G0S2KROJccJhQOxG8s/1bu/OxlUKvcKpHaz3g5tvyNQBIeyjwon4aYmi/IlUEn73
         kustT8rD50VbUzX6bz56cr3VRfsIKdr0+//EUtX2lSV14u3mR6RxPl1ACNZtOisiiHjD
         z0m3PIzYW/Pq4UFhQIjv0wjR5f+TWbLIAxkKwp2+z1m3UAvGX7YCQwaX+MTua63fMAWa
         wtUCmhl5J4KfGOLnDQQ5GkDsyTBp99uCe1mnhWjxVGt0pFO/WynjfdTMzhqOnYbU3bEB
         4/GU/LlCu8ll+ZT8tvD/w83XPtNpz1PdSPtQVzIjVjQEHzcQPtBOiXquA0m8OEvyTUZM
         IUWw==
X-Gm-Message-State: AOAM533iuO4FJc/2u6qc5U3gYOuZ81rfUpcLYGb5P2FTlBMIezK4irk+
        Y0L+kXaARBqLHRNBregBPp6jGlMMRZfOXw==
X-Google-Smtp-Source: ABdhPJx8kz4G6QfMDp/thA8HWQarratbcFLEcph2bOgrtodOMOPBjNb7eJ9VEWG2TXb5vkkjA9bTNA==
X-Received: by 2002:a05:6830:9c8:: with SMTP id y8mr23269746ott.258.1628657624166;
        Tue, 10 Aug 2021 21:53:44 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id o20sm596486oov.39.2021.08.10.21.53.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 21:53:43 -0700 (PDT)
Date:   Tue, 10 Aug 2021 23:53:42 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <611357d6fdce_44d208fa@natae.notmuch>
Subject: Blog post: The git staging area, the term literally everyone agrees
 with
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I spent several man-hours re-reading 13 years of discussions regarding
the term "staging area", and I detailed everything I found on this blog
post.

Literally no one had a problem with the term "staging area", except one
person.

https://felipec.wordpress.com/2021/08/10/git-staging-area-rename/

-- 
Felipe Contreras
