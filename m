Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F7FC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C957A6162E
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhJVDeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:34:31 -0400
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:40625
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232619AbhJVDea (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Oct 2021 23:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=cessssaigkdq5uletp7pzdlghxldyiuc; d=coderkalyan.com;
        t=1634873533;
        h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:From:To:References:In-Reply-To;
        bh=itmrT4W8gouG/gh0ktxxu68Rog0ujenQyUkNfPLRNCY=;
        b=CkfIjJs/6vjdhY8ByYN1LcYqc80N4ramA/2nd/M64AlgdD/iNSwLJQZvqPorI4ac
        vUGNQST3irSxuzEYbPnCef+bPdef194r/16o/H8DxhB63apGzVFH2jRGBJpfGieIPka
        7jB4yBQJsVoia/ZlLjXYxTYb2LK4QM2HWeCn12eE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7v7vs6w47njt4pimodk5mmttbegzsi6n; d=amazonses.com; t=1634873533;
        h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:From:To:References:In-Reply-To:Feedback-ID;
        bh=itmrT4W8gouG/gh0ktxxu68Rog0ujenQyUkNfPLRNCY=;
        b=iQI8KHLB6NxfhWHcG/cqf2vgE+NsXLUoS4/OrITBgW7KwEV0wLB2cp/vr19lwrfF
        RtAx0UpfRrndhld/WmwA5ZHaMXVa0bx3bXheg5p2cn3FoU/qGhSrjCV2XxPqx+wAPhd
        qTA3uRbmZNJvxbtDzLV40efWSv1Vd8XxObSL2H+c=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 22 Oct 2021 03:32:12 +0000
Message-ID: <0101017ca60e5ffd-9563fafd-86f6-443d-9cbe-e07203caacba-000000@us-west-2.amazonses.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git" <git@vger.kernel.org>
Subject: Re: Git submodule remove
From:   "Kalyan Sriram" <kalyan@coderkalyan.com>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Matheus Tavares" <matheus.bernardino@usp.br>
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com> <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net> <xmqqbl3ihu6l.fsf@gitster.g> <CAHd-oW5PfygyNsRWGg4_W2pxR_HbePvguKRf-bK9RtY3cuAX9g@mail.gmail.com> <xmqqee8egddw.fsf@gitster.g>
In-Reply-To: <xmqqee8egddw.fsf@gitster.g>
Feedback-ID: 1.us-west-2.6woXiZ10/hvs78i2LW4ugcJq1GLEuVeUxt3YeADpvNg=:AmazonSES
X-SES-Outgoing: 2021.10.22-54.240.27.55
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Oct 21, 2021 at 4:35 PM PDT, Junio C Hamano wrote:
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > On Thu, Oct 21, 2021 at 7:47 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >>
> >> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >>
> >> > On 2021-10-21 at 17:25:38, Kalyan Sriram wrote:
> >> >> Hello,
> >> >>
> >> >> I was curious why git-submodule does not have an `rm` command. Curr=
ently
> >> >> I have to manually delete it from .gitmodules, .git/config,
> >> >> .git/modules/, etc. See [0].
> >> >>
> > [...]
> >> I'd imagine that the happy-case implementation should be fairly
> >> straight-forward.  You would:
> >>
> >>  - ensure that the submodule is "absorbed" already;
> >>
> >>  - run "git rm -f" the submodule to remove the gitlink from the index
> >>    and remove the directory from the working tree; and
> >>
> >>  - remove the .gitmodules entry for the submodule.
> >
> > I think "git rm <submodule>" already does these three steps, doesn't it=
?

Wow, this is a surprise. Looks like this behavior is mentioned in the
man page but is not very well known.
> So perhaps "git submodule rm" would just become a synonym for "git rm"?
>
> Thanks.
Almost, yeah, but not quite. I ran a couple quick tests to clarify my own
understanding of how submodules work, and found that:

"git rm" deletes the submodule directory completely and modifies
.gitmodules, effectively removing the submodule. However, it leaves the
entry in .git/config dangling, which is annoying.

"git submodule deinit" (which I didn't know existed until I just read the m=
an
page) deletes all contents of submodule directory, but leaves the=20
(empty) submodule directory itself intact. It DOES delete the entry in
.git/config, but leaves a dangling entry in .gitmodules, so the next
"git submodule update --init --recursive" registers and populates the
submodule again.

>
> Wow, that is a unnerving layering violation, but I suspect it is too
> late to fix it.=20
I agree, it's probably too late to change the behavior of "git rm"
regarding how it treats submodules. That said, I think the cleanest
solution would be to update "git rm" to also remove the dangling
.git/config entry. Then, I could make "git submodule rm" a synonym for
"git rm" for clarity. This would probably also involve updating
documentation in multiple locations to make sure everything is
consistent, and verifying "git rm" doesn't leave anything else about the
submodule dangling. Please let me know if anyone has a better idea for
anything I listed.

Thanks for your input so far, Junio, Matheus, and Brian! If no one has
any objections, I'll figure out how to make these updates and send a
patch along.

Thanks!
Kalyan
