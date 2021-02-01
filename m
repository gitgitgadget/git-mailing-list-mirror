Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19062C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 05:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D311B64E15
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 05:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhBAFlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 00:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhBAFix (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 00:38:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FA6C061574
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 21:38:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w4so6645394ybc.7
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 21:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HYNgP1YDDRF3b8T2bBCtmoq0UXQgmhK8WDx5bCEnzqA=;
        b=AxNv3Bd01tT0uFBLHLpzZSP1a+Rx2wWqg1TiQUbEuw33fR7rFyUsoIkzqgZoyGlx6B
         JLDJY2xEY+K4LUfr+fabWn43Twzfm9kEE6hwWPdF/q6mYUOlO0OrLc6RIoa1WX+IOBsu
         WAW1/yOiTQT+zkMmJ6in5pZcqxC2vpt3Z+L5V2MT/qqg0sZYbu+VEw+VG+6AFpoIgyo9
         QpcXgumnwp/xR66W274SRFF5Na90cCRBOv/yyXREmMml/WYQDYtTMcq89r6HA2M210pT
         8GNqzcjjdiiWtcRbsZ8GHCjil3U/Kh7yBznCQ8kFCogja29jhCWgVtUMrpjI6ZdMwk46
         QBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HYNgP1YDDRF3b8T2bBCtmoq0UXQgmhK8WDx5bCEnzqA=;
        b=kT+FztCoMjKTh9YIKjBz6VFl7bWOIr2IfBZ5fnYF+jtZYam0M2VRhg86xsn+IHg/CA
         zKmgEvkt4boKgv0nH1epWHoLQft1Nt6p80209rIaTtxDRsxzO1UkBPCg/33wWBCe4aoB
         4hkl1yyRcHJIEIgt9TWrTvezBOJMtZSj2zrOw74KYpfXhSrFXR0GCdHJnZFFCCxfI9wR
         L7kXe8QOzJ74y8aFYAfZZlB9+BLeAh3+9uMdV/rFxyZgoRC4c6e8hNWVb8XDaewUT31r
         jpSHM6+gE1j4nAZiPqRoJ0royVyrq/crfZR33+gkYjPCRyD8DcoYhsLyoh+9mmZ9RsLT
         jamA==
X-Gm-Message-State: AOAM532RTJddTrNVkjehTmDU4TwI4amu9FpiR19OSslcFdeCMZa2QlHJ
        8cl+/qToMvkDXur64P+UMQX/hHYza7MuSnKr2YE4
X-Google-Smtp-Source: ABdhPJwWwRKebwDPGqbV7wTh0lE9Y9fmjm2ib42DK8yZ2MjyzM1kXBTbp8+n/NjkScq+DMjhdsj//9HlPWgPUD5ZqLXW
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8203:: with SMTP id
 q3mr22793101ybk.86.1612157891039; Sun, 31 Jan 2021 21:38:11 -0800 (PST)
Date:   Sun, 31 Jan 2021 21:38:08 -0800
In-Reply-To: <20201222000220.1491091-12-emilyshaffer@google.com>
Message-Id: <20210201053808.1309469-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-12-emilyshaffer@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v7 11/17] run-command: allow stdin for run_processes_parallel
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/run-command.c b/run-command.c
> index ea4d0fb4b1..80c8c97bc1 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1683,6 +1683,9 @@ static int pp_start_one(struct parallel_processes *pp)
>  	if (i == pp->max_processes)
>  		BUG("bookkeeping is hard");
>  
> +	/* disallow by default, but allow users to set up stdin if they wish */
> +	pp->children[i].process.no_stdin = 1;
> +

This makes sense. May be worth a more detailed comment, e.g.:

  By default, do not inherit stdin from the parent process. (If not, all
  children would share it!) Users may overwrite this by having the
  get_next_task function assign 0 to no_stdin and an appropriate integer
  to in.
