Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F338EC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 22:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiKKWnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKKWnv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 17:43:51 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFEC5BD77
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:43:50 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id l6so3209858ilq.3
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d43hLrzdzGuSKQeO4bUPmW96+RY3/11YSqbazOxnphE=;
        b=z6j1cUXKP4SdG4Am3YN71PSUbf7Vtgw+YBmub1QXRxcq0WSnSxiJ1QpwU/ACOWDh1V
         KZfoodeVsBBLjtVSJKWSx2cI+W0eZ/FOxyn0SW2J7RrBt5uh4MtV9+shQvCQAlszZfdc
         udvnSVJfKbTPbzWS7YmNfq9ccRey1QchcyjjO5t7rc6/VgbuuRe6J1gVJY1XTIeiBdre
         6tJTLeCKmPa9+zRm2j6myepU1odiaEdtpiVAxo2Yka5CQXlec9Ogv9PVLlFq/NNgY1uD
         3RmhpM/stztnOUCUvPIzxeXa+kMBAoRr3U1LxEL3NNxwfzjPajj17kFfblF03ChJZl6m
         8wfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d43hLrzdzGuSKQeO4bUPmW96+RY3/11YSqbazOxnphE=;
        b=q5sxGUR1AJv/NBFQqCgyUlbgYaExcgBVwDoPSD4mOpZtAhj2GqmpFbKndMxLyqDT1k
         grFL8KbXrOSwHqcFx3rzFZzvTY9ciqbaj8n0V9bRV/dhaxFp/aXgQ++P9bmC4veLj1jO
         5p4/N3Y0MeX20pZwNt1eCjwXu2hrDlGEx5DIMhih5zFRVqZH4238jnj29MQHxMy8qPnO
         PNb1NomfHAFrmj1hN7rbHwda39hHx2tLWSGDlBo9lZwAMn0/s5uE1OhkaoqrxC6Asaf4
         qna5Z12zkPZl2r+uF7Q8z8eesGfYcMart7d8bEcimNMsxCsdhvjWl+cyu88xZVAUEFjE
         AWXg==
X-Gm-Message-State: ANoB5plJGtaqT7sv9IaO8SQ+z2H38zMVqW4tVg86YoHLOLCOVkLp+Ttv
        KGnq1iQKT+LS2vjp+nTUktHJlA==
X-Google-Smtp-Source: AA0mqf76DbF7oS12gG/P1eDsLe7nkOqI9uP/r69rIj5kiJLtpn0Jj0ssrHPYxJuvJ8PNDirV8Vngcg==
X-Received: by 2002:a05:6e02:34a0:b0:302:489c:669 with SMTP id bp32-20020a056e0234a000b00302489c0669mr916736ilb.135.1668206629616;
        Fri, 11 Nov 2022 14:43:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z26-20020a05663822ba00b00363ec4dcaacsm1225153jas.22.2022.11.11.14.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:43:49 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:43:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        me@ttaylor.com
Subject: Re: [PATCH] maintenance: improve error reporting for unregister
Message-ID: <Y27QJNZWF41Kp04W@nand.local>
References: <20221110225310.7488-1-ronan@rjp.ie>
 <Y224GSbupvWD8mu/@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y224GSbupvWD8mu/@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 09:48:57PM -0500, Taylor Blau wrote:
> On Thu, Nov 10, 2022 at 03:53:10PM -0700, Ronan Pigott wrote:
> >  Documentation/git-maintenance.txt |  2 +-
> >  builtin/gc.c                      | 22 ++++++++++++++--------
> >  t/t7900-maintenance.sh            |  6 +++++-
> >  3 files changed, 20 insertions(+), 10 deletions(-)
>
> Thanks, this looks pretty reasonable to me. Let's make sure Stolee has a
> look, too.

Actually, scratch that -- I missed a couple of important things that
I'll point out inline in the patch above. Sorry about that.


Thanks,
Taylor
