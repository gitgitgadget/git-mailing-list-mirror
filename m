Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1737CC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 04:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E102A61108
	for <git@archiver.kernel.org>; Tue, 11 May 2021 04:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhEKE5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 00:57:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62261 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhEKE5q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 00:57:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DCED137752;
        Tue, 11 May 2021 00:56:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/pMp0ci/6vr/ETu5ioPWUu+9Ug3nc2YQluWnSa
        YcaCw=; b=yQ6zHPgxCnbp7SmykIUXrMSy9Pr2ofsSEXPu8q7/7C9BBEqhwkRV2F
        pWujHDd6nz8KA4rrGinVpSCk7EIxE/REXMj4d2tuxGXBKP05tMWB9hO9GPkZobCO
        nmHzNbzWJpBJCtF4f2JkUugtqcQnUxGwukt3FvTa9cCs8JB2GTJGQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19F94137751;
        Tue, 11 May 2021 00:56:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 455C6137750;
        Tue, 11 May 2021 00:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g>
Date:   Tue, 11 May 2021 13:56:36 +0900
In-Reply-To: <xmqqsg2toqik.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        11 May 2021 13:14:59 +0900")
Message-ID: <xmqqo8dhool7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44C8E6AC-B215-11EB-B18B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Fix long standing inconsistency between -c/--cc that do imply -p, on
>> one side, and -m that did not imply -p, on the other side.
>>
>> After this patch
>>
>>   git log -m
>>
>> will start to produce diffs without need to provide -p as well, that
>> improves both consistency and usability. It gets even more useful if
>> one sets "log.diffMerges" configuration variable to "first-parent" to
>> force -m produce usual diff with respect to first parent only.
>
> Please make sure that you clearly state that you do not blindly
> force --patch output in the proposed log message.  Explicitly
> mentioning that "git log --stat -m" would not give a patch but just
> diffstat would be assuring.

Also, avoid "-p" in the title.  "let -m imply diff generation" might
be a good compromise.

What --cc/-c implies is to show some kind of diff for merges
(dense_combined_merges, combine_merges and !ignore_merges are the
members of the revs field that controls how merge commits) and they
ask for specific kind of diff is shown.  So "-c/--cc imply -p" is
quite wrong (you never get straight --patch output for merges when
you give -c/--cc---you get combined diff).  In a sense, you could
say -c/--cc implies -m (i.e. do show some kind of diff for merges).

Taken together, perhaps:

    Subject: diff: let -m imply diff generation

    The "-c/--cc" options to "git log" asks for merges to be shown
    with patch-like output, implicitly enabling the "-m" option
    (which is used to tell "do not ignore merge commits when showing
    patches).  However, the opposite is not true; giving "-m" alone
    does not tell "git log" that the user wants some form of patches.
    
    Make "-m" imply "we want some form of diff output", so that "git
    log -m" would behave identically to "git log -m -p".  When the
    user explicitly asks for what kind of diff output is desired,
    e.g. "git log -m --stat", there is no need to imply anything,
    specifically, do NOT blindly turn on the "-p: option to turn it
    into "git log -m --stat -p:.

or something like that.

If we enable "some kind of diff" for "-m", I actually think that by
default "git log -m" should be turned into "log --cc".  As you told
Alex in your response, "log -m -p" is a quite unpleasant format to
read---it is there only because it was the only thing we had before
we invented "-c/--cc".

But that might be outside the scope of this series.  I dunno, but if
there is no other constraints (like backward compatibility issues),
I have a moderately strong preference to use "--cc" over "-m -p"
from the get go for unconfigured people, rather than forcing
everybody to configure

> Also this needs a test to ensure that is what happens.  Having a
> test for "log -m" and another for "log -m --stat" would be
> sufficient.
>
> And in the context of this step, the rename of the member in the
> previous step makes quite a lot of sense.
>
> Thanks for working on this topic.
