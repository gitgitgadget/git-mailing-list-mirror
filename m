Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEEFC33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 14:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C2E214AF
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 14:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrTNjRJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAQOco (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:32:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53832 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgAQOco (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 09:32:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id m24so7646180wmc.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=skf5ZUqW8fMEy0YmrLXiTJQNYFmXrpRUupvxkXjI4Po=;
        b=IrTNjRJOlltnF3T11faq5Zg+u6NdHjwJMSKbT4zT/hNr/SOy1Fa0bQGeeIYPeFR5HY
         aprGypX0mIrvXj8zGkll4M7uFQ5g0GD231PMCFs690K83X5AX5FCd7X1C30GT7YlNr/s
         4luOpMoeg1LW9nlZtAfKhtoTGZ9s/Orz9bjUUnsIQtKjxEG2wAla8osVNHXMBBC5BYNw
         RjpDwacYfE4B4XkCX85T6Py0ud3usNSxsvSr8CId4764aXCfvDhGe79+AJ8HfKy56bgw
         QznXYxJqlRaC6oi9S01VU40cSp+HSrgC6WEU/WZAlEjkpO3LiS2nztQVkf3B15WUehIh
         mwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=skf5ZUqW8fMEy0YmrLXiTJQNYFmXrpRUupvxkXjI4Po=;
        b=cco5nIYf69bdTWih+zEJvKC9XSZcl32k2vbm6S+mWPtJyWBGMMARbAtG8mBVxoaxrh
         ya4jwYwSUB8U4B6pBFojWYHw5PueJD3PYL3KMFJiiEoDWgEUVFC96Tqxv5W7AKHBjOc0
         xmbyLTmLb93Ar1lI1p6y06PdirVBjJfFAEiUKWx8/FBQWVnTAnP0/YziZkvasBIoN5Cw
         5Jrxzm5ScqzRhAMB3DHVVdHXCZGSpubYGssk3er2dVrJZ1RZa1ZD6DAqGXTlHLJ8Yd8L
         2ZWF7CddJIpB2qxKZspiLouRDzzONivcVj6ffcpQKCyqRVj9q13V1/xSeo36u6e0ioBu
         HYxw==
X-Gm-Message-State: APjAAAXFmLZvvdjk0RV81fR4fH6hUp7t2d6jYTUs5bpt+iR2adeuxLT5
        ubjcAw+ZKZInvMrJkO9aUCM=
X-Google-Smtp-Source: APXvYqyHyVnboF4fChzL6PpfUsJiq4pfqLHU/WFH3b3L6BkBr/VNg2BHmCt1j1pi5aq2zluLzlcW2g==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr4845531wmi.101.1579271562338;
        Fri, 17 Jan 2020 06:32:42 -0800 (PST)
Received: from szeder.dev (x4db97368.dyn.telefonica.de. [77.185.115.104])
        by smtp.gmail.com with ESMTPSA id n8sm34244079wrx.42.2020.01.17.06.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 06:32:41 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:32:36 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 01/10] built-in add -i/-p: treat SIGPIPE as EOF
Message-ID: <20200117143236.GA11737@szeder.dev>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
 <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
 <5e258a8d2bb271433902b2e44c3a30a988bbf512.1578904171.git.gitgitgadget@gmail.com>
 <20200113170417.GK32750@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113170417.GK32750@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 13, 2020 at 06:04:17PM +0100, SZEDER Gábor wrote:
> and 'GIT_TEST_ADD_I_USE_BUILTIN=1 ./t3701-add-interactive.sh -r 39,49'
> fails with:
> 
>   + test_must_fail force_color git add -p
>   about to run diffFilter
>   attempting to xwrite() 224 bytes to a fd with revents flags 0x4
>   test_must_fail: died by signal 13: force_color git add -p
> 
> I don't understand why we get SIGPIPE right away instead of some error
> that we can act upon (ECONNRESET?).

Doh', because it's a pipe, not a socket, that's why.  pipe(7):

  "If all file descriptors referring to the read end of a pipe have
   been closed, then a write(2) will cause a SIGPIPE signal to be
   generated for the calling process."

So ECONNRESET is definitely not the right error to set on POLLERR,
though I'm still not sure what the right one would be (perhaps
EPIPE?).


