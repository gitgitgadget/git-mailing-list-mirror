Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552FEC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 21:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC5C64DE1
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 21:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhBKVxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 16:53:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54388 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBKVxA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 16:53:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E892A434F;
        Thu, 11 Feb 2021 16:52:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QTslA44tDzo/9vKq8lmjQ4RAnS4=; b=m6/eR7
        7OZrtnKv/WNJ7FXlzZnf9VvzFD6vxWcFLpRroOoahRS1V0RYXVeNLaUB0SHteW/G
        ORBVVtJmuZtcQjTWzinpyVdZBc/LXEN1/iZRZWEaE3pkQMN34590USh2Sg0jb1gz
        ND3Ni5vV/sG1cw+d0FdnPMHIDXFsZXgIETy/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YfDa+7PHTTsDqlNsAoYb9kA8GGsUsW83
        FUwc33W+QbFXpQGOcGCACsW/hLboP4ezPaomLa3EPZoXdousTsXTRWwyuEKTmGd1
        ZxC0MvFrHeKdreLp0rebawIJQhy8vewnYQEaokeyqpYLJWPaJsL3wk4mgK4bE+Uf
        xUrrPlPURkU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9613DA434E;
        Thu, 11 Feb 2021 16:52:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21008A434B;
        Thu, 11 Feb 2021 16:52:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 0/2] use unique out file in t5411
References: <20210120124906.GA8396@szeder.dev>
        <20210121025331.21658-1-worldhello.net@gmail.com>
Date:   Thu, 11 Feb 2021 13:52:17 -0800
In-Reply-To: <20210121025331.21658-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Wed, 20 Jan 2021 21:53:29 -0500")
Message-ID: <xmqqft22w9v2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6900480A-6CB3-11EB-974A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> t5411 has some test cases for the behavior of failed 'git push'
> commands.  Even the 'git push' command ended, the output file
> may still be updated with messages from 'git-receive-pack' command
> running in background.  This breaks test cases which reuse the
> same 'out' file.

I do not recall hearing from SZEDER who raised concerns about "a lot
of churn that can be avoided by a change in the code to die more
gracefully" in his previous round's review.  This has been in 'seen'
for a long time, so let's move it down to 'next'.

Thanks.
