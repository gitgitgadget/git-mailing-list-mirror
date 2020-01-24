Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01657C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23892071A
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QokrEPYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAXUub (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:50:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42162 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgAXUub (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 15:50:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so1669886pfz.9
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 12:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ghDqQGQZVPXAkyVM+l0KMX/vroDa2MW5YxvvJqJWrY0=;
        b=QokrEPYVH9tDvOPKfV9R5wSjbIagh9Z8E+pxHHSA1LnB7S3EnOo+1lg1WrUL/XkN/X
         YBs92vo66gheZL65xvdHVpf09U2BYG3aD9iurW1gIXCviFZJXQCG7zb+/UaRXGflC3ze
         PpQVtt7yV8Kr7IhGcXgex/sm4KV/9aipPvlNBg1ZPPGO4jhuzIrt3USspF69AxLo0WRL
         7MarVAOmkZ+yLnp0hhfsTGqtgKCRUwaBfR234vZsVPhq5NtduY6MYYVNI6IjyXrbEQlT
         9plCHWKtiox/hZ8uN2adPdC6o5QA+mSbQirPTEZWMe8NuauxpcE2RkkkrlMUAhsEryd5
         OVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ghDqQGQZVPXAkyVM+l0KMX/vroDa2MW5YxvvJqJWrY0=;
        b=G099WZ20WF85Wm/OYl9aWNcu2/C+1GQ7XaiFqWDa7IqolnQB1v4zI7l8i9OMELPQpU
         Q49lbYhQKYWkwdlAA7ffm3V/ZhxgyPPtN1hLc+lyNnsWnbjpV4FRLaU0JcP9TMd8VfCJ
         hY7X3NUrOfe4Xw3tyZP0/QzXo1xfScADa1+YYdXhyWY7m+Ze2xEeM/LKwXq1HbMgnqp2
         oygB6CLXEYhIEglJTrXlR+W5LmV6M5OXwAZgseErYzCQDFginPub41v3dSU0xJPpGxBU
         Y+lvgHSLISrzgoEjbbwRZxqd3Igevfk8LSmZMVpudqwLeE3yRsSK8Algi/gKsMEe5Wu1
         t2Hw==
X-Gm-Message-State: APjAAAU6noExW6kzt890yit2wENYGFu/vIaf45YxFOXT98cUiF4dMQVL
        49+zhUYU8JmK0Y3gduimycq8nw==
X-Google-Smtp-Source: APXvYqy8NFXmV7IUeFWw00s8UqIYjjugHfo90Xt5cDvX5x7ZUrOciKg/ApRz9hMDovYwjPF7hzi/kw==
X-Received: by 2002:a63:213:: with SMTP id 19mr6187586pgc.160.1579899030445;
        Fri, 24 Jan 2020 12:50:30 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id g24sm7343395pfk.92.2020.01.24.12.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:50:29 -0800 (PST)
Date:   Fri, 24 Jan 2020 12:50:25 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>,
        Richard Kerry <richard.kerry@atos.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5] MyFirstContribution: add avenues for getting help
Message-ID: <20200124205025.GA140846@google.com>
References: <20200124200915.249473-1-emilyshaffer@google.com>
 <xmqq7e1gzj73.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e1gzj73.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 12:35:28PM -0800, Junio C Hamano wrote:
> emilyshaffer@google.com writes:
> 
> > From: Emily Shaffer <emilyshaffer@google.com>
> 
> Hmm, unlike folks who use GGG, your From: address seem almost usable
> without having to waste two extra lines (which matters when one has
> to review many patches a day).

Blame an unhealthy appreciation for being able to write emails in Vim.

I generate patches with 'git format-patch' - what's the unusable part of
"almost" usable here? Typically I invoke it like so:

  git format-patch -o ~/mailed-patches/blah -vN master..branchname
  git send-email --to=git@vger.kernel.org ~/mailed-patches/blah/vN*

If there's more tweaking I should do in the workflow I'd like to know.

> > +==== https://lore.kernel.org/git[git@vger.kernel.org]
> 
> Hmph.  I would have expected mailto:git@vger.kernel.org as the main
> URL here, as this enumeration is not for those who lurk to passibly
> receive information, but for those (new) contributors who want to
> ask help by actively transmitting.  Mentioning lore as an archive
> when talking about the list is necessary, but it shouldn't obscure
> the main e-mail address people need to know in order to send their
> requests.

Ok. My personal bias as a long-time browser-as-primary-mail-client user
leaked through. I'll send another revision now.
