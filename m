Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51981F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 05:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeKNPDD (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 10:03:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57195 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNPDD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 10:03:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 071CA18E84;
        Wed, 14 Nov 2018 00:01:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bH7RxnJxWCZu5qITl/gM59dGe5M=; b=LDL4RJ
        ouE/OIIKtFfkGyW7Oa1tVUSJjHBW8pgx90cHtiwiPzoYcSKDTKSDy1fyyTppXEHg
        Xl7hiVI2HAq8+7Pt9DnhRhZNW9F73a3rOZa8iTY/708wfeWR1iAChd/YKKr1QUE8
        9hQhmiVaLrrnBkm+eUxFJw1I2BhIommXhllA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vweld9usp4oZRkKorxKqkUNQSrgo0QVC
        VpW3JzJ8olEe2+sU89BQh/EfUD42bo2t/QMLxl6KNpNz7S30Rj5LieUNXATbmQB0
        mcPav2Idqu9M4tEXJcg7iJYMmByl/D3xzU0awRFpQixtBx+QJ9AWLNF2VpesOsT0
        qOHJ/OyVsTg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E138E18E83;
        Wed, 14 Nov 2018 00:01:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E3C6018E82;
        Wed, 14 Nov 2018 00:01:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/5] tests: do not require Git to be built when testing an installed Git
References: <pull.73.git.gitgitgadget@gmail.com>
        <316e215e54b921330b91c763255eb25f475a64ae.1542030510.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Nov 2018 14:01:21 +0900
In-Reply-To: <316e215e54b921330b91c763255eb25f475a64ae.1542030510.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 12 Nov 2018
        05:48:37 -0800 (PST)")
Message-ID: <xmqqa7mcp80u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 558C6C06-E7CA-11E8-8970-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We really only need the test helpers in that case, but that is not what
> we test for. So let's skip the test for now when we know that we want to
> test an installed Git.

True, but...  hopefully we are making sure t/helpers/ has been built
in some other ways, though, right?  I do not offhand see how tests
would work in a pristine checkout with "cd t && sh t0000-*.sh" as
t/test-lib.sh is not running $(MAKE) itself (and the design of the
test-lib.sh, as can be seen in the check this part of it makes, is
to just abort if we cannot test) with this patch (and PATCH 1/5)
under the test-installed mode, though.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 832ede5099..1ea20dc2dc 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -51,7 +51,7 @@ export LSAN_OPTIONS
>  
>  ################################################################
>  # It appears that people try to run tests without building...
> -"$GIT_BUILD_DIR/git" >/dev/null
> +test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git" >/dev/null ||
>  if test $? != 1
>  then
>  	echo >&2 'error: you do not seem to have built git yet.'
