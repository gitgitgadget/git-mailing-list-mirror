Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D661C43463
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 21:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1002083B
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 21:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RCddNISZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgIQVj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 17:39:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55546 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgIQVj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 17:39:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04F9D88ABD;
        Thu, 17 Sep 2020 17:39:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:cc:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=alI8X9okKpe3uC6eUcxNq9vOjU0=; b=RCddNI
        SZECrobV8SN8t8f0kDsNtIMXLT7p1dC/lF5002kLRxuLj88q7t+mT52zwmry3Y6T
        OcrzReBikAiNfHMvGS7EFyJDaeilRjiwUzmumNeJ5jEBG7omHlQ5WwP9h6nCF52B
        HCldmpm8chwe5pSxYG30e6a8SeaPzs0gTIl40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:cc:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Em34+S8fGJEQiEMSoefR4X0wqMXOpE/B
        5jC3uYb0fkM2KcjsZ9mZkq/idBQf80LoDp/oXmYDP3b6Dy+vgR0GPBtzQUgH5r1s
        XZTBTYjDilvCgoJJQCK7gVLhWFslpNpG8f7Eh8Y0bipigXwzD9a+TUz/Luzm5JzP
        MlahhSz3EYs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFBD088ABC;
        Thu, 17 Sep 2020 17:39:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76E3D88ABB;
        Thu, 17 Sep 2020 17:39:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Sep 2020, #04; Wed, 16)
References: <xmqq8sd9t679.fsf@gitster.c.googlers.com>
cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 17 Sep 2020 14:39:53 -0700
In-Reply-To: <xmqq8sd9t679.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 16 Sep 2020 20:47:38 -0700")
Message-ID: <xmqq363gqdzq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53074240-F92E-11EA-A483-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * js/no-builtins-on-disk-option (2020-08-24) 3 commits
>  - ci: stop linking built-ins to the dashed versions
>  - install: optionally skip linking/copying the built-ins
>  - msvc: copy the correct `.pdb` files in the Makefile target `install`
>
>  The installation procedure learned to optionally omit "git-foo"
>  executable files for each 'foo' built-in subcommand, which are only
>  required by old timers that still rely on the age old promise that
>  prepending "git --exec-path" output to PATH early in their script
>  will keep the "git-foo" calls they wrote working.
>
>  The old attempt to remove these executables from the disk failed in
>  the 1.6 era; it may be worth attempting again, but I think it is
>  worth to keep this topic separate from such a policy change to help
>  it graduate early.
>
>  Expecting a reroll to update log message for the last one.
>  as it confused at least two reviewers.
>  cf. <xmqqwo1baop3.fsf@gitster.c.googlers.com>
>  cf. <20200903104537.GA27325@szeder.dev>

I think this is more or less good modulo the way the last bit is
explained.  No rush, but just trying to make sure it will not stay
stalled forever.

Thanks.
