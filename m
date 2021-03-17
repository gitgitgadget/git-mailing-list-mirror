Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A0FC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34A764EB3
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhCQSTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:19:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52778 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhCQSTB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:19:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0C69A39B2;
        Wed, 17 Mar 2021 14:19:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7eZyv3gknplMGY1KaRdRj9U7wdY=; b=E+AeJl
        GY1pYJnhPOkKLOtbWzZqWCn1syOzfqeogIYzPAXISjRbPnZWGjRZavNvZKLnBM02
        P1Bu2eCbBQUSxYtwGVgxO3HcL/pMJT7p8mKH1xbWI194RAL8Zmgv6Qr17vdFHoiQ
        OD5Tv5ZsNnjAgkh3II8D2UYNehdPR8+AJIQ9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kN22Hbs7NcLLUssVqF1EbL9a9SaYPlj+
        bxESIB85btHCbNHdbxbRPqjlkNxemAuWV46MZIpQd7wfM1D5e4ZtlnYMeuBQwqT1
        DSQ3hDzPrMR7tC9v+ouRsJhzAghvkqD9hGeg6J6ly9FlwjGrcymQqiJNuTKvD6tF
        ON1LwJAIlsE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A9DCA39B1;
        Wed, 17 Mar 2021 14:19:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED2AFA39B0;
        Wed, 17 Mar 2021 14:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com
Subject: Re: [PATCH] t5606: run clone branch name test with protocol v2
References: <YFIGSo3U5u7zy9fq@C02YX140LVDN.corpad.adbkng.com>
        <20210317154200.2656837-1-jonathantanmy@google.com>
Date:   Wed, 17 Mar 2021 11:18:59 -0700
In-Reply-To: <20210317154200.2656837-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 17 Mar 2021 08:42:00 -0700")
Message-ID: <xmqqo8fhwsmk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EBF753E-874D-11EB-B45E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> 4f37d45706 ("clone: respect remote unborn HEAD", 2021-02-05) introduces
> a new feature (if the remote has an unborn HEAD, e.g. when the remote
> repository is empty, use it as the name of the branch) that only works
> in protocol v2, but did not ensure that one of its tests always uses
> protocol v2, and thus that test would fail if
> GIT_TEST_PROTOCOL_VERSION=0 (or 1) is used. Therefore, add "-c
> protocol.version=2" to the appropriate test.
>
> (The rest of the tests from that commit have "-c protocol.version=2"
> already added.)
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Thanks, Son Luong, for noticing this. Here's a fix for the
> GIT_TEST_PROTOCOL_VERSION part. This was built on 4f37d45706 but also
> applies cleanly on master.

Makes sense.  And I do not see need for any other changes, like
test_expect_failure with protocol 0 (or 1).

Will queue as a candidate for maint-2.31.

Thanks.



>
>  t/t5606-clone-options.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index ca6339a5fb..5e30772735 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -106,7 +106,7 @@ test_expect_success 'chooses correct default initial branch name' '
>  	git -c init.defaultBranch=foo init --bare empty &&
>  	test_config -C empty lsrefs.unborn advertise &&
>  	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
> -	git -c init.defaultBranch=up clone empty whats-up &&
> +	git -c init.defaultBranch=up -c protocol.version=2 clone empty whats-up &&
>  	test refs/heads/foo = $(git -C whats-up symbolic-ref HEAD) &&
>  	test refs/heads/foo = $(git -C whats-up config branch.foo.merge)
>  '
