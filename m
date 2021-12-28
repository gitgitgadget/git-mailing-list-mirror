Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FFEC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 10:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbhL1Kza (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 05:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbhL1Kz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 05:55:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B25C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 02:55:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso6154416wmi.0
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 02:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wOhkwbaExjKh/TXORVAXkzzQrWBSM7NvQv4aQAvYkwQ=;
        b=fs6Gu5u+edatcgl2igsfOo7Z0qwPbN71ixiXfVBDy/yf6DBpChDAgasYYbPsvbdBtp
         M8teanPHMbgznOVRMf3UEP8omPN6jgpuB93m1mextBEHLc5YXh1ORNyqVfwniVDbn3tr
         1rd9oAtxWXw9MZYa04uQQtY1ig45wPWz6tFAqhls7Yg3P38auufKylW+tuCVBHKeMYlL
         vEwWok7JCI0a3vzghrn0ZV1ZlXwXO9NjWdUMLuWjOPG8n/cXTX4eRLkyCN4Np5q9KSdN
         ccXXNoxPndcG9wjIEB6lnuA/v74C59Ge/5nzxFRaaPcofG2Eu+fxVLgjRdyrNhlAXjJ2
         U0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOhkwbaExjKh/TXORVAXkzzQrWBSM7NvQv4aQAvYkwQ=;
        b=ZNjt8TAs7JDhCeWxrRRNfk/ImqjQ2TTi2JPfK0yDqQJEfoKJb5c2KqaYVtEqrysKZS
         iXXxUsUQCQMPXhYEzGAYR5rIljLRA1HhCY5eFhJQ/4YzSh5ixZeAidCiUricYpU3K075
         TL9sCDgf2wknU4p4203ae8c4B/gopNrgINAeGav+xUrovLvmB26MOaVQAxqlNWpk9zRI
         1LHvk+S4oRaOyTJFFxXFuvJKNOIpDFle82u7TN9Vbwv9AsJUupbNzwLE+rzCTvVfbYo0
         pNL3tI8j1XH5ShquWXLyhvcX+soFfx50LG02C2KgRkrE4H17tquf3iorFk+Ehj+nB63I
         1a5g==
X-Gm-Message-State: AOAM532NGC6oK6Np9bUKpo2o28nHfZ7rrwoYEtHDCFe5DWkfl0pmueeq
        Bd/Xnxa7rXa0mQlh4LN/29mhgQehRGPZXQ==
X-Google-Smtp-Source: ABdhPJwb6unBZK9MDkh3AGPERsViXnzI3B9JQj9hLBymK0dq7uoABLq1zoZq2u029O6ZnEgTx3cGzg==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr16891158wmf.187.1640688925804;
        Tue, 28 Dec 2021 02:55:25 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id m15sm20381971wrw.27.2021.12.28.02.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:55:25 -0800 (PST)
Date:   Tue, 28 Dec 2021 11:55:22 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH v2 0/8] Add a new --remerge-diff capability to show & log
Message-ID: <20211228105522.634k3ovahty773vz@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 25, 2021 at 07:59:11AM +0000, Elijah Newren via GitGitGadget wrote:
> Here are some example commits you can try this out on (with git show
> --remerge-diff $COMMIT):
> 
>  * git.git conflicted merge: 07601b5b36
>  * git.git non-conflicted change: bf04590ecd
>  * linux.git conflicted merge: eab3540562fb
>  * linux.git non-conflicted change: 223cea6a4f05
> 
> Many more can be found by just running git log --merges --remerge-diff in
> your repository of choice and searching for diffs (most merges tend to be
> clean and unmodified and thus produce no diff but a search of '^diff' in the
> log output tends to find the examples nicely).
> 
> Some basic high level details about this new option:
> 
>  * This option is most naturally compared to --cc, though the output seems
>    to be much more understandable to most users than --cc output.

Agreed. --cc is *simple* but I'm more comfortable reading conflict markers
from --remerge-diff, since I'm used to that.  So at least for content
conflicts it looks simpler.
