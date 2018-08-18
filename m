Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242DF1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 22:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeHSBmq (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 21:42:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37726 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeHSBmq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 21:42:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so9935131wrr.4
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8EKcKXfEuxJx2SNpnJOC6EIx7qSYOiDvgI6IILfMhGc=;
        b=ghXlPu4zQgRg30botZKXFrl3M3COvWM5l5EGpQtTMCP0RTOsoruYIyHP+Wziyqsl6Q
         EniEm1nPQsWoenhOtg03it8qTd03a7lU7ceynZVRxD8ytEz1dfIMgJ790mBTmLVIjUJ5
         AzzxhfNuYDgKf5ZFoCWhucvlgDoSHs/ekNacO4YKZ08LZ81NYrWr2a+STJWrrAHU3zij
         uN+M5bHQ7Z5d+3yBQFzdieed5nRa19NUwf4RizwUx5Sbrm/mQtZ7pZFm/9ZffmTkZvRo
         d9k4wf3eq631Q4+R6i0spvzCLTF3U5dfocPWpB5PbNc1YNjR9Dnb4Q6hVuA3GHF1MovS
         oKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8EKcKXfEuxJx2SNpnJOC6EIx7qSYOiDvgI6IILfMhGc=;
        b=rdXlBYl2wvHwVUO0eyufat6OMfbxO6tySuMwCPAakQuXgMHc8QNoDuQZHrpvLAywoo
         E29q7sIp91UjZfahZTltGM2nFGBOJ/0Cb53umdbRZDPHQwmnLwVgjosq2zKiiW9Znyas
         NCzHszb2MLoUY3W4ipMYyqCa41jxvHq6/A8OowULVhaugREmei1954V0qln0qjPgYcL3
         cMov808FhL2nK0AvYsMCAPg4wxlzLsnV/dRppZjuGE3DL2gr/ioiW4zbJ8prxGpjENA1
         RMXhDm7CGGux70b/UQSHO8QUSuepZHEsFSb4anGY2LX+4ZxLzsL2Ubkevo8n4lV/6Wab
         z6gQ==
X-Gm-Message-State: AOUpUlGDYiqZJUPixDEp7k59PTk4MIaXBZI/7XPVxPY/lNo4yrAyyZvo
        EvUGO/DknhCrd33ikLFLRvs=
X-Google-Smtp-Source: AA+uWPy1BOYIPNYHTJQBiTdkwVAJrsAIBJWEnyqvGYHFb8AXPuEBLzPPwLYnUiN+3j0QiKiUdAIiRg==
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr26529056wrs.171.1534631611100;
        Sat, 18 Aug 2018 15:33:31 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id a184-v6sm8826785wmh.41.2018.08.18.15.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 15:33:30 -0700 (PDT)
Date:   Sat, 18 Aug 2018 23:33:29 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 24/26] stash: optimize `get_untracked_files()`
 and `check_changes()`
Message-ID: <20180818223329.GJ11326@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <9bde85eacb94db54763aab35efe287c5af7c8316.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bde85eacb94db54763aab35efe287c5af7c8316.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> This commits introduces a optimization by avoiding calling the
> same functions again. For example, `git stash push -u`
> would call at some points the following functions:
> 
>  * `check_changes()`
>  * `do_create_stash()`, which calls: `check_changes()` and
> `get_untracked_files()`
> 
> Note that `check_changes()` also calls `get_untracked_files()`.
> So, `check_changes()` is called 2 times and `get_untracked_files()`
> 3 times. By checking at the beginning of the function if we already
> performed a check, we can avoid making useless calls.

While I can see that this may give us some performance gains, what's
being described above sounds like we should look into why we are
making these duplicate calls in the first place, rather than trying to
return early from them.  I feel like the duplicate calls are mostly a
remnant from the way the shell script was written, but not inherent to
the design of 'git stash'. 

For example 'check_changes' could be called from 'create_stash'
directly, so we don't have to call it in 'do_create_stash', in the
process removing the duplicate call from the 'git stash push'
codepath.  That would provide the same improvements, and keep the code
cleaner, rather than introducing more special cases for these
functions.

I haven't looked into the 'get_untracked_files()' call chain yet, but
I imagine we can do something similar for that.
