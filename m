Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD1AC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 19:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiJYT2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJYT2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 15:28:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A141D0CF6
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 12:28:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46D4E15989A;
        Tue, 25 Oct 2022 15:28:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Y5ousCfYPaKu
        kfY1HcRyCOTFUcBaSzO+QRqFz26yuKg=; b=oSxspugwqEnfb7uboLW+QwXVF2aH
        jGmqhU7qxJxqzgdlMej+tv2/gKLx/OA0JHRWUubSXMJlKCusCSvklBtMlswoV66Q
        gFT5FATwLUHaTsWGMyu3VXaqCQnzYvaoipjwKLifxhNuAmL/vPoay6noh8bonSRe
        ovop9seDkNs0W+c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E5FC159899;
        Tue, 25 Oct 2022 15:28:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E7BE159898;
        Tue, 25 Oct 2022 15:28:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: error and informative messages
References: <3f63d53d-2e14-ffe0-6263-2a15f83453ad@gmail.com>
        <xmqq5ygaul5k.fsf@gitster.g>
        <faf7a985-f6ef-f20a-3857-031396124d60@gmail.com>
Date:   Tue, 25 Oct 2022 12:28:37 -0700
In-Reply-To: <faf7a985-f6ef-f20a-3857-031396124d60@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Tue, 25 Oct 2022 01:39:02 +0200")
Message-ID: <xmqqzgdjn1ne.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 39DFC858-549B-11ED-BDC0-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>>> 	- "no such branch '%s'"
>>> 	- "branch '%s' does not exist"
>>> 	- "invalid branch name: '%s'"
>>> 	+ "no branch named '%s'"
>
> Yes, I had doubts with the third.  The error is referring to the source=
 branch
> in the copy/rename operation, so I think it makes sense to say that the=
 branch
> doesn't exist, even if it couldn't.

OK.  As long as it refers to a branch that ought to exist, then
using the fourth one is perfectly fine.

> I prefer a single term like 'modify' as I find it less confuse than 'se=
t or
> unset'.

OK.

Some folks find it unsure and confusing if 'modification' includes
'deleting/unsetting', and that was why I brought up 'set or unset'.

>>>  - "%s" and "'%s'" was used to format a branch name in different
>>>    messages.  "'%s'" has been used to normalize as it's the more
>>>    frequently used in this file and very common in the rest of the
>>>    codebase.  The opposite has been done for options: "-a" used vs
>>>    "'-a'".
> ...
> Same reasoning as above.  It is a system-chosen term, but the message
> has not a placeholder to put a value, we're using a literal.

I doubt that "same reasoning" is sensible. I'll welcome input from
others, but=20

    $ git grep '"[^"'\'']*'\''--[a-z]' \*.c

looked very reasonable, and after imagining the output with them
losing the single quote around the option name, I would think they
are better with the quotes around them.

>>> Finally, let's change the return code on error for --edit-description=
,
>>> from -1 to 1.
>>=20
>> OK.  That last one may be better to be a separate patch, as these
>> wording changes are subject to discussion and bikeshedding.
>
> Mmm, I thought about that.  This change is one that we've been delaying=
 because
> it might break something due to a change in the way we report errors.  =
We're
> specifically changing this here and the change is small, so I found app=
ropriate
> to do it here.

Not really.  Nobody reads error messages, but programs can react to
exit codes.  It is more important to get the latter right.

>> This does not fall into any of the categories the proposed log
>> message discussed.  Rather, it looks more like "the code
>> subjectively looks better this way".  It happens to much my
>> subjective taste, but that does not change the fact that we
>> shouldn't distract reviewers with such an unrelated change in the
>> same patch.
> =20
> It certainly looks subjectively better, and in less lines...

As I said, it does not matter.  It is outside the scope of "improve
error messages" and should be done outside the series, or at lesat
as a separate step in the series.

>> And that should be a separate patch, that can be reviewed and
>> applied regardless of the rest of "error messages cleanup" topic.
>
> Good point.  I didn't think about that and it also goes in the line of
> the previous patches in this file.  I'll review that.  Also gives a goo=
d
> opportunity to fix that repeated code /... if (copy) ... else if
> (rename)/.

OK.  But again, that is outside the topic of "improve error
messages".

Thanks.

