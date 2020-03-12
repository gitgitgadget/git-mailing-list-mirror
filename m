Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D278CC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD09206CD
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SvnDgPMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgCLV1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:27:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64466 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgCLV1f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 17:27:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0F093CCA5;
        Thu, 12 Mar 2020 17:27:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7H2R+h9v1q6ta1ARQQOBra+9TXc=; b=SvnDgP
        MK+1CleaTS6KEZxnO8Bb8O267JAu3dHAJBd29MW6kxk0Eht/vQ6CIw0lQZvdjDuV
        pxd7VT8mDwKvuPWmXE0m6fu+499DP4YC4W+O3GCv80T7GO0tGrKdQAt79gLgDt3q
        Xd/I6OMiDsZsl7xAOwvXYcrOFn5RjceUrPBRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P4+NP7upVC58ebq9B0JCLPjp5kDwumcH
        iouxD2MibLPLK+dlGFdJqTj6JN8jt9lFzK3pY7Rc3zmLPX6qssAMVdD0NUAqEnwx
        tb7MXQJdhKf22j50kI3YG4bBUDxzi1AmiPymD7C7NZR/YrJwyqXFv4LWxx/RnBUU
        H3zVqtV2gUw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B85BE3CCA2;
        Thu, 12 Mar 2020 17:27:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4027E3CC8F;
        Thu, 12 Mar 2020 17:27:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
        <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
        <20200312151318.GM212281@google.com>
        <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
        <xmqqftedfkvy.fsf@gitster.c.googlers.com>
        <CABPp-BGvqUEDoj6_mUAsSVeS8+h5ruCFcMTENtf5LY2XWKVj-g@mail.gmail.com>
        <20200312203718.GA870787@coredump.intra.peff.net>
Date:   Thu, 12 Mar 2020 14:27:28 -0700
In-Reply-To: <20200312203718.GA870787@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 12 Mar 2020 16:37:18 -0400")
Message-ID: <xmqqo8t1e01r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46C4AEFC-64A8-11EA-9350-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Though in this particular case, I don't mind too much just leaving "am"
> as an alias for "apply" (it was actually the first thing I tried when
> writing my earlier emails, but I'm probably not a representative user
> there). Putting that in a release, though, may mean supporting it
> forever. :)

Yeah, I agree that what used to exist only in 'next' and we chose to
remove it before it its 'master', does not deserve to be supported
forever.  So let's scrap the "am is taken as a synonym for apply".
It would not help the old version taken from 'next' grok a new
configuration file that uses "apply" anyway ;-)

> I guess like your email I'm going back and forth between the two
> options. I think that means it probably doesn't matter _too_ much either
> way.

OK, let's avoid screwing it up even further by doing no more damage
than merging just the three fix-ups we discussed recently.  

The fact that jrnieder runs 'next'+patches for his $DAYJOB users
makes me hope that there may be other organizations that do the
same, and cooking in 'next' would mean somthing, though.

We may want to think of a way to strongly encourage those who are in
charge of choosing and maintaining the versions of Git that is used
in their organization, whose operation depends on the healthy future
versions of Git, to run 'next' or at least 'master', to stay ahead
of the released versions.  Some education and advocacy is needed?

