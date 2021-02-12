Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A65C433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 22:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16F964E92
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 22:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhBLWWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 17:22:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63402 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhBLWWR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 17:22:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13FD5127910;
        Fri, 12 Feb 2021 17:21:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l3lrkL6Zq+cLebucJa6XtA+e2lw=; b=TqeZGo
        /zBPtrpeqeGTFVAB5O3DP196+ToGeyanUlllp98nXbgH/iu5UxPE0smZb/va45jp
        39vDYhSjqx9qeraD8l0+g1WVPJm2E4l/+nZwFllZHnk8dyt6XNS8kV3Al4b7osGX
        AZ78NkvVvxGIBnQxnPa+NZ6/OpgEVvdPsaZfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PcEv7MZV7nvtLGxf0FOa+y7KZw9CH8OO
        RzpVIeV25VS85o+ZrYb8l7pIJybimvy+DEluByEgKh2yM9/BtVCkenTgTW+Bzwy9
        5W5Pa3GgCT37qK8628XR8aoE5I8qkX0PlXYLuACE72V5LBJ+WkLEnLl+lRb7Qevk
        0OWZL/XsDto=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D0D912790F;
        Fri, 12 Feb 2021 17:21:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 05DDE12790B;
        Fri, 12 Feb 2021 17:21:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Nicholas Guriev <nicholas@guriev.su>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] mergetools: support difftool.tabbed setting
References: <2fb58fd30ae730ccd3e88ec51b5fe6d80ab7a8c7.camel@guriev.su>
        <CAJDDKr4zM1ZuNc+JpQnAtqwa5Ljv7_5bL3X-cC3e5Xg3z2Cbcw@mail.gmail.com>
Date:   Fri, 12 Feb 2021 14:21:29 -0800
In-Reply-To: <CAJDDKr4zM1ZuNc+JpQnAtqwa5Ljv7_5bL3X-cC3e5Xg3z2Cbcw@mail.gmail.com>
        (David Aguilar's message of "Thu, 11 Feb 2021 21:51:24 -0800")
Message-ID: <xmqqmtw9udue.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8375F9A-6D80-11EB-81A2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> I'm not really sure if "tabbed" is the best name for what's going on,
> though.  It's really more of a "diff everything in one shot" mode, and
> it just so happens that the tools in question use tabs.

This statement matches my reaction to this new feature exactly.

The way the external commands are triggered via GIT_EXTERNAL_DIFF
mechanism makes it "easy" to show changes for one path at a time and
"hard" to do so for all paths at once, but the resulting end-user
experience that is forced to view one path at a time may be awkward.

> That said, I wonder whether we need this new feature, or whether we
> should instead improve an existing one.  I'm leaning towards improving
> the existing dir-diff feature as a better alternative. ...

As a non-user, I have no strong opinion on the "new feature"; other
than that I trust your judgement on the "difftool" design issues,
that is.

Thanks.
