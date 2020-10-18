Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995EBC433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AAA22269
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RN2eoK5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgJRUEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:04:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62746 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732967AbgJRUEv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 16:04:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F13E571A62;
        Sun, 18 Oct 2020 16:04:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UfneaQ/MV+/Qud0u+LMEm4KMK54=; b=RN2eoK
        5ql6R+wXqRuBf4IUMUqYA716hLpF+3/Hfe1/z6cJdsYSgxvI7onv0ULfKVU0+dNb
        dMrTzjlUEXTV7gd0XtSYTA3G5MjTkTvHO3YmHCBlgOJ8xE3C1ddatKa3rqNzz8ba
        lFskoPPpPlve9RTmr5lYbVxGiAEsz03obvNLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vy5fpAJyvmip/4DdIT85Sn0qtrUrRxqv
        revnz0vhkpAzXLcj6sBmrrlIyTiDClh9s/oGfuBMz0AIi0iXaYzwnYL2Xkbt2usi
        VUXhS+jXuTkEtdcXOkjHnGM7JG/3PkNdab0jYOnC4EAIFeyVyNMqXMt9W2hAAsmf
        YhsKRwr6CDs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E795A71A60;
        Sun, 18 Oct 2020 16:04:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72E2C71A5F;
        Sun, 18 Oct 2020 16:04:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Amanda Shafack via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Amanda Shafack <shafack.likhene@gmail.com>
Subject: Re: [PATCH v2] t9832,t2200: avoid using pipes in git commands
References: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
        <pull.885.v2.git.git.1603032125151.gitgitgadget@gmail.com>
        <CAPig+cR7Hm9m1EiWkr5tKYS3r_zJf98XT7OQ+-Jt4EWkaFQTDw@mail.gmail.com>
Date:   Sun, 18 Oct 2020 13:04:47 -0700
In-Reply-To: <CAPig+cR7Hm9m1EiWkr5tKYS3r_zJf98XT7OQ+-Jt4EWkaFQTDw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 18 Oct 2020 15:25:40 -0400")
Message-ID: <xmqqsgab7128.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CC8B03E-117D-11EB-8EB4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> precise, the subject could say:
>
>     t2200,t9832: avoid using `git` upstream in a pipe
>
> Nit: It's subjective, but it feels a bit more natural to list the test
> numbers in ascending order rather than descending order, which is why
> I swapped them around in the example above.

;-)

>> When a git command is upstream in a pipe, an unexpected failure of
>> the git command will go unnoticed.
>>
>> Write out the output of the git command to a file, so as to actively
>> catch a failure of the git command.
>
> It's easy to see from the patch itself that the output of the Git
> command is now written to a file, so it's not necessary to say so in
> the commit message. Therefore, the entire body of the commit message
> could be written more succinctly, perhaps like this:
>
>     Avoid placing `git` upstream in a pipe since doing so throws away
>     its exit code, thus an unexpected failure may go unnoticed.

Yup.

> The actual patch itself looks fine, and these comments about the
> commit message are quite minor, thus there probably is no need to
> re-roll (though feel free to do so if you think the bit of extra
> polishing of the commit message is worthwhile).

IIUC, the microproject experience aims new contributors to get used
to the style of communication that happens during review cycles of a
typical topic, using a trivial dip-the-toes-in-the-water problem as
an example.  I'd rather not to see contributors get into the habit
of leaving loose ends and have somebody else clean after them.

Thanks.

