Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C855CC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13D160F35
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhHKWEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 18:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhHKWEC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 18:04:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD74C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 15:03:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso7334200pjy.5
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pS77DrTMdOv63SlHAFI2I9tnfLjou4qIfh3QiR1WiBU=;
        b=lOCcGYp1+4x2o8rYvg0vGKMy9mO7iYai/Wt56byXph4N6ejnOzbi0nuxvYCL1QBe5Y
         r5jtqplkyBpVgjaOWLYg9bXIZ8uioSPAt3NYbwNNzMRZmqOFubd9B98xR1Jp4NuGn+Me
         DLmH5QK7y5OGLfILMi3A7owZqz+dvzXhJF20Z9cUcTVRMbNtEo2rvIWUqsTNgRF7aXbM
         QPlqKNJTAIYqDHV84rmvBEBIE7iNwsHxMD/b3G/nnxS7P5jbL57gNA5gcjZFwkB8Cwrr
         tAMpapnjr50wZpto5CSL6rlcpyCfKJmh+VVhlFX3jeuOiOScBoLTnF0/90NCPZLAHf5L
         3VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pS77DrTMdOv63SlHAFI2I9tnfLjou4qIfh3QiR1WiBU=;
        b=AQcSyDUVFo6dtacyG8ygtkDPRzvWLbcZyLywb3NZzO/3jBfa1UwkRX3ybA131N2YD8
         jUq4MMZO4Fsq2HlncTyi6ykyWBlc8OaubCCP/ZKiguDJ7gi5+R/1d+wML8pv6b/oKbtV
         ObMJpoUBo9Bqhq67mKgcuLVJBmDq9jI268lM8LA1LS+/pzauYl++JAm2UV611q/04NsI
         jW4UNe6Ok0X3RNL1xXlq4dpU5hZI8VTqQCVJ6qlDKNhJh/yHUAO5dB4QXl5L7zWu8Evx
         gLWY7EwnwW4HlNM/f0FevHBX3n6S1ynh1HIhzkWpbuh2/wppI/soQ0+vkEF33OFFArPa
         Cy+w==
X-Gm-Message-State: AOAM531MrM1jLPWdx0kn0UjsyLCez16hk8VQBFOZmEWi+XWxzTwfT2lG
        Z7QWMUJUkx/s+l5aWs+qpVxZxDgcIYgNvA==
X-Google-Smtp-Source: ABdhPJy+C4tS4VyATFEER+SMEoKb+/6QiV0ytqquIVnjgSJQ03z0/5umeIQ7vMjzD+GBf4lP+ZOkmQ==
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr8089005pju.51.1628719418002;
        Wed, 11 Aug 2021 15:03:38 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
        by smtp.gmail.com with ESMTPSA id g2sm538420pfi.211.2021.08.11.15.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 15:03:37 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:03:29 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Gerhard Buch <Gerhard.Buch@web.de>
Cc:     git@vger.kernel.org
Subject: Re: Git GUI does not start
Message-ID: <YRRJMexgc3TTTN2X@google.com>
References: <trinity-1ab86a7f-c1b8-4934-9b31-861a78e15889-1628689643260@3c-app-webde-bap05>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-1ab86a7f-c1b8-4934-9b31-861a78e15889-1628689643260@3c-app-webde-bap05>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 03:47:23PM +0200, Gerhard Buch wrote:
> 
> Hi,
> 
> Git GUI does not start any more and I'd like to share the bugreport below. Any idea how I can get diagnostic information to find die problem?
> 
> best regards
> 
> Gerhard

FWIW, we also received a user report that this is happening on MacOS,
looks like also related to something wrong with this Wish dependency:

"""
Getting the following error when running git gui command on terminal.

$ git gui

/usr/local/git/git-388133509.245/libexec/git-core/git-gui: line 8:
/usr/local/git/git-388133509.245/share/git-gui/lib/Git Gui.app/Contents/MacOS/Wish: No such file or directory
/usr/local/git/git-388133509.245/libexec/git-core/git-gui: line 8: exec:
/usr/local/git/git-388133509.245/share/git-gui/lib/Git Gui.app/Contents/MacOS/Wish: cannot execute: No such file or directory
"""

Seems like we had this problem with our MacOS release some years ago
too, but I don't see much useful info on that years-old report about how
we fixed it last time...

> 
> 
> --------------------------------------------
> What did you do before the bug happened? (Steps to reproduce your issue)
> Open Git GUI -> choose open existing projekt
> It worked with the previsous version 2.28 before. Before posting the bugreport I updated to the most recent version to be at the latest version.
> 
> What did you expect to happen? (Expected behavior)
> That Git GUI opens...
> 
> What happened instead? (Actual behavior)
> Git GUI icon appears in task bar, but not the usual Git GUI window.
> On left click on the task bar icon, the top entry says Wish Application. On choosing this entry two Windows appear.
> One is empty. The second is titled "Konsole" and has (System32) 1% in the field below the menu bar.
> What's different between what you expected and what actually happened?
> Git Gui does not start and there is no indication on possible reasons for this.
> 
> Anything else you want to add:
> I've checked the project directory with git cmd:
> git status:
> On branch <branch name>
> nothing to commit, working tree clean
> 
> 
> [System Info]
> git version:
> git version 2.32.0.windows.2
> cpu: x86_64
> built from commit: 3d45ac813c4adf97fe3733c1f763ab6617d5add5
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 17763
> compiler info: gnuc: 10.3
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
> [Enabled Hooks]
> 

As for the 'git-bugreport' contents here, I wonder if we should be
including diagnostic infos about git-gui. I'm not very familiar with
git-gui so I'm not sure what would be useful, though...

 - Emily
