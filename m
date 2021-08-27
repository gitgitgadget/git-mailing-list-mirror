Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42E9C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B98A60EBD
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 09:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244681AbhH0JS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 05:18:56 -0400
Received: from forward103j.mail.yandex.net ([5.45.198.246]:44412 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244626AbhH0JSy (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Aug 2021 05:18:54 -0400
Received: from sas1-35b601a382d3.qloud-c.yandex.net (sas1-35b601a382d3.qloud-c.yandex.net [IPv6:2a02:6b8:c08:c505:0:640:35b6:1a3])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 7E1B7101AF7;
        Fri, 27 Aug 2021 12:18:01 +0300 (MSK)
Received: from sas2-1cbd504aaa99.qloud-c.yandex.net (sas2-1cbd504aaa99.qloud-c.yandex.net [2a02:6b8:c14:7101:0:640:1cbd:504a])
        by sas1-35b601a382d3.qloud-c.yandex.net (mxback/Yandex) with ESMTP id PAjLb4YmM4-I1IShB6w;
        Fri, 27 Aug 2021 12:18:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1630055881;
        bh=JNyH5qdyKpIkgcBHO7x1oa5SZy3YkRE4ubipk5tzq3o=;
        h=In-Reply-To:References:Date:To:From:Subject:Message-ID:Cc;
        b=ODtgW11H1c+uc0zHaBoRuZ/7gFbT6RLAuLSbVGxOcyfjU937Ui4+PEp7Xb6ybsEjP
         DP9MWk4BkyH8Li/VlCQueVGlRu0lrJs24GxuQvgouLXUBXUtSWCkMCzhjqgDM8tXMO
         2tGDIJEiPDu+mS+XfDE6dRKoQZqWcVXoY2tLnTZw=
Authentication-Results: sas1-35b601a382d3.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-1cbd504aaa99.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id X4D5t4LNMv-I0h47FAn;
        Fri, 27 Aug 2021 12:18:00 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <826fa09ce470d1a3f06714cdd7f75891fecda676.camel@yandex.ru>
Subject: Re: How to interactively rebase-and-reword nth commit?
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Fri, 27 Aug 2021 12:18:00 +0300
In-Reply-To: <YShISkyN7stYtkV2@coredump.intra.peff.net>
References: <eda317b080a2e75a170c051c339a76115cce5ad7.camel@yandex.ru>
         <YShISkyN7stYtkV2@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2021-08-26 at 22:04 -0400, Jeff King wrote:
> On Wed, Aug 25, 2021 at 05:06:03PM +0300, Konstantin Kharlamov wrote:
> 
> > Any ideas, how can I tell `git` that I want to "reword" nth commit right
> > away? Sure,
> > I am not the first one to stumble upon it, am I? Any ideas?
> 
> Have you looked at the new --fixup options in 2.32? E.g.:
> 
>   git commit --fixup reword:HEAD~2
> 
> will immediately drop you in an editor to adjust the commit message. The
> result is a new "fixup" commit which is then applied when you
> autosquash. So you could do multiple such adjustments, and then:
> 
>   GIT_EDITOR=: git rebase -i --autosquash
> 
> to apply them all to the appropriate spots.
> 
> -Peff

Thank you for the suggestion! I think I gonna stick to the `rebase-at` now that I know the way to solve my problem with GIT_SEQUENCE_EDITOR. The "rebase-at" workflow sounds better optimized to me, due to lack of the `git rebase -i --autosquash` step.

I get that the idea with autosquash that you can remove the commit if you realize you did something wrong. But I usually have a copy of the local branch on a remote repo, so in rare cases I realize I want to undo the change I can simply run `git reset --hard origin/mybranch` ☺ (otherwise, reflog is also a thing).

