Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A084FC433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788E560FE8
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhJXUgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 16:36:11 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:33939
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231394AbhJXUgK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 24 Oct 2021 16:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=cessssaigkdq5uletp7pzdlghxldyiuc; d=coderkalyan.com;
        t=1635107629;
        h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:From:To:References:In-Reply-To;
        bh=epamjqOsDHUxjeL5U5k1iMHW2E4UgI+KtRHLJQEvqnM=;
        b=FYqOh07gkV8CB959/9xTu7LZWtW3NDlyeIYc1ZWxPDIMBXS1Z+OryKXM1J6++7uO
        2Fv6FRPNCC+1Qervtgy/WkuSku06ORFNyWaUHwp4ttdwzEMasFnGRq3zMsqWIFc8x6T
        ZztyoXuqqPeCo78LsoGOneVuX6dJkb4VDbxgmono=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7v7vs6w47njt4pimodk5mmttbegzsi6n; d=amazonses.com; t=1635107629;
        h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:From:To:References:In-Reply-To:Feedback-ID;
        bh=epamjqOsDHUxjeL5U5k1iMHW2E4UgI+KtRHLJQEvqnM=;
        b=T2mN3l5niv9hHMdgS7i6p0kKFDuHPVJpqGkwHeDbW3Cvpk9vuhs0btmT4nPLPELE
        GR0ztzB1bLgjCxWuJtUgYrfFDlB99V5OQxTwGSk/JylHKN8nE+cJSbYLO1rw3ToUjRX
        B7W4HJsD8aLRjnTU5YWG8355ifKyv7IQ/K3pHXw4=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 24 Oct 2021 20:33:49 +0000
Message-ID: <0101017cb4026947-7e22d019-674b-4d1c-b229-b10328252341-000000@us-west-2.amazonses.com>
Cc:     "Matheus Tavares" <matheus.bernardino@usp.br>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git" <git@vger.kernel.org>
Subject: Re: Git submodule remove
From:   "Kalyan Sriram" <kalyan@coderkalyan.com>
To:     "Junio C Hamano" <gitster@pobox.com>
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com> <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net> <xmqqbl3ihu6l.fsf@gitster.g> <CAHd-oW5PfygyNsRWGg4_W2pxR_HbePvguKRf-bK9RtY3cuAX9g@mail.gmail.com> <xmqqee8egddw.fsf@gitster.g> <0101017ca60e5ffd-9563fafd-86f6-443d-9cbe-e07203caacba-000000@us-west-2.amazonses.com> <xmqq4k98en01.fsf@gitster.g>
In-Reply-To: <xmqq4k98en01.fsf@gitster.g>
Feedback-ID: 1.us-west-2.6woXiZ10/hvs78i2LW4ugcJq1GLEuVeUxt3YeADpvNg=:AmazonSES
X-SES-Outgoing: 2021.10.24-54.240.27.185
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Oct 22, 2021 at 3:02 PM PDT, Junio C Hamano wrote:
> "Kalyan Sriram" <kalyan@coderkalyan.com> writes:
>
> > "git rm" deletes the submodule directory completely and modifies
> > .gitmodules, effectively removing the submodule. However, it leaves the
> > entry in .git/config dangling, which is annoying.
>
> The entry is not dangling. It is there to be used when you go back
> in history.
>
> > "git submodule deinit" (which I didn't know existed until I just read t=
he man
> > page) deletes all contents of submodule directory, but leaves the=20
> > (empty) submodule directory itself intact. It DOES delete the entry in
> > .git/config, but leaves a dangling entry in .gitmodules, so the next
> > "git submodule update --init --recursive" registers and populates the
> > submodule again.
>
> "deinit" is *not* about remove a submodule. A project can be
> checked out and used with or without its submodules instantiated,
> and "git submodule init" is a way to instantiate it. "deinit" is
> its opposite. As far as the history (which has already been
> recorded in the repository, and the history that will be recorded
> in the repository starting from that state) is concerned, the
> submodule is there---it's just that you are not interested in it and
> chose not to check it out.
>
> So "git rm" seems to be doing exactly what "git submodule rm" should
> be doing, nothing more, nothing less.

That makes sense, thanks for the clarification. So it looks like there
isn't any work to be done here after all?

What are your thoughts about aliasing git submodule rm to git rm?=20

Thanks,
Kalyan
