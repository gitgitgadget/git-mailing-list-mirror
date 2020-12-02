Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD4C6369E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CA721D7A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgLBWGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 17:06:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56743 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgLBWGu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 17:06:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 668BB8AA21;
        Wed,  2 Dec 2020 17:06:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sAI3f5pM8Welj5yaTXS8uqjBWo0=; b=L50XHS
        4sAJGiTQmjAZ+P/LGhTHq8FkPhUFjqSj+Yzr1yCBzG/wSCXVO8PitKPY8jtgKHX0
        JEQcz9gKXb8mu8di7daucNr2F4FuUDGMAXMqbLp5R6kZtlZAB5sYrGhIouO75dFn
        WAOsrfuIAY+a+I9QRvGl6U67KhrgAmSXBDE+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GfBJs6sGLjf5Otf1XexRy27VKFdrhPtk
        7CJIoOOoknDUnvH7koSRJthxN2g267VWinaIIjiBZiDrdIYs8fd9+Ti6PEV5+Tu1
        EGLNhxMbr6Zftp2nU8gsijSCh4fAVO6enQ8bOVosmOeXFYc2ixwEen3qj63Q6VWl
        lT5A36AQGbQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F4498AA20;
        Wed,  2 Dec 2020 17:06:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7FEE8AA1E;
        Wed,  2 Dec 2020 17:06:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: Is git-am expected to honor core.sharedRepository?
References: <CAHd-oW4yHSTYr0Gwn60tu2c7VY=PJbSbg23Z5Bd_11Do-+juGA@mail.gmail.com>
Date:   Wed, 02 Dec 2020 14:06:04 -0800
In-Reply-To: <CAHd-oW4yHSTYr0Gwn60tu2c7VY=PJbSbg23Z5Bd_11Do-+juGA@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 1 Dec 2020 12:23:55
        -0300")
Message-ID: <xmqqim9jn9rn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9303A1B6-34EA-11EB-8678-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> (For some background, I stumbled across this while considering using
> safe_create_leading_directories() for a parallel-checkout patch. But
> then I noticed it adjusts the directories' permissions based on the
> setting and I was worried whether it could be user for checkout.)

Forgot to respond to this part, but you are correct.  

Anything that tries to replace what is in entry.c must not trigger
adjust_shared_perm() on files and directories in the working tree,
and it is a no-no to call safe_create_leading_directories().

