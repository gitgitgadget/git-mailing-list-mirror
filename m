Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3BEC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A476920838
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="So1P9B/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHLTZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:25:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55558 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLTZS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:25:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C9B56FDC2;
        Wed, 12 Aug 2020 15:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WhAMLMvmOXxi
        kqfkuP2+mh5zNPw=; b=So1P9B/q4b4zdYlPU9ACiCzWvtq8QeCEJgDnMI2TAhkh
        tp/E0U0g1uesTmxxbXjEfd7XPtyNaN3EbK28ZO3eFarqnTtre9VXrw5tp66D9ipA
        gKI9mKGAHj0BLKI3HCvRctqOrNMrYqa3YMkba5mPsAHz8JrGx4bMaEl1YPv+Byg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ThRfEb
        OYcxTkHP3udY9XbivDOCE1FErN89RdyKps3TswoGsRxRyoWTmrqKF+kuAb2z6oD9
        dcAUsFhzStLQYsxhuEjTEv16DNdxsM2l/+XAjOtgTCdAiSTvRiyBpZ2xUhIqJB9V
        RH7EYMRNWNLJD8zCJddKGEX+KBIEl1a9hRe+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 737746FDC1;
        Wed, 12 Aug 2020 15:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E8C2A6FDC0;
        Wed, 12 Aug 2020 15:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] rebase: remove unused function reschedule_last_action
References: <80744078-c0a9-5b55-0578-d6b62af6673b@web.de>
        <20200812134827.GB74542@syl.lan>
Date:   Wed, 12 Aug 2020 12:25:15 -0700
In-Reply-To: <20200812134827.GB74542@syl.lan> (Taylor Blau's message of "Wed,
        12 Aug 2020 09:48:27 -0400")
Message-ID: <xmqqv9hn650k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8CFAC1B2-DCD1-11EA-B168-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Aug 12, 2020 at 03:45:47PM +0200, Ren=C3=A9 Scharfe wrote:
>> The only caller of reschedule_last_action was removed by ef64bb328df
>> (rebase: strip unused code in git-rebase--preserve-merges.sh,
>> 2018-05-28); remove this unused shell function as well.
>
> Easy peasy ;-). Obviously correct, and thanks for cleaning this up.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

I thought preserve-merges backend is on its way out, but I do not
have objection to have some part of it retire earlier than the
remainder of it ;-)

Will queue.  Thanks.

>> ---
>>  git-rebase--preserve-merges.sh | 10 ----------
>>  1 file changed, 10 deletions(-)
>>
>> diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-mer=
ges.sh
>> index dec90e9af67..b9c71d2a71b 100644
>> --- a/git-rebase--preserve-merges.sh
>> +++ b/git-rebase--preserve-merges.sh
>> @@ -193,16 +193,6 @@ mark_action_done () {
>>  	fi
>>  }
>>
>> -# Put the last action marked done at the beginning of the todo list
>> -# again. If there has not been an action marked done yet, leave the l=
ist of
>> -# items on the todo list unchanged.
>> -reschedule_last_action () {
>> -	tail -n 1 "$done" | cat - "$todo" >"$todo".new
>> -	sed -e \$d <"$done" >"$done".new
>> -	mv -f "$todo".new "$todo"
>> -	mv -f "$done".new "$done"
>> -}
>> -
>>  append_todo_help () {
>>  	gettext "
>>  Commands:
>> --
>> 2.28.0
>
> Thanks,
> Taylor
