Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9410DC83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 00:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C1620731
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 00:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moMEKTWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgD3AV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3AV6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 20:21:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE52FC035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 17:21:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k197so5727909ybk.21
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 17:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nOYGMjPLrgbsEsSMnpE0k0KXkWaeHG2kM9gPJzfkaSU=;
        b=moMEKTWvLlstgSJi+fGHpUzaUjaJH1fBcKzxnKKnFHwLKqcKfThoC7ncl6Cgpc/Du5
         zngzUSGD2tVSarIWrQhOldiu3OslT519WcxFf6XhWN5qIr2nqb/BaMRYmdFaN0bUj1WZ
         OBNsEaHOof+BCvxT3f+u24ZW3/FBiNorWcATTP72vw3Avde/yyT8ZYJ225xF/aIbRSZX
         6ToolAUhkIPZKTXzMQC5ZqA6pLoQ/tn8ZS94SbZkMAUSS+TrM/aJ4Qrt7HdP/K8q4QoP
         Ug0O4Nbzgvboz0d/7ZEKPl3X5U2Gb2orRYvqvrLWSGKSQJ+J+JWYZyuhtJqelhL8oMdW
         XADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nOYGMjPLrgbsEsSMnpE0k0KXkWaeHG2kM9gPJzfkaSU=;
        b=K412mtdikARH+GsosRyYFN6ANkeeNeoCtIOW2pjVM4J2y/UF5yNOOE36dIIMYNbd5c
         Ue/MRC9e9o3vu/pJL2UZCcfRS/9STQiGBs+p33Y3LBNQporFQ1fpBvTJ/5UovDr00g1X
         u405F7StyQ4DEF0VNGMF4nvv1SYITyKe0hAl6XkO5uziZ3HQNvseyUnEVyJZB9Kk32cB
         EOzPPXLOzaWUhR2yQ+T/a9AXv9F6PTyKQU60cOI+95L/QTWYy2b5Zg+gSPYuxRIDbdFb
         DxqH9XnBr/45ezDriH/qIeTBJzRw7o2oLEFAO4Yf5nCTFFDkUxuNepJQekL6BW2RZPjr
         4HYg==
X-Gm-Message-State: AGi0PuYqoj082ikcQKXCq9e8ayz8mnKOXpojT0L5l92+Miqpl4V2UT+m
        d9I+lX4OkEKZPsqsKJd9npAasXz2ze64fQ81KMIB
X-Google-Smtp-Source: APiQypJj7xsFzzzKXo3nhju2cvSSjUd4/ez8dTiHkMZ1ZpO6yXwfOT40xCZ/yj311N0L5XEN5i0kjsGYSsqwtPyzYu+1
X-Received: by 2002:a25:d901:: with SMTP id q1mr1574995ybg.30.1588206117157;
 Wed, 29 Apr 2020 17:21:57 -0700 (PDT)
Date:   Wed, 29 Apr 2020 17:21:54 -0700
In-Reply-To: <0b93abe072aa35ab96ba3b97118caa8ffe8e439d.1588199705.git.me@ttaylorr.com>
Message-Id: <20200430002154.231855-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <0b93abe072aa35ab96ba3b97118caa8ffe8e439d.1588199705.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: Re: [PATCH 2/5] shallow: extract a header file for shallow-related functions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, I couldn't apply these patches neither on latest master
(86ab15cb15 ("The fourth batch", 2020-04-28)) nor on its 2 immediate
ancestors - what is the base of these patches? (Or is there something
wrong with my workflow?)

I'll review based on the patches themselves, but what I've seen looks
good so far.

> diff --git a/builtin.h b/builtin.h
> index 2b25a80cde..2e701a023c 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -5,6 +5,7 @@
>  #include "strbuf.h"
>  #include "cache.h"
>  #include "commit.h"
> +#include "shallow.h"

It's a pity that builtin.h has to be modified in this way, but I see
that it's necessary - a few files that include builtin.h (at least git.c
and builtin/bisect--helper.c) assume that they have shallow function
access through this header.

Once I manage to apply these patches myself, I'll verify with
--color-moved that the lines moved as I expect, but otherwise patch 1
and 2 look good.
