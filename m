Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2791AC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 05:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB73823BA9
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 05:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgLSFeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 00:34:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63674 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgLSFeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 00:34:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 356399BE0B;
        Sat, 19 Dec 2020 00:33:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KQrEyITJlwsGJOvfCWIeTPRSBxQ=; b=rPSPTh
        DWPl+Gyk1bcgxZY5B+0W8hBbwCYpS1hWXLu7BS5Dyg5Q9zwDD6eNh+5iUC0PhgI1
        IYpFKs/VIsxBnRRTwFRX22IcgEp6s6l0uxm/6za/IVFXzUHaz8vH9hSEN25elGfu
        ytSKNILSYyKxLsC/iHKSEOaU8LJCYnR6gU/uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mHm/SSZF6A+FtuqKmIa8XlbQsN7z0ZQo
        b3o2t20FuQtFw1nADh6DbpTHfl4u61F0lhIPQ3OlrYdQgiWCMbmqtDCNYEkqW7Xa
        fMc3dHFDaHIwMMhcqueYeqaG3rtOQDjsc7xWWcJqHNDAmV8rXG7gI+B6PgsNcuau
        JaWFXdtsqW8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D5319BE04;
        Sat, 19 Dec 2020 00:33:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1A789BE03;
        Sat, 19 Dec 2020 00:33:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git List <git@vger.kernel.org>,
        pudinha <rogi@skylittlesystem.org>
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
        <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
Date:   Fri, 18 Dec 2020 21:33:26 -0800
In-Reply-To: <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
        (Felipe Contreras's message of "Fri, 18 Dec 2020 22:50:48 -0600")
Message-ID: <xmqqczz6qs0p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B80C6E1A-41BB-11EB-A2A7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Dec 18, 2020 at 10:27 PM Philippe Blain
> <levraiphilippeblain@gmail.com> wrote:
>
>> It seems that 83bbf9b92e (mergetool--lib: improve support for
>> vimdiff-style tool variants,
>> 2020-07-29) introduced a regression in the output shown by 'git
>> mergetool --tool-help'.
>> Even if I have 'meld', 'kdiff3' and 'xxdiff' installed and in PATH,
>> they are not shown at all when
>> the above command is invoked. Only vimdiff, gvimdiff and their *2 and
>> *3 variants are listed.
>
> How about this?
>
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -46,7 +46,7 @@ show_tool_names () {
>                 while read scriptname
>                 do
>                         setup_tool "$scriptname" 2>/dev/null
> -                       variants="$variants$(list_tool_variants)\n"
> +                       variants="$variants$(list_tool_variants)"$'\n'
>                 done
>                 variants="$(echo "$variants" | sort | uniq)"

Ah, I didn't see your variant before sending mine.  $'\n' would work
with bash but we prefer not to rely on bashisms here.

