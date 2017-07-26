Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3BAD2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 20:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751491AbdGZU4m (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 16:56:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54010 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751472AbdGZU4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 16:56:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC809955D4;
        Wed, 26 Jul 2017 16:56:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hn3I8SS5lMQQBvmMR5Lss+Fd5fc=; b=sHw0Kn
        xxsz5WY2QCarDVDQxJiOsyS0ZK6j83u+pKuZfsQF57p+aDorrcSe7vhkATCbVI6X
        YVjwS3Zm9v+jHoi9pvrBvNjGjpLV0tKRj8KaDKnvsCX3DaiRAuUIvo5OvHFAmKJz
        FBtE2a0mjPwxh7qsVfcQAwZLRX3nQNZpwoaCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xy9IKMJ1aWbh1p+ewTb3zXu4bjMKAWyZ
        jqvlvTgbnNKc2pBn9ydoj6gc2GOa5cKGF+rOo+vuv/lhFva9AgxpU1vFBnaVvvt0
        oXN1W1DHpgJNAcU0IjO/DLZjbrAenuH5TO2EJkwtF22H7F6NNlOF5R+anFVe3tXi
        zUnM5ubp61A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B34A7955D3;
        Wed, 26 Jul 2017 16:56:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D2A4955D1;
        Wed, 26 Jul 2017 16:56:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: Re: [PATCH 01/15] t7411: check configuration parsing errors
References: <20170725213928.125998-1-bmwill@google.com>
        <20170725213928.125998-2-bmwill@google.com>
Date:   Wed, 26 Jul 2017 13:56:39 -0700
In-Reply-To: <20170725213928.125998-2-bmwill@google.com> (Brandon Williams's
        message of "Tue, 25 Jul 2017 14:39:14 -0700")
Message-ID: <xmqq1sp2rk6w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC1133A2-7244-11E7-A3F6-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Check for configuration parsing errors in '.gitmodules' in t7411, which
> is explicitly testing the submodule-config subsystem, instead of in
> t7400.  Also explicitly use the test helper instead of relying on the
> gitmodules file from being read in status.

Makes sense.

> ...
> -	test_must_fail git status
> -'
> -...
> +test_expect_success 'configuration parsing with error' '
> +	test_when_finished "rm -rf repo" &&
> +	test_create_repo repo &&
> +	cat >repo/.gitmodules <<-\EOF &&
> +	[submodule "s"]
> +		path
> +		ignore
> +	EOF
> +	(
> +		cd repo &&
> +		test_must_fail test-submodule-config "" s 2>actual &&
> +		test_i18ngrep "bad config" actual
> +	)
> +'
> +
>  cat >super/expect <<EOF
>  Submodule name: 'a' for path 'a'
>  Submodule name: 'a' for path 'b'
