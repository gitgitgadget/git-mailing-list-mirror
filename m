Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25001C11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 03:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40E861D08
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 03:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhF3DjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 23:39:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57090 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhF3DjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 23:39:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E0B0131546;
        Tue, 29 Jun 2021 23:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YQXBguQ4fTrtKBiRzbb8YFeHJkqhOHS75k49Lh
        l6Hk0=; b=WMHINLfIHBtBXgNeRYH/OBotACwgbpIEeGjRUYw5ST+3k4kxz+3XcE
        9UkdLsBRx/b53GlzBEYu1pm4RoVNf90K1LIhelFgTRx4hfFtLijNv5MxJOpWMNjV
        wXAXyPqGJf5Ku8ytdfZHSdDd5QQaDNQ9Kx9HTPdKbsQKGVFYODqtE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 360F0131544;
        Tue, 29 Jun 2021 23:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7DA2E131543;
        Tue, 29 Jun 2021 23:36:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 1/2] t6400: preserve git ls-files exit status code
References: <20210615172038.28917-1-congdanhqx@gmail.com>
        <cover.1624974969.git.congdanhqx@gmail.com>
        <49104273b8b801fc61811347120c5f4c42a3700b.1624974969.git.congdanhqx@gmail.com>
        <CAPig+cSKOzebGRyoytUGORhq56P0rijYrKO6uu7q7fWnzwiQkw@mail.gmail.com>
        <xmqqk0mcuw0e.fsf@gitster.g>
        <CAPig+cRu9Sh7gKi37Hj9nj+A0zZvmrrJgaVZepsD0Y-618tmvw@mail.gmail.com>
Date:   Tue, 29 Jun 2021 20:36:36 -0700
In-Reply-To: <CAPig+cRu9Sh7gKi37Hj9nj+A0zZvmrrJgaVZepsD0Y-618tmvw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 29 Jun 2021 21:57:58 -0400")
Message-ID: <xmqqa6n8uipn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 608DDD50-D954-11EB-A169-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I may be misunderstanding your suggestion, but isn't the proposed
> test_output_wc_l() function the same as what Danh had originally
> implemented several re-rolls back (though he named it
> test_line_count_cmd())?

Could be, except that I recall we saw extra noises like --out/--err
that weren't used and contaminating the current working directory,
which are gone from the latest iteration.  The simplification
compared to that iteration is quite welcome---it made the resulting
code that uses the helper easier to follow compared to the earlier
attempts.  But this round simplifies it too much and the results got
harder to follow by burying the command name in the helper and made
it less obvious that the last part of the helper's parameters are
arguments given to ls-files, I would think.
