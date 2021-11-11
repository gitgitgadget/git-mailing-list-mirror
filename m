Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9DC433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 19:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B05C61264
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 19:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhKKToq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 14:44:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58091 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKTop (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 14:44:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CB05167A95;
        Thu, 11 Nov 2021 14:41:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w1G9jA2tOqZ/5Up/hPVd3ltfftO5YFS5caCXcp
        IsVFo=; b=m1szO9F4ghWuj3SomFvkW2pHx5GqSrbm/Mnd2pu0hcSxRezrt2VK5V
        9msCnM9ZVZxJLf2hT7ysOo00kjk9D1YjNObv+aCMkctahx6Mrtrmiy6aZ2RuMzKI
        qAhLqLuGqp7pyKRo4umo3OoWXzmICgIEoSsRxuQu5re7cyNKucHPQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54E1B167A94;
        Thu, 11 Nov 2021 14:41:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B7AAC167A93;
        Thu, 11 Nov 2021 14:41:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Subject: Re: Unexpected conflict with ort merge strategy?
References: <CAPMMpojsNQuHe9iSUGyu_q2M4VObjDPj4c0QrFPsHdYypQ3aog@mail.gmail.com>
        <CABPp-BFAf+-ULwtd7WowsN2KSeJ0s1ucZZ1QSRYg8J+wM9MrZw@mail.gmail.com>
Date:   Thu, 11 Nov 2021 11:41:52 -0800
In-Reply-To: <CABPp-BFAf+-ULwtd7WowsN2KSeJ0s1ucZZ1QSRYg8J+wM9MrZw@mail.gmail.com>
        (Elijah Newren's message of "Thu, 11 Nov 2021 09:57:09 -0800")
Message-ID: <xmqqfss2lbsv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C13D110-4327-11EC-A1C5-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> TAKEAWAY: Whenever you are dealing with multiple files or directories
> that are near matches, the person doing merges/rebases/whatever really
> does need to be responsible to pay close attention to any such
> files/directories (and this is not new to merge-ort; it has always
> been an issue with merge-recursive as well).

One difference is that merge-recursive has fewer magic heuristics
(for example, it did not have "my neighbours moved, so I should").

Less clever tools may burden the human users with more manual
resolution in more cases, but when the heuristics work against the
human user, it is easier to understand the situation (iow why/how
the tool made a wrong decision) because they are more predictable.

It is a balancing act.  We would prefer to see things more automated
when there is no room for ambiguity, but a heuristics that works
correctly 80% of the time would force human users to watch out for
mistakes the tool may make in the 20% of the time, which means they
need to look for mistakes in _all_ merges made by the tool, which is
not something we would want.  That is the takeaway.

Thanks.
