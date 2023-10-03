Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E5DE8FDB3
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbjJCUqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjJCUqj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:46:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8091BBF
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:46:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15FCF2DC38;
        Tue,  3 Oct 2023 16:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MfiC9LAlGYUx
        vN0+GU2hM1o8QYv1BNJIHXIFGLSI4VE=; b=xoVAExYAqFgd8h7nNNaQEVD4N7aM
        27RQ068h/2NA+8DzUBxULg6QSqeGFF/bEvoWF0HcUO1qdr8Nv/t4VM2Wj0lJbTuD
        UlWrRZ1j0bWXRiKc+BaixiONydRjd1qkNAZfWfBewuRyO3GdKaZ0rO5LNia1671S
        5P2TsRh+mrqzrDE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D9D12DC37;
        Tue,  3 Oct 2023 16:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9937C2DC35;
        Tue,  3 Oct 2023 16:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/5] git-jump: admit to passing merge mode args to ls-files
In-Reply-To: <CAPig+cQHAK2_LEG0-6MTF52t2D8b_SRxzB51B_4N35ujtGeb6Q@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 3 Oct 2023 14:33:39 -0400")
References: <20231003082107.3002173-1-stepnem@smrk.net>
        <20231003082107.3002173-3-stepnem@smrk.net>
        <CAPig+cQHAK2_LEG0-6MTF52t2D8b_SRxzB51B_4N35ujtGeb6Q@mail.gmail.com>
Date:   Tue, 03 Oct 2023 13:46:30 -0700
Message-ID: <xmqqjzs3xwm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EEEA3378-622D-11EE-81FD-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> There's even an example of such usage in the README.
>>
>> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net>
>> ---
>> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
>> @@ -9,7 +9,7 @@ The <mode> parameter is one of:
>>
>>  diff: elements are diff hunks. Arguments are given to diff.
>>
>> -merge: elements are merge conflicts. Arguments are ignored.
>> +merge: elements are merge conflicts. Arguments are given to ls-files =
-u.
>
> Should "ls-files -u" be formatted with backticks?
>
>     Arguments are passed to `git ls-files -u`.

Probably not in this case, as this is end-user visible help message
that is not formatted but given to the terminal.

The whole preimage looks like this:

    usage: git jump [--stdout] <mode> [<args>]

    Jump to interesting elements in an editor.
    The <mode> parameter is one of:

    diff: elements are diff hunks. Arguments are given to diff.

    merge: elements are merge conflicts. Arguments are ignored.

    grep: elements are grep hits. Arguments are given to git grep or, if
          configured, to the command in `jump.grepCmd`.

    ws: elements are whitespace errors. Arguments are given to diff --che=
ck.

    If the optional argument `--stdout` is given, print the quickfix
    lines to standard output instead of feeding it to the editor.

and it is already a mixture.  "given to `git grep`" is not quoted,
neither is "given to `diff --check`" or "given to `diff`"

I think rule for help/usage messages should be that=20

 - anything that the end-user may want to cut&paste should be left
   alone to make it easier to cut,=20

 - but at the same time the message should make it clear which part
   of a sentence is what,=20

Clicking on `--stdout` or `jump.grepCmd` does not include the
surrounding quotes, at least in my environment, so the use of
backquotes in these places satisfy the two goals, it seems.

Unlike `--stdout` and `jump.grepCmd`, all other things that are not
quoted, including the one that is added by this patch (i.e.,
"ls-files -u"), are something the end-user needs to cut and paste in
reaction to seeing this error message, so as long as they are
understandable in the sentences they appear in, I think they are
fine.

If we wanted to standardize, we may start to encourage consistent
use of quoting, but I do not think it should be part of this topic.

Thanks for being careful and thoughtful.
