Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859E3C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB92206F1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V206q07I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCLTH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:07:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56651 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 15:07:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11239505F7;
        Thu, 12 Mar 2020 15:07:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pQSTGWjALFXzM9ZN/iJ5UilPeO4=; b=V206q0
        7IjJfdGkanifDM12srp4OS+zBNcsqMSTezpPMincT1M0fIRXdwp8WDP0X6FqpFYu
        3twIA6nGKTDloSlEHt+PuVnegJG0OlTGNS5ePT32G8iIEqQCJKFw5wZ7wnkCt8eP
        4NQQaI/Hekq6j4yWWXVk8s3gqAsdaXM7w6Qv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mKa1cN3d5bgRhpcbAgG1FSaYY19atPjc
        y3nzTp5aIa5HBv5ECGLp0I7GnOdZQBA1dZHZGtKxpkWqXNjI1BKFeIzMzo6jrGUe
        CpXMFURkzO5dTV7xQlNc9VVqQKfislfNEN8NoGmzuLJHl0hweGeZ7JZiH1f4Xc6R
        7QcHtnV6gRY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06762505F6;
        Thu, 12 Mar 2020 15:07:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 835C1505F5;
        Thu, 12 Mar 2020 15:07:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
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
Date:   Thu, 12 Mar 2020 12:07:25 -0700
In-Reply-To: <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 12 Mar 2020 09:33:02 -0700")
Message-ID: <xmqqk13pfl3m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5C2A9B2-6494-11EA-A3BB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I'm a little worried about ignoring the setting and just picking one;

I am more than a little worried, too.  I think erroring out is
warranted in this case for exactly the reason you gave here.

> if the setting has been marked and they set it to e.g. "appply" (one
> too many p's), then does it really make sense to just show a warning
> but continue using the backend they didn't want, especially since they
> may miss the warning among the rest of the output?  I'd rather go the
> route of improving the message, perhaps:
>         _("Unknown rebase.backend config setting: %s")

