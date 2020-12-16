Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F05C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C462D2389A
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbgLPXZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:25:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52329 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730793AbgLPXZP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 18:25:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C6CEFEBEA;
        Wed, 16 Dec 2020 18:24:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u+RCbCmwPegZYAHndgplEGT/ZSo=; b=x5uY/e
        Tz7IZqzvyJGJTCAkt4vr7bjKKiri4C8uPRr3fHWTHrrA4GBbmlh8bFl84KidLFg8
        VdxiGLY/vNOywYlC8R9zBn1zmNtyUuq+kQmjY3Tv1yMWLEoairqtCZBwmEFfoGIu
        NwR3EOfozCkfLA7HFF1dsgCYjGcjrzgsajOsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xO0TyU7SWI8oETdn3cMqEEJEn4niqNUZ
        FN14Ajtn07XxFmpNRBJu3NTm7P4o6EGUpkVRUHtmHoiQPj1qwbsarzSq1rfgDilS
        o80Rb69TuEJ77lIGIxbVI70Cknl7dtdCCwZF7GP34Az3yiMPi9l3ttpK67phLKir
        XrxiuKJ/22c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65FACFEBE9;
        Wed, 16 Dec 2020 18:24:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA209FEBE4;
        Wed, 16 Dec 2020 18:24:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stuart MacDonald <stuartm.coding@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [Bug report] includeIf config is not displayed in normal
 directories
References: <CAPQE4+qq11W9VzftJ6y+cbdJ1x64c8Astjwd4z4M-oc5hv1jeA@mail.gmail.com>
        <xmqqczza7lpm.fsf@gitster.c.googlers.com>
        <X9pe119edtL5KQTU@coredump.intra.peff.net>
        <CAPQE4+rhWT9kgusNXOw5cnJ-oFq++4G1FMaXvQ3wppQ0GE0hSA@mail.gmail.com>
Date:   Wed, 16 Dec 2020 15:24:28 -0800
In-Reply-To: <CAPQE4+rhWT9kgusNXOw5cnJ-oFq++4G1FMaXvQ3wppQ0GE0hSA@mail.gmail.com>
        (Stuart MacDonald's message of "Wed, 16 Dec 2020 15:43:31 -0500")
Message-ID: <xmqq5z512v2r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D91E1526-3FF5-11EB-A340-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stuart MacDonald <stuartm.coding@gmail.com> writes:

> My old understanding of git clone:
> - create sub-directory
> - create subdir/.git and whatever initial states are needed
> - clone the repo from origin into the directory
> - all never having left $CWD
>
> It's actually:
> - create sub-directory
> - cd subdir
> - create ./.git and initial states
> - clone the repo _while inside_ a gitdir
> - cd ..

I am not sure how the above two should make any difference with the
[includeif "gitdir:<pattern>"] matching.  Regardless of where your
$CWD is, the inclusion is decided on the location of the .git/
directory we are dealing with, so as long as "subdir/.git" matches
the pattern given to "gitdir:<pattern>" the inclusion should work
the same way even if the internal implementation of "git clone"
changes between the above two.

IIRC "includeif" is a Peff's brainchild, so I'd ask him to correct
any mistakes in the above paragraph, but I am a bit puzzled as to
what the true misunderstanding is, where the misunderstanding came
from, and which documentation if any we should look into improving.

Thanks.

