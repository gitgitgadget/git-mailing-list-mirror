Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C982EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 16:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjGLQkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGLQkd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 12:40:33 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2016E69
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 09:40:26 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A28A1A0746;
        Wed, 12 Jul 2023 12:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=spr3ApQh3yrQfEZV3uEvl4fghtWVefywHAusDV
        CN48U=; b=D2bD0lT8DqI9WwTBd2ZPs9TPzyBKVxxQLF7TGN/B1snN32YZx0jMOb
        YmFU+ZGNoihlxCpdUn9gUtdhbIGGT3dDU3NP06uDNgyjb2hSb/UpRwdtx5JSJgxq
        QsSGY/w3PHWAKTddinGYbCNqiZ92H/JWoCaKzCdDGo6J9qSQNlfcM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F6881A0745;
        Wed, 12 Jul 2023 12:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B4BD1A0744;
        Wed, 12 Jul 2023 12:40:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     pvutov@imap.cc
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: remove mentions of .gitmodules !command syntax
References: <20230712160216.855054-1-pvutov@imap.cc>
Date:   Wed, 12 Jul 2023 09:40:24 -0700
In-Reply-To: <20230712160216.855054-1-pvutov@imap.cc> (pvutov@imap.cc's
        message of "Wed, 12 Jul 2023 18:02:03 +0200")
Message-ID: <xmqqleflt75z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD4196EA-20D2-11EE-ADFA-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pvutov@imap.cc writes:

> From: Petar Vutov <pvutov@imap.cc>
>
> To mitigate CVE-2019-19604, the capability to configure
> `git submodule update` to execute custom commands was
> removed in v2.20.2.
>
> The git-submodule documentation still mentions the now-unsupported
> syntax, which is misleading.
>
> Remove the leftover documentation.

The change during v2.20.2 timeperiod you have in mind may be
e904deb8 (submodule: reject submodule.update = !command in
.gitmodules, 2019-12-05).  The key phrase is "in .gitmodules"
as it did not forbid writing update command in the configuration.

The pre-context lines of your patch (see below) say that the 'custom
command' option and 'none' option are only available via the
`submodule.<name>.update` configuration variable.  IOW, this part of
the documentation does not talk about the .gitmodules file---it
talks about what you can say in the configuration file (which is
under your local control).

I think the existing text that came from fc01a5d2 (submodule update
documentation: don't repeat ourselves, 2016-12-27) may be
misleading, and may has room for improvement, but I do not think it
is wrong per-se.  If we remove it, there is nowhere else that teaches
users !cmd can be set in their configuration files, or is there?

Thanks.

> Signed-off-by: Petar Vutov <pvutov@imap.cc>
> ---
>  Documentation/git-submodule.txt | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 4d3ab6b9f9..b40ac72f75 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -163,12 +163,6 @@ checked out in the submodule.
>  The following 'update' procedures are only available via the
>  `submodule.<name>.update` configuration variable:
>  
> -	custom command;; arbitrary shell command that takes a single
> -	    argument (the sha1 of the commit recorded in the
> -	    superproject) is executed. When `submodule.<name>.update`
> -	    is set to '!command', the remainder after the exclamation mark
> -	    is the custom command.
> -
>  	none;; the submodule is not updated.
>  
>  If the submodule is not yet initialized, and you just want to use the
