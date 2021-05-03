Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A1EC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 03:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9A861362
	for <git@archiver.kernel.org>; Mon,  3 May 2021 03:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhECDKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 23:10:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62003 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhECDKc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 23:10:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8FE0113A4F;
        Sun,  2 May 2021 23:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nuqcm3gvpZocuIFgpG2yDTSoI2djfxMwSgp4Ze
        64B9E=; b=ZKbNH95yIxwHMtYFLgkfBkiyqA1yP1kkx4PTJPxewYMyC71Yy7yqwF
        f3jBsOzycnnQZql+WvVvezpTxZXuqlWkquRsQrEi4a7J99GQjpdS0zYWz0KhMUCT
        njnMiEqx1zXJOISdb0jnLKz4bc+qKeeU/9+/JCgSmBQvVYilPsLlQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1E88113A4E;
        Sun,  2 May 2021 23:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E4562113A4D;
        Sun,  2 May 2021 23:09:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Faith <jeremy.faith@jci.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
References: <CY4P132MB00885C970ACF5A277F06E40385419@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
        <xmqqfszac25x.fsf@gitster.g>
        <CY4P132MB00885F00AAA46BCFAC76881B855F9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
        <xmqq5z04fwoz.fsf@gitster.g>
        <CY4P132MB00883DC8ABC72790A15C9630855E9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
Date:   Mon, 03 May 2021 12:09:35 +0900
In-Reply-To: <CY4P132MB00883DC8ABC72790A15C9630855E9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
        (Jeremy Faith's message of "Fri, 30 Apr 2021 09:56:11 +0000")
Message-ID: <xmqqo8dsa4y8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE0E9F26-ABBC-11EB-BAC0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Faith <jeremy.faith@jci.com> writes:

>>I wonder if we can repurpose the command to "match" the
>>misunderstanding, without hurting existing users, by
>>
>> (1) updating the one-liner description of the command in the
>>     documentation;
>
>> (2) keep the EXIT STATUS section as-is; and
>>
>> (3) adjust the code to exit with status that reflects if there was
>>     at least one path that was ignored (not "that had an entry in
>>     the gitignore/exclude files that affected its fate").
>
> If I understand correctly:-
>   (2) requires no change
>   (3) I believe my one line change does this
>
> Which just leaves (1) where current line is
>    git-check-ignore - Debug gitignore / exclude files
> I think with the exit status operating as documented this description still
> works i.e. check-ignore can be used to test if the .gitignore/exclude files
> are working as desired.

As an end-user facing command, we'd probably want to align this more
with the description of check-attr.  I think that the description as
you quoted is OK as-is.

>>That certainly is a backward compatible change, but I suspect that
>>we may be able to sell it as a bugfix, taking advantage of the
>>documentation bug you quoted above.  Of course, people do not read
>>documentation, so scripts that used to use the command in the way it
>>was intended to be used (as opposed to "the way it was documented")
>>will still get broken with such a change, though.
>
> I'm not sure how the old exit status could be used in a useful way but you are
> correct there is a chance that some existing scripts depend on it.

I have a suspicion that the existing tests may depend on the current
"we found a match" semantics---they may not count as "existing
scripts".  We'd need to update them if that is the case.

> I was originally confused by the exit status when using git versions 1.8.3.1
> and 2.25.1. With these versions check-ignore returned 0 when a matching
> pattern was found, it did not matter if it was a positive or negative pattern.
> This did not match the exit status documented in the man page so I thought my
> .gitignore patterns were not working when they were.

Yup, that is understandable as the manpage was utterly wrong, and
its description was so plausible that nobody noticed.

As I already said, I think it is OK to sell this change as a bugfix
to align implementation with the documentation wrt negative results;
in addition to the 3 item list quoted at the top, we might need to
adjust tests (or add tests if we are not covering the "not excluded
because we explicitly have a negative entry" case).

Thanks.




