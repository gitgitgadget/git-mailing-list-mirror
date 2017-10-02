Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23EC9202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 04:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbdJBEBu (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 00:01:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51266 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750740AbdJBEBu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 00:01:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 772589387B;
        Mon,  2 Oct 2017 00:01:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rshtjLL8g0q8
        NO0LGJJyyad8vxw=; b=LBplQwZD/msSpvRhFvBxhhnrYqzTQW5i4DToA5kSr+wp
        sFUyR1BpLuTDHIRPMFPVcG9cQGzw/aiwBrwEOvC7yBwenGfz+iIQO291v7L19Z8j
        ekz4PFlPvbB0VxEJ4ipfZxCTySt/4ezeUef/ugmvtrRUnRREGRY7kWfZwOam4eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Fgr9Br
        FF1g+2i1lvv8+B1eR7V/LCz0p9dCiKl2oz7IhlRSu9YnA4tYn6XxiQC+wUGblws6
        rCcY7tkzRBLsxqNcw20npxRrJHRLdHeK/PdcgHU41kpQXajMVsJlNhIzj9MitK/e
        TOOvRdtZ1ds607IXHArEdozdubcxrxIfLFS1c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E5EB93878;
        Mon,  2 Oct 2017 00:01:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C436C93869;
        Mon,  2 Oct 2017 00:01:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 11/11] read-cache: roll back lock on error with `COMMIT_LOCK`
References: <cover.1506862824.git.martin.agren@gmail.com>
        <26a9c90a6478ec9ddb4ce34923e251ebe9323ab2.1506862824.git.martin.agren@gmail.com>
Date:   Mon, 02 Oct 2017 13:01:36 +0900
In-Reply-To: <26a9c90a6478ec9ddb4ce34923e251ebe9323ab2.1506862824.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 1 Oct 2017 16:56:12
 +0200")
Message-ID: <xmqq60byqjtr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6382F3B0-A726-11E7-BFA9-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Teach `write_locked_index(..., COMMIT_LOCK)` to roll back the lock
> before returning. If we have already succeeded and committed, it will b=
e
> a noop. Simplify the existing callers where we now have a superfluous
> call to `rollback_lockfile()`. This should keep future readers from
> wondering why the callers are inconsistent.

Makes sense.  Thanks for cleaning up.  The split-index codepath was
something I've never reviewed seriously with fine toothed comb, and
I feel a lot better now knowing that somebody other than its authors
and me have read it through ;-)
