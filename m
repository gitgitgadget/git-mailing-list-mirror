Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61156C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 20:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbiEZUzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243421AbiEZUzm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 16:55:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337D8E64DF
        for <git@vger.kernel.org>; Thu, 26 May 2022 13:55:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75CDE19F466;
        Thu, 26 May 2022 16:55:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9uB735exNrPknlBl1PBDOVXXic5y/ien/RLjaV
        hfHFs=; b=xOAMlJeG4mnXCXEQQ+9UGsyD8+HPUwg2iBfEAwcM5ng+pkUNRb7naT
        omJzjzEdB0s4gR7uC+qqwVgqazy1QyFJ5nssdw0OFKH06oPjRl8UZVadgWX5OeXw
        YUuEjZQzbRJtLa43hm02gwGxU7vrMNYZhW2VIZu5iWCJ+8NRzlovk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E5B519F465;
        Thu, 26 May 2022 16:55:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 26E3C19F464;
        Thu, 26 May 2022 16:55:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 3/3] rebase: note `preserve` merges may be a pull config
 option
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <ece3eecdc4de44cdec1b6efa9079930721db85ad.1653556865.git.gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 13:55:36 -0700
In-Reply-To: <ece3eecdc4de44cdec1b6efa9079930721db85ad.1653556865.git.gitgitgadget@gmail.com>
        (Philip Oakley via GitGitGadget's message of "Thu, 26 May 2022
        09:21:05 +0000")
Message-ID: <xmqqv8tsvws7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31993800-DD36-11EC-BA39-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philip Oakley <philipoakley@iee.email>
>
> The `--preserve-merges` option was removed by v2.35.0. However

Are you sure about that?

52f1e821 (pull: remove support for `--rebase=preserve`, 2021-09-07)
that is in v2.34.0 and above dropped pull.rebase=preserve from the
Documentation/config/pull.txt (and others).  My local collection
of various Git versions agrees with me.  "git help config" from
2.34.0 does not list preserve as a valid choice, but 2.33.0 does.

> users may not be aware that it is also a Pull option, and it is
> still offered by major IDE vendors such as Visual Studio.
>
> Extend the `--preserve-merges` die message to also direct users to
> the use of the `preserve` option in the `pull` config.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>  builtin/rebase.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index aada25a8870..6fc0aaebbb8 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1205,7 +1205,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			     builtin_rebase_usage, 0);
>  
>  	if (preserve_merges_selected)
> -		die(_("--preserve-merges was replaced by --rebase-merges"));
> +		die(_("--preserve-merges was replaced by --rebase-merges\n"
> +			"Your `pull` configuration, may also invoke this option."));

What is a `pull` configuration?  Our configuration variable names
all have at least one dot in it.  I think it is better to be
explicit to clarify what exactly we are suggesting to fix.

"Your `pull.rebase` configuration may be set to 'preserve', which is
no longer supported; use 'merges' instead", or somesuch?

Thanks.
