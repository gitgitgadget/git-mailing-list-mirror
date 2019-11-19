Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B2A1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 03:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfKSDD0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 22:03:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58046 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfKSDD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 22:03:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B9E037CDA;
        Mon, 18 Nov 2019 22:03:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V5m/Fku3eW7G1vJKeRVWUhb34i8=; b=suGo8a
        K6cyefBhhdo4rVGp/pu5iMQKHKRuP99/3Uzz47pPa6VLrA0hOvgs8r6LYWLnIl7C
        bgOSrXJGMqe8Y0xwA7IzJB5aUymTlIAv5/TrQpeBnnMtggVK/j7ZpKYiYBZ31m8U
        KWET6EGQEdJ8t2Qw1bLsULHyThA1amFxqwkOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lnH0/dtrIVh3D1gXoXcJkVSWwgW0sJ36
        eAGmLTykRo6GxrofTT5iop8JXdtNjdDqcZo+T4exopR0vNeyOB4iX8Te4PFCct/U
        joNZnBHHo9MxBk+FIzd4YJyunhgTOru4yjaSuWCrVcPBKTnoM97QRsv0qUjxsy5k
        QTyQQdQ4PQE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13DB537CD9;
        Mon, 18 Nov 2019 22:03:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CEC437CD8;
        Mon, 18 Nov 2019 22:03:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/3] t3206: demonstrate failure with notes
References: <cover.1574125554.git.liu.denton@gmail.com>
        <00d6b47db0a68d0bc91b252675a2165985426f5e.1574125554.git.liu.denton@gmail.com>
Date:   Tue, 19 Nov 2019 12:03:22 +0900
In-Reply-To: <00d6b47db0a68d0bc91b252675a2165985426f5e.1574125554.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 18 Nov 2019 17:06:57 -0800")
Message-ID: <xmqqblt8zhxh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 262164A8-0A79-11EA-9DDD-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When a commit being range-diff'd has a note attached to it, the note
> will be compared as well. However, this shouldn't happen since the
> purpose of range-diff is to compare the difference between two
> commit-ranges and, since the note attached to a commit is mutable, they
> shouldn't be included as part of the comparison.

I do not agree with the reasoning.  Commits in the new iteration of
the same series would have note attached to them that are different
from the note attached to corresponding commits in the old iteration.

Imagine that "git am" gets enhanced to store the per-iteration
comments you write under the three-dash lines (e.g. "fixed typo in
the log message pointed out by X") as notes attached to each of the
resulting commits.  It does make sense to compare the commits _with_
notes by default, if these notes are configured to be shown in "git
show" output by default for the user.

I do think that it may be a good idea to optionally allow comparison
without notes, when "--no-notes" is given to range-diff on the
command line, by passing the option through, though.

Thanks.

