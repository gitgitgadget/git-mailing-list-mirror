Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84A3C1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 02:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfJ2CYc (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 22:24:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55858 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfJ2CYc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 22:24:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BDFFA934E;
        Mon, 28 Oct 2019 22:24:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v44ruZYsWxiravdTew/pZanwr7c=; b=HzK42P
        cggFwAhUEkoAywoGlPXhoIiDtEuphm7maktQmvFzHks7Y4rQ1rIbsp2o7p1GaFEG
        bP6kvQFUyu130PFK5oPwFffjtp+zYViJkf8YUXfn84//NRQ5fV6/Yr+OtM0sf9l3
        gdqy//ZPw+5+qrczEkr3oDxFauMT5DzQyJgyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KXrXKCZutQKW6he3WXAOeK23fFdU8kfJ
        ++Kaxk9TmgOacIsMack6sxbbq2hnxxqjTfLN1egQLm2cGxLm9ym9vxA+vtJvLH+4
        IoD7HFrPebqMfXYb1XWlPFd/0JHRZlcsaYh0AYBsym0Mv3wxVGg6J7S0UV0iO1O1
        CeRxwEvWcoc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 036FFA934D;
        Mon, 28 Oct 2019 22:24:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3446AA934C;
        Mon, 28 Oct 2019 22:24:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Mihail Atanassov <m.atanassov92@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Documentation/git-bisect.txt: add --no-ff to merge command
References: <20191025222032.3399-1-m.atanassov92@gmail.com>
        <20191026022655.GF39574@google.com>
        <CALs020+0E=7wy-N46BRLrBcKmMSTpcMyZ9WybmgTzb60aCo5PQ@mail.gmail.com>
        <CALs020KFKOp4mFnY_2Mg5_H8Jc6PPV56O=1S66mriZA+XWd1Hg@mail.gmail.com>
        <20191028222405.GE12487@google.com>
Date:   Tue, 29 Oct 2019 11:24:22 +0900
In-Reply-To: <20191028222405.GE12487@google.com> (Jonathan Nieder's message of
        "Mon, 28 Oct 2019 15:24:05 -0700")
Message-ID: <xmqq4kzs8f1l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39201522-F9F3-11E9-BD4F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> As an orthogonal point, I wonder whether we can start the multi-step
> migration of making --no-commit imply --no-ff by default:
>
>  1. Act as --ff when --no-commit is passed without --ff or --no-ff
>     (the state today)

which means "--no-commit controls whether a new commit is created or
not and nothing else, and because --ff is the default for merge,
merging a true descendant will fast-forward".

>  5. Refuse to perform a fast-forward merge with --no-commit is passed
>     without --ff or --no-ff, just as though --no-ff were passed.

Is that a good endgame, though?  It is correct that "--no-ff" means
"do not allow the merge to be fast-forwarded and the way the option
does so is by creating an otherwise unnecessary merge commit", and
"--no-commit" means "do not allow creating any new commit", so
technically they are mutually incompatible, but would it be useful?

I'd imagine that a more useful behaviour would be for "git merge X"
with any other options to honor this basic trait: the working tree
and the index after the operation shows the result of merging X and
HEAD, if the merge can cleanly be made, and otherwise the working
tree and the index would show something close to the result of such
a merge with conflicts that would help recording the result of the
merge manually.

For that, wouldn't it make more sense ot change the semantics of the
"--no-commit" option from "no new commit gets created" to "HEAD is
not moved"?  "git merge --no-commit X" when X is a descendant of
HEAD would then become "git read-tree -m -u HEAD X" plus perhaps
storing X in .git/MERGE_HEAD file etc. to prepare for concluding
"git commit" to record the result manually.

In any case, as you said,

>>>> -if   git merge --no-commit hot-fix &&
>>>> +if   git merge --no-commit --no-ff hot-fix &&
>>>
>>> Good.
>
> This part still looks like a good change to me. :)

This looks good to me too.
