Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0A61F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 03:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfJ2DZr (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 23:25:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51758 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730052AbfJ2DZr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 23:25:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1992634DD3;
        Mon, 28 Oct 2019 23:25:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hin2j4/6NRsC3JIa8J6qdmEtbRs=; b=pn5DbN
        qK11zauo2X7X1JXnPYobZEvkKRCV5jzeQlPw1/dzgx1sMdD0wYHA6fsroGjzkYRy
        yezdrC7tjEz7DegLpHgRWzSFvLOb0arm+1F38pS9W9UYnKEM98yyevsbVDah+Y2i
        93sltt33vZBPteb4F4465ftN2AnHKKFry/7N0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X6FsASZ3S5bk7H/19suK+gbIwfRzwgRV
        aStykxXQhcS+OEyaq+g+eobCcaczHYfhbswOLSyrnyTgIyKaTbqrrWvjDFqBXShc
        BbtMnMi3H/fuZoDPsIHBemSe0jCRTJb+3v2At6fZQCIuZOvLkmfp6UmrEoFKm3V8
        x14xGq9zFgw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10F6D34DD2;
        Mon, 28 Oct 2019 23:25:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 665B434DD1;
        Mon, 28 Oct 2019 23:25:44 -0400 (EDT)
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
        <xmqq4kzs8f1l.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 29 Oct 2019 12:25:43 +0900
In-Reply-To: <xmqq4kzs8f1l.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 29 Oct 2019 11:24:22 +0900")
Message-ID: <xmqq7e4o6xmw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAB38EF8-F9FB-11E9-A537-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> As an orthogonal point, I wonder whether we can start the multi-step
>> migration of making --no-commit imply --no-ff by default:
>>
>>  1. Act as --ff when --no-commit is passed without --ff or --no-ff
>>     (the state today)
>
> which means "--no-commit controls whether a new commit is created or
> not and nothing else, and because --ff is the default for merge,
> merging a true descendant will fast-forward".
>
>>  5. Refuse to perform a fast-forward merge with --no-commit is passed
>>     without --ff or --no-ff, just as though --no-ff were passed.
>
> Is that a good endgame, though?

Ah, I was confused by "refuse to perform".  You were not trying to
make the command fail outright without doing anything.  Yes, that
would be a good endgame, I would think.

I am not sure if the transition would be smooth, though.
