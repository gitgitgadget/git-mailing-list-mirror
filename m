Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34748C4361B
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 18:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA12922D0A
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 18:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgLTSMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 13:12:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64140 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgLTSML (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 13:12:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6364EA7206;
        Sun, 20 Dec 2020 13:11:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RyqqvBW46M1z
        i53/UhKw2OscPtc=; b=Qceh+1z4sB7GhkJexU33Ik08hb3TRHjhwoZd9p74fpFE
        rp1qQCBRhClC9L3oDoRotxroKB+7QXRB6x8uZ8w2w5P3ae+gXb0ox0gUd0AgUWgY
        p1xjpsJnnrk0bTSGRAWFINmREY/DLgp2YIHGnZB260WLreA2L8QtECbB0Hkyfzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=grr3tX
        G1mncL7FF9j172FtNvqexcRJ2rcGqRMxsJx2CfrDfEM1v/sLoIcQ68wAE8T2LzX9
        f4DTEAT6nI01+ZD9zC/jBjURFNOXLtyjcRZCwUc2Rr2zKCcfHOEmcHtTPcckNR02
        N/RrfNi/UBLgDWTEQtIN7otnh6CkQV4i461AU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10926A7204;
        Sun, 20 Dec 2020 13:11:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65F24A7203;
        Sun, 20 Dec 2020 13:11:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git List <git@vger.kernel.org>,
        pudinha <rogi@skylittlesystem.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
        <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
        <xmqqczz6qs0p.fsf@gitster.c.googlers.com>
        <5fddeda8a5a92_1de0de2088a@natae.notmuch>
        <xmqqsg81pvm8.fsf@gitster.c.googlers.com>
        <c4f2330f-715b-1745-5ad7-5477f4e833db@gmail.com>
        <568f42a0-f630-64ca-9f77-183dcaa56d1e@kdbg.org>
        <a9e6f3aa-e88e-6cc2-fb16-c26bdd3bf4d3@web.de>
Date:   Sun, 20 Dec 2020 10:11:25 -0800
In-Reply-To: <a9e6f3aa-e88e-6cc2-fb16-c26bdd3bf4d3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 20 Dec 2020 17:23:26 +0100")
Message-ID: <xmqqwnxcmjoy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C679FB28-42EE-11EB-AAFF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> This still starts a subshell in the last line.  How about something
> like this?
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 7225abd811..79d5ed1fa9 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -46,11 +46,9 @@ show_tool_names () {
>  		while read scriptname
>  		do
>  			setup_tool "$scriptname" 2>/dev/null
> -			variants=3D"$variants$(list_tool_variants)\n"
> -		done
> -		variants=3D"$(echo "$variants" | sort | uniq)"
> -
> -		for toolname in $variants
> +			list_tool_variants
> +		done | sort | uniq |
> +		while read toolname
>  		do
>  			if setup_tool "$toolname" 2>/dev/null &&
>  				(eval "$condition" "$toolname")
>
> It requires setup_tool to be silent, though.

Another thing it depends on is that the side-effect of setup_tool in
the first loop does not matter in the end, as it now is done in the
upstream of a pipe.  It is a safe assumption to make (setup_tool is
called again in the later loop, so in the original it was called
twice), I think.

>> BTW, is `sort -u` not available everywhere?
>
> It's used by the function mergetool_find_win32_cmd in the same file
> and by several test scripts, so that shouldn't be a problem.

"sort -u" is safe; it is even in POSIX.

Having said that, when finding out how portable a construct we
already use is across the platforms we support, my recommendation is
to pretty much ignore what we do in a function or a file that we
know is only used by a single platform.  Stuff written for Windows,
for example, can assume that we use a particular implementation of
system-supplied tools and libraries.  The use of "sort -u" in
mergetool_find_win32_cmd can be legitimately justified with "We know
we use only GNU sed" and "we taught -u to our busybox sed already",
for example, if these statements are true.

Thanks.
