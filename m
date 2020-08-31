Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA82BC433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 18:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962DF20678
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 18:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pMqUGjGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgHaSV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:21:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61109 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgHaSV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 14:21:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B54E1E7D5F;
        Mon, 31 Aug 2020 14:21:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1oTnhKpav5ydLig7yTzsDc91vtA=; b=pMqUGj
        GtYi/hKN6shu48cKUUJLiE7EoszVTbuGF4WP2PK7lMxOSGWUvcx7Wu3CNGV9dZ4C
        0E/WTAXpGIF71OR/CzqkiLMsrknhR7Gw6G5KBJtZaA0nqwdxChBXxoaduiR3+crv
        MykUkgtJh/bpgYcOSMNRHWPyg+NL+6+9Cbafw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yGeNAQXpQt+O3ZGkwVhdHoXmpLD2qXkz
        XOGZ7m+f1VmwgGAyTkCgRY44Wrh3TPksBK1h+to92DF07jrGOQNb+/toc8npc548
        R4R9T4cb9YBi4/rSJmzDFqlipP5CsInFi3pcduF5geCF0ZIxDduFHJLhGn9xRVcn
        A3A/ySqGD4c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE0F9E7D5E;
        Mon, 31 Aug 2020 14:21:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EF446E7D5A;
        Mon, 31 Aug 2020 14:21:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Aaron Lipman <alipman88@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] t3200: clean side effect of git checkout --orphan
References: <20200829225648.11971-1-alipman88@gmail.com>
        <CAPig+cQeYz9Mh+26YshuCQSzXCCUyKNGGr1wJ3FNNLpf=9QRuw@mail.gmail.com>
Date:   Mon, 31 Aug 2020 11:21:51 -0700
In-Reply-To: <CAPig+cQeYz9Mh+26YshuCQSzXCCUyKNGGr1wJ3FNNLpf=9QRuw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 30 Aug 2020 01:35:05 -0400")
Message-ID: <xmqqimcyfzgg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8137D9E-EBB6-11EA-B854-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Aug 29, 2020 at 6:57 PM Aaron Lipman <alipman88@gmail.com> wrote:
>> The "refuse --edit-description on unborn branch for now" test in t3200
>> switches to an orphan branch, causing subsequent git commands
>> referencing HEAD to fail. Avoid this side-effect by switching back to
>> master after that test finishes.
>>
>> This has gone undetected, as the next effected test expects failure -
>> but it currently fails for the wrong reason.
>
> s/effected/affected
>
> In fact, the three tests following the orphan test all expect failure
> (though I didn't check if they also fail for the wrong reason), and
> the following test which doesn't expect failure has an explicit "git
> checkout master" early on, which explains why it was not impacted by
> this problem.
>
>> Verbose output of the next test referencing HEAD,
>> "--merged is incompatible with --no-merged":
>>
>>   fatal: malformed object name HEAD
>>
>> Which this commit corrects to:
>>
>>   error: option `no-merged' is incompatible with --merged
>>
>> Signed-off-by: Aaron Lipman <alipman88@gmail.com>
>
> Description and actual fix make perfect sense.

Yeah, looks good.  Of course, the affected test can be made more
defensive to protect the precondition it relies on from getting
broken by other tests (i.e. if it refers to HEAD, it should make
sure it is on an actual commit).   Each test cleaning up after
itself is a good discipline to have, but what is "clean" is quite
subjective and depends on each test piece in the script X-<.

Thanks, will queue.
