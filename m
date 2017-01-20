Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32EA220756
	for <e@80x24.org>; Fri, 20 Jan 2017 22:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbdATWWY (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 17:22:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57638 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752981AbdATWWW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 17:22:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 257B763149;
        Fri, 20 Jan 2017 17:22:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H+MqLhgrCND16JiUABn7hYjsSMM=; b=dE56W9
        uzLAYztSArEx3sjnCeZGiLZhehJZ7zwXP+NnJmTV1lVNEetXyUIGikdZ9TMhhKjJ
        HSTtD982UP9NppHV57RCqwf1zN3Cu/o7Y2rdB3gODHVUpwEAGmzzwtnkMPrn9/61
        5wvLS2QvNZXSp7y3SDZECO1s6YqRct0Cbh96k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pwwWgI/IaqFDrDCEtCOF3UMfkbsk7lAK
        4qKKe5nmmf4St1g1FkxQCambBuq2hc2VMIA0ieM0SgIrxowz4CVBoSZeUr8cXXzq
        +1zOUKlx86SBRkcjZa93/+0z4qIM2KXZaRqW/HjciKWNLFnomzPg33pr5qbhKuCV
        c/Esp5KZi5E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C31D63148;
        Fri, 20 Jan 2017 17:22:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A68563147;
        Fri, 20 Jan 2017 17:22:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vladimir Panteleev <thecybershadow@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] show-ref: Allow --head to work with --verify
References: <20170120155015.4360-1-git@thecybershadow.net>
        <xmqqa8aly2o4.fsf@gitster.mtv.corp.google.com>
        <1bf9a446-0b00-f27a-4625-0bc8c25356fe@gmail.com>
Date:   Fri, 20 Jan 2017 14:22:14 -0800
In-Reply-To: <1bf9a446-0b00-f27a-4625-0bc8c25356fe@gmail.com> (Vladimir
        Panteleev's message of "Fri, 20 Jan 2017 20:26:44 +0000")
Message-ID: <xmqqefzxwew9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5B53E46-DF5E-11E6-AE01-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vladimir Panteleev <thecybershadow@gmail.com> writes:

> Hi Junio,
>
> On 2017-01-20 19:03, Junio C Hamano wrote:
>> Having said all that, using --verify on HEAD does not make much
>> sense, because if HEAD is missing in .git/, I do not think Git
>> considers that directory as a Git repository to begin with.  So from
>> that point of view, I am not sure what value this change adds to the
>> system, even though the change is almost correct (modulo the "quiet"
>> thing).
>
> My use case was the following series of steps:
>
> Q1: How do I resolve a full ref name to a commit SHA1?
> A1: Use show-ref <full-ref-name>.
>
> Q2: How to make git show-ref also work when HEAD is specified as the
> reference?
> A2: Add --head.
>
> Q3: How do I make git show-ref only look for the exact full ref name
> specified, instead of doing a pattern/substring search, and thus
> output at most one result?
> A3: Add --verify.
>
> However, A2 and A3 are incompatible. Thus, there doesn't seem to be a
> way to e.g. make a simple alias which looks up a ref only by its full
> ref name, where said ref might or might not be HEAD. The obvious
> workaround is to check if the ref is HEAD in the rev-parse caller,
> however it seemed more logical to fix it in git instead.
>
> The documentation for show-ref also makes no mention that --head is
> ignored if --verify is specified, and the combination was not covered
> by any tests, therefore this seemed to me as a simple omission in
> --verify's logic.
>
> There is also rev-parse, which also has a --verify switch, however it
> does something else, and I don't see a way to ask rev-parse to only
> consider full refs.

Your log message for the patch needs to be updated by summarizing
the above better.  I couldn't read the motivation behind the change
fully from the original (even though I guessed it correctly).
