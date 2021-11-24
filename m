Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DC0C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 22:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245129AbhKXWTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 17:19:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57590 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbhKXWTN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 17:19:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69371167A1B;
        Wed, 24 Nov 2021 17:16:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wpWTrDCtiIoW+Sbd0DDwI05tSJqLSao4XdSfKj
        OlukY=; b=g3LH39QyHKg0/GJKz+R9ZOHp08dNDCo4b98iFVPDbkTtYXFT1uCbTg
        I653JwxsFouGZuUEQBldUKvMjZ2AQQj3FmqLKTVjN4K/VuxDOK+7ZzDjykBNrylm
        3bOT1BDtwzVQ29oyt+zp9S8/D+T9+xCbb9r5o4IA9PH1sQ2PM8ivs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55D64167A1A;
        Wed, 24 Nov 2021 17:16:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2775167A16;
        Wed, 24 Nov 2021 17:16:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin von Zweigbergk <martinvonz@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Letting tools partially resolve conflicts in a file
References: <CANiSa6iNpm6--qHpUFYhPfSi+ounGttA8=TAsep18A-=iyoFEQ@mail.gmail.com>
        <xmqqmtltz1vp.fsf@gitster.g>
        <CANiSa6iAXAXeDCh_OK=-wLPQiFSWFxRyCSC0SVvTJ8Gp4wdQ7w@mail.gmail.com>
Date:   Wed, 24 Nov 2021 14:15:59 -0800
In-Reply-To: <CANiSa6iAXAXeDCh_OK=-wLPQiFSWFxRyCSC0SVvTJ8Gp4wdQ7w@mail.gmail.com>
        (Martin von Zweigbergk's message of "Wed, 24 Nov 2021 14:03:08 -0800")
Message-ID: <xmqqwnkx9p40.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B138812-4D74-11EC-8FC1-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> The solution I had in mind for letting merge tools communicate partial
> resolution was to let them take 3 inputs (as today) and produce 3
> outputs (perhaps by overwriting its 3 inputs). That way they can leave
> conflicts in a conflict-marker-agnostic way. ...
>
> Correct. My team at work hopes to create a language-aware mergetool.
> The "#includes and imports" I mentioned is just one case that such a
> tool could resolve. Hopefully it can also figure out cases like where
> both sides modify an array (on a single line), or where an expression
> is modified on one side and re-wrapped on the other. The thing is that
> it will obviously not be able to handle *all* conflicts, so we want to
> leave remaining conflicts for the user, so that's where this idea
> comes in. I don't foresee having more than one such tool in the chain
> before the user gets involved.

Hmph, OK, so the part I guessed that more than one such tools are
chained together was incorrect.  I do not find it too implausible to
wish to first let the "include/import" tool to clean up the fallout
of renaming the include/module files this source depends on, and
then let the "renamed variable" tool to handle the fallout of
renaming a local variable in a file in this source file, in this
order or the other way around.  It may be a tall order to write a
tool that can handle *all* coflicts, but it would be a nice future
to see that multiple tools, each of which specializing one corner of
its own, work well together.



