Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A77C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 01:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB9E2064B
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 01:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKQYDaKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfLGBJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 20:09:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37083 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLGBJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 20:09:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so4230213pfm.4
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 17:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qt6vYHDiIRUGGBFAy3UQ9DRqAzQreQlMgzu7fJQDcE0=;
        b=nKQYDaKu3w8Nz2tvlK/oqAS9Yx8ViVx5nDkevw2lNShi7uO8GOmg36cOSOtBv0BBza
         1A/KWucjBTMNGVjJg8/SdMReOvc5axu70qUZ2MM4W+N7JBbyGjdb3XuR47fJKwZ7Fsvb
         qQOLA2+75IJngYGvPoDs/hWrsf1Y6mrQdJK/XcFpPDi5TkvY5NZNbJ/fjaphj859HM0z
         Sbmvfutl6e/oO0RRPbf+g31mlLPUNqMDZBp0TgrQ9rEIDYu7mHxiHbHUQCCuT5W+1IU5
         5QkDoF3+n0m/xKn3A8N7derPBkJd3ij43mK3djBxC4ydZ6v1rjC6jUcAJwg08UrHOIz3
         7cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qt6vYHDiIRUGGBFAy3UQ9DRqAzQreQlMgzu7fJQDcE0=;
        b=IFwoi57PIdC6gMlSSKGqO39la0VVJjDkc/gO1CscmxD4bR00xLim2NKTy1wLYVMMHY
         Lh+/P6oi/J0pBPI8iAIg8OK+PdPIuMGuUe+tdCF6L1anNP/R8UDNPsBRjoDE9OP/Mu/n
         RYTY02l4vUCqI8omJfpFMKKBIrdQH6rb3k+uRNbjhFMpqhDaKHIqInZgz+dlvEfyWl4F
         fPAoXgxJNhQM5teo1eDdy9BhPF9cDJL8WvBM2DJVk+D4KFsXYXXU8Yzha5OKecDb2+N9
         fjmEZIfVP/2EWlFIsRcKVP8vxdOyoI80BzBOzp71F8Paij4koT4aJMrdQCL7PXzQwuWJ
         SDsg==
X-Gm-Message-State: APjAAAUKj+nHSwGUT4YOKy+Z/U6RTAU82R/mUm35MzWpYQ/OD2lJ3UnP
        9r4H2wKym8FoJHcZWK5dpvU=
X-Google-Smtp-Source: APXvYqzW9MrjyEiV4lBcfpXhqpPqeJm9vuxmgmt36nIx5j/n99aWsPBN+ACTH4IRDRq11X5YSKgunw==
X-Received: by 2002:a62:888e:: with SMTP id l136mr17757460pfd.80.1575680956116;
        Fri, 06 Dec 2019 17:09:16 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id b7sm4360036pjo.3.2019.12.06.17.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 17:09:15 -0800 (PST)
Date:   Fri, 6 Dec 2019 17:09:38 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH 00/13] git-p4: python3 compatibility
Message-ID: <20191207010938.GA75094@generichostname>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yang,

On Fri, Dec 06, 2019 at 04:33:18PM -0800, Yang Zhao wrote:
> This patchset adds python3 compatibility to git-p4.
> 
> While some clean-up refactoring would have been nice, I specifically avoided
> making any major changes to the internal API, aiming to have passing tests
> with as few changes as possible.
> 
> CI results can be seen from this GitHub PR: https://github.com/git/git/pull/673
> 
> (As of writing, the CI pipelines are intermittently failing due to reasons
> that appear unrelated to code. I do have python3 tests passing locally on
> a Gentoo host.)

Currently, there's a competing effort to do the same thing[1] by Ben
Keene (CC'd). Like the last time[2] two competing topics arose at the
same time, I'm going to make the same suggestion.

Would it be possible for both of you to join forces?

Thanks,

Denton

[1]: https://lore.kernel.org/git/pull.463.v4.git.1575498577.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com/
