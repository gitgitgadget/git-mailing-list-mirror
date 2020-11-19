Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D38C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 23:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505CA22227
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 23:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IRUIZLCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKSXfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 18:35:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54052 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgKSXfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 18:35:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3221E11701F;
        Thu, 19 Nov 2020 18:35:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=INlcooPxPfEFzves0dyPm7Uj1sQ=; b=IRUIZL
        CRjydv5hoh1vA4XOzbVbR3VNzzR8XqezyOwN9F/CaWYU1dmxHiCj2WOwt2Ryoo5h
        TR9HASaGkK9odkw5vHGxvTLNnr86MWtFJc8E5zwGxq6JgRJcSUB0l+4oxN2Yi6lm
        8t6YU/7XdvqnoGS1CLC5p77Hkm2L8XW5AFVY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jl7o5V1N9CMHFKpyFGI4gEKuiUd0HDLV
        5a6I0P9X/vIu0pk2ulrylSlPNotVg3q3haJDHSLPrsc4tz862bQuC7RsIKJG7F7q
        Arxzdn4n6Fdp1xbPdE4xte24noCFF8dvLXQ8sxjFVdtQERVR2XivPEWfve7albAp
        jiedt7Xz30I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A42311701E;
        Thu, 19 Nov 2020 18:35:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 59C0011701D;
        Thu, 19 Nov 2020 18:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 00/28] tests: use main as default branch name
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 15:35:12 -0800
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 18 Nov 2020 23:44:18
        +0000")
Message-ID: <xmqq3614x6mn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF9FCBCE-2ABF-11EB-B16B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Note that this branch is based on next, mostly because it would otherwise
> conflict with en/merge-tests, jk/diff-release-filespec-fix and 
> ds/maintenance-part-3.

Note that what is queued in my tree is unlikely to be based on
'next', but instead start by merging jk/diff-release-filespec-fix
and possibly the fix-up for ds/maintenance-part-3 into 'master' and
then applying these patches on top.  

This will be time consuming but cannot be avoided ;-)

I just started building such a topic branch.  It is likely that
the result of today's integration cycle would be pushed out much
later than usual.

Thanks.
