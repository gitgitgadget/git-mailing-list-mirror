Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C246DC5519F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF8722240
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryD8xCVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgKSADm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 19:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgKSADm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 19:03:42 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9614C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 16:03:40 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id v21so670245plo.12
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 16:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=10HYDlYOQOvyTwx7ZtRfhxnjCXzvThMbt7BtkDHeDIQ=;
        b=ryD8xCVCXweHPSiUK2zKiL/eDM1k2tWH0lpmbxc1ncI9DDBKU3ypQXcc9PrhYENxog
         F/xMbyICGr9JIXT1GtLHVgl7xeu1DOJQfRl6R68GH16qPAyj6q3N/gP7gnbgVPVj75Lm
         ira6IeSBui6Dxtp1pymEDZMkTW88iEjjshcYcoVkJiQVe7S6OQal4wwbhwPhSyuaPtQT
         50hVM2hlDQGhedYwVHMLumLfLt5eMF9pkFqoSuG21iF/nULsLY2OLnb1XbfHLsWR5oIV
         UMKrw6zvcIlJY8NhgcHB6FqdIeI+vuwwuQpa4U80U6rF7zGu29xy+S9icyHmvmpSkpxJ
         X8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=10HYDlYOQOvyTwx7ZtRfhxnjCXzvThMbt7BtkDHeDIQ=;
        b=JAmjAxrD9kBW7Eabdf/LkvFgqZ8l/hz0ihkB2R30gpMzn3fZvCNgFXc9M0vLviD8ff
         YbQCnXl1T3vmDIGYX8QY9aVaxsmdZ7H5k6xYUafe0Tj5Z6kXgw49QTex7mrqCvAzdnIU
         1DXRultB/9xsOS7D9yxbZbIsDx9HVX7Ms0hzXwYgqovVzD396TDaX8wJYlmIQzQj3G3v
         kz1EROjHIEM1xMAuRmStQVq74VKopvPS4bd2mdyzliVDDTSjs8yCFGvsnQlcpHMchw16
         mfbhA1OnvOaC4PAUAWs6RIHWeF7WbnjGsNRMO2MLxKnbwIeGRqDMDDn62VlAZYmssFj+
         cOTw==
X-Gm-Message-State: AOAM5319TdulwXEAEUg/GljNJoMGlaBf1zPUfNcbqgpyci9Ff2duyat2
        H6OQp4qIC8J6jPvapFwSd86+6Q==
X-Google-Smtp-Source: ABdhPJxtinuet1vfBhgPI/FRWZIjcXaNCUXwO8SiWZ+raxC0uAIVwjOxgR2Pxjpz9GtSLYpgstpXXw==
X-Received: by 2002:a17:902:b7c6:b029:d8:e447:f7ef with SMTP id v6-20020a170902b7c6b02900d8e447f7efmr6213150plz.1.1605744219947;
        Wed, 18 Nov 2020 16:03:39 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id s6sm28232011pfh.9.2020.11.18.16.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 16:03:38 -0800 (PST)
Date:   Wed, 18 Nov 2020 16:03:33 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com
Subject: Re: [PATCH v2 0/3] submodule: port subcommand add from shell to C
Message-ID: <20201119000333.GI36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com
References: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

Thank you for this series! Please see the comments below:


On 2020.10.07 13:15, Shourya Shukla wrote:
> Hello all,
> 
> This is the v2 of the patch with the same title, delivered more than a
> month ago as a part of my GSoC. Link to v1:
> https://lore.kernel.org/git/20200824090359.403944-1-shouryashukla.oo@gmail.com/

Since GSoC has ended for the year, I wanted to point out the
git-mentoring@googlegroups.com list, where you can find additional
mentors if you like.

> The changelog is as follows:
> 
>     1. Introduce PATCH[1/3](dir: change the scope of function
>        'directory_exists_in_index()', 2020-10-06). This was done since
>        the above mentioned function will be used in the patch that
>        follows.
> 
>     2. There are multiple changes in this commit:
> 
>             A. Improve the part which checks if the 'path' given as
>                argument exists or not. Implementing Kaartic's
>                suggestions on the patch, I had to make sure that the
>                case for checking if the path has tracked contents or
>                not also works.
> 
>             B. Also, wrap the aforementioned segment in a function
>                since it became very long. The function is called
>                'check_sm_exists()'.
> 
>             C. Also, use the function 'is_nonbare_repository_dir()'
>                instead of 'is_directory()' when trying to resolve
>                gitlink.
> 
>             D. Append keyword 'fatal' in front of the expected output of
>                test t7400.6 since the command die()s out in case of
>                absence of commits in a submodule.
> 
>             E. Remove the extra `#include "dir.h"` from
>                'submodule--helper.c'.
> 
>     3. Introduce PATCH[3/3] (t7400: add test to check 'submodule add'
>        for tracked paths, 2020-10-07). Kaartic pointed out that a test
>        for path with tracked contents did not exist and hence it was
>        necessary to write one. Therefore, this commit introduces a new
>        test 't7400.18: submodule add to path with tracked contents
>        fails'.

Generally, we want to avoid describing in detail what the code does;
hopefully, the code can speak for itself. It may be a better use of the
cover letter to describe the motivation for the series as a whole.
Reviewers will not necessarily have background on what you want to
accomplish. We came up with a few factors that might have inspired this
change, but we're not sure which you intended to address:

* Increase efficiency by reducing the number of processes forked and the
  use of the shell.

* Make the submodule code easier to maintain (since the project probably
  has more C experts than shell experts).

* Improve the user experience with submodules by giving the
  submodule-add code access to C internals, and vice versa.

Knowing what you want to accomplish can make it easier for reviewers. Of
course, you'll also want to include important context in your commit
messages as well, so that it's available in the history if future
debugging is necessary.


Thanks again for the series, and please feel free to follow up if you
have any questions
-- Josh
