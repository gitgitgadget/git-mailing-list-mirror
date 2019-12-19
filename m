Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2C0C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609B0222C2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbIUOLL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfLSS6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:58:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43103 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbfLSSyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:54:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so3588267pga.10
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9l513TSRDR7hUZlHaoex9lk365u4DefbazTxFQ3ocEE=;
        b=kbIUOLL6QDh/zPJxm5JwhT7e4cqDhXB3qVEnLld3a9epI1TNRYykUBQGDYjuVoo6qq
         vay2F/HwsFB+CwpZ+MuX1JVASiR+HyW/mr6qQTWbZuTjaeYHCOw+W4abZz7wlaASlmM5
         1TI0VLeAsjjdB3CF372JAkLoXOVK1tJQHXiPU/dHW36uKqdaFda7SWEO178LHAZ482gH
         ro+EYvyEMExu/OYHpED4DlnddTPL4Nsv4dbGSODWfMmhJ1NWfeGIDfML/sIbOQyUpFxD
         4M9+wF8hqkbgoiVMP56Qz7KQwqgg17I1IYIc8nMRqEdIM/RDwV0VTSNKnK6v9MSKp3KR
         C91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9l513TSRDR7hUZlHaoex9lk365u4DefbazTxFQ3ocEE=;
        b=D+tVBxtYH17XBcw1giYF2H7SOaE88YlGKAPLQGV0uvzREqlbw26YCwD5/SMuUni36l
         zYPaW8hFKrVbfgFYf+08aH+YSCyarv48Iz6PWSdbGiAvZ5eAtBDtfXPOGIpzirGj+ZXT
         SL9HqhfzgbIiqyhTvjR+tJ2egWqqpKHMWna/wU1KQ990IcqUfqIeWBcpvSIJVjgg7DNP
         hArWD6T9Nj3PLgcqBGDvYNtCKRf3tB0DmgQYDK+YVeIooFCYVEQ2v/3z0V5XssI+EwTG
         gazn1qja4ST48QoFjswo3Jfdyqi7DLEqno2epmBJZjt0EmnNjgaR/zeNJGPape4qTuJn
         McfQ==
X-Gm-Message-State: APjAAAU8cx5GrK1Dtqgbodk7VTou8r/v88Y5KhEDrxuA1yivwf4EeOpz
        fd4JRTrvi72mae7dOipLxbeIww==
X-Google-Smtp-Source: APXvYqze3Z8OSx6tbLCQ6q91bTcP8NVJTCbATluTTATKP0oMS1qoWRlMeMRv5pHpncedPbjP8JIZeA==
X-Received: by 2002:a63:ff52:: with SMTP id s18mr10603912pgk.253.1576781672152;
        Thu, 19 Dec 2019 10:54:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 200sm9287706pfz.121.2019.12.19.10.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 10:54:31 -0800 (PST)
Date:   Thu, 19 Dec 2019 10:54:27 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 0/1] [Outreachy] commit: display advice hints when
 commit fails
Message-ID: <20191219185427.GA227872@google.com>
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
 <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
 <xmqqlfr8b28v.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfr8b28v.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 19, 2019 at 10:26:40AM -0800, Junio C Hamano wrote:
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> >      @@ -19,16 +19,16 @@
> >             #   (use "git add <file>..." to update what will be committed)
> >             #   (use "git checkout -- <file>..." to discard changes in working directory)
> >             #
> >      -      #   modified:   ../builtin/commit.c
> >      +      #   modified:   /builtin/commit.c
> 
> Really?

It's hard to know what this cryptic comment means.. :)

This was a recommended change:
https://lore.kernel.org/git/20191218031338.203382-1-jonathantanmy@google.com

Since other changes were being made at the same time, I personally don't
mind a little nit fix in the commit message.

Or, do you mean that "now it looks like the file is at the filesystem
root, which is wrong"? It is indeed wrong now when it wasn't before. But
I, for one, can't tell what you mean by just the one word.

 - Emily
