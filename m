Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDF7C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD8761108
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhIHKmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbhIHKme (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 06:42:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D015AC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 03:41:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i21so3236160ejd.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TF7JOQTC6s8F8fClBtucTgOG/uEoYnVSDlUytjwAbpg=;
        b=gAWFNQWa/tRWvFLNLh1H/MHHZ7ta3ey9CKPZQdmved3hJD7WZyIm+5JtYxAi63quZ2
         9zFOXZ/HAkWFZyuFz5FhNpF8r73ZopbKxGK1cZOgicj+TQc1olF3QY0RctJ2M+B8eMnI
         uSgf5TUua+n/sHI/Z3z48S/+XMzrPE3m/A5Wqb2wPjGdNGl1x3gyEkrAQ0f5IpHud8JJ
         gJ8n2A5NBqIvov4ljT2gRxXdJD9opM+qH2t7eGPB/xeUP+2jTRLbpNXDFnC3WywDg2/Y
         JVNMdK+qlphMv4eaVJ8kGYuwuN/mmiaxfOhvRgOWdhhv5A280C0XxzpDQGUPHEmB7tbl
         1zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TF7JOQTC6s8F8fClBtucTgOG/uEoYnVSDlUytjwAbpg=;
        b=InVEy04XQlps9yj9yLtF78w6GuGTOgfsCUhO4n5SG1rCZ1l2zcN40WrpsUGFtc0e6C
         jJEgnv//8r70wQR4X9Ham9q8/0T41aqpvOuuOy0/ZUb/sVDA5h3eLvYSv2WX5O55+K0M
         vE4/C72Qqh86a0TfAySqegPmNrQYrjmd9XaSLPKfV1tLkHX2CsnklG7Sk7rlqeq4DVvi
         6GlRa92a250b6oueDVq0AQE+DvgqqBDVQKxUe3QbaGbkZ+cUD8zc9/LB04cOlmHSbE5O
         YwI54LQr6D8ouJC0kYb/pNXV2fKry8ystoTrzmm+r03n5Q+Z7joZG4crTbgqE6i90ozf
         lw5A==
X-Gm-Message-State: AOAM530a++/8YL0eaLG+U94F4n5Oi+u4dnUNGXC4MNANmUV0gPeA489c
        WTMgGhXdX+oUemt4kemXlnvnQP/TqLm4mw==
X-Google-Smtp-Source: ABdhPJzt8RFgJTvveMVqnTw1rAwATnv+Bz2ZPfISFIEI3Uqn2A+xGh4w1xOrmt4iOOAwzFW5xPdEHg==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr3245815ejc.188.1631097684915;
        Wed, 08 Sep 2021 03:41:24 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 6sm483501ejx.82.2021.09.08.03.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 03:41:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 01/11] t3407: run tests in $TEST_DIRECTORY
Date:   Wed, 08 Sep 2021 12:41:15 +0200
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <0f5992e8caba424e484524252a303a00e108df34.1631094563.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <0f5992e8caba424e484524252a303a00e108df34.1631094563.git.gitgitgadget@gmail.com>
Message-ID: <87ee9zic30.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Commit 97b88dd58c ("git-rebase.sh: Fix --merge --abort failures when
> path contains whitespace", 2008-05-04) started running these tests in
> a subdirectory with a space in its name. At that time $TEST_DIRECTORY
> did not contain a space but shortly after in 4a7aaccd83 ("Rename the
> test trash directory to contain spaces.", 2008-05-04) $TEST_DIRECTORY
> was changed to contain a space so we no longer need to run these tests
> in a subdirectory.

Well spotted & a nice cleanup!
