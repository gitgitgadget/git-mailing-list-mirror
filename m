Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5451CC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1685323A00
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgLSROG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 12:14:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64863 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgLSROG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 12:14:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 282C211755D;
        Sat, 19 Dec 2020 12:13:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yn1zYPtqZUguZM7hhgDd8jTmZfY=; b=gbc8Xg
        RU3yk6gaSe6BZaektY2C/U3+u2UzoNxbDsHrTFCeFUTEh8qrH8OL2O0fAGsnYoy6
        WGWdBRReliQjTtkcobEv+hKkQ4Mp7CP0pfoIIqa0UbkZbX0egWqTr9eNl1ACP0Tk
        e13XYWwnAdUrw/KT0BINvT1jZg05aIL8n2Bw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q1SJdJF9MWYqldEP37lfdX7fEcczt0AL
        iLydPLqQ+YTk681G3U6PdvY6IYrtgsOmT/cy2mQ8URH9pSLRxw98ZO0iiGb4MHpP
        9v0sEzFQ8H+6365FOoBXP/0cIUDYmkJ9qmYT7DoYECLLogJHMhsD+3ZNn8NU6crh
        Ezzno9lpwn4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FB8C11755C;
        Sat, 19 Dec 2020 12:13:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6979C11755B;
        Sat, 19 Dec 2020 12:13:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git List <git@vger.kernel.org>,
        pudinha <rogi@skylittlesystem.org>
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
        <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
        <xmqqczz6qs0p.fsf@gitster.c.googlers.com>
        <5fddeda8a5a92_1de0de2088a@natae.notmuch>
Date:   Sat, 19 Dec 2020 09:13:19 -0800
In-Reply-To: <5fddeda8a5a92_1de0de2088a@natae.notmuch> (Felipe Contreras's
        message of "Sat, 19 Dec 2020 06:10:16 -0600")
Message-ID: <xmqqsg81pvm8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7ED78AD2-421D-11EB-8798-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> > How about this?
>> >
>> > --- a/git-mergetool--lib.sh
>> > +++ b/git-mergetool--lib.sh
>> > @@ -46,7 +46,7 @@ show_tool_names () {
>> >                 while read scriptname
>> >                 do
>> >                         setup_tool "$scriptname" 2>/dev/null
>> > -                       variants="$variants$(list_tool_variants)\n"
>> > +                       variants="$variants$(list_tool_variants)"$'\n'
>> >                 done
>> >                 variants="$(echo "$variants" | sort | uniq)"
>> 
>> Ah, I didn't see your variant before sending mine.  $'\n' would work
>> with bash but we prefer not to rely on bashisms here.
>
> Yeah, but it's not even an RFC/PATCH. It's not proposed as a solution.
>
> It's just to focus the eyes of the relevant parties on the likely issue.

I think that served its purpose well, especially as the message went
to the original contributor CC'ed.  I improved on it by mentioning
that we do not welcome $'\n', in case the original contributor did
not know it and blindly took the suggestion.

Thanks.

