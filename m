Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F622C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574EE2075D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IjlJFq0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgG2Sxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:53:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55440 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Sxd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 14:53:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDD0FF3D28;
        Wed, 29 Jul 2020 14:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YdJIxJ7RqN826VcFGJ/WQQe9lFc=; b=IjlJFq
        0ezEEqoQ2FSSfjpP5laNqqjH/g8QdwmT1rNWeJaWlx6gvE+utgsmTDfyol3DKj1e
        uk6XIaenhWxxFZjFRTbIy195vTfImd2YUeWqOOga//BST3/3Frk2h0DZDIiScPhs
        Bno5ZdavW0KmM5Qkqib4bOcUTvP3W1J85vUDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ndTzrtZEb5k55pDHyd52BsLYg7bw6PXb
        9MAdeRLodYE6sl7An4g158mQxDU01WvRP+350ydPB7gXmkbK214U7+e56FICjGma
        xOtGLnjvBEORrNSSf2gdbo7ycLEhY2IZPQzVFq66ICbp5ScaBUQ1nwfYXRzLjGVN
        j1iru7uAdSg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D56D0F3D27;
        Wed, 29 Jul 2020 14:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1A2C0F3D24;
        Wed, 29 Jul 2020 14:53:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision: add "--ignore-merges" option to counteract "-m"
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200728163853.GB2650252@coredump.intra.peff.net>
        <xmqqv9i7cq1k.fsf@gitster.c.googlers.com>
        <20200729182206.GA2339835@coredump.intra.peff.net>
        <20200729183049.GA2340161@coredump.intra.peff.net>
Date:   Wed, 29 Jul 2020 11:53:25 -0700
In-Reply-To: <20200729183049.GA2340161@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Jul 2020 14:30:49 -0400")
Message-ID: <xmqqv9i69mqi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C96E73EC-D1CC-11EA-A128-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 29, 2020 at 02:22:07PM -0400, Jeff King wrote:
>
>> After thinking on it more, I flipped it to:
>> 
>>   -m::
>>   --diff-merges::
>>      [existing text...]
>> 
>> and then I don't think we need to have another block for
>> --no-diff-merges.
>> 
>> I'll likewise add a statement that "-m" is implied by "--first-parent"
>> and can be counteracted with the "--no" form, which I think should spell
>> out all the implications of the series.
>
> Hmm, I take that back. I tried adding this:
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 0785a0cfe9..41c859e63f 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -1154,7 +1154,9 @@ options may be given. See linkgit:git-diff-files[1] for more options.
>  	and diff is generated. An exception is that only diff against
>  	the first parent is shown when `--first-parent` option is given;
>  	in that case, the output represents the changes the merge
> -	brought _into_ the then-current branch.
> +	brought _into_ the then-current branch. Note that
> +	`--first-parent` implies `-m` if no combined-diff option is
> +	enabled; you can use `--no-diff-merges` to override that.
>  
>  -r::
>  	Show recursive diffs.
>
> but then I'm left wondering: why would you ever want to override it? I
> added the option as an escape hatch in case anybody really needed the
> old behavior.

Old behaviour meaning "git log --first-parent -p master..next" would
mostly list commits without patches unless there is a single-parent
commit thrown in the first-parent chain?  I would imagine it would
be one way to locate and view reverts, cherry-picks and "oops I
botched the merge previously" fix-ups on 'next'.

I could add "--no-merges" to that command line but then the output
loses all the clues on when topics are merged in what order and show
only those single-parent commits, so it is not exactly the same
thing.  It loses a lot, and the current behaviour strikes a very
good balance for the use case.

So, if we make "-m" the default in some cases (like "--first-parent"),
we do need a way to toggle it off.

Thanks.

