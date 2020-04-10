Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3270CC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BF0216FD
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lSVSjQ02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDJVEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:04:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59988 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDJVEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 17:04:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA315C5366;
        Fri, 10 Apr 2020 17:04:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Siaaxc6z8xez0fpSy2UpwIkI3Pg=; b=lSVSjQ
        02VfHeANyKo7Zw5K+M56osIPDX8Nlh3K5eCkm4v0bawikEjgYRR1gdrlGD+7tuu8
        PGymF93sFMAha1Kyz5JhPY7JWmf+qd0kGTxTnpR/FgxGvmwKfNJLtmsmdXZD96Yi
        3cnhTiPmNyXkqDXHNzUmnCTLaR8My4ZBaCYuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YNmw6Q152A7mQWAmqJ2xiReROsAGZhkB
        pkxBAR9g6XuQ3RqcMhWwaV2RpMALBu9R69VjA5Mw5KjQECIi8saud/IwBRCIISt7
        DClvmMPPjkNFhc72RMmoq97E9zJg+qmPLLzIIrJxfqmljLQOMlHCRoL+N0WEjTJA
        rusS4R0Wdmg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A19E3C5365;
        Fri, 10 Apr 2020 17:04:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED2F0C5364;
        Fri, 10 Apr 2020 17:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, bturner@atlassian.com,
        sami@boukortt.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/3] rebase -i: mark commits that begin empty in todo editor
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
        <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
        <xmqqpncfhy3g.fsf@gitster.c.googlers.com>
Date:   Fri, 10 Apr 2020 14:04:44 -0700
In-Reply-To: <xmqqpncfhy3g.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 10 Apr 2020 13:42:11 -0700")
Message-ID: <xmqqlfn3hx1v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E829D484-7B6E-11EA-9D8B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> I wanted to base this commit on jt/rebase-allow-duplicate, in particular to
>> add a patch moving his new --[no-]keep-cherry-picks arguments to be close to
>> the --empty={drop,keep,ask} and --[no-]keep-empty flags, since all three are
>> related. But unfortunately that series was based on 2.25, and my series
>> needs to be based on 2.26.
>
> Even though this one might qualify as a regression fix to be based
> on an older track, the other one is a new "feature" and is not even
> in 'next' yet, so there is no reason why we must keep its base on
> maintenance tracks (perhaps its earliest round was first queued when
> 2.25 was the latest tagged release?)
>
> So I am OK to rebase the other topic to v2.26.0; would that help?  I
> already saw there was some entanglement with the other topic in one
> of the patches in this series, so...

This is a total tangent, but when I tried to rebase
jt/rebase-allow-duplicate that builds directly on top of v2.25.0 to
a newer base, after resolving conflicts, "commit -a" and "rebase
--continue", somewhere I seem to have mangled the authorship.  It
could entirely be a driver error, or it may be a bug in "rebase",
especially with recent backend change.  I am planning to come back
to it later to figure out if there is such a bug, but I'd need to
recover from the authorship screwup first, so it may take some
time.

