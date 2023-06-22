Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09B0EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 12:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjFVMnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 08:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFVMnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 08:43:23 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F471BD4
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:43:20 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-561b7729a12so8722617b3.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687437800; x=1690029800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itqsnc4otAZOu70qau49igAHlxB9U76mfRXVYvQ7/L8=;
        b=35kpOSJXXt7glJ6gXekV199Ilm6f8YbsHxA9h2QKLfA7EK10sNzONNlRUiYSSekG/S
         QZJ3u9qmyg6JQBujgjZ1qBe7m9hO+rZfL5x2LtFsyBvHD166Wff+YB9ngpxf1hMyObD8
         ChmtdTfVoXf59PTbhLUJAP1P6323HqK6haIfJFOaUFP22OoUuheMUpVOLYBmiSIQ7DQB
         gW5cUDtOJZ6JFIPhwPH8yhZlrwgD7kH4GCqrYWtvDRek99yX8GXXXeOoO3IehXlBpGeN
         ertPt5pldVwvDpraW2aHzv/T+i/UfQ8f2YfU9b9OOSZWXuMAUZXPpBGPCsbdsrEGT496
         tjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687437800; x=1690029800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itqsnc4otAZOu70qau49igAHlxB9U76mfRXVYvQ7/L8=;
        b=gyuLh3wX6/c2vOwlsqQGr8jG04ho1Y268VKRGSeSJfVUMCm1vNQve4AXz8e6mnSIGr
         RByHDXoDhUedSY0NVqWU7zlnyuLrFhZz9epxqIYB7Xja58Z/sTgvtKG+h/xdGm25Ap9x
         og01o7vihQi9OAIzmB78/0jbL8qxjIY0A7HG/8+j/TF8ANddNXU9cbRZ/h9lbMSvb1IT
         iZAtHFxFsOs/ywLHTscU1BwTT3n7Y4rdmX6LqRdXnDr7EoElhvzUQpsqNK3omG4fqVVg
         4+j2sN7UZAU3pRwF0UZvzTWWRQsibUTLRX0r16Pzt38FnNuiMknYulsnh1JBpOkMEddb
         Hgow==
X-Gm-Message-State: AC+VfDwDnlNlu9fZYJd241uG0nIqq4i4xyAxGqt0ETwxx5ETwPoXL3JZ
        Es+2WBD2zoRasYNjh4iRRbYL0A==
X-Google-Smtp-Source: ACHHUZ5yeAN6OxsW7hj9Y9YnynZdJicMRyqctPKrXiijC4kFnEGM6lsPJWFMgzNSYS2eXurBjJpYnA==
X-Received: by 2002:a81:4f92:0:b0:56d:708:e3b0 with SMTP id d140-20020a814f92000000b0056d0708e3b0mr28339728ywb.22.1687437799931;
        Thu, 22 Jun 2023 05:43:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x204-20020a0dd5d5000000b0056d33f253fcsm1818548ywd.35.2023.06.22.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:43:19 -0700 (PDT)
Date:   Thu, 22 Jun 2023 08:43:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] revision: rename ref_excludes to ref_visibility
Message-ID: <ZJRB5GSsFcdc/m+n@nand.local>
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
 <43e88a945226e1e08f2bd1a2bdebebda09cd6ec8.1687376112.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43e88a945226e1e08f2bd1a2bdebebda09cd6ec8.1687376112.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 07:35:10PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>
> The ref_exclusions API provides the ability to check if certain refs are
> to be excluded. We can easily extend this API to check if certain refs
> are included, which [1] considered when teaching git-pack-refs the
> ability to specify not only refs to exclude but ones to include.
>
> A subsequent commit will actuall extend the API to add the ability to
> keep track of ref inclusions. As a preparatory patch, rename
>  ref_exclusions to ref_visibility.

Skimming through this patch, it looks like a straight-forward rename
that doesn't change any functionality. I think other readers may benefit
from a note that says something to that effect.

> ---
>  builtin/pack-refs.c       |  6 ++--
>  builtin/rev-parse.c       | 18 +++++-----
>  refs.h                    |  2 +-
>  refs/files-backend.c      |  2 +-
>  revision.c                | 72 +++++++++++++++++++--------------------
>  revision.h                | 18 +++++-----
>  t/helper/test-ref-store.c |  4 +--
>  7 files changed, 61 insertions(+), 61 deletions(-)

Obviously all of this looks OK.

Thanks,
Taylor
