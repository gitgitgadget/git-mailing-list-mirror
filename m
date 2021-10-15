Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5E5C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 18:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D418461220
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 18:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242478AbhJOSHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 14:07:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52830 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhJOSHc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 14:07:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDAD2FF7B9;
        Fri, 15 Oct 2021 14:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=loXMJvdjz3AugyxTgNfJxW4pVtenLQ1LWAVHHG
        ULhkM=; b=Xj8hb8E14Qx2gg5QoEQvU9a+nyUwg79r9Ztsx6LjYEwJxWWxnPB9Lu
        re2m20H8S0JreQZ7flClKjC4KfNSIAx2Hzlyy697+f4kZn+Uh3AAtufJwktl43Eg
        OqMyHV4+4+8AvFqcaKVlMv6aWzAgu04zDq4MRzR1rP/wh0o/quSZo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4D77FF7B8;
        Fri, 15 Oct 2021 14:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3072FFF7B7;
        Fri, 15 Oct 2021 14:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v13 1/3] grep: refactor next_match() and
 match_one_pattern() for external use
References: <20211015161356.3372-1-someguy@effective-light.com>
Date:   Fri, 15 Oct 2021 11:05:24 -0700
In-Reply-To: <20211015161356.3372-1-someguy@effective-light.com> (Hamza
        Mahfooz's message of "Fri, 15 Oct 2021 12:13:54 -0400")
Message-ID: <xmqqwnme5fkr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78ADF158-2DE2-11EC-8AF6-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hamza Mahfooz <someguy@effective-light.com> writes:

> These changes are made in preparation of, the colorization support for the
> "git log" subcommands that, rely on regex functionality (i.e. "--author",
> "--committer" and "--grep"). These changes are necessary primarily because
> match_one_pattern() expects header lines to be prefixed, however, in
> pretty, the prefixes are stripped from the lines because the name-email
> pairs need to go through additional parsing, before they can be printed and
> because next_match() doesn't handle the case of
> "ctx == GREP_CONTEXT_HEAD" at all. So, teach next_match() how to handle the
> new case and move match_one_pattern()'s core logic to
> headerless_match_one_pattern() while preserving match_one_pattern()'s uses
> that depend on the additional processing.
>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
> v5: separate grep changes from pretty changes.
>
> v6: rescope some variables.
>
> v7: export header_field[] and allow for subsequent matches on header lines
>     in match_one_pattern().
>
> v8: add headerless_match_one_pattern() and move header_field[] back.
>
> v9: get rid of the new check in headerless_match_one_pattern(), move the
>     header pattern filtering logic in grep_next_match() and document
>     grep_next_match() in grep.h.
>
> v10: add a "magic" comment in grep_next_match() to signify a fall through
>      in the switch statement.

Makes readers curious what happend in v11 and later...
