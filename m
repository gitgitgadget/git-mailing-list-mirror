Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45581C433DF
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD2C21702
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=schrab.com header.i=@schrab.com header.b="4pugLz/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGUAXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUAXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 20:23:11 -0400
Received: from pug.qqx.org (pug.qqx.org [IPv6:2600:3c02:e000:5::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07053C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 17:23:11 -0700 (PDT)
Received: by pug.qqx.org (Postfix, from userid 1000)
        id 1262D1EEBB; Mon, 20 Jul 2020 20:23:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schrab.com; s=mail;
        t=1595290989; bh=kybKYFyL9WXePKS1+6qp5eJXdImXPHJ/U0Nwa+JG2L4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=4pugLz/sxq13oEDANS1wMTfq2UJTmkeoLVLs9GpqHtE7kGvjEQbtvuwvHadfWTb64
         sz+7qyXMqiFnNfaJHxGyQN6YIBTh54xQuXFchnIvl/NKqGOF4XK9/RCNB+2bBX/mnP
         HO3vXH7s0YeuXLDgpbD2H7AQS4fDbSaU2Ldd8UTEq0yE+Z/8JJvs4/dDi3TaUrR4by
         zTRsoo3kSyBlkCZfqQdRLlMw+I3MI60w78SfBbpcHZtX47+BvfRQ4cECPOo81R2fvf
         joIC/HtMa4m+pf56YEd+9MuxehNJ518Z1KGcvFmnMUgCrYb/igpCV/kJjPloDHLztt
         wNRbdr6mR3YwA==
Date:   Mon, 20 Jul 2020 20:23:09 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     "David J. Malan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "David J. Malan" <malan@harvard.edu>
Subject: Re: [PATCH] git-prompt: changes == to = for zsh's sake
Message-ID: <20200721002309.GA178512@pug.qqx.org>
Mail-Followup-To: "David J. Malan via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "David J. Malan" <malan@harvard.edu>
References: <pull.679.git.1595287052428.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <pull.679.git.1595287052428.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 23:17 +0000 20 Jul 2020, "David J. Malan via GitGitGadget" <gitgitgadget@gmail.com> wrote:
>From: "David J. Malan" <malan@harvard.edu>
>
>When using git-prompt.sh with Zsh, __git_ps1 currently errs
>when inside a repo with:
>
>__git_ps1:96: = not found

That depends if zsh's `equals` option is set or not. If it's set (as it 
is by default) you'll get that behavior. If it's unset (`setopt 
no_equals`) that should behave as in bash. But, it fixing the code to 
work regardless of shell options is definitely a good thing.

>This commit changes `==` to `=` for both Bash and Zsh.

An alternate fix would be to switch to using double square brackets 
instead of single square brackets for the test. Since contents of double 
brackets have their own parsing rules the `equals` option doesn't apply 
there, and so `==` is available for checking equality same as in bash.  
IMHO, this provides saner behavior in general; although it's definitely 
not POSIX compliant.
