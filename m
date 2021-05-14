Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0B7C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 22:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7E961440
	for <git@archiver.kernel.org>; Fri, 14 May 2021 22:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhENWIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 18:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhENWIv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 18:08:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4C8C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 15:07:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m124so289390pgm.13
        for <git@vger.kernel.org>; Fri, 14 May 2021 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GjBdSFfKo6FlDcR+UErNTabkjkR7Fk1F1f86ZG06kdY=;
        b=aUA6nrNQpS43LYyCh0/603IrDGcSlZz5nDoGCfGL8qbuh0KVmTsO4Bx2UO88rEt9Ed
         3xPT3nkyeFcH0MXondKqKzEMqu+0XNFQKUrz5glVEY7VJ4y9bHzuv7ICdXurjy527Hxe
         xVx+OPk2mRqCjCpqMenJk5waXBcUVMRH4uCp5GagTZpsKulLzfL1QMksIJ3vHH8VwiSB
         5Ib4GHjDMEfEwWwLsGoUif9zYF+bjB3STBbgF+fQiRe6rErd10hwAgY2x/EWO1bE1QpR
         fYwiwNPIOMo9UH6QvJe0p3Zdtornce5eCp9Dqcb5W/Zr11NaCZANzj9+WEhG6a5ZBmvB
         GG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GjBdSFfKo6FlDcR+UErNTabkjkR7Fk1F1f86ZG06kdY=;
        b=GLGLYHWZZTe+XzY68/IYSNkh5zDkHEeICL1bWhW3G5up35xNqPws+K+3ockyqt2lru
         ITFTsSp4FKUuEBXqQdpB8L2nIVBGr/b4X5r+4I2pc+KCtAFeqpxImxgbCHH/PaVdDA5C
         E26LC55ij92IqgIaBqkP71ANDFkH++1e3oJ+D90M+VdZyH+zpyokNPIJYxFU5qT9D6HP
         RYz0co6UJtpdXHwGfpGOGud+Ts02tcdvFauCTp3GiapksSOzSxRFBK0AX/QKocMqJnrW
         3HqVS+9WMmDBT3kXe7jDlPL7GCeZmG6OCN41TExaG56kFoSc4a47su+lOmzHBwW0uoXB
         J/Ng==
X-Gm-Message-State: AOAM531iSD6zNy7RscAXWUC0z+yWi5nEPWaQgsM/VcANe8VCUkxk5jb3
        nb+NJVbOc2i9mQbXzyJDlVvYc6YwIAcs+A==
X-Google-Smtp-Source: ABdhPJydXHytIEtfulKkOJIihP40/XkjGLo0OHaW2GSlng4LKiCzvs2EX+I22OJ/vqFcYBCMIxpBpw==
X-Received: by 2002:a63:eb47:: with SMTP id b7mr21817005pgk.227.1621030058879;
        Fri, 14 May 2021 15:07:38 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:be08:fb62:598a:3497])
        by smtp.gmail.com with ESMTPSA id p65sm674426pfb.62.2021.05.14.15.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 15:07:38 -0700 (PDT)
Date:   Fri, 14 May 2021 15:07:33 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tr2: log parent process name
Message-ID: <YJ70pQCuvz1chbrS@google.com>
References: <20210507002908.1495061-1-emilyshaffer@google.com>
 <1cae0717-745b-5e3a-fadc-3966da00d80c@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cae0717-745b-5e3a-fadc-3966da00d80c@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 01:28:39PM -0400, Jeff Hostetler wrote:
> 
> 
> 
> On 5/6/21 8:29 PM, Emily Shaffer wrote:
> > It can be useful to tell who invoked Git - was it invoked manually by a
> > user via CLI or script? By an IDE? Knowing where the Git invocation came
> > from can help with debugging to isolate where the problem came from.
> > 
> > Unfortunately, there's no cross-platform reliable way to gather the name
> > of the parent process. If procfs is present, we can use that; otherwise
> > we will need to discover the name another way. However, the process ID
> > should be sufficient regardless of platform.
> > 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > We briefly discussed hiding this behind a config, internally. However, I
> > wanted to include the parent name alongside the cmd_start event, which
> > happens very early (maybe before config gathering?).
> > 
> > Maybe it's better to log the parent_name as its own event, since it
> > shouldn't change over the lifetime of the process?
> > 
> > procfs is very non-portable, though - I think this won't even work on
> > MacOS. So I'm curious if anybody has better suggestions for how to do
> > this.
> > 
> >   - Emily
> 
> 
> Look at `trace2_collect_process_info()` in `trace2.h` and
> `compat/win32/trace2_win32_process_info.c`.
> 
> That function is designed to let the process call out to
> platform-specific code to do things like getting the name
> of the invoking process.
> 
> It is called with an enum to indicate when/why it is being
> called.
> 
> On Windows, I have platform code to get the process ancestry,
> the peak VM usage, and whether the process is being debugged.
> Two of those were easy....  And all are very platform-specific.
> 
> They all generate events of the form:
> 
> 	trace2_data_*("process", "windows/<something>", ...)
> 
> Some of my `t021[012]/` helper scripts exclude "process" category
> messages from the output to make the t*.sh tests portable.
> 
> 
> To implement a /proc lookup as you have suggested, I would
> fixup the Makefile or config.mak.uname to include something
> like a "HAVE_..." feature and then use that at the
> bottom of trace2.h to declare a trace2_collect_process_info()
> function and then have your code in compat/procinfo.c hide
> behind my interface.
> 
> Your code should emits events of the form:
> 
> 	trace2_data_*("process", "linux/<something>", ...)
> 
> I notice there are several `PROCFS_*` symbols currently defined
> in `config.mak.uname` so maybe this should be:
> 
> 	trace2_data_*("process", "procfs/<something>", ...)
> 
> (I'm not sure how similar code for Linux and the various BSD
> versions would be.)

Thanks a bunch for the pointers - this is great.

 - Emily
