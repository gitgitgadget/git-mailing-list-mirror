Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D9C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F8720663
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLfSg99V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgFOKqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgFOKqq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:46:46 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA76C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:46:45 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so15223971qkg.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YaQzS7+9Pvw7IClE5SsiVQODznv+tHo+rFYLa3HIsME=;
        b=mLfSg99Ve2J7VS/Ie6m0l+gtDdn1zkNWUeQuC+bVkfcuxaiyYovThxsTbecV77Ipj9
         Mwusi0bCbfffpa9ma/axRwvlB0VqLckwOAvR9MoIIojdct4mNxWMdzbHgJDc9RqvAwll
         RRtYUPqhpsY4+CBLxuI7XJhmOfNgEaohctjJ3x5TxBS8ZQxLUChP9+LQBXjZmu37sqCu
         ID/ajQSN4d43R0O6CwvhLV1G/Z7MkmvV76Sy8G75uVLdiAg4HtocF1porWRethPZAyLI
         hFpoXd3SfFqLs6eGtmK0ngjjVd374aT0OepWuhd+GKjVYBNFCLmv8bcp/uNpyApcWQE2
         IHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YaQzS7+9Pvw7IClE5SsiVQODznv+tHo+rFYLa3HIsME=;
        b=rS6pStW02dIf7/iUNJBlUQUgoREGArg6Fi7tnh3td1eta904uZRelZx3oENWjsY6+R
         u0ePOp95+RG5iZiH+PVHST5rWE6OxD3sx3egjYkOgzich56nIOEG2GMRLNaHZxYe944P
         h+BrkMPwNOM6fJ7Ee4I5d4A4aXfvgM+sU0zgZEr0ZEdFkstXB92xG4hk0E/I5g4dovrj
         h7BuPLUsd+6WYKCbmeJNI8L5m1F4cqzpcHwhUk4zF+twXs8fOnwH1u3LhJqrkZow6HIv
         LEbpSahRLEDLW2mUqdiVe/QxMVghQyXhqZlz+p0c77l0ZUGzoPCQuNTFLCpyg4mEypvf
         y/KQ==
X-Gm-Message-State: AOAM532xwygcwqkykHbnqFTrJaPO/2fGNSu+xmXAF3l/2oWwD3Vp4Jls
        I4/+8ZwhuHG9jeeakUEaeeY=
X-Google-Smtp-Source: ABdhPJwodTPvCpl3zQJVQDmuMGs0xhbtPm6cZ8naKvbL3Huc/fUjCsHZiBRpKJXmyJlz4v1BjT73VA==
X-Received: by 2002:ae9:ef0e:: with SMTP id d14mr14632990qkg.416.1592218004787;
        Mon, 15 Jun 2020 03:46:44 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id k26sm12483749qtk.55.2020.06.15.03.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 03:46:44 -0700 (PDT)
Date:   Mon, 15 Jun 2020 06:46:41 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 5/9] submodule: use the (possibly overridden) default
 branch name
Message-ID: <20200615104641.GA54462@generichostname>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <06ef42052d534a668bf5227e79f1ca3b5c6aa2c1.1591823971.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ef42052d534a668bf5227e79f1ca3b5c6aa2c1.1591823971.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 09:19:26PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> To allow for overriding the default branch name, we have introduced a
> config setting. With this patch, the `git submodule` command learns
> about this, too.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

One thing to consider: in the future, if we move away from "master"
or even allow the value to be configurable, we're gonna end up breaking
a lot of repositories this way.

If a developer regularly pulls in submodule updates via
`git submodule update --remote`, when the default branch name changes,
this will suddenly stop working. This will require developers who use
submodules to "fix" their .gitmodules file.

If it's configurable, this problem might be even worse. It could lead to
scenarios where one developer might go "works for me" while another
developer (who may set the configuration and forget about it) would be
confused about why it's not working for them.

Just a couple thoughts I had while looking at this patch.
