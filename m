Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEEBC32792
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbiHVTcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbiHVTbs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:31:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A825BB5A
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:31:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3192134809;
        Mon, 22 Aug 2022 15:31:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AfIQyb/PVLybAeWoN5PBENPWKO7HqvH0Cu+lGj
        tScmY=; b=j6/WPMK4L7VN9+aGgVvQSn+N25Fv6OMnwOBLS5YnadNYsqTXWasx2D
        gZOHNgJM1jH6K4iUs+jULzwP5s2dLGSyS+DWDJSIuoc25q4bzgGvI5Yws/UEE0wg
        X9hHFwd0YCq690o9rCvej1NLdFZmRffQ516HUBIZlZzqRJ5zcL8+0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BAA32134808;
        Mon, 22 Aug 2022 15:31:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BB7F134806;
        Mon, 22 Aug 2022 15:31:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, chakrabortyabhradeep79@gmail.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: Re: [PATCH 1/6] t5326: demonstrate potential bitmap corruption
References: <cover.1660944574.git.me@ttaylorr.com>
        <3e30ab1a19115107fc24a25118f2417319bd1b0d.1660944574.git.me@ttaylorr.com>
        <3525f8bd-31af-181d-b7a5-6e8a453bbba7@github.com>
        <YwPDkW8KemC5Hs/C@nand.local>
Date:   Mon, 22 Aug 2022 12:31:44 -0700
In-Reply-To: <YwPDkW8KemC5Hs/C@nand.local> (Taylor Blau's message of "Mon, 22
        Aug 2022 13:57:37 -0400")
Message-ID: <xmqqbksccbxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EA8A99C-2251-11ED-9E78-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > +	git init repo &&
>> > +	test_when_finished "rm -fr repo" &&
>>
>> nit: test_when_finished should be the first line of the test.
>
> The "rm-then-init-then-test_when_finished" is an (unfortunate) pattern
> extended throughout t5326, mostly that some tests don't clean up "repo"
> after deleting and recreating it.

I do not think it is so bad to be defensive to "prepare it cleanly
enough so that I would not be affected".  So "rm -fr repo && git
init repo" I would fully support.  "init && test_when_finished" is
totally indefensible.  It should be the other way around.

> But it's easy enough to just use a separate repository, and avoid
> removing it altogether. Thanks for the suggestion!

Those who run tests in a batch without "-i" would have more material
to study and find breakages if you did so.  I agree that is probably
something worth doing (unless in narrow corner cases where each test
repository consumes unusual amount of storage or somethinglike that).

