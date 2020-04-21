Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B063C54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9EC20753
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X/GZoxsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgDUUNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:13:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59250 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgDUUNq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 16:13:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7545061FFB;
        Tue, 21 Apr 2020 16:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6GsmZG9T5I1tbIcHmamsML6DBnE=; b=X/GZox
        sYugxBIGajOaKeZWJxOuS4pyZCNR8K+f2tSwK0sEQ4zmzEm/lB0P8WI1hyO5oYg5
        d9wezGhI+YpsCPvMVamYmONY7ZWl+e0V4oPg7115+7dTu427qhtvxG4HsNQVFtla
        9fdbcbPGm6asDYz2xNwUwQbTMHfSh/wdFyYt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rqeVgP3B6i4wjl0jaiDZEyuiQBrN0AqE
        3wv412Fb0yNsaXMAXJ3pX74vG/7CbbpLe3fa1g+Ow3TEdiXbhRQYCoNamejC/vpz
        q0R3bTxEMdnYEmgdjyZJ7wPlqoicLCrqMJo5CKAqZtlRJhaumWH8nDJIWdZyhrZi
        Bn/8P892kSE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DE8B61FFA;
        Tue, 21 Apr 2020 16:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE71461FF9;
        Tue, 21 Apr 2020 16:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v9 00/10] Reftable support git-core
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
Date:   Tue, 21 Apr 2020 13:13:43 -0700
In-Reply-To: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 20 Apr 2020 21:14:45
        +0000")
Message-ID: <xmqqmu74mwaw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 999DA358-840C-11EA-86C4-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * what is a good test strategy? Could we have a CI flavor where we flip the
>    default to reftable, and see how it fares?

I do not know if the current tests are prepared for it yet,
e.g. there may be places that say "cat .git/refs/heads/master" and
do something to its contents.  But I think that it is a good goal to
shoot for to make sure we can run all the tests with reftable
enabled.

Thanks.
