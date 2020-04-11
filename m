Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53917C2BA19
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 21:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D900C20787
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 21:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B/EZKT+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgDKV14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 17:27:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57385 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgDKV1z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 17:27:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FDAF41276;
        Sat, 11 Apr 2020 17:27:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WaJI7pJkCVLJc0ehBRwu4ajQ8dA=; b=B/EZKT
        +yaDj7kvDqTXhdqhg3k/8nUOgUCRS6pMNFUA+K06H5IpHHQ/ctj3ozCJbQdEOMcY
        K1GRvEyP+5iz37zKyQ038l4gbi4zso7eBMwty8iuw2Xft7gnfxzxuUsLbnqafnm8
        lDoU0kUuNwtEc1j7N7nSObZHIbFIM4CI92c64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BubVI5jOJEBE6ubW1XuND3m1IlXLHmu5
        Mjy6qkT5xPEpMjXDpQNgz59D4Yk/OeUP17h85cD0l1yoOIJXZ933r3eQREWWeBML
        fMZ2f7F9LkY79IDbai02JEKume+vOwNjpdR9hyFgGpo6ZaLgM7N0KsuQTOqXUly+
        gCOpDBOyMoE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47BF741274;
        Sat, 11 Apr 2020 17:27:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C18D341272;
        Sat, 11 Apr 2020 17:27:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/3] Make the tests that test core.hideDotFiles more robust
References: <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
        <pull.603.v3.git.1586612422.gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 14:27:53 -0700
In-Reply-To: <pull.603.v3.git.1586612422.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sat, 11 Apr 2020 13:40:19
        +0000")
Message-ID: <xmqqmu7hhfvq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DC82A6C-7C3B-11EA-94B6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> We have this feature on Windows where the files starting with a dot can be
> marked hidden (whether a file is hidden by default or not is a matter of
> naming convention on Unix, but it is an explicit flag on Windows). This
> patch improves the regression tests of this feature, and it has been carried
> in Git for Windows for over three years.
>
> Junio, I followed your advice, and did one more thing: the function is now
> renamed also only in 3/3.

Looks good.  

I would have renamed it when making it global, exactly for the
reason you stated in [3/3], but it's not like we would merge only
the first two without the fixup, so it does not matter in practice
(as long as other people won't pick up a bad habit from the example,
that is).

Thanks.  Let's start merging a lot of things down to 'next'.
