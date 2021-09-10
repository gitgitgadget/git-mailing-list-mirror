Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A9BC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 18:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E90C611C3
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 18:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhIJSfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 14:35:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51352 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhIJSfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 14:35:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E620E7010;
        Fri, 10 Sep 2021 14:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LnoS5ysParbcvH/NVw3pxjiKh9JGzWkwtOvuRL
        ehTds=; b=gpDOHLwQNLZ7HOvkOSviiaZgcRU22DthBoEpXs1x3yLBSQQpKcb9+R
        b0KmMoYi+WJFvOX0wAllQKlb2A3v0voYvXA/jfmR2ej90JKPg742/HBkV934eUr5
        u2t1joKkSzzlnzlwG7rQryEI6fZDt0u9+9ldXb6yoDH14/+ANgPNI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A602E700F;
        Fri, 10 Sep 2021 14:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB71FE700C;
        Fri, 10 Sep 2021 14:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
References: <20210830072118.91921-1-sunshine@sunshineco.com>
        <20210830072118.91921-4-sunshine@sunshineco.com>
        <xmqqwno2505w.fsf@gitster.g>
        <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
        <xmqqeeaa4y0v.fsf@gitster.g>
        <CAPig+cQdXp0c+JYthvy+bbr6vLR7nq4pQY3w+CADUtzr+Ang4A@mail.gmail.com>
        <CAPig+cTFbnrPPSZbzihJ9gdGV2c4poXWyNjhK3mnr5_uRwpxbg@mail.gmail.com>
Date:   Fri, 10 Sep 2021 11:33:52 -0700
In-Reply-To: <CAPig+cTFbnrPPSZbzihJ9gdGV2c4poXWyNjhK3mnr5_uRwpxbg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 10 Sep 2021 01:18:20 -0400")
Message-ID: <xmqqwnnos2jz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A60352F8-1265-11EC-AFB9-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Have we made a decision about whether this patch series -- which
> avoids indenting blank notes lines -- is desirable? Or are we worried
> about backward-compatibility?

I do not know about "have we made" part of the question, but an
input from me to come to an answer to the question is that, while I
can see why it may be desirable in some cases, I do not view it as
compelling enough to risk any unforeseen breakage to other peoples'
workflow.  My opinion is based on an assumption that it is desirable
because it would squelch "here is a trailing whitespace" noise in an
editor and/or a pager that is appropriately configured and allow the
user to spot whitespace breakages in the payload more easily and for
no other reason.  If there are other reasons that make this change
desirable, they might influence my opinion.
