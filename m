Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE20C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 19:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjHITiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjHITiV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 15:38:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA010DA
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 12:38:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7EA96353F9;
        Wed,  9 Aug 2023 15:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6ElRraVGv2CrNhH5RJzGAdsYbghEabr+HfXlRG
        GSXc8=; b=l5c18X0p1jqOtkOq5NOOEZOgiIxirdSgIBDuoK/6Q7B/4uF5iFLlr+
        PK4jFwCuThYF8IcpI4VPuc0goCDaaDMA1iAA+SCXKZWUjieB6txcQCnDXP28W06R
        hU/ZDz0Zh5RCuv1T0Ja9m7LVZkrvlXE3roDSDfREIty0CHIn0BzVU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77488353F8;
        Wed,  9 Aug 2023 15:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0F5E2353F5;
        Wed,  9 Aug 2023 15:38:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/1] t/lib-rebase: improve documentation of
 set_fake_editor()
References: <8ce40f48-f36f-9e81-1a3f-9d8b170c4a0f@gmail.com>
        <20230809171531.2564785-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564785-2-oswald.buddenhagen@gmx.de>
Date:   Wed, 09 Aug 2023 12:38:13 -0700
In-Reply-To: <20230809171531.2564785-2-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Wed, 9 Aug 2023 19:15:31 +0200")
Message-ID: <xmqqfs4sm2fu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48739438-36EC-11EE-A4C7-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> Firstly, make it reflect better what actually happens. Not omitting some
> possibilities makes it easier to fully exploit them, and not
> contradicting the implementation makes it easier to grok and thus modify
> the code.
>
> Secondly, improve the overall structure, putting more general info
> further up.
>
> Thirdly, document `merge`, `fakesha`, and `break`, which were previously
> omitted entirely.
>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>
> ---
> v2:
> - everything phillip asked for, i think. of course, it's still bullet
>   points, just without the punctuation - i wouldn't know what else to
>   do about it which would be an actual improvement.

If more bits are spent for the explanation of concrete changes (like
"move general info first and then describe details") that back
subjective claims (e.g. make it "better", "improve" the structure),
the result probably would read better.  Readers do not have to take
your word on it that the result is "better", but at least would
understand the reason why you think the result is "better" and can
agree (or disagree) more easily.

I am not Phillip but to me what you wrote in the above look clear
enough.  Thanks for working on it.

> Cc: Phillip Wood <phillip.wood123@gmail.com>
> ---
>  t/lib-rebase.sh | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 7ca5b918f0..133c856992 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -8,18 +8,21 @@
>  # - check that non-commit messages have a certain line count with $EXPECT_COUNT
>  # - check the commit count in the commit message header with $EXPECT_HEADER_COUNT
>  # - rewrite a rebase -i script as directed by $FAKE_LINES.
> -#   $FAKE_LINES consists of a sequence of words separated by spaces.
> -#   The following word combinations are possible:
> +#   $FAKE_LINES consists of a sequence of words separated by spaces;
> +#   spaces inside the words are encoded as underscores.
> +#   The following words are possible:
>  #
> -#   "<lineno>" -- add a "pick" line with the SHA1 taken from the
> -#       specified line.
> +#   "<cmd>" -- override the command for the next line specification. Can be
> +#       "pick", "squash", "fixup[_-(c|C)]", "edit", "reword", "drop",
> +#       "merge[_-{c|C}_<rev>]", or "bad" for an invalid command.
>  #
> -#   "<cmd> <lineno>" -- add a line with the specified command
> -#       ("pick", "squash", "fixup"|"fixup_-C"|"fixup_-c", "edit", "reword" or "drop")
> -#       and the SHA1 taken from the specified line.
> +#   "<lineno>" -- add a command, using the specified line as a template.
> +#       If the command has not been overridden, the line will be copied
> +#       verbatim, usually resulting in a "pick" line.
>  #
> -#   "_" -- add a space, like "fixup_-C" implies "fixup -C" and
> -#       "exec_cmd_with_args" add an "exec cmd with args" line.
> +#   "fakesha" -- add a command ("pick" by default), using a fake SHA1.
> +#
> +#   "exec_[command...]", "break" -- add the specified command.
>  #
>  #   "#" -- Add a comment line.
>  #
