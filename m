Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0034C2BB54
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 00:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79C9206A1
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 00:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qyUvUwxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDHAkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:40:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61822 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDHAkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 20:40:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCCA3B090F;
        Tue,  7 Apr 2020 20:40:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1q590koMLpdTAJ3mdR3CzqbyxEI=; b=qyUvUw
        xHObpHLJn+E+OSBUku05X/DK+TAswkA6HdZJURLGOrlGmYbixXSD1s+AdA/uVUjF
        hbqD+EhrG5xE4Bctbp1r7xENb+S/wyW955VeGt4LPM/jlvaMOHHcviH93ZXlwkJB
        ESZrW9VgkFSwpxICtCtGL+QLGAaE40pHvklZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZiNE2CbVTapFtDvC8mb3DOZXpXFi5Gby
        LGCYPIT+TpA7tfINz1VqUFvZNS9j8oeSJWrhVk0ah+EMcJKRqHblR09yBQNQOLAw
        j15yL9PVDqqIeo8a4nbuBjsjFoKqurjCwKmVgVUn06LZlY4i7uf3TbKrXnRv9L3Z
        JcendPwnicg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5FF2B090B;
        Tue,  7 Apr 2020 20:40:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 26DEEB0909;
        Tue,  7 Apr 2020 20:40:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
        <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
        <20200312141628.GL212281@google.com>
        <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
        <20200407230132.GD137962@google.com>
        <20200407235116.GE137962@google.com>
Date:   Tue, 07 Apr 2020 17:40:14 -0700
In-Reply-To: <20200407235116.GE137962@google.com> (Emily Shaffer's message of
        "Tue, 7 Apr 2020 16:51:16 -0700")
Message-ID: <xmqq4ktures1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83EA4830-7931-11EA-8162-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> [hook "unique-name"]
>   pre-commit = ~/path-to-hook.sh args-for-precommit
>   pre-push = ~/path-to-hook.sh
>   order = 001
>
> Then, in another config:
>
> hook.unique-name.pre-push-order = 123
>
> or,
>
> hook.unique-name.enable = false
> hook.unique-name.pre-commit-enable = true
>
> To pick it apart a little more:
>
>  - Let's give each logical action a unique name, e.g. "git-secrets".
>  - Users can sign up for a certain event by providing the command to
>    run, e.g. `hook.git-secrets.pre-commit = git-secrets pre-commit`.
>  - Users can set up defaults for the logical action, e.g.
>    `hook.git-secrets.before = gerrit` (where "gerrit" is the unique name
>    for another logical action), and then change it on a per-hook basis
>    e.g. `hook.git-secrets.pre-commit-before = clang-tidy`

Sorry, but the description and the tokens used in there are so
detached from the current reality that I am having a hard time
trying to even guess what you two were talking about.  

For example, how would I express that I am using program X as my
'push-to-checkout' hook in a way consistent with the above
description?  Would "push" correspond to your "git-secrets" and
"checkout" to your "pre-commit", or would these be placed where you
wrote "unique-name"?



