Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D869EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 18:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGYSgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjGYSgC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 14:36:02 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54649A3
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 11:36:01 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26FFB18F333;
        Tue, 25 Jul 2023 14:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4RhRrhWCmZ22CoIwRAsEw0cexVQFYxBcBqkGK4
        ojfY8=; b=b7OT3c9Fn5nCqMRApW1EpRxwXiKKQqkNMZBO0xBOWzt30G02cIrpPb
        KgRtNpDfetq1enhVBYJACxKpyUVjL/m3lT+E7BE1cnGSlYTLyuCeXjjkQwKx2hH+
        X2KKjs18AmMs/dCsuo345CFKVi4QR3hpV7wQkcuFkTCpqbVfN8emo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F88B18F331;
        Tue, 25 Jul 2023 14:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8273818F330;
        Tue, 25 Jul 2023 14:35:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Credential improvements need review
References: <xmqqedl3a909.fsf@gitster.g>
        <20230724194854.3076-1-mirth.hickford@gmail.com>
Date:   Tue, 25 Jul 2023 11:35:56 -0700
In-Reply-To: <20230724194854.3076-1-mirth.hickford@gmail.com> (M. Hickford's
        message of "Mon, 24 Jul 2023 20:48:54 +0100")
Message-ID: <xmqqzg3jltyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18833F22-2B1A-11EE-9362-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M Hickford <mirth.hickford@gmail.com> writes:

>> * mh/credential-erase-improvements-more (2023-06-24) 2 commits
>>  - credential/wincred: erase matching creds only
>>  - credential/libsecret: erase matching creds only
>> 
>>  Needs review.
>>  source: <pull.1529.git.git.1687596777147.gitgitgadget@gmail.com>
>
> Hi. Is anyone able to help review these changes?
>
> https://lore.kernel.org/git/pull.1529.git.git.1687596777147.gitgitgadget@gmail.com/
> https://lore.kernel.org/git/pull.1527.git.git.1687591293705.gitgitgadget@gmail.com/

Thanks for pinging.  One thing that may help (both patches, my
understanding is that they are of the same spirit, just one is for
libsecret while the other one is for wincred) is to describe the
problem the patches attempt to address a bit more.  For example,
in one of them:

    Fix test "helper ... does not erase a password distinct from input"
    introduced in aeb21ce22e (credential: avoid erasing distinct password,
    2023-06-13)

we can read from the above proposed log message that it is a "fix"
to some bug, and that the "bug" was introduced by the named commit,
but there are a few things that it does not explain, that could have
helped readers to convince themselves that the changes in the patches
are addressing the right problems and solving them in the right
way.  For example,

 * how does the "bug" manifest itself in an observable way to the
   end-users?  "When they do X, they expect Y to happen, but instead
   Z happens, and doing Z breaks expectation of users expecting Y in
   this (W) way."

 * what was wrong in the code that led to the "bug"?  Was it testing
   a wrong condition before making a call to some system service?
   Was the condition it checked correct but it made a call in a
   wrong way (and if so how)?

Thanks.

