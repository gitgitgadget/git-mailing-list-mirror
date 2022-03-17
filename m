Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADB0C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 21:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiCQViu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 17:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiCQVis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 17:38:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C51B0872
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 14:37:30 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D73A186248;
        Thu, 17 Mar 2022 17:37:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DBHmaahyuc9J5oFPYJ/XfA7PyBod6N+EIUuL4U
        E32es=; b=c8WaaXwrpbN0+oOPthmQGwM1J0W81wZparh8Fl6c7FMkpPWsfF93Dt
        QgqDYuYkKXtMj8YuSS++jCRs7QqMekYFee+V/Zlp9gDtc+NMKV6y1F1jiv918QM9
        TAWcLTIb1a7KTgly/5Z+xwV7QvoLPGvUidEyaPteTfu2g3yJRRGMQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7531E186247;
        Thu, 17 Mar 2022 17:37:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D36C2186246;
        Thu, 17 Mar 2022 17:37:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 1/3] rebase: test showing bug in rebase with non-branch
References: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
        <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
        <cac51a949eed0fa593247a593aae2b100be6f4f2.1647546828.git.gitgitgadget@gmail.com>
        <xmqqo824e145.fsf@gitster.g>
Date:   Thu, 17 Mar 2022 14:37:26 -0700
In-Reply-To: <xmqqo824e145.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        17 Mar 2022 14:10:50 -0700")
Message-ID: <xmqq4k3wdzvt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 712E4678-A63A-11EC-B5A8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	test_cmp_rev HEAD main &&
>> +	test_cmp_rev main $(git rev-parse Second) &&
>> +	git symbolic-ref HEAD
>
> I already said that the second one should expect main to be at
> $old_main, but the "HEAD and main are the same" and "HEAD is a
> symolic-ref" test can be replaced with a single test that is "HEAD
> is a symbolic-ref to 'main'", which would be more strict.  I.e.
>
> 	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
> 	test_cmp_rev main "$old_main"

Scratch that.  No, we do not want HEAD to be pointing at 'main'
after rebase, so the above is totally wrong.  What you have at the
end of the series is the right version, as I said in my review of
the [PATCH 3/3].

Thanks for working on this topic.
