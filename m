Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61420C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CA720722
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fb5BA2Bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfL3X1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 18:27:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65194 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfL3X1w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 18:27:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B29D796772;
        Mon, 30 Dec 2019 18:27:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=43e61ZYpQN6Y9hML8DN5fWJ4zpo=; b=fb5BA2
        BjjHfnM+7W1iU5WoU5lamuRvC0xIUFxN0TfmfKIymPCM+fCU/mjjOaY4cpABC2Ng
        ew9g4RAaKGc7yP1oAPOK+JeEm5TV7PURoFy0ev12lfyA/DF8jf6kFIiGkQEWJTOc
        vbEZMqkoPsXQ90m8izWCPUfun3+7mDfBp88F0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BQ3rMRF8uLhxaJBjdB6Rx3e62PgWvE8F
        8sVZ/St7e1SxfMvrGXojBvIiLi8o8lSQC5/tIX44XYuA78abfQSXWKtEBvCq8L8h
        3POCISLu7hwcjjDtbMnffSrqUdXd1xG8suvij7Qp4Qmwr8MAmBpoCTGwmloWrcSC
        YAlbAdoqvy4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB07096771;
        Mon, 30 Dec 2019 18:27:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D08E39676F;
        Mon, 30 Dec 2019 18:27:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 16/16] t4124: let sed open its own files
References: <cover.1577454401.git.liu.denton@gmail.com>
        <54315fecfe373d8020f2172b9b43e02c0dae137d.1577454401.git.liu.denton@gmail.com>
        <868smt2zqh.fsf@gmail.com>
Date:   Mon, 30 Dec 2019 15:27:45 -0800
In-Reply-To: <868smt2zqh.fsf@gmail.com> (Jakub Narebski's message of "Mon, 30
        Dec 2019 23:52:06 +0100")
Message-ID: <xmqqfth1fl72.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD3A2F62-2B5B-11EA-8647-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Denton Liu <liu.denton@gmail.com> writes:
>
>> In one case, we were using a redirection operator to feed input into
>> sed. However, since sed is capable of opening its own files, make sed
>> open its own files instead of redirecting input into it.
>
> Could you please write in the commit message what advantages does this
> change bring?

A fair question.

My version of short answer is "nothing---it is not wrong to write it
either way, and it is not worth the patch churn to rewrite it from
one form to the other, once the script is written".

If we were to extend these tests in such a way that the command
needs to read from more than one input file, though, dropping the
redirection like the patch does is a good first step toward that,
i.e. extending

	sed -e "expression" patch

to

	sed -e "expression" patch-1 patch-2 ...

would look more natural than starting from

	sed -e "expression" <patch

to end at the same place, so as a preliminary clean-up, a change
like this one may have value, but because there is no such further
updates planned, so...


