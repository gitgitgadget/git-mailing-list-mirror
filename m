Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B953FC4332E
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E70B23136
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbhAFUmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 15:42:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63256 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbhAFUmU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 15:42:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B714B1157AA;
        Wed,  6 Jan 2021 15:41:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/QNgvngQJZoAuECn3oeHtkp7sSQ=; b=rUaz4U
        0uq76Y0Wahf8SfE5hilHbSxYNggDPMJJJEz5VXcJqpAvMIBTt2dvl9bfNr9065VD
        VQ8MKj2uUo2DF3ASuKXeR0mg2c6fXi6mKQLYvt62HOENwEG6NLoIMlcphOFJG5lS
        8MxFCi4seYzmuu1yU6/IjUf0zW6scv1RethSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G514dyCepqU/SvJg2x16hsa3c0g/PVMQ
        F28QtG69fkylst9IFbNR4OWgXZOeUL2sMLPsK/pvZ9eS6oIPQveZzVQe5aptHslT
        /Uvy+su4PGxBqHl0Gs50ROizC9EuFiyRW3b66nKhrOK9NnbR2DqFAnpn+wuwSQG7
        gyZwEx6S7vM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF9DD1157A9;
        Wed,  6 Jan 2021 15:41:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0282C1157A8;
        Wed,  6 Jan 2021 15:41:35 -0500 (EST)
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
Date:   Wed, 06 Jan 2021 12:41:34 -0800
In-Reply-To: <3be0a434-d29f-a7b5-fb46-bb1fc1649d27@gmail.com> (Derrick
        Stolee's message of "Wed, 6 Jan 2021 06:41:50 -0500")
Message-ID: <xmqq1rexssqp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91A0C5E8-505F-11EB-ABFC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> I wonder if "false" or "exit 1" would fit the bill.  In any case, a
>> comment may help, perhaps?
>> 
>> 	test_expect_success 'do nothing and succeed on empty/missing config' '
>> 		# if this runs even once, "false" ensures a failure
>> 		git for-each-repo --config=bogus.config -- false
>> 	'
>
> I can add a comment, but keep in mind that this example would run the
> subcommand as "git false". This isn't intended as an arbitrary script
> runner, but a "please run the same Git command on a list of repos".

Ah, that is a good point.

The comment needs to explain:

	# the command fails if it attempts to run even once because
	# 'git false' does not exist

and at that point, it does not have to be spelled 'false'.  It could
be 'no-such-git-subcommand' (and I wonder if that makes the comment
unnecessary).

That reminds me.  If I have ~/bin/git-false and ~/bin on my $PATH,
would this test fail to catch breakage?


