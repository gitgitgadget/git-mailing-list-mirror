Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456AFC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D185610E5
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhHSURU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:17:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60552 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhHSURS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:17:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 736FE157EB2;
        Thu, 19 Aug 2021 16:16:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IDGMAfTuBDGm
        18MoYYv6w59dhkZjtK0mP0EMCQxWvkk=; b=un+ScOzJ1Sb26PnrwpvDHuTxBdWa
        vjDObOLUr/QmWbrmud5JtwpptzqA5jQUFOkqwXzBOTvDY0fNNDz84+3ROglvHCpu
        HqeGbc/sbhPw+6a4/PRcCiR8YCUBUiCekdq44O0ATJ/C67x+r1K/4yC0LuoWkUd4
        Sw2M3qs7pL4s3cA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6BFB7157EB0;
        Thu, 19 Aug 2021 16:16:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B109F157EAF;
        Thu, 19 Aug 2021 16:16:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] t6300: don't run cat-file on non-existent object
References: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com>
        <cover.1629263759.git.congdanhqx@gmail.com>
        <b813d6f2ad96d79a8904ef8b255d4b73ea6567d2.1629263759.git.congdanhqx@gmail.com>
Date:   Thu, 19 Aug 2021 13:16:37 -0700
In-Reply-To: <b813d6f2ad96d79a8904ef8b255d4b73ea6567d2.1629263759.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Wed, 18 Aug
 2021 12:19:26 +0700")
Message-ID: <xmqqo89tyyu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5C1E7560-012A-11EC-A8E6-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> In t6300, some tests are guarded behind some prerequisites.
> Thus, objects created by those tests ain't available if those
> prerequisites is unsatistified.  Attempting to run "cat-file"

is -> are.

> on those objects will run into failure.
>
> In fact, running t6300 in an environment without gpg(1),
> we'll see those warnings:
>
> 	fatal: Not a valid object name refs/tags/signed-empty
> 	fatal: Not a valid object name refs/tags/signed-short
> 	fatal: Not a valid object name refs/tags/signed-long
>
> Let's put those commands into the real tests, in order to:
>
> * skip their execution if prerequisites aren't satistified.
> * check their exit status code
>
> The expected value for objects with type: commit needs to be
> computed outside the test because we can't relies on "$3" there.

relies -> rely
