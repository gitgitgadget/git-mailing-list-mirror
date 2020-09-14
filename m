Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF237C43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 21:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A28F218AC
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 21:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IC+/Ggr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgINVCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 17:02:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63047 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgINVCC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 17:02:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB61B1034E1;
        Mon, 14 Sep 2020 17:02:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=BAkSpaNT4UhWphc64qobdVhAGI8=; b=IC+/Ggr1LVep1h9NMX7U
        LqVw/oFIPyFMskG4klYPY0CQVZOI2pOCC3y8O3cNIYI+ni5goMt4sGY09rmWgrVg
        x4hVdPg17ifU0r3xWc6QrOuraLiJlnIepf0u1tMRmxB05lvn3qINGoVRqkTIZdvb
        NIMVyEzb6CLCD8mb1dBchvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=JJmv3Yb8s2BlnFCUK1J7whY4KcMivm2ZCPOh6vCYH6AgCA
        8i+9K11kUsYtlcB503pc63lIm+Weexk5DZOptCycqPL3plTxK77qTRggZaBtF0OR
        Q3y4KK6WsT1Ty3XIuw34KEZN7kUxK8pL3mbVxBiQB1f67uT4USlQO4iRsJ0BM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B112D1034E0;
        Mon, 14 Sep 2020 17:02:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C82B01034DD;
        Mon, 14 Sep 2020 17:01:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 6/7] doc: add reference for "--[no-]force-if-includes"
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
        <20200913145413.18351-7-shrinidhi.kaushik@gmail.com>
Date:   Mon, 14 Sep 2020 14:01:55 -0700
Message-ID: <xmqqzh5s1398.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86CA14DA-F6CD-11EA-BEF3-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 3b8053447e..b40fe7e7cf 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -320,6 +320,12 @@ seen and are willing to overwrite, then rewrite history, and finally
>  force push changes to `master` if the remote version is still at
>  `base`, regardless of what your local `remotes/origin/master` has been
>  updated to in the background.
> ++
> +Alternatively, specifying `--force-if-includes` an an ancillary option along
> +with `--force-with-lease[=<refname>[:expect]]` (when "<refname>" or "<expect>"
> +values are unspecified) at the time of `push` will verify if updates from the
> +remote-tracking refs that may have been implicitly updated in the background
> +are integrated locally before allowing a forced update.

You cannot omit <refname> without omitting <expect>, so

	... with "--force-with-lease[=<refname>]" (i.e. without
	saying what exact commit the ref on the remote side must be
	pointing at, or which refs on the remote side are being
	protected) at the time of ...

would be more appropriate.

> +--[no-]force-if-includes::
> +	Force an update only if the tip of the remote-tracking ref
> +	has been integrated locally.
> ++
> +This option verifies if the tip of the remote-tracking ref on which
> +a local branch has based on (for a rewrite), is reachable from at
> +least one of the `reflog` entries of the local branch about to be

If we take the "we don't have to look at a local branch's reflog;
just check HEAD's and rebase will automatically be handled without
expensive merge-base" approach, then

    ... if the tip of the remote-tracking ref was once checked out
    to the working tree (for a rewrite) by seeing if it appears in
    the reflog of "HEAD" ...

