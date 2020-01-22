Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55B0C32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A51C24655
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 20:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gtyHyv+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAVUra (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:47:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59943 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 15:47:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1271FABAEB;
        Wed, 22 Jan 2020 15:47:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tTsqdjzrj3q4dtHZ+Qcr5jbN0Co=; b=gtyHyv
        +MTqSGGewsP1nvBgnM6nfMvTfsLsWlle3I5B6ikRamZzuCkf7BLx629Xdl69cFl6
        nvyLITMd/DxjfrbbHdXvZW2Jx34g/IrsnubUpBPTABhtMjt8sfSYSYXsMxkNJyOL
        FI3FYMU9tqiM/qNSmc2KSMywdpXd1rPVtBI44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lba93lVTDmW3SW3XDh1nHvqPYeqvsy2s
        qKH4/CpXIBr+U+GjXB8V7Nv6Y5cu6EV1k7Nt2zdznIOMyfQBoiEuUtgAOhh456fK
        1eX72CD8F9bqZsQ0PBWzCxaBcV9Otm+zwmFCME3LW8dwlITmUi1GMK783SzbhVwg
        UTDEjWUF91U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 08E17ABAEA;
        Wed, 22 Jan 2020 15:47:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F1EFABAE9;
        Wed, 22 Jan 2020 15:47:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
        <avarab@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Jeff King <peff@peff.net>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v1] rebase -i: stop checking out the tip of the branch to rebase
References: <20200109150332.GF32750@szeder.dev>
        <20200121191857.23047-1-alban.gruin@gmail.com>
Date:   Wed, 22 Jan 2020 12:47:22 -0800
In-Reply-To: <20200121191857.23047-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 21 Jan 2020 20:18:57 +0100")
Message-ID: <xmqq5zh36wx1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 652D38FE-3D58-11EA-9229-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> One of the first things done by the interactive rebase is to make a todo
> list.  This requires knowledge of the commit range to rebase.  To get
> the oid of the last commit of the range, the tip of the branch to rebase
> is checked out with prepare_branch_to_be_rebased(), then the oid of the
> HEAD is read.  On big repositories, it's a performance penalty: the user
> may have to wait before editing the todo list while git is extracting the
> branch silently (because git-checkout is silenced here).  After this,
> the head of the branch is not even modified.

Hmph.  One curious thing in the above is why this is specific to
"rebase -i". The need to know the commit range to rebase is shared
across any rebase backend, and it would be the most natural to parse
the optional second argument (i.e. the branch or the commit to
rebase) before builtin/rebase.c dispatches to a specific rebase
backend, wouldn't it?  So, the question is why a normal "rebase"
does not need the same fix?

If the answer is "rebase in general was fine without extra checkout,
but 'rebase -i' was doing an unnecessary checkout" (or any other
answer) that is something that would help future readers to record
in the commit log message.

Thanks.


