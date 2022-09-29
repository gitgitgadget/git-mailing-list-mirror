Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CD2C04A95
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 01:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiI2B4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 21:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiI2B4I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 21:56:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F017FBF72
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 18:56:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82F7B1B9846;
        Wed, 28 Sep 2022 21:56:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZMJppkLdkety
        V7T8Cfpby6NnT0zoh1uzBLaNlTEG8UI=; b=fVOA/Iwj4w9h0CGnNSVrsrPgnvRE
        iCbTz2L/2nZt9/djAYuq2cud8L6T6a7nk/OxmNbCMRRiega6l09tsYz5UT7WgAL+
        U/XdpZH+9kVwx4LxybCUC5AeE3noiNYAHG2gRw6XcWrgaFnnR2HDIhTiHSnki89/
        xlm1x6e9YbtQZzY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BFA01B9845;
        Wed, 28 Sep 2022 21:56:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31E741B9844;
        Wed, 28 Sep 2022 21:56:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: description for non-existent branch errors
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
        <858edf12-67b1-5e2c-dd2e-3eb476530803@gmail.com>
        <xmqqleq6ovh4.fsf@gitster.g>
        <26a5cbe2-d821-e7f6-e56f-4ad90ef2cf2d@gmail.com>
        <xmqqedvw1mmu.fsf@gitster.g> <xmqqzgejtmkd.fsf@gitster.g>
        <a55cf3b7-218d-3c8b-ae1c-c09d49caeda8@gmail.com>
Date:   Wed, 28 Sep 2022 18:56:03 -0700
In-Reply-To: <a55cf3b7-218d-3c8b-ae1c-c09d49caeda8@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Thu, 29 Sep 2022 01:59:35 +0200")
Message-ID: <xmqqmtajosek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E030C93A-3F99-11ED-BD61-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Those changes I think are worth doing along with the fix for the leak
> of 'static const char *head'.

Let's not grow the scope of the topic forever.  It will increase the
chance of new mistakes and throw us into endless iterations.

I think the posted patch plus tests for the new behaviour (i.e. no
longer we give a misleading error message) is a good stopping point.

Extending the behaviour to allow some of these operations that
currently fail on an unborn branch may or may not make sense, and
that should be discussed separately, possibly for each option.
After the dust from the current one settles.

Personally, I do not think a "static const char *" variable that
holds onto an allocated piece of memory smaller than 1kB is
something we should worry about.  Leak checkers should also be smart
enough not to warn about such a variable, shouldn't they?

> And then the error descriptions.  Not just the capitalization but
> some similar but different messages too.

Yup, and that is probably a separate patch after all of the above
settles.

Thanks.
