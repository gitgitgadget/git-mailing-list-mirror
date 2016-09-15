Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 771A92070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbcIOS2A (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:28:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58844 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751502AbcIOS16 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:27:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23AC13BA0C;
        Thu, 15 Sep 2016 14:27:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UkU7B8IAhdg/u30QkOX1Pgid2Zc=; b=KLyM80
        4KmbIM2BTkhOVFDpcFoTRAcKBlDSlbMtLYZoerikMgbziJmiNL8XCwhapy2tNb87
        UG3f3NO/faGbKwtQdLQijOY2lKRQsGuXpNB2nKacDQ1cpSKk74X6cg5Y69jlV/gz
        0VAv6Yt8Ui2buw74f+Tz36qdM4Wt7uneqzwMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tOLppvoxw/exETgXT4bZBUWp7VN1hJ7u
        LpoKi+f5yzVfhU6VPDKhb6A1rM+nOUxLWMoyZLJgom9QmFziQhLoq2BFZFE7qHRF
        xs5KjRa8JU255L+5RqfDK/WshmQ5OWw/gPKhsbEcBpb8TW5DS4bjD/RSTH+kWgxi
        M0swPJsuFTw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B4243BA0B;
        Thu, 15 Sep 2016 14:27:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C2A23BA0A;
        Thu, 15 Sep 2016 14:27:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Yaroslav Halchenko <yoh@onerussian.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [wishlist?] make submodule commands robust to having non-submodule Subprojects
References: <20160915130233.GC9833@onerussian.com>
        <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
        <xmqqwpidniry.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbYEqbr0h_0U=Ed-NRrsjb4XmznL8C45gTyJCVx+X-LTQ@mail.gmail.com>
Date:   Thu, 15 Sep 2016 11:27:54 -0700
In-Reply-To: <CAGZ79kbYEqbr0h_0U=Ed-NRrsjb4XmznL8C45gTyJCVx+X-LTQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 15 Sep 2016 11:15:16 -0700")
Message-ID: <xmqqsht1nhlh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F830762-7B72-11E6-B4F1-90D812518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>     When searching around the net, some people use half
>     initialized submodules intentionally,...
>
> Not sure I agree with such a setup, but people use it.

In such a top-level project, people would not use "git submodule"
command, would they?  I do not think anybody in this thread was
pushing to forbid such a use, and it may be perfectly fine if "git
submodule" does not work for such a gitlink; after all such a
subdirectory is not even meant to be a submodule.

> So how about this fictional work flow:
>
>          $ git init top
>          $ cd top
>          $ git commit --allow-empty -m 'initial in top'
>          $ git init sub
>          $ git -C sub commit --allow-empty -m 'initial in sub'
>          $ git add sub
>         You added a gitlink, but no corresponding entry in
>         .gitmodules is found. This is fine for gits core functionality, but
>         the submodule command gets confused by this unless you add 'sub'
>         to your .gitmodules via `git submodule add --already-in-tree \
>         --reuse-submodules-origin-as-URL sub`. Alternatively you can make this
>         message disappear by configuring advice.gitlinkPitfalls.

I am not sure if I agree with that direction.

If the trend in Git community collectively these days is to make
usage of submodules easier and smoother, I'd imagine that you would
want to teach "git add" that was given a submodule to "git submodule
add" instead by default, with an option "git add --no-gitmodules
sub" to disable it, or something like that.

>          $ git submodule add --fixup-modules-file ./sub sub
>          Adding .gitmodule entry only for `sub` to use `git -C remote
> show origin` as URL.

I agree that a feature like this is needed regardless of what
happens at "git add" time.
