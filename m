Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B095C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbiDRRJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbiDRRJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:09:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143A4201AC
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:07:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B0B518D2A6;
        Mon, 18 Apr 2022 13:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yB9b0s3BIcKotppel55tRgn6a4uyfJ6FX4OQ7q
        wiETw=; b=XEyN9iGilRZPpidinw/JU6TeFiYsLNBPdqR45hhkFCIE/dN8xZ7t+n
        6W3jKhdp2W2wGkJ8OkqQ5hQ49Y4VvZ45L6G1sc6E7mosUMZuJ0TWMz6SJ79ZkjSA
        XqBNjhpwg5O0CTGJLoXeLHo/nohyb3MmdOH+bd1lPzYhB4RkLp0AU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0426B18D2A5;
        Mon, 18 Apr 2022 13:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7944B18D2A4;
        Mon, 18 Apr 2022 13:07:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rebase: simplify an assignment of options.type in
 cmd_rebase
References: <20220418164359.205723-1-eantoranz@gmail.com>
Date:   Mon, 18 Apr 2022 10:07:03 -0700
In-Reply-To: <20220418164359.205723-1-eantoranz@gmail.com> (Edmundo Carmona
        Antoranz's message of "Mon, 18 Apr 2022 18:43:59 +0200")
Message-ID: <xmqqr15uxqvc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F884A730-BF39-11EC-91DE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> There is an if statement where both if and else have the same
> assignment of options.type to REBASE_MERGE. Simplify
> it by getting that assigmnent out of the if.
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
>  builtin/rebase.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 27fde7bf28..d2d63bdef1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1187,11 +1187,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		} else {
>  			strbuf_reset(&buf);
>  			strbuf_addf(&buf, "%s/interactive", merge_dir());
> -			if(file_exists(buf.buf)) {
> -				options.type = REBASE_MERGE;
> +			options.type = REBASE_MERGE;
> +			if(file_exists(buf.buf))

Perhaps fix the style as we are changing the line anyway by losing {}?
i.e.

			if (file_exists(buf.buf))

>  				options.flags |= REBASE_INTERACTIVE_EXPLICIT;
> -			} else
> -				options.type = REBASE_MERGE;
>  		}
>  		options.state_dir = merge_dir();
>  	}

Other than that, good finding!
