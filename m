Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF9DC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A0C2072E
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nL2SQQuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgC3S0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:26:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61494 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgC3S0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 14:26:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED0EB5385A;
        Mon, 30 Mar 2020 14:26:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e8w8simPUCgthMujcEkAt8EXUQ0=; b=nL2SQQ
        uXC8tqpIM2Y0AsT26Y/c+qxZiU+OnY3N0eXXLhzLdNTupZWZ2gf20WyARXLr5PQC
        KY/xqFzHDAcWHdKVkvhvS7LGNqCFwWYOixEoN/P3aFbP7Bif43WkF0kEJlnTcF+F
        vUQgAkwTbKycKpilQLH43QnKWaZchNheuyXQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T1od28e3fvSoW3cYXJ5+jAY2fL0He9Mu
        cjNoN3n3C5+U0zEfyFfS2u02YLCr0M+9NqwG8on428L//+IjGz23RAYw1u4nX3U4
        rjHr8AtSdA2EwU2jWeW2aYjWMuUuHzmQLUwIigZhYpyOrjmnpidiF0mA/CW0HaJ9
        B/Z6cA4j31g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2BD853859;
        Mon, 30 Mar 2020 14:26:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2436653858;
        Mon, 30 Mar 2020 14:26:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] MyFirstObjectWalk: remove unnecessary conditional statement
References: <pull.589.git.1585408753519.gitgitgadget@gmail.com>
        <20200330180742.GB37946@google.com>
Date:   Mon, 30 Mar 2020 11:26:06 -0700
In-Reply-To: <20200330180742.GB37946@google.com> (Emily Shaffer's message of
        "Mon, 30 Mar 2020 11:07:42 -0700")
Message-ID: <xmqq5zel8zsx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBFA63F8-72B3-11EA-99FB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Sat, Mar 28, 2020 at 03:19:13PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> In the given example, `commit` cannot be `NULL` (because this is the
>> loop condition: if it was `NULL`, the loop body would not be entered at
>> all). It took this developer a moment or two to see that this is
>> therefore dead code.
>
> Nice catch. Thanks.
>
>> 
>> Let's remove it, to avoid puzzling future readers.
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

Thanks, both.
