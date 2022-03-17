Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CC1C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 15:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiCQPzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiCQPzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 11:55:45 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A841C7C2C
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 08:54:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14B86180796;
        Thu, 17 Mar 2022 11:54:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Y7QJhpZUp5sv
        VeUtzbdDq8AVaLN554t5Nn1iMoAGS/s=; b=wwE25cz9u78RTn6JOkM7/Hco1IwA
        eiwFTgbgkBKBzR+j3J0ckny+HUpIiSX6YdCd3WJZPgPokqgAHRvSI+bCQIw73ifg
        ZPN0BHy/Fp7zafvGsCK4iXWmYUKju2NxYDPmonWrrgUfH3FZq47znSDjBdZKrNd1
        t/sfWXTmvdOnY7Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D095180795;
        Thu, 17 Mar 2022 11:54:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 76614180794;
        Thu, 17 Mar 2022 11:54:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v2 1/2] tests: demonstrate "show --word-diff
 --color-moved" regression
References: <a5e5cdd4658d457ffbd80f7263e352cbf3141a1a.1647520853.git.git@grubix.eu>
        <cover-v2-0.2-00000000000-20220317T144838Z-avarab@gmail.com>
        <patch-v2-1.2-7f6a6450259-20220317T144838Z-avarab@gmail.com>
Date:   Thu, 17 Mar 2022 08:54:24 -0700
In-Reply-To: <patch-v2-1.2-7f6a6450259-20220317T144838Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 17 Mar
 2022 15:55:34
        +0100")
Message-ID: <xmqqtubwh8wf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 85205778-A60A-11EC-98A7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +test_expect_failure 'no effect on show from --color-moved with --word-=
diff' '
> +	git show --color-moved --word-diff >actual &&
> +	git show --word-diff >expect &&
> +	test_cmp expect actual
> +'

OK.  Just for future reference ...

In this case it is OK to start with a "document current failure"
that gets turned into expecting success in a separate patch for two
reasons, (1) it is by somebody other than the author of the patch
that fixes the breakage, and more importantly (2) the body of the
test is short enough.

But in all normal cases, please add a test that expects success in
the commit that implements a fix.  A one-line change that turns
expects_failure to expect_success in the commit that implements a
fix, when presented in a patch form with the standard 3-line
context, does not often have enough post-context to show the
behaviour the test tries to exercise and makes reviewing harder.  It
also makes it more cumbersome to cherry-pick the fix to a different
context as the two patches must be kept together.

Thanks.

