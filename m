Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723E4C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2855B61874
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhC1Bem (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 21:34:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59260 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhC1BeY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 21:34:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A73EBA8AF2;
        Sat, 27 Mar 2021 21:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K/xn5kG6X4yFpBcEJGv8iWWUg8M=; b=GmxhUX
        qC+s/vJ/rsoiMZId+5Sc+sMAl9tiW9kLn9rVkduIxVIo0a6Na2WzxfitA7c9PTdk
        zLV6rqHyRF+x9MVi5etJQl8iWglbFsH2YFqtgYF8H61zEfpZWJGg+s+zBTrQ5PPo
        /luNCHNxrARCiMAq2GAlwZd/QhwTfFNI8I2yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k+9wkUZfxGpeYogPIYPJx9DdkfTv94x8
        QfHhiKa0bi5LkjYREhuKJUA5TtLG8Ztj2W6r6kMozK01LqbgJaAsVc+X7wmybosG
        sUzoAcgEakXKCIdZn3K8DDGVv+nYORCUVCwe0unNEH4uuZywgD2//7u8+QGxhDmP
        s0uKIUJEIUo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A021AA8AF1;
        Sat, 27 Mar 2021 21:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2AB80A8AF0;
        Sat, 27 Mar 2021 21:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] doc lint: fix bugs in, simplify and improve lint
 script
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
        <patch-4.6-5c8e8f21495-20210326T103454Z-avarab@gmail.com>
        <a7e1bbc1-eb3e-72d0-ef65-24cc38346a04@iee.email>
Date:   Sat, 27 Mar 2021 18:34:22 -0700
In-Reply-To: <a7e1bbc1-eb3e-72d0-ef65-24cc38346a04@iee.email> (Philip Oakley's
        message of "Fri, 26 Mar 2021 12:48:45 +0000")
Message-ID: <xmqqo8f4oych.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9858252-8F65-11EB-AA95-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 7313956d73f..6bfd8c75772 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -4,6 +4,7 @@ MAN5_TXT =
>>  MAN7_TXT =
>>  HOWTO_TXT =
>>  INCLUDE_TARGETS_TXT =
>> +ALL_TXT =
>
> Maybe LINT_TXT would better clarify its use, rather than squatting on
> the generic "ALL"?

As long as it is truly "all the .txt files" and will stay that way,
and the set of files we lint happens to be "everything under the sun",
I am OK to have this as ALL_TXT.  We may in the future want to do
something other than running lint-foo scripts to all the .txt files.
