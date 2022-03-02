Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66D7C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 23:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiCBXr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiCBXr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 18:47:26 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B753E5BD18
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 15:46:03 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DC5117BF45;
        Wed,  2 Mar 2022 18:09:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fSW9nyr5dC2m
        Ypp844Eo4EdUfpC6AubHUV2Vi6dCTW4=; b=AefCKfW8xYyRqr2T8gzkucLTxcjF
        AV2SAEOQbQ0qGzYGh60aS9J3IwOKWd5XB0Itjklyl8NKCFSMhAYBFqw8Atl2OGli
        5N8Yaclunmi0hvc4FHFWtolnr94+STpx7hwZ8stNlj9y+SkVUM0fKbC+Ex103ZgI
        YuFjtbODR0AXNoc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1525217BF44;
        Wed,  2 Mar 2022 18:09:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3D4B117BF43;
        Wed,  2 Mar 2022 18:09:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 06/15] apply tests: use "test_must_fail" instead of
 ad-hoc pattern
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
        <patch-06.15-7952ae1f3b5-20220302T171755Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 15:09:48 -0800
In-Reply-To: <patch-06.15-7952ae1f3b5-20220302T171755Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 18:27:15
        +0100")
Message-ID: <xmqqfso0gddv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DBE88DE8-9A7D-11EC-8FA2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  test_expect_success 'apply should fail gracefully' '
> -
> -	if git apply --index patch
> -	then
> -		echo Oops, should not have succeeded
> -		false
> -	else
> -		status=3D$? &&
> -		echo "Status was $status" &&
> -		if test -f .git/index.lock
> -		then
> -			echo Oops, should not have crashed
> -			false
> -		fi
> -	fi
> +	test_must_fail git apply --index patch &&
> +	test_path_is_missing .git/index.lock
>  '

Wow, that is very old fashioned.  Thanks for cleaning up the
leftover mess from the days before test_must_fail was prevalent.
