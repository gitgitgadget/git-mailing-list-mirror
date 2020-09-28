Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE2C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 20:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F392083B
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 20:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B08hRy7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgI1Ub1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 16:31:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65063 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgI1Ub1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 16:31:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17A028D96B;
        Mon, 28 Sep 2020 16:31:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=byv0LF4/FTcHcZyAWGgelA2QyZA=; b=B08hRy
        7e5g+sn43KT0/up4MqKP9stQjffDzNidb3TZy/ABO7VOLR3zMYkZECVX58R+B4XF
        CNhfq0CEtT3tDbDeestsd/q9E9kCtDuCgfaGO6lrKXCpNWJJ21T6bN0KNb0Ozy1c
        hk4rRy4fZ/DGUqw0TWvDBaSb5QIKcUO1cLang=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HqMc4V3cP2q7KSIV5hNlLkQNFSfvmpRz
        /VseiEyNis+r1yDHPysTUXUXtR7ELfdKAkqRmLsrKzZFvgsSAoYMt7ty0WMNw7NQ
        Xt3tnkdV/tMA1DnpKI5G0/SA+GttG3wJ695lOUpwInkwPx/6IcZljOf67QxRt6lV
        6wAWOUEQ6VI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0999F8D96A;
        Mon, 28 Sep 2020 16:31:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BB0B8D969;
        Mon, 28 Sep 2020 16:31:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Prepare git credential to read input with DOS
 line endings
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
        <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 13:31:23 -0700
In-Reply-To: <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 28 Sep 2020 11:40:21
        +0000")
Message-ID: <xmqqpn65lk2s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93B7F228-01C9-11EB-8F50-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This contribution came in via Git for Windows
> [https://github.com/git-for-windows/git/pull/2516].
>
> Sadly, I did not find the time to go through all the changes of 8f309aeb
> ("strbuf: introduce strbuf_getline_{lf,nul}()", 2016-01-13) (as Junio asked
> [https://public-inbox.org/git/xmqqmu9lnjdh.fsf@gitster-ct.c.googlers.com]).
> Rather than delaying this patch indefinitely, I admit defeat on that angle.

Oh, that's OK.  Thanks for resurrecting the stalled patch.  I didn't
mean the suggested action while I was waiting to be an exhaustive
audit---I merely wanted to avoid having to queue a few more separate
ones soon after applying a patch for just a single place.

> Changes since v1:
>
>  * Added a commit to adjust credential-daemon and credential-store in the
>    same manner.

I am kind of surprised to see that these need to be touched at all.

The change to credential-store is sort-of understandable, as the
file it uses could be hand-modified in an editor and its line ending
could have been changed to CRLF, hence it needs to be prepared.

But does inter-process communication with the daemon need to care
about CRLF line endings?  Do parts of the protocol within the
credential system use platform specific line ending?
