Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05791C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 00:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1085206F1
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 00:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rw9sd//O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCMAE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:04:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50718 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgCMAE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 20:04:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57EA8C7210;
        Thu, 12 Mar 2020 20:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TkSFex8avqJ+UKv+v1l6UB3SVHI=; b=rw9sd/
        /O9C7JTn2U7yxOwRyTpvNBbc+2Jm0hh39FccEyB3lVWMsKxVpUdUeBbU4dIXNt0H
        D3JyEcGwHt97Kp8Aqf5BQrDAeGXf9sDg+/XB58V1R+BUbdInU1fNlmy1HCvEQmar
        EJtWm9QHQUu2Nh/FtujqqDGA4UtWD6Vyri+TM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JE7GMMD+Ww3aiqeiSSGyPEt2XtXO4TRn
        vS3eCOY3YK2gTWchVCP6uxG9XFAu92IH7N00mkjvX2lTvCqf5cisZfagEn2AtASD
        2AvzJGNYBHLnGlpAMHB37hcTJ+uysSoMrtr/+fmWkp1v3uD/RQAk6edO1iotGvTs
        cIZg34u2Km4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FD6AC720F;
        Thu, 12 Mar 2020 20:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F505C720E;
        Thu, 12 Mar 2020 20:04:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
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
        <xmqqo8t1e01r.fsf@gitster.c.googlers.com>
        <CABPp-BGQ0anV7P19PF6NgosF4psQ=TQp=8B6dt2U+ENE2Ubjew@mail.gmail.com>
Date:   Thu, 12 Mar 2020 17:04:48 -0700
In-Reply-To: <CABPp-BGQ0anV7P19PF6NgosF4psQ=TQp=8B6dt2U+ENE2Ubjew@mail.gmail.com>
        (Elijah Newren's message of "Thu, 12 Mar 2020 15:06:14 -0700")
Message-ID: <xmqqfteddsrj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42288AA6-64BE-11EA-95B1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> We may want to think of a way to strongly encourage those who are in
>> charge of choosing and maintaining the versions of Git that is used
>> in their organization, whose operation depends on the healthy future
>> versions of Git, to run 'next' or at least 'master', to stay ahead
>> of the released versions.  Some education and advocacy is needed?
>
> I agree, it's super cool that Emily and Jonathan distribute 'next' to
> their users at Google and provide us lots of early feedback.  I wish
> we had something similar; currently, the only control I have is
> requesting that some documentation file that includes a recommended
> minimum git version be bumped to something newer, and I usually need
> to provide a reason (I can't just say, "It's the newest release").

Of course, within such an environment, "It's to help make sure that
the upcoming release won't be broken for us" is hard to phrase
in a palatable way for the management :-<.
