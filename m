Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062BAC2BD09
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F0520865
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gGHZbXGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfLDSOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:14:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65052 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731863AbfLDSOF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 13:14:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3240839B52;
        Wed,  4 Dec 2019 13:14:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hj5h3PI8jHIfIvB87tecb1ebH7w=; b=gGHZbX
        GJxSvZwOrusFhpOpGanXHVQ7eqB46Oo3c6n/5WJBn8zsr5EK0I/9I4bICYvsSTmY
        +jbB/CpcplTLsDeKu7YS9273kr6dJ56IwHKu3cDwaj2Zm5J/m1BnJfm35tznwfNE
        C82A37NVkORmXRCYOKpuITcnyQSjDU1OdBaQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RbWZhYJjIu+oUi42sztDKsJ9Ki/axQ9i
        FkuMWQUK0Y18knhKNUzUZELBXkLREZ6KTZzjOrFBgMKFoQYFqVDU/GjGeV/zV+Z5
        n9E3WQQRuYONivVlerKs42PFoUckZ5E+ZNsPOQAtFCoNZ5wx7ThjPwVJ9ATiaees
        18csV1dFa8M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B1F539B51;
        Wed,  4 Dec 2019 13:14:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 241E839B50;
        Wed,  4 Dec 2019 13:13:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 22/26] t7700: consolidate code into test_no_missing_in_packs()
References: <cover.1574731022.git.liu.denton@gmail.com>
        <cover.1574884302.git.liu.denton@gmail.com>
        <a99a45cb6f2cc7328ef0e52fc2ea8fec537bfba9.1574884302.git.liu.denton@gmail.com>
        <xmqq7e3i4b1p.fsf@gitster-ct.c.googlers.com>
        <20191202205037.GA43606@generichostname>
        <xmqqo8wqwd9m.fsf@gitster-ct.c.googlers.com>
        <20191202232816.GA26892@generichostname>
        <xmqqblsp76xs.fsf@gitster-ct.c.googlers.com>
        <20191204072437.GA3395833@generichostname>
Date:   Wed, 04 Dec 2019 10:13:57 -0800
In-Reply-To: <20191204072437.GA3395833@generichostname> (Denton Liu's message
        of "Tue, 3 Dec 2019 23:24:37 -0800")
Message-ID: <xmqq1rtk557e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7B46A18-16C1-11EA-9A3E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> Sure, let's see what you have in mind.
>
> Here's a complete replacement for the commit message:
>
> 	t7700: consolidate code into test_no_missing_in_packs()
>
> 	The code to test that objects were not missing from the packfile was
> 	duplicated many times. Extract the duplicated code into
> 	test_no_missing_in_packs() and use that instead.
>
> 	Refactor the resulting extraction so that if any git commands fail,
> 	their return codes are not silently lost.
>
> 	We were using sed to filter lines. Although not incorrect, this is
> 	exactly what grep is built for. Replace this invocation of sed with grep
> 	so that we use the correct tool for the job.
>
> 	Instead of verifying each file of `alt_objects/pack/*.idx` individually
> 	in a for-loop, batch them together into one verification step.
>
> 	The original testing construct was O(n^2): it used a grep in a loop to
> 	test whether any objects were missing in the packfile. Rewrite this to
> 	sort the files then use `comm -23` so that finding missing lines from
> 	the original file is done more efficiently.
>
> 	The result of this is that we end up with a `grep | cut | sort`
> 	pipeline. Previously, we were extracting the `sha1` as part of the
> 	`while read sha1 rest` loop. Since we removed the while-loop, we need to
> 	use `cut` to extract the `sha1` field. Note that we could have chosen to
> 	combine the `grep | cut` into a single `sed` invocation but we
> 	consciously leave it separate as it makes the intent more clear.
>
> 	While we're at it, add a space to `commit_and_pack ()` for style.
>
> 	Signed-off-by: Denton Liu <liu.denton@gmail.com>
>
> The only change between this and the old commit message is the addition
> of the "The result of this..." paragraph.

Ah, you were planning to only update the log message?  Then let's
not bother.  I do not think we would want to encourage "grep piped
to cut" as a good pattern for others to follow and a single sed that
finds the relevant lines and munges the content of these lines into
what is desired conveys the intent clearly and more concisely (I
was hoping that that was what you had in mind for a reroll).






