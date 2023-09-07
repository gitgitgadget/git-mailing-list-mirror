Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E69EC874B
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 18:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbjIGSRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245000AbjIGSRd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 14:17:33 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE51BD4
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 11:17:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F0721A4938;
        Thu,  7 Sep 2023 14:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=yDLCCoz61MqVHT1rHjzlw7XJOJXQro00tjq2Hi
        +xRss=; b=pee0k0xTQyF7NwJwjaa/216jrMRn0qSesmnZgQBHRKsPV9ZoFm+kLG
        7+jQhnvO5Ewylz4vh0evKJDxsgKCWVBEaxQQmqk7Fljz0QLU0ySZlT5X+Wj+XgLR
        +6TLvR86fvdBMjxF+35N6oIEsgI0z06ypd1nlgb8vEQG6NTIYjZBc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 068801A4937;
        Thu,  7 Sep 2023 14:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 655251A4936;
        Thu,  7 Sep 2023 14:16:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] builtin/repack.c: drop `DELETE_PACK` macro
In-Reply-To: <ZPmHpqHNzXF0Jbu6@tanuki> (Patrick Steinhardt's message of "Thu,
        7 Sep 2023 10:19:50 +0200")
References: <cover.1693946195.git.me@ttaylorr.com>
        <559b487e2ab056c79367a673188764e4cdce3c96.1693946195.git.me@ttaylorr.com>
        <xmqqh6o7nsf2.fsf@gitster.g> <ZPi1c98o2fKB/U+e@nand.local>
        <ZPmHpqHNzXF0Jbu6@tanuki>
Date:   Thu, 07 Sep 2023 11:16:46 -0700
Message-ID: <xmqq1qf9lugh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B52AAD3A-4DAA-11EE-BA0D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> If the intent is to make this check a bit prettier, how about we instead
> introduce a helper function like the following:
>
> ```
> static inline int pack_marked_for_deletion(const struct string_list_item *item)
> {
>         return (uintptr) item->util & DELETE_PACK;
> }
> ```

Good suggestion.

Or just check if it is NULL (with the new code that only cares about
the NULL-ness).  Regardless of the implementation, having such a
helper would document the intent of the code better, especially if
there are multiple places that make that check.

> Other than that the rest of this series looks good to me, thanks.
>
> Patrick

Thanks.
