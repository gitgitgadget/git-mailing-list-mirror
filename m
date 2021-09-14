Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41636C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 21:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF6360E8B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 21:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhINVki (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 17:40:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56932 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhINVkh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 17:40:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60A48DF30B;
        Tue, 14 Sep 2021 17:39:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=zxbgu49LhYZx5qmwRq0ZtmnakneZZDRPyV4L0jQ3kww=; b=iSsd
        0o3KRLUmtS2HqeCdLmnM22mv4N6R3xrXzM8dOV/pKoLklh0lCLqyzIz92vF+hAgo
        PXzpdVLghPmYkOarUJy6DSrlWVf05xlj373kymlRkYBDi1vndXQ2ZWyTX8lIMoFm
        HZrGJsKdLFuvKiqTo6Mz4oh2SxaUz1NlfkSWBJg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58DD6DF30A;
        Tue, 14 Sep 2021 17:39:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D05B3DF307;
        Tue, 14 Sep 2021 17:39:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH] MyFirstContribution: Document --range-diff option when
 writing v2
References: <20210913194816.51182-1-chooglen@google.com>
        <xmqqwnnkcfz8.fsf@gitster.g>
        <YUDaIc19rhendwc9@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 14 Sep 2021 14:39:18 -0700
Message-ID: <xmqq7dfizvjt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3753984E-15A4-11EC-92FD-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> 	$ git format-patch -v2 --cover-letter -o psuh/ \
>> 		--range-diff master..psuh-v1 master..
>
> Having an explicit psuh-v1 is a good idea.

I think what's good idea is not explicit psuh-v1 but taking the
range from the upstream (i.e. "master"), not "psuh" (which assumes
that symmetric difference will cover everything, which may not
necessarily be the case).

>> 	# ..psuh-v1 can be ..@{yesterday} or whatever reflog reference
>
> If we make it clear that psuh-v1 is just the tip of the last round, perhaps the
> readers who would do this can already infer this from context, and we can omit
> the comment for brevity?

Oh absolutely.  These #comments were meant for your consumption and
not as a suggestion to be placed in the final text given to the end
users.

> I believe the unspoken intent is that having v1 patches in the same directory as
> v2 patches makes it easy to refer to both versions, and in turn, this promotes
> better quality discussion between v1 and v2.
Separate directories may make it easier to do:

    diff -u psuh-v1/ pshu-v2/

as

    cd psuh && diff -u v1* v2*

would NOT work, but comparing patch e-mails textually, especially
after the order of the patches or title of them got updated, won't
be so useful an operation anyway.

When you have multiple topics in flight, you want your psuh topic in
a single directory (perhaps differentiating the iterations with v$n
prefix, or you can choose to have a subdirectory v1, v2, etc. in
that directory) that is different from the directory for your plul
topic, instead of flat collection of directories for psuh-v1,
psuh-v2 and plul-v1 topic-iterations.

