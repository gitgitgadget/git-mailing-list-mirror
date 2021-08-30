Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0227C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9804460FED
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhH3QD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 12:03:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59377 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbhH3QD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 12:03:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B75714CE60;
        Mon, 30 Aug 2021 12:03:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=feUGbaIL5o9r
        AOQzEUXcXBGGL3BUK3OZYOP9VJYIt14=; b=ZxFQAqglrihFNiBjZDAZN6E3n9ZC
        NCXb94cL+QiU6dSK65SWKfDp9U6TbtnGi85F7p0cKE17WkJLzHLNAxg+SFR7pjMZ
        4dtUdqje/5URZ1BoebOZc9RAmwssAMXeqz6J8nz9jRePak3zfN7uLBdbLI/DHOR4
        WqjTaIP91JNw4W8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9317A14CE5F;
        Mon, 30 Aug 2021 12:03:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D64BB14CE5D;
        Mon, 30 Aug 2021 12:03:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] t7900: add '--scheduler=launchctl' parameter to fix test
References: <17313607-7ae8-c37a-7931-7712c7bfdb88@ramsayjones.plus.com>
Date:   Mon, 30 Aug 2021 09:02:58 -0700
In-Reply-To: <17313607-7ae8-c37a-7931-7712c7bfdb88@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sat, 28 Aug 2021 00:59:53 +0100")
Message-ID: <xmqqtuj66hu5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C01E97E6-09AB-11EC-9937-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi L=C3=A9na=C3=AFc,
>
> As I said, I had a test failure from your previous series (Linux Mint)
> which was solved with this patch.
>
> ATB,
> Ramsay Jones
>
>  t/t7900-maintenance.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This test comes from outside L=C3=A9na=C3=AFc's series.  I guess I am see=
ing a
botched semantic merge conflict resolution of mine where the two
topics met.

The need for this fix made me a bit worried that the behaviour of
resolve_scheduler(SCHEDULER_AUTO) forces us to always name the
scheduler or risk a similar breakage, but in real life, nobody needs
to "force" use of, say, launchctl on a platform where launchctl is
not available so it is OK.


> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 8955aea9c8..36a4218745 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -609,11 +609,11 @@ test_expect_success 'start and stop macOS mainten=
ance' '
> =20
>  test_expect_success 'use launchctl list to prevent extra work' '
>  	# ensure we are registered
> -	GIT_TEST_MAINT_SCHEDULER=3Dlaunchctl:./print-args git maintenance sta=
rt &&
> +	GIT_TEST_MAINT_SCHEDULER=3Dlaunchctl:./print-args git maintenance sta=
rt --scheduler=3Dlaunchctl &&
> =20
>  	# do it again on a fresh args file
>  	rm -f args &&
> -	GIT_TEST_MAINT_SCHEDULER=3Dlaunchctl:./print-args git maintenance sta=
rt &&
> +	GIT_TEST_MAINT_SCHEDULER=3Dlaunchctl:./print-args git maintenance sta=
rt --scheduler=3Dlaunchctl &&
> =20
>  	ls "$HOME/Library/LaunchAgents" >actual &&
>  	cat >expect <<-\EOF &&
