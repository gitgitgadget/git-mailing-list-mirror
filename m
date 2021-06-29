Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7D1C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 22:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45AD61D00
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 22:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhF2Wvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 18:51:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53541 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbhF2Wvx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 18:51:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BCBACE715;
        Tue, 29 Jun 2021 18:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=tdh1voZeuXNKV/H4Me9+ILIUQD+C173E0lbT9rp7UtQ=; b=MQxc
        0jxh4i868XQkcAy/G+6YU8RJA3hFX6TIhu8bkLPI3l9XUSMyj1NLYUoiYTUpQKPi
        QYyFlFf51dGrvrxYbRwYKYDPxo+K+dJqPWEPHph5cPUaFFZsxsQTEzbpkdpALv9i
        SAJ3LjHPk5DngagIghkzv4IBQoCz7xEOCF2byqA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EA4FCE714;
        Tue, 29 Jun 2021 18:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 853FACE712;
        Tue, 29 Jun 2021 18:49:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 1/2] t6400: preserve git ls-files exit status code
References: <20210615172038.28917-1-congdanhqx@gmail.com>
        <cover.1624974969.git.congdanhqx@gmail.com>
        <49104273b8b801fc61811347120c5f4c42a3700b.1624974969.git.congdanhqx@gmail.com>
        <CAPig+cSKOzebGRyoytUGORhq56P0rijYrKO6uu7q7fWnzwiQkw@mail.gmail.com>
Date:   Tue, 29 Jun 2021 15:49:21 -0700
Message-ID: <xmqqk0mcuw0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F1E62DE-D92C-11EB-B27F-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +check_ls_files_count() {
>
> style: funcname () {
> ...
> I also &&-chain the `local` declaration:
>
>     local ops val &&
>     if test "$#" -le 2
> ...
> A quick grep of the tests indicates that they are consistent about
> using lowercase for the first word in a BUG():

Thanks for a pair of sharp eyes, Eric, in your review.

> -	test 5 -eq $(git ls-files -s | wc -l) &&
> -	test 4 -eq $(git ls-files -u | wc -l) &&
> +	check_ls_files_count = 5 -s &&
> +	check_ls_files_count = 4 -u &&

I have one more comment on the main part of the patch.  It is easy
to see that this conversion is correctly done in this particular
patch from the way 5/4 and -s/u are reproduced from the preimage to
the postimage, but I doubt that readers in the future, who long have
forgotten that the "-s" came from "ls-files -s", would find the new
form easy to read and understand.

Do we have the same helper duplicated across two test scripts?

I wonder if it is worth adding a single copy that forces the callers
to spell out the command name in test-lib.sh and make the above into
something like

	test_output_wc_l = 5 ls-files -s

or even

	test_output_wc_l = 5 git ls-files -s

That way, it is easier to see what command is being run (yes, I know
you have _ls_files_ in the middle of the name of the custom helper,
but the thing is that "-s" and "_ls_files_" in the middle of the
helper are so far apart that it is not immediately obvious what the
argument "-s" is about), and by not having two identical copies, we
have less risk of them drifting apart.

Hmm?
