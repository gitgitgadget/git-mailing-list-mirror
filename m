Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866411F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbfHVQBr (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:01:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56078 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbfHVQBr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:01:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6647A1758E1;
        Thu, 22 Aug 2019 12:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dnOsBe6ekpCc
        25uGVr518exHpVs=; b=q0LNPWPAkzUpCO9xPS1VOqfRwM103LZ97Fbz3NwFQ6IO
        YQRACp3/Al9KMn4O7aPXtvANck9UQw8qo5A3447hwuf3a7VaiDrB6YZN+/9XXs0K
        +p2hj6NBjsvFVUFOmpqGK3EmOwOvM+32vzwB98bWbyElJoweWndmUdM3J9DyQ8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ig1MaO
        OoFcSkOk7uW0zQwEFBgZgHEBYFpTc+wSuhBQnz+BPJKgZj0AUcstlUoiJeYSgr0i
        vCTFk+M69Qkz3YkyJPFtqjCGAwtwpgqMStqADt54lDNHzLPDgpk52ED8mtifQuMD
        3O8HaCcv+V/Y0PaFylaPf6owIG0YZbKrasEVo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ED0A1758E0;
        Thu, 22 Aug 2019 12:01:46 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BEC821758DF;
        Thu, 22 Aug 2019 12:01:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 2/2] line-log: avoid unnecessary full tree diffs
References: <20190821110424.18184-1-szeder.dev@gmail.com>
        <20190821110424.18184-3-szeder.dev@gmail.com>
        <e52e867b-af17-d239-11b5-e0c6353acc2f@gmail.com>
        <20190821173515.GY20404@szeder.dev>
        <20190822084158.GC20404@szeder.dev>
Date:   Thu, 22 Aug 2019 09:01:44 -0700
In-Reply-To: <20190822084158.GC20404@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 22 Aug 2019 10:41:58 +0200")
Message-ID: <xmqq7e75qjdj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2416C8CE-C4F6-11E9-AC4B-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Well, that fruit hung much lower than I though, just look at the size
> of the WIP patch below.  I just hope that there are no unexpected
> surprises, but FWIW it produces the exact same output for all files up
> to 't/t5515' in v2.23.0 as the previous patch.
>
> Can't wait to see how it fares with that evil Windows path :)
>
>   --- >8 ---
>
> Subject: [PATCH 3/2] WIP line-log: stop diff-ing after first TREESAME m=
erge parent

A quick question.  That we need "stop diffing after first treesame"
patch in the first place means we have always been attempting to
follow all the parents of a merge?  I'd expect that to happen when
"--full-history" was given to "git log -L..." invocation.  When we
are simplifying side branches without "--full-history", I agree that
we should see if any parent is treesame with respect to the paths we
are interested in, and if so ignore all other parents.

Or am I misunderstanding the issue here?
