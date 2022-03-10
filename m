Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD482C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 21:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiCJVj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiCJVj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 16:39:57 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1B6BECC3
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 13:38:46 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59A0E1835D0;
        Thu, 10 Mar 2022 16:38:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ug7lX1mGAMLDNh9mBFJDeaK63XpltOLjlKTHx6
        WEocs=; b=dKRT6mFpfC/kBZ//avABrzG6JhXW7HlDe5KzoS5/QCqF4eEb1SVTts
        XGw0qgXim6JJV8mfrppYNTEl5RR6YM2zUd9ja2vPknifMmy3kJktZVXITkLv4xgX
        RB+qPtnvV9+aoy+7xXJW9/xcPJtQ+cygkj3J51L+QYcR0E00bSUbQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 521AE1835CF;
        Thu, 10 Mar 2022 16:38:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CBB141835CC;
        Thu, 10 Mar 2022 16:38:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 0/6] Importing and exporting stashes to refs
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <xmqq35jpei18.fsf@gitster.g>
        <Yipn+UiRw/GL6u2Y@camp.crustytoothpaste.net>
Date:   Thu, 10 Mar 2022 13:38:42 -0800
In-Reply-To: <Yipn+UiRw/GL6u2Y@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Thu, 10 Mar 2022 21:04:57 +0000")
Message-ID: <xmqqbkydcwt9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7591E362-A0BA-11EC-8050-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I do want to preserve my nice --first-parent property.  What I propose
> to do is this: I'll take your approach and reverse the parents to
> preserve the --first-parent chain and synthesize a predictable root
> commit based on the fake ID information we use for stashes when nobody's
> provided any.

I am wondering if this can be made not an export format but a new
mechanism to store stashes that we use without having to export and
import.  Capping the series of "stash entry" commits with an extra
commit that is continuously amended, and recording which stash entry
has already been used (and not to be shown) etc., in the log message
part of that commit, would give us "stash drop" without rewriting
all the history and would easily bring us to feature parity with the
reflog based implementation, I would hope?

