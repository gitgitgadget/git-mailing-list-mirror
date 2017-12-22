Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 265671F406
	for <e@80x24.org>; Fri, 22 Dec 2017 20:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756820AbdLVUqy (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 15:46:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55261 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756149AbdLVUqy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 15:46:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F7B0BCB95;
        Fri, 22 Dec 2017 15:46:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=flfFD1OsoNCS+PHPcWrLzk6f6ao=; b=mlW8mO
        mxrG2AMgjN2TxzjpX4HhvIO/3CIabLZSrp5T2nL2c8kPGAPLbEimkGHmj8vL3k23
        /rDqThmgLZB/uK3NekO0l362K0VcUwAS0M59QPt307zFP2h5L989EyOi0pf+T3lW
        5bKLoAhyHbZ0IDYrpWM5RSXpsMgMA0Wd42rlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ErT6vqJZpiVT7dHtOWRqfhRbjoBuKzjQ
        gyaG0PoCNIUEc+xYdAnDxbid4vvQ5SNB+ijozn2lv7UyAoiInM7fYGiKY3gQ8vZO
        SFCZmCmDpiQF1jwdjYlNvXwRZL24ZuzQ2k9O8RwWW2AI4EHf4pImtUCLU3nu/sV4
        2DIcGhi4sn8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67D93BCB94;
        Fri, 22 Dec 2017 15:46:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC13DBCB93;
        Fri, 22 Dec 2017 15:46:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH 2/3] move index_has_changes() from builtin/am.c to merge.c for reuse
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
        <20171221191907.4251-1-newren@gmail.com>
        <20171221191907.4251-2-newren@gmail.com>
        <CABPp-BGwZq2m4fexVKThGHwSFM3i3xxy2x9cZhtQvSHZ07unYg@mail.gmail.com>
Date:   Fri, 22 Dec 2017 12:46:51 -0800
In-Reply-To: <CABPp-BGwZq2m4fexVKThGHwSFM3i3xxy2x9cZhtQvSHZ07unYg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 21 Dec 2017 11:36:38 -0800")
Message-ID: <xmqqd136qymc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D923706-E759-11E7-9661-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Dec 21, 2017 at 11:19 AM, Elijah Newren <newren@gmail.com> wrote:
>> index_has_changes() is a function we want to reuse outside of just am,
>> making it also available for merge-recursive and merge-ort.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>
> Note: These patches built on master, and merge cleanly with next and
> pu.  However, this patch has a minor conflict with maint.  If you'd
> prefer a version that applies on top of maint, let me know and I'll
> resubmit.

I think I managed to create two topics, one that is with these three
patches (2/3 backported) on top of maint and the other one merges
the former on top of master.  Please see if you found a mismerge
when I push the results out.

Thanks.
