Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83A0C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 07:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7E2611C8
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 07:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhISHNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 03:13:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64738 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhISHNb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 03:13:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 226D7EB8AC;
        Sun, 19 Sep 2021 03:12:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nypmn0LobLQ+u8oQ/bNR7nZoykG0KXVMGQ3Anb
        BUqmI=; b=FOo5hSgOR+nHvNI4EPNEaAJ343yUyD5uuUJKDWk0xMg7/cDQbHkfae
        F9Mx7P6oCkm2tnmf0o5l82YUzt9XFBTK4ShzW8LCrXSLo+oDOfNcxwrhG/a1a9V0
        GTJhs+ISxWWiKEY/osB0g/HatWIc12las9taoAyIld6T5hfWwO8ew=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 070BEEB8AA;
        Sun, 19 Sep 2021 03:12:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2346EEB8A9;
        Sun, 19 Sep 2021 03:12:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] connect: also update offset for features without values
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
        <YUYLXKN8U9AMa5ke@nand.local>
        <YUZinXsGdL19l/tQ@coredump.intra.peff.net>
        <CAPig+cSSxgVU47wCNpcW2HTwCA60e1oZ6Yzkb5i-W2HDijq+MQ@mail.gmail.com>
        <YUaeUuX7aoXtS3jQ@coredump.intra.peff.net>
Date:   Sun, 19 Sep 2021 00:12:03 -0700
In-Reply-To: <YUaeUuX7aoXtS3jQ@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 18 Sep 2021 22:20:02 -0400")
Message-ID: <xmqq35q1f398.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4E334AC-1918-11EC-930B-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Ah, yeah, I forgot we had that. I _thought_ we had a variable ($HT or
> something) for this, but it looks like we only define and use it in a
> few scripts.

I do not mind seeing a patch that consolidates them to test-lib.sh
and make HT sit next to SQ and LF.

> Yeah, that'd probably be OK. I usually shy away from embedded tabs
> because they can cause confusion in editors. But we have them already,
> and this kind of expected output is not touched all that often.

Hmph, I do shy away from trailing whitespaces and we cannot do
leading tabs when doing <<-EOF, but I haven't seen much problem with
them in the middle of a line.

It does become annoying when they happen to be at the 7th column
because it is hard to tell (even with one-letter-at-a-time move
command in your editor) if it is a SP or HT, but q-to-tab in the
middle of lines would make the result much harder to read and the
cure is worse than the disease.

