Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386FFC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A0421744
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZSS2NxjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbgGaRsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:48:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57404 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbgGaRsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 13:48:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE4FDED36A;
        Fri, 31 Jul 2020 13:48:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LeKni1ztnGzt1RW+eyCMCoUfkd4=; b=ZSS2Nx
        jQcvvP50W7hfwKj7InGUL8W8J/Ku/gCzKD/t+QmT2CW1IU4/TbdEWY0o55OkuZ5S
        V183wpmQDsRk5HcBNEZbD4SE9Sk2xml81IfzzZ3R/6urmLejcew12EilagoDvU6L
        2KhNdTNuiCMzMmRAL+y9A3A7ekD91A8WylBms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TELZ7o1mDCX05SZO6fazFA9U0jUirq7+
        celenue0SnopDF9xMi1hXSCMQBug85eqXFwVkctm3sIEEoYkzy2uS1GTw0Wo3ojR
        FWEz1dzh0WrAbULY7U2ljslNjznP/yVGWfsHRIzQ3ghtfwU3eeNpwMWa2LT7tjyp
        KRa/Ez0oDXw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6932ED369;
        Fri, 31 Jul 2020 13:48:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F03ECED368;
        Fri, 31 Jul 2020 13:48:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH v3 0/6] stash: drop usage of a second index
References: <20200630151558.20975-1-alban.gruin@gmail.com>
        <20200731165140.29197-1-alban.gruin@gmail.com>
Date:   Fri, 31 Jul 2020 10:48:31 -0700
In-Reply-To: <20200731165140.29197-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Fri, 31 Jul 2020 18:51:34 +0200")
Message-ID: <xmqq4kpn4lu8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D2E2872-D356-11EA-B5D1-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> The old scripted `git stash' used to create a second index to save
> modified and untracked files, and restore untracked files, without
> affecting the main index.  This behaviour was carried on when it was
> rewritten in C, and here, most operations performed on the second index
> are done by forked commands (ie. `read-tree' instead of reset_tree(),
> etc.).

Does the "second index" in the title refer to the on-disk $TMPindex
in https://github.com/git/git/blob/ffac537e6c/git-stash.sh#L147 that
is used to create a tree object $u_tree (and similarly for the
working tree files $w_tree)?

> The goal of this series is to modernise (a bit) builtin/stash.c.

Modernise in what way is quite unclear.  With the internal API we
have available from C code, we can create a tree object from an
in-core index without writing the in-core index out to an on-disk
file that is different from the main on-disk index file, and I
suspect, from the "drop usage of" in the title, that it is what this
series is trying to do, but the description could have been written
in a way that is more helpful to readers to understand it without
having to guess.  It made me wonder if you are not even using the
secondary in-core index and no longer writing the tree to record the
untracked paths and their contents, but obviously such a patch would
not work well ;-)

