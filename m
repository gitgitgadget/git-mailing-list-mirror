Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8F3C4361B
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 15:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6C023106
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 15:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgLTPfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 10:35:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64301 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgLTPfK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 10:35:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3EF7EFD481;
        Sun, 20 Dec 2020 10:34:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=vMuMRtsQ9y5kqFeAL6FzX/iFCME=; b=oMGHRc9rmwcuSOfC3rTb
        nmNyz6IWNFk18kMtquNL1Olev7uH/5ZIHBwe+ftqR6a0//XN0teOQyaOGrsPushx
        4rrJzcDu32w0PDVMkp5BRTTcE19dfcJcyyy8JZJ+Z+Zz3kQqUI7Se6Q9BjMC/TZb
        6gwt7RnYbXN2m3BdBGxOaH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=eg3cQRFLoDUEIaWjqrgH1Qy4UgbqKeDtYI3n4UlQjz4i5x
        APLNYFTuZcaxZmD0iCSvvY4wQgZpFwl9i17UHFaVvt6lUR8bGv2C0yd4fAm6J2Wi
        940UwXCtV/lYGqWMsiuPJk83AqQpiJZkAn2WIOjoqfxXwvzwoWcLDAPz9rmqg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37821FD480;
        Sun, 20 Dec 2020 10:34:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 81A19FD47F;
        Sun, 20 Dec 2020 10:34:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git List <git@vger.kernel.org>,
        pudinha <rogi@skylittlesystem.org>
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
        <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
        <xmqqczz6qs0p.fsf@gitster.c.googlers.com>
        <5fddeda8a5a92_1de0de2088a@natae.notmuch>
        <xmqqsg81pvm8.fsf@gitster.c.googlers.com>
        <c4f2330f-715b-1745-5ad7-5477f4e833db@gmail.com>
Date:   Sun, 20 Dec 2020 07:34:23 -0800
Message-ID: <xmqq1rfko5j4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D72E22A2-42D8-11EB-B2F5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Thanks for both answers. Felipe's solution does the trick, but Junio's does not;
> it seems we do have to have a newline there.

Curious.  Are you sure you changed the second echo to printf and
left the argument after '%s\n' unquoted, i.e. $variants and not
"$variants"?

> diff --git i/git-mergetool--lib.sh w/git-mergetool--lib.sh
> index 2defef28cd..6f03975493 100644
> --- i/git-mergetool--lib.sh
> +++ w/git-mergetool--lib.sh
> @@ -46,7 +46,7 @@ show_tool_names () {
>  		while read scriptname
>  		do
>  			setup_tool "$scriptname" 2>/dev/null
> -			variants="$variants$(list_tool_variants)\n"
> +			variants="$(echo "$variants" && list_tool_variants)"

Gee, echoing the variable double-quoted inside $()?  That's as ugly
as a command substitution construct can go X-<.

>  		done
>  		variants="$(echo "$variants" | sort | uniq)"

