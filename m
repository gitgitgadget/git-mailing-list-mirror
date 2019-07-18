Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0411F461
	for <e@80x24.org>; Thu, 18 Jul 2019 20:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391606AbfGRUeU (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 16:34:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51179 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfGRUeT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 16:34:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCD6E7F115;
        Thu, 18 Jul 2019 16:34:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nW4a8Mn9I2xTlBViZdi2MLUxyu4=; b=OR6Hjb
        0prkB+k4P1wF6SOI4jfCC2ctk8rGbUdebvEUpM83gLPk6ueyvTiDUbRDX06fdPNI
        /Cs2/h95w3O0Dun4SYHMb9mFNQ3tvpaV2hVLb4zGgNgHGIRjSrMpex566WnjV5kZ
        sIoV0rnM+AlrpkfbVciG8+x308gttMXK6l6LY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pzc6t68GrfdB0i/dIxPNaf+FuiGKRuar
        EhNEiLNXmg/w8l4ZtOd+kfZoKtA0ntkHbGXW8kMEbVrbyV5KBF3EzRQusUT28KLx
        wawkGGoKDvlMFdgQF3g65r9a4Tli725W4fMj5Bc/8mXikMQ1geOjHMlOeD+RMo0L
        bquu2xTsKaI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C51A27F113;
        Thu, 18 Jul 2019 16:34:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12E0F7F112;
        Thu, 18 Jul 2019 16:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 23/24] t5505,t5516: create .git/branches/ when needed
References: <pull.287.git.gitgitgadget@gmail.com>
        <db69b33ff4a583f75e07f15d10dba70bd99fcaf7.1563455939.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Jul 2019 13:34:12 -0700
In-Reply-To: <db69b33ff4a583f75e07f15d10dba70bd99fcaf7.1563455939.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 18 Jul 2019
        06:19:16 -0700 (PDT)")
Message-ID: <xmqqftn3xet7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68919FCC-A99B-11E9-9EB0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is a real old anachronism from the Cogito days to have a
> .git/branches/ directory. And to have tests that ensure that Cogito
> users can migrate away from using that directory.
>
> But so be it, let's continue testing it.
>
> Let's make sure, however, that git init does not need to create that
> directory.
>
> This bug was noticed when testing with templates that had been
> pre-committed, skipping the empty branches/ directory of course because
> Git does not track empty directories.

Many tests assume that the .git/info/ directory exists, and the only
reason why they can is because we have templates/info--exclude; the
situation around .git/branches/ is exactly the same.

Deprecating .git/branches/ directory and dropping the parts of tests
that wants to make sure the support still works (t5516 is not about
migration but about working with .git/branches configuration) would
be a different matter.  Until that happens, let's not do this patch;
otherwise it would force us to sprinkle "mkdir -p .git/info/" all
over the place for the same rationale.  A directory in .git/ created
by hardcoded mkdir in "git init" (like .git/refs/) and created by
copying templates by "git init" (like .git/info/ and .git/branches)
are both "created by 'git init'".  Special casing the latter is just
silly.

