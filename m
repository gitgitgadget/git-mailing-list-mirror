Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BADC433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2A8235DD
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbhAGV07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:26:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54921 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbhAGV07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:26:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DE0CAB0CC;
        Thu,  7 Jan 2021 16:26:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=yX3eiJ1TQ7MFFZDRCXDH480cqWc=; b=u0u2uChKgKirLNaWxEga
        ZPxNRfSw9dAARu5ebHlNx98qg1D58JeHNKJUXihi3wkkPgGJgx1YXjJhHui5kHIi
        pHcHG9iihPy51pOXpltWTuLzaSV1tk9yJqOcYnVnm2hrLccVaasd+LZ9+aeAye54
        RSID9FGzeVC8YW7hA1oJjWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=v1/0e+rFbISX5dfDeNbR1yg9CDr1ZrPyhzEjYDLQeAt+nJ
        YCf2w4ybaNX7gNuRsXzVunzTI7No1Q0CRhrmCLNKS7zt5IcXRLPuGjU8BJoUXRGa
        DBJKLSaGSWDif8UDbQnIZ4zTMFJi94xhC5BjRXfqeTmiC9vRZhbyPWaVim9n0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67177AB0CB;
        Thu,  7 Jan 2021 16:26:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6B9FAB0CA;
        Thu,  7 Jan 2021 16:26:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v9 5/5] mergetool: add automerge_enabled tool-specific
 override function
References: <20201228045427.1166911-1-seth@eseth.com>
        <20201228192919.1195211-1-seth@eseth.com>
        <20201228192919.1195211-6-seth@eseth.com>
        <xmqqpn2ivcc1.fsf@gitster.c.googlers.com>
        <20210107035806.GA530261@ellen>
        <xmqqy2h5meum.fsf@gitster.c.googlers.com>
        <20210107092716.GA548935@ellen>
Date:   Thu, 07 Jan 2021 13:26:17 -0800
Message-ID: <xmqq1rewl9qe.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA999C76-512E-11EB-8CF4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> On Wed, Jan 06, 2021 at 10:38:09PM -0800, Junio C Hamano wrote:
>> By the way, do you have any idea why we see test breakages only on
>> macos when this topic is merged to 'seen'?
>
> Thanks for those links. I have an OSX machine nearby and will
> investigate tomorrow.
>
> Related: are the Windows tests affected by this patch? I wanted to check
> for myself but I've been struggling with getting Git-for-Windows
> installed in a VM.

On the left hand side of the page I gave the links to, it shows that
'windows-build' job is failing (and windows-test jobs are not run as
a consequence).  I am not sure why it failed, but I have a feeling
that the build machinery hasn't even seen the code being built when
it errored out.

  cf. https://github.com/git/git/runs/1659807855?check_suite_focus=true#step:3:40

So we cannot tell (yet).
