Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCE3C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 04:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2822253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 04:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGtrQ6IY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfLMEOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 23:14:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38770 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfLMEOg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 23:14:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so756172pfc.5
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 20:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t9GyWRALw9kZqdzOc9VdKxFrTJD2Vi9knx9G5dhjYRU=;
        b=NGtrQ6IY7vcGIObZrHO+1hRYBpS/YvT2XqsrqByCuCRdmJrbamb06bLifbE1sW2RvB
         n25vXLEAObHVN43AvDxTrLrWwkybyn4JQNaGog4tBzeHDQ3a+0DyWIX1ZQlLZvTnQOyg
         hgaEA3ZK2Ix+R5IDKkMsDRaxuqoQs7yo2imLuZ8xRdhcJFDuuf+fvAfgzC9oaXp/mRrP
         u0s8MX6aI4MRpXQUtgP0yjisTWfewRn7ofx+yEhVdXBYZvdlbrZCNGRZcPJ2RVA4txXl
         bo/4ESLsCPbaunoRWi8cMtj3qfgPM82sxhnDLVRgr5EFe5He110OMCRfCmS+Urwyalpl
         QhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t9GyWRALw9kZqdzOc9VdKxFrTJD2Vi9knx9G5dhjYRU=;
        b=i/478qjfdKv5sQHx73nf1TdLuUEvn7o9QnfBNSvnM5EzESnJqP9APE6rLC+YHZjVvc
         BvbOyl8hS8+zLhFR7zMV5rjvyN/FzF4CwKyGpV5FyqdXUcRu+gPvMBxfuRhQZOdsRdFG
         cYT4T6x0kus9QETbaawqfEzMR8PNSYCAsNDxPlyxybVMnEHBasKm6eyZe8r49hiaOQdy
         dH79F6JwAua71bz+5kSjAAWsQ93Tdj9yOH+mnnrc3bCNU5XNWP7sTifmO+z8neJPKeWN
         X66qQb7BB6IyUSEAXW/TlQ31znhXhCOu38+59W/ksgThDXFfIIEwaxFHafpN+bkK2Ha5
         FGBA==
X-Gm-Message-State: APjAAAXhCwJ41lW/RE2emtyZEQtXoLXaJ5xDwwK0PpU1d/ciT3doE6y/
        +svAz65VuWsc/pNR4y/sBrlTXw==
X-Google-Smtp-Source: APXvYqxhj4s5nEr77p2hUtaxrInsbqz9njyfA24I5iITOtGxzrr9DoH3OvsSP0bFdfQ0wMyb7tTU5A==
X-Received: by 2002:a65:66c8:: with SMTP id c8mr15243045pgw.161.1576210474872;
        Thu, 12 Dec 2019 20:14:34 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id q6sm9595825pfq.27.2019.12.12.20.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 20:14:33 -0800 (PST)
Date:   Thu, 12 Dec 2019 20:14:29 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Kerry@google.com, Richard <richard.kerry@atos.net>
Subject: Re: [PATCH v3] MyFirstContribution: add avenues for getting help
Message-ID: <20191213041429.GC135450@google.com>
References: <20191213013128.6268-1-emilyshaffer@google.com>
 <f3037862-b8f7-d674-4b1e-7b9df3fa49cd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3037862-b8f7-d674-4b1e-7b9df3fa49cd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 12, 2019 at 10:00:45PM -0500, Derrick Stolee wrote:
> On 12/12/2019 8:31 PM, Emily Shaffer wrote:
> > With https://public-inbox.org/git/20191114194708.GD60198@google.com/ we
> 
> We are trying to move to lore.kernel.org, I think.

Argh, and I even wordsmithed a few paragraphs down in this commit
message too. Sending..

> 
> > now have a mentoring mailing list, to which we should direct new
> > contributors who have questions.
> > 
> > Since #git-devel's traffic is fairly low, it should be OK to direct some
> > questions there too. Mention some of the conventions in case folks are
> > unfamiliar with IRC.
> > 
> > Because the mentoring list and #git-devel are both a subset of Git
> > contributors, finally list the main Git list and mention some of the
> > posting conventions.
> > 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > Since v2:
> > 
> > - Removed a double slash in a URL
> > - public-inbox -> lore.kernel.org
> 
> Ah, I see you mentioned it here and in the contents. Commit messages
> are harder to keep straight, in my experience.
> 
> > +==== https://lore.kernel.org/git[git@vger.kernel.org]
