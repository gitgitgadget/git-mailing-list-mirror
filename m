Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE5E1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 06:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfKSGKc (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 01:10:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51969 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfKSGKc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 01:10:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3E5919160;
        Tue, 19 Nov 2019 01:10:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3ZsCRP1vzT2gPmZGgWtalIKzxcw=; b=qPtUPf
        +a39X2XeFVe9eClxam5/Dpi9ZxxqSeYBXc3C6HCxs12iQwcXQ5OQ08L6ObnbNWrS
        PZAGYlDLP8GWHOHVRGOlflw+Btd1+4UXvrdhRLEca+ECazBTB08UriRF2S2lWZyk
        Ni0WN5mGxGl/TZ0C/kIbUUxxNcHn1IVVbbnRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NKr01t67PgMLRRlf1cnqqDvtmoN5wNtL
        KziXy5o3UyUGQkAsALT+al5+4s2ivmoKTxOyRuoCf4159xqKb8Nhzb9gZMsd0l/H
        DBx/d8K/MMgE5VLAZKpz8WyMVhMMKhpEyh/Qxqe+XbIC5F42cvk0PtmWgh+/8FxD
        ts610PgbuIg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE4191915E;
        Tue, 19 Nov 2019 01:10:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 111AC1915D;
        Tue, 19 Nov 2019 01:10:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 6/6] commit: support the --pathspec-from-file option
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
        <cb5fc9b14dbe81703a7fc61b56f5c68c4a49ebc2.1573055478.git.gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 15:10:27 +0900
In-Reply-To: <cb5fc9b14dbe81703a7fc61b56f5c68c4a49ebc2.1573055478.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Wed, 06 Nov 2019
        15:51:18 +0000")
Message-ID: <xmqqo8x8xup8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4915C6BA-0A93-11EA-A5F3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -277,6 +278,18 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
>  	the last commit without committing changes that have
>  	already been staged. If used together with `--allow-empty`
>  	paths are also not required, and an empty commit will be created.
> +	
> +--pathspec-from-file=<file>::
> +	Pathspec is passed in `<file>` instead of commandline args. If
> +	`<file>` is exactly `-` then standard input is used. Pathspec
> +	elements are separated by LF or CR/LF. Pathspec elements can be
> +	quoted as explained for the configuration variable `core.quotePath`
> +	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
> +	global `--literal-pathspecs`.

OK.

> +--pathspec-file-nul::
> +	Only meaningful with `--pathspec-from-file`. Pathspec elements are
> +	separated with NUL character and are not expected to be quoted.

Although it is not incorrect, "are not expected to be quoted" feels
a bit weak as the technical description.  Are they not expected to
be quoted, but the command gracefully works on them even when they
are found to be quoted?

Rephrasing to avoid such misinterpretation may be worth doing,
perhaps

	... and are taken as-is without unquoting (i.e. as if
	`core.quotePath` is set to `false`).

or something like that?

Thanks.
