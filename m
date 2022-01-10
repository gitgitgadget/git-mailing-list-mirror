Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D05C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiAJTwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:52:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62399 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbiAJTwF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 14:52:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D18F17F618;
        Mon, 10 Jan 2022 14:52:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2XhU1zaLPNKIzFz/U53/Bl5tS3omXtUGh103t+
        FP99Y=; b=RLiIJ7A2mux29KtADCnMQ+cKcW8YJbdVK5Jgxxjqg4KXwX47qpH9CJ
        +CZgiat1k24PWIQ54zJy8JKgg7RuHkQ6vGIAHRURQ/SK0JNXZ3IaPr5PLSWQYgCR
        GiFCAMi+4GePhE2UXNCaVoOdTclkZLeJfJDJcXNF179UDMEf57tI0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 644E517F617;
        Mon, 10 Jan 2022 14:52:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C23CE17F615;
        Mon, 10 Jan 2022 14:52:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Subject: A couple more duplicate declarations
References: <20220110184134.18675-1-martin.agren@gmail.com>
        <c0a0798d-96fb-936b-3234-88e500eb86d0@github.com>
        <xmqqfspvz8us.fsf@gitster.g>
Date:   Mon, 10 Jan 2022 11:52:01 -0800
In-Reply-To: <xmqqfspvz8us.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        10 Jan 2022 11:30:51 -0800")
Message-ID: <xmqqwnj7xtb2.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7E1F304-724E-11EC-B4DC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Thanks for cleaning up the duplicate, looks good to me!
>
> Thanks, both.

This is not urgent at all, given that we are about to enter the
pre-release stabilization period and patches that might result from
this message would become lower priority, but there are a couple of
duplicate declarations, which I'll mention in order to help people
to come back to them later.

* trace2_cmd_exit_fl() was added to git-compat-util.h and to
  trace2.h by ee4512ed (trace2: create new combined trace facility,
  2019-02-22).  Logically it belongs to the latter.  Moving
  inclusion of the latter from <cache.h> to <git-compat-util.h>
  might be the lowest-cost fix, but there may be ramifications.

* xdl_emit_diff() is declared in xdiff/xdiffi.h and xdiff/xemit.h; I
  wonder if there is a caller that only includes one but not the
  other header.  As they came from the same upstream-import commit,
  I wouldn't worry too much about it.

