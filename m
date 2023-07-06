Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341F9EB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 20:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjGFUZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 16:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGFUZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 16:25:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C01DB
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 13:25:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C9092073C;
        Thu,  6 Jul 2023 16:25:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iKN/dmZPaDQmv5a/sYQ99be+dyfXXj1AWOgnA2
        abR7s=; b=WlwP/cfGghNywDHwqaTLaMLmsi3UUKHeIlcSnP5umRiWmmhjkPT9E+
        Yk5ltYyTECkkZZBPnFyw4Kki1Uc3yZzDQbX1EaUsJeA6ddzYSn7Alj4CXtITGMif
        gPPtMs98bjNTMXvu+Z7r6RgZ6z/+TC0LaUH9X8eEAMJNc74HNsrFI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 448E42073B;
        Thu,  6 Jul 2023 16:25:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C84682073A;
        Thu,  6 Jul 2023 16:25:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
        <20230706040111.81110-1-alexhenrie24@gmail.com>
        <20230706040111.81110-2-alexhenrie24@gmail.com>
Date:   Thu, 06 Jul 2023 13:25:35 -0700
In-Reply-To: <20230706040111.81110-2-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 5 Jul 2023 22:01:02 -0600")
Message-ID: <xmqqttugbxds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 443A9C66-1C3B-11EE-979E-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Also, don't imply that `git pull` is only for merging.
>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>

I appreciate, but do not need, the credit; in any way, I didn't
co-author this one.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  remote.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index a81f2e2f17..1fe86f8b23 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2323,7 +2323,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  			base, ours, theirs);
>  		if (advice_enabled(ADVICE_STATUS_HINTS))
>  			strbuf_addstr(sb,
> -				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
> +				_("  (To reconcile your local changes with the work at the remote, you can\n"
> +				  "  use 'git pull' and then 'git push'. To discard the work at the remote\n"
> +				  "  and replace it with what you did (alone), you can use\n"
> +				  "  'git push --force'.)\n"));
>  	}

Since wt-status.c:wt_longstatus_print_tracking() calls this
function, I would expect that this change would manifest as test
breakage in "git status" (or "git commit" whose commit log edit
buffer is examined) tests.  Are we lacking test coverage?

Thanks.



