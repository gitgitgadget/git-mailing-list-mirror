Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3EFC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE4D241A6
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FmBU2ree"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506651AbgJUWWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:22:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65362 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506647AbgJUWWd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:22:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1614804D7;
        Wed, 21 Oct 2020 18:22:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O1E1Xbu9BOnpum1aXJnBqvm++28=; b=FmBU2r
        eeVnKigS9vhbeqF6rpMsBs2jhZDDfZfl8mZ9J4KWWntlDbP81jXUE24a4cOQiWw2
        qlzFbj/IiS/KQrP3hsN3OfhcqiBjDJSXnODWbgvPyX/lPc0FL7yFdywdj3tKLTOQ
        Iu2Rz1O4XQBoI0SJGAh2r/IcMMfH4rAwh4l8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VBbe8sic6Z512hBF+2aSJ+Qrn4V0wb0V
        kejLxW9cNvVFbKwYguZwo7vV7cnINp48yDcW2Lod8DKm5hGUUlX9uEvfCBxDp7b9
        caT3bCvP737SoXPRKyj6r0rkztFQUY1a+Q3fRSSG4szVF5HMfW/mtyyIHZVr3n6h
        Sg7NHAI/Sj4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6781804D5;
        Wed, 21 Oct 2020 18:22:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58D5D804D4;
        Wed, 21 Oct 2020 18:22:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 03/10] tests: start moving to a different default main
 branch name
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <d9469202c2dda238882150452fac1aa7fc7fbfec.1603135902.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 15:22:29 -0700
In-Reply-To: <d9469202c2dda238882150452fac1aa7fc7fbfec.1603135902.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 19 Oct 2020
        19:31:34 +0000")
Message-ID: <xmqqy2jz43tm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E87F31A2-13EB-11EB-9395-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Note: the `GIT_TEST_DEFAULT_MAIN_BRANCH_NAME` is _not_ intended to be
> used manually; many tests require a specific main branch name and cannot
> simply work with another one. This `GIT_TEST_*` variable is meant purely
> for the transitional period while the entire test suite is converted to
> use `main` as the initial branch name by default.
>
> We also introduce the `PREPARE_FOR_MAIN_BRANCH` prereq that determines
> whether the default main branch name is `main`, and adjust a couple of
> test functions to use it. This prereq will be used to temporarily
> disable a couple test cases to allow for adjusting the test script
> incrementally. Once an entire test is adjusted, we will adjust the test
> so that it is run with `GIT_TEST_DEFAULT_MAIN_BRANCH_NAME=main`.

Good transition plan.  The name of the environment variable itself
serves as markers that remind us where we need to update once the
conversion is done, so there is no need to leave NEEDSWORK comment,
either.

Nicely done.

