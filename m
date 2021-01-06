Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8664C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC9D23132
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbhAFVlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 16:41:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57273 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbhAFVlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 16:41:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74CAF11217B;
        Wed,  6 Jan 2021 16:40:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kwyYl28qeSje+HWKHG7JHAE1Hic=; b=IOvvH2
        HYdY+5vTQddzEj5EOIBdssukNq0F69OgqnmXng9hxETH7Zeym1GNIk912XGhcFxu
        z8C8P39k+iHTcEYEtPkwn+JfY4fXdBWVAqJVsdQVEN1/zseDjFSGapdsfIkQdBH3
        yWv1uvb4durxZTf5gGLhP6kZNCViQ/0uEuSfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ItwTlXjCDq4nOWazN146ws1j4nldnfnt
        aCCjaPs6V5ZY894ZNws1Oy3jp50lt34NYjE02a3lNfae2pxDtZuMdlPSJAzy09Ed
        hbfF0RdSlhB6chwUfvVPQwmmqHjvGNXM/7HQ3AeSr/wyDAPfpSK8zUqgd0tWCBWM
        folFaqxv90s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DFC911217A;
        Wed,  6 Jan 2021 16:40:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ADDC9112179;
        Wed,  6 Jan 2021 16:40:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] for-each-repo: do nothing on empty config
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
        <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com>
        <db7bf751-7541-59b9-a3a0-ec07e28eb9de@gmail.com>
        <xmqqa6tmtrr1.fsf@gitster.c.googlers.com>
        <3be0a434-d29f-a7b5-fb46-bb1fc1649d27@gmail.com>
        <xmqq1rexssqp.fsf@gitster.c.googlers.com>
Date:   Wed, 06 Jan 2021 13:40:51 -0800
In-Reply-To: <xmqq1rexssqp.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 06 Jan 2021 12:41:34 -0800")
Message-ID: <xmqqv9c9pwv0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D995E3D0-5067-11EB-B840-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <stolee@gmail.com> writes:
>
>>> I wonder if "false" or "exit 1" would fit the bill.  In any case, a
>>> comment may help, perhaps?
>>> 
>>> 	test_expect_success 'do nothing and succeed on empty/missing config' '
>>> 		# if this runs even once, "false" ensures a failure
>>> 		git for-each-repo --config=bogus.config -- false
>>> 	'
>>
>> I can add a comment, but keep in mind that this example would run the
>> subcommand as "git false". This isn't intended as an arbitrary script
>> runner, but a "please run the same Git command on a list of repos".
>
> Ah, that is a good point.
>
> The comment needs to explain:
>
> 	# the command fails if it attempts to run even once because
> 	# 'git false' does not exist
>
> and at that point, it does not have to be spelled 'false'.  It could
> be 'no-such-git-subcommand' (and I wonder if that makes the comment
> unnecessary).
>
> That reminds me.  If I have ~/bin/git-false and ~/bin on my $PATH,
> would this test fail to catch breakage?

Yes, I think $PATH in the test environment starts from the original
$PATH and modified only by prepending, so my ~/bin/git-false would
kick in.  We cannot reliably depend on the absence of a subcommand.

We can instead use

	# the whole thing would fail if for-each-ref iterated even
	# once, because 'git help --no-such-option' would fail
	git for-each-ref --config=<var> -- help --no-such-option

and I think that would be much more reliable; if an invocation of
"git help" inside our test suite fails to refer to the "git help"
from the version of Git being tested, we already have a serious
problem.

Thanks.
