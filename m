Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E1CC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9060D238D7
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgLGTxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:53:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59194 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGTxx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:53:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9091111D193;
        Mon,  7 Dec 2020 14:53:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7m15fR1GmyLFLkKvrmQYvG59iCU=; b=hz+Bjk
        IYZTW066pedqLtgQS3+GFNoMI7TVz4CzulNNh0ffRurS3KEHGnnOnHednQOKa1h9
        NAAC1PJszrujR/ayqO658Qmu40PFpygAt6sydisWcy16mdo4istXaCQqmz5lJzM0
        eN0HJGV2tCDzfYiUthymvC/8iwAEGOpW+R9Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MWhTV02D4aIH3QEIHZIXAwU7xgKfY4Q8
        yNvjLesh12RMR5W0v4Gf54c0Jiyn7uyPhMAMrsMBP/hP8uva4lp4/LjvMq/Db87Y
        dSD/9b0yxklt2lI3RkEfXEI0dWVozQ4l/pR1NxI0eIWig10hFrRo0uwBVvqcxEj7
        /zcRp63Bjkw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87C6A11D192;
        Mon,  7 Dec 2020 14:53:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA44011D191;
        Mon,  7 Dec 2020 14:53:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
        <20201204061623.1170745-3-felipe.contreras@gmail.com>
        <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
        <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
        <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
        <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
        <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
        <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
        <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
        <xmqqeek2cc14.fsf@gitster.c.googlers.com>
        <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
        <xmqqpn3lbhxn.fsf@gitster.c.googlers.com>
        <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
Date:   Mon, 07 Dec 2020 11:53:05 -0800
In-Reply-To: <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
        (Felipe Contreras's message of "Mon, 7 Dec 2020 13:09:22 -0600")
Message-ID: <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D33A61BE-38C5-11EB-AE27-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> They start by saying the same thing. But one errors out and says the
> user must choose, and the other warns that in the future the user must
> choose.

Then I do not see the point in giving the warning---even in the
future they do not have to choose as long as they are merely
following along.

>> > Just to put this series in context: it's only part 1; it does not
>> > introduce pull.mode, and it doesn't make --ff-only the default.
>>
>> I'd view the "in a non-fast-forward situation, the warning kicks in
>> to those who haven't chosen between merge and rebase (i.e. no
>> pull.rebase set to either true or false, and pull.ff not set to
>> only), which is a bit more gentle than the current situtation" a
>> good stopping point.  That state is already making ff-only the
>> default for unconfigured users, or you can view it as shipping "git
>> pull" in a shape that has the more dangerous half of its feature
>> disabled to avoid hurting users.  So I am not sure why you keep
>> saying you do not have --ff-only as the default.
>
> The warning doesn't make the pull fail, ff-only does.

Then probably you are giving an error and a warning at a wrong
place.

 - When history fast-forwards, and the user hasn't chosen between
   rebase or merge, there is no need to give any warning.  Just
   succeed by fast-forwarding.

 - When history does not fast-forward and the user hasn't chosen
   between rebase or merge, whether pull.ff is set to "only" or not,
   we should fail and the error message can instruct the user to
   choose between rebase and merge; there is no "ff-only" option
   that is useful in the situation.

And that essentially makes the "ff-only" mode the safe default that
castrates one half of the feature (the more dangerous half) of "git
pull".  Why do we make it more complicated than that by warning that
the user must choose in the future?  They will see an error tell
them that when they start pulling while on their own work, and I do
not see a need to bother them before that point.
