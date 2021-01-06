Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C34C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6F02332A
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbhAFW5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:57:43 -0500
Received: from mailscanner.iro.umontreal.ca ([132.204.25.50]:29069 "EHLO
        mailscanner.iro.umontreal.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbhAFW5m (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jan 2021 17:57:42 -0500
Received: from pmg3.iro.umontreal.ca (localhost [127.0.0.1])
        by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id C9C2444128E;
        Wed,  6 Jan 2021 17:57:01 -0500 (EST)
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
        by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id 79C6E441284;
        Wed,  6 Jan 2021 17:57:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
        s=mail; t=1609973820;
        bh=x9qRf1X0PYpp3USV4svLFuVJbBqv0TQyxWgDx1jEnhw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=K5jBAIJXax4bnbJMNl8S02Q4r29UCu+sFDXzcjP+UYrlmckakXDm201F7PLXTlR73
         8c0CTh5uKY2YOgN+nnamUp/VaHSl8tem+S0avn3EwAyj/fd3wvfOywTH6K4Oiry9ls
         8+3vH7n4AtUhZq/YW0lbo0ahTpMZsu4iQZ1xHJFMNEPNXWdK23EHytTKEkg5zKFqD3
         t2gVuhl/QkDwHTV96UgwLmUcd65ac8FdDZJtfyUnA57W4Tx3dufRVK5YxhbHSgO+qf
         ONl5fXY3REB3Il5v0qPkOZaapfpEYPqBsgp+F7YO/hAudVeeOhYXA0NDNzbFjfbRGo
         gB3mbhXctccxQ==
Received: from alfajor (unknown [45.72.224.181])
        by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id 392111203E4;
        Wed,  6 Jan 2021 17:57:00 -0500 (EST)
From:   Stefan Monnier <monnier@iro.umontreal.ca>
To:     Jim Hill <gjthill@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: New orphan worktree?
Message-ID: <jwvk0spr8ta.fsf-monnier+Inbox@gnu.org>
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
        <xmqq1rexrbz1.fsf@gitster.c.googlers.com>
        <CAEE75_0e4_m_7hQXycVK1f=4LOb82U2DYveAvcF2XKKNgmfpNw@mail.gmail.com>
        <xmqqr1mxpv8n.fsf@gitster.c.googlers.com>
        <CAEE75_1o+A13+8SBeF9S0SN0ZaYhgK3D1bhbfWNWZWsj9jOXrw@mail.gmail.com>
Date:   Wed, 06 Jan 2021 17:56:59 -0500
In-Reply-To: <CAEE75_1o+A13+8SBeF9S0SN0ZaYhgK3D1bhbfWNWZWsj9jOXrw@mail.gmail.com>
        (Jim Hill's message of "Wed, 6 Jan 2021 14:25:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> not a good example to support the use of the "--orphan" option.
> I agree with that part, slathering infrastructure and abstractions on
> oneliners (okay, twoliners) is suspect in my book. worktree add,
> symoblic ref (really, no need to get lowlevel there, checkout --orphan
> does it) done. Tag an empty commit and the sequence gets closer
> to a legit oneliner
>
>     git worktree add foo empty; git -C foo checkout --orphan newbranch

FWIW, I'd be quite happy to have an ad-hoc revision which represents
"the (currently non-existing) ancestor shared by all branches".
Assuming we'd call it "ORPHAN" (other names that come to mind would be
"ROOT", "GOD", "=E2=88=85", "BIGBANG", ...), then

    git checkout --orphan newbranch

would become

    git checkout -b newbranch ORPHAN

and then I'd also be able to say

    got worktree add -b newbranch foo ORPHAN

I've had occasional use for such a pseudo-revision in other
circumstances as well and I think I'd find it easier to remember how to
use this then the `--orphan` option.


        Stefan

