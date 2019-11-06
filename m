Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE411F454
	for <e@80x24.org>; Wed,  6 Nov 2019 01:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfKFBvS (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 20:51:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61127 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfKFBvS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 20:51:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3398A4996;
        Tue,  5 Nov 2019 20:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D1ZDtUog+mM0RH7RqEOuVo2PHIs=; b=QHppXe
        5Cgk36iaShv5Xng4CcWAVsfZ8s4zXJpt3028l7esskjS11COsNsQFNIoyfgPYhtS
        Y71Mu8B0UBy0o97dO6oC07yT74idebDHdR+BPAHDjaTWZkb44FFtqrJ2nIbm59/X
        QdWKntxGGXG37W/2BtzlSHymqCwyq4OSxqQYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IMGEpjw1Y5f08EMrlmcprT/qdgm251Ms
        eq00h8jJnuTqW/lya3qTJgHWnDu0GAw1VXDQIJy1ahYnRdqITvGiKe1k76XJJyjR
        /agmR7KFOexTUlFKSbMzqmJhXZUdKoZhbxJb0iOOhN9eedW2CFJDCh/R9LbssicL
        CUw3HVNQtkQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ABE54A4995;
        Tue,  5 Nov 2019 20:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE5FEA4994;
        Tue,  5 Nov 2019 20:51:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     git@vger.kernel.org
Subject: Re: 'git reset -- NonExistingFile' succeeds
References: <f6d853ce-6f27-ed58-a850-d9a6f245509a@syntevo.com>
        <xmqqo8xu51cv.fsf@gitster-ct.c.googlers.com>
        <df35c20c-669e-35a1-9b2c-22940637b560@syntevo.com>
Date:   Wed, 06 Nov 2019 10:51:11 +0900
In-Reply-To: <df35c20c-669e-35a1-9b2c-22940637b560@syntevo.com> (Alexandr
        Miloslavskiy's message of "Mon, 4 Nov 2019 11:24:01 +0100")
Message-ID: <xmqq36f1ydps.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA1E0786-0037-11EA-9CBA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> On 02.11.2019 5:49, Junio C Hamano wrote:
>> It's sort of expected ;-)
>
> Didn't expect such a detailed reply, thanks!
>
> Not really a problem for me, just I was surprised and thought that I'd
> ask about it.
>
> I came across this issue when writing a test for 'git reset'. I'll
> simply change the test to verify the repository state instead of
> expecting 'git reset' to fail.

As I said, it is expected that Git is not perfect and there would be
many little corners like this that can use improvements.  IOW, it is
not unexpected that "git reset -- NoSuchFile" does not raise an
error, but that does not make it a bad idea to at least think about
teaching it to do so.  There _might_ be fallouts, though; there may
be scripts by people that rely on 'git reset -- "$variable"' with
some random pathspec in a $variable to quietly become no-op when no
paths match (in which case, we'd have to mimic ls-files and add a
"--error-unmatch" option, perhaps).


