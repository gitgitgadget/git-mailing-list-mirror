Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7A7C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D4F2071E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNvAjjl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgAXUy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:54:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36339 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgAXUy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 15:54:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so1735241pgc.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 12:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AnaFd7g9FFAmTnBnHfalNaIiY+VAsB8Z/SM7THODjTU=;
        b=sNvAjjl3NWqr0+FJ1pgo7Cm73M74nej3XSiNklL2Pmjtr7xET4Mf/h7iRGHP0hLndF
         SiABeUpdePFcFzeWi3+e6VXAvBzjW0yAn0xN84EwM/vovPQbZoVbTrLHZaJ7CPvsBVmu
         tvieIOLKK2jD3LhHuS2YzEMZHO8qiKAAYnGhk5MfZdrdShartwQ+fhmnoPkPGwtFSL8+
         t1VzqTZlONh6G0HvxAu6M+yjnG6AzGosBmpjGT7u0yejUTT9QC/kJlGiGe0EHQBMQ05U
         lgsKZ2L0Ccp9F2VHBzGBKw0BdSr3E+q7riZ7FBzkcsfYfvhFkEyQ8toEd3zOxqeQ2zTX
         JGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AnaFd7g9FFAmTnBnHfalNaIiY+VAsB8Z/SM7THODjTU=;
        b=GPJ8vCjtjVpQVnVmRUvbBtYVNt3/aZgGcLfLZnLfxy1aLM+hxhXeM/junVScP6rcmk
         KkcHSytKR1/gJQno5cnuVOW/Xs1ZOQDJtaf0HHCg0TNxi/2sRsDKB4jvWuQtTb2wRcbh
         JTZxAeShGY/5rh48Mb7WAiTgUwCqbYnHMLjT3NPSDiTaGZaGaGzHPwtvvvYgpEo0T7/O
         zAqVz7ymF6SNfDIL/gdJsu2VfhyGuIUJiXFzYqKZ3hK543Fgqo0XB+UCrcbfukG9mUS8
         /DgKJArJFy4qHltBIH/ywu+CMnxWnc/RD9Z2BhGsewJ16Ig+IXVjd2/eXYJjuOgcP4ue
         yJJQ==
X-Gm-Message-State: APjAAAVQ81I3LTUHZxl5eDIuTjNeWXh0hsQ0mVHbL0DDQ6AGgeOZ2oQc
        g52XJUZKljrLpdIAiH/wH8OJyQ==
X-Google-Smtp-Source: APXvYqzdQCUHL0yomqCzL/1Wra30r5IoGetQpHCtbAi4DVqOxoQ3chptd5o9I8JLF3ce277Y4FfR/Q==
X-Received: by 2002:a62:d144:: with SMTP id t4mr809939pfl.7.1579899294883;
        Fri, 24 Jan 2020 12:54:54 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id q15sm7592644pgi.55.2020.01.24.12.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:54:54 -0800 (PST)
Date:   Fri, 24 Jan 2020 12:54:49 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>,
        Richard Kerry <richard.kerry@atos.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5] MyFirstContribution: add avenues for getting help
Message-ID: <20200124205449.GB140846@google.com>
References: <20200124200915.249473-1-emilyshaffer@google.com>
 <xmqq7e1gzj73.fsf@gitster-ct.c.googlers.com>
 <20200124205025.GA140846@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124205025.GA140846@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 12:50:25PM -0800, Emily Shaffer wrote:
> On Fri, Jan 24, 2020 at 12:35:28PM -0800, Junio C Hamano wrote:
> > emilyshaffer@google.com writes:
> > 
> > > From: Emily Shaffer <emilyshaffer@google.com>
> > 
> > Hmm, unlike folks who use GGG, your From: address seem almost usable
> > without having to waste two extra lines (which matters when one has
> > to review many patches a day).
> 
> Blame an unhealthy appreciation for being able to write emails in Vim.
> 
> I generate patches with 'git format-patch' - what's the unusable part of
> "almost" usable here? Typically I invoke it like so:
> 
>   git format-patch -o ~/mailed-patches/blah -vN master..branchname
>   git send-email --to=git@vger.kernel.org ~/mailed-patches/blah/vN*
> 
> If there's more tweaking I should do in the workflow I'd like to know.

Ah, I think that 'git send-email' is injecting this because I added a
redundant "sendemail.from" line to my ~/.gitconfig while I was testing
out 'git bugreport' for my other patchset. I'll remove that config from
here on.

 - Emily
