Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C731C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5734C206E0
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UUjdNEID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfLITrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:47:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52901 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLITrh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:47:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F47F9F1BB;
        Mon,  9 Dec 2019 14:47:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e7C7J5qynm9EqM+U7d8BFLGfgV0=; b=UUjdNE
        ID5jy7LVTmv+RgGfGolBKjk8wywp04/q325OHsEOKAj6dyY5jHiO04AwRWoAY5xp
        H+c29aqbVTVs9yKccE2drUyzL7LLNimfooX2dGqvT4Fs3kpLXp/vXWa9BrkOpWMq
        U78JUjnVYUR4+G1kLWKAgD2lIzP+1C9Vq0TMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XYBpj64skntYZ17gjHbBkHNB7Bt133nW
        Idrb7BZJYUsPdUIfiKqWcrmFYXkfwsdeQN7ACEO2iZnJA2jeu3lPK1GL3t9Mj2Aw
        +zT5f8Hg3E/7qVV/iynjFTh9kswPXzUq7MNOc8rgCLxsM6/dZJ8ACa/aV4QcIbNk
        lnkBySlFNpE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A9449F1B9;
        Mon,  9 Dec 2019 14:47:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 526FC9F1B8;
        Mon,  9 Dec 2019 14:47:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v5 03/15] git-p4: select P4 binary by operating-system
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
        <e425ccc10fbc1f5e135eb59ffc84626f9d0ae4ff.1575740863.git.gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 11:47:30 -0800
In-Reply-To: <e425ccc10fbc1f5e135eb59ffc84626f9d0ae4ff.1575740863.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Sat, 07 Dec 2019 17:47:31
        +0000")
Message-ID: <xmqqd0cxuvql.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD7DCFFA-1ABC-11EA-BFCF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> The original code unconditionally used "p4" as the binary filename.
>
> Depending on the version of Git and Python installed, the perforce
> program (p4) may not resolve on Windows without the program extension.
>
> Check the operating system (platform.system) and if it is reporting that
> it is Windows, use the full filename of "p4.exe" instead of "p4"
>
> This change is Python 2 and Python 3 compatible.
>
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---
>  git-p4.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Makes sense.  Ack from somebody on Windows (not required but would
be nice to have)?

> diff --git a/git-p4.py b/git-p4.py
> index 60c73b6a37..65e926758c 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -75,7 +75,10 @@ def p4_build_cmd(cmd):
>      location. It means that hooking into the environment, or other configuration
>      can be done more easily.
>      """
> -    real_cmd = ["p4"]
> +    if (platform.system() == "Windows"):
> +        real_cmd = ["p4.exe"]
> +    else:
> +        real_cmd = ["p4"]
>  
>      user = gitConfig("git-p4.user")
>      if len(user) > 0:
