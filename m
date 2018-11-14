Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E3BB1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeKNOzF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:55:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52704 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNOzE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 09:55:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36D0629595;
        Tue, 13 Nov 2018 23:53:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZZlZpk7T+h2zQdzSrJbdh+7aJ2M=; b=dgZ2hR
        0+SVcMJtehBsjzB74tmMVmo21p1CsGGYMH5KHJvha/3q63vFd7siAREg+S3MktmJ
        NXJpz8zxkEtmujlSMshHxa0yFHgImtnGVU1jjv3v+vObH8Lvua1WY6TpEPLwnRy3
        taYjuWmM1i2jJ/HzFNkKYjUMRPOD7Xu/zsLMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pqlh+ODKnItp2EUL7QpC3EOpEFdSRCqW
        aJO9UNxKQY01js/UiQ5RiPcliBwyWiz42lXf95VRbi/V7yiA6Rq/f3MzDkiSAFjf
        Os+4VAYQ8bmCmzEx08xZ+BuPCOygYf3kwua2flxJasPXjeCiXaNcJQLPVizD4MIt
        SuoqURYB+sw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EFC229594;
        Tue, 13 Nov 2018 23:53:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3484429593;
        Tue, 13 Nov 2018 23:53:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] tests: fix GIT_TEST_INSTALLED's PATH to include t/helper/
References: <pull.73.git.gitgitgadget@gmail.com>
        <2b04f9f086e0361345fb38effd61a4b1ef4ac22d.1542030510.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Nov 2018 13:53:25 +0900
In-Reply-To: <2b04f9f086e0361345fb38effd61a4b1ef4ac22d.1542030510.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 12 Nov 2018
        05:48:33 -0800 (PST)")
Message-ID: <xmqqmuqcp8e2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3966833C-E7C9-11E8-9B73-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We really need to be able to find the test helpers... Really. This
> change was forgotten when we moved the test helpers into t/helper/

Yeah, it is unfortunate that more and more things have internal
whitebox test that can only be checked with test-helper binaries,
which makes it impossible to fully testing installed git, but that
is not a new issue this fix introduces.  This at least allows us to
keep using the test-helpers from freshly built Git while using the
installed version of Git for most of the tests.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 47a99aa0ed..832ede5099 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -957,7 +957,7 @@ elif test -n "$GIT_TEST_INSTALLED"
>  then
>  	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
>  	error "Cannot run git from $GIT_TEST_INSTALLED."
> -	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR:$PATH
> +	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$PATH
>  	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
>  else # normal case, use ../bin-wrappers only unless $with_dashes:
>  	git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
