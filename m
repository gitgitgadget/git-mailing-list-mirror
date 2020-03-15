Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD41C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 19:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F20E20575
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 19:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uWLG2XNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgCOTjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 15:39:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51219 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgCOTjX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 15:39:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04F764E679;
        Sun, 15 Mar 2020 15:39:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ukPziffvIjrXoXYKSTXl2l6TQVk=; b=uWLG2X
        Nm4wdvSf8bFK1/TTdT8Zn5DHx3r2VwL6p7SGwJMKtmNrkVdWdUVB99rUZcjVSMGG
        QZ979IDjFpYz08K9UkFEmEfUcEUN3s299/431StQpfgkbKKdTiGFZX4oYEe/KEhj
        Xw7zBMtOUZ4+S65CBjRF0Y3aCFZ8mOjjtQ9iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YkBTNl+mPoSxHiKnZD4iuG2/VOjJLUZ8
        oPu2Wavw3xtzpijgBCHf3dB5XhoDhWOLsC/6C2Pnkt+smkz7tgubzwIr9hBInA8A
        iKDl/QmdngD+XC/quuRTOro/8qurQDBOP9xfJj3z/9kIfvxe3DlThVMDKttSMCyM
        FV4MfAKs9Gk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0F3A4E678;
        Sun, 15 Mar 2020 15:39:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82F374E676;
        Sun, 15 Mar 2020 15:39:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Universal progress option (was Re: [PATCH] clone: use --quiet when stderr is not a terminal)
References: <pull.581.git.1584133742475.gitgitgadget@gmail.com>
        <xmqqh7yqc16w.fsf@gitster.c.googlers.com>
        <a044478f-ca04-3475-90de-0332e80f552d@gmail.com>
        <310a176a-1b30-a479-638e-33a51fb2c896@gmail.com>
Date:   Sun, 15 Mar 2020 12:39:20 -0700
In-Reply-To: <310a176a-1b30-a479-638e-33a51fb2c896@gmail.com> (Derrick
        Stolee's message of "Sun, 15 Mar 2020 09:41:39 -0400")
Message-ID: <xmqqk13l9zmf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA6C9E3A-66F4-11EA-B2FE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> 2. Update Git's option-parsing to check for --[no-]progress in
>    every builtin (before the builtins do their own parsing).

    git $frotz -e --no-progress other options

Now, without knowing what exactly $frotz is and how it handles its
command line options, you cannot tell if you should unset the global
"progress" variable.  It could be that "-e" is an option that takes
one argument (e.g. "git grep -e") in which case, you should not
touch the global, or that "-e" is an explicit request to invoke an
editor by countermanding anything in the environment or config
(e.g. "git merge -e"), in which case you found "--no-progress" that
affects the global.

If the parser that kicks in before the commands do their own parsing
needs to know that much to correctly understand "--progress" anyway,
wouldn't the same amount of effort would allow us to teach these
individual commands to understand "--progress" and pass it correctly
down to the underlying helpers?

So, "git clone --no-progress" that lets checkout progress may be a
bug worth fixing, but I do not think a global switch is a good way
forward.

Thanks.
