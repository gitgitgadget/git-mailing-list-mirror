Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F030BC433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 21:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B944E2068F
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 21:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ddBou6Iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgGJVNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:13:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60497 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGJVNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 17:13:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E8FAD2494;
        Fri, 10 Jul 2020 17:12:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/sxB7GEcNBAZQcfR3hMYjGOVkAg=; b=ddBou6
        IqDlgxGW/irAcB+4O6TlGuBD2Rq8edEY+fbBUXtB1Ha/08uZ+jaiMm9KE8mEv2RB
        qjxDSMhZXJNgS4quaOm02sdbm9wLxgK1/mqMRjVrpAtmkw4J+99dBkSSyazmc3sM
        Uov68ja0s49dbDgia7Qc50IYIlRYN9yUIWGAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wPf0/2i80w+BTs4ZJ6WIamXzMm2VRoM7
        do1YUrx9tFaVss9O0FLzAC0o09EMHpV4n+u1dbxb8n5/GMPygumTinhTlKifDbjX
        N/fo1MzaxQwYkBTaIgofEpQWjgtMFamrvBTROMfrkopXQO+lyyGYwN94pJKWl+cC
        jMoKxLYEaf4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 676DAD2493;
        Fri, 10 Jul 2020 17:12:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF335D2492;
        Fri, 10 Jul 2020 17:12:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Zach Riggle <zachriggle@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: --function-context shows wrong function in chunk
References: <CAMP9c5k5kLSqhCh9400iLdZ=+-nKonavOYpBSs_NHdaVVJ_ycQ@mail.gmail.com>
        <xmqqk0zbt9h3.fsf@gitster.c.googlers.com>
        <CAMP9c5kzRoVKEQMMVt_tnRMrayP+yT0c+Q2xxewbrZN8piCbHQ@mail.gmail.com>
Date:   Fri, 10 Jul 2020 14:12:55 -0700
In-Reply-To: <CAMP9c5kzRoVKEQMMVt_tnRMrayP+yT0c+Q2xxewbrZN8piCbHQ@mail.gmail.com>
        (Zach Riggle's message of "Fri, 10 Jul 2020 15:14:31 -0500")
Message-ID: <xmqqimevrs4o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20426488-C2F2-11EA-9B23-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zach Riggle <zachriggle@gmail.com> writes:

[administrivia: do not top-post]

>> I think it is possible to modify the "find the line that match
>> xfuncname pattern" logic to start scanning backwards from the first
>> actual change (i.e. the blank line in the preimage of the patch
>> inside "int main() {" function in your example) and make the hunk
>> header say "int main() {" instead of "int other_routine() {".
>>
>> I however doubt that such a change makes any sense.  In fact, I find
>> the sample output above both quite logical and also even desirable.

> This happens even with -U0 which does not include the e.g. trailing
> bit of other_routine.

Sure, it does not change the equation, though.  We are finding the
line that matches the xfuncname pattern before the first line of the
hunk, which is "int other_routine() {" in your example.

> $ git diff -U0 -b --function-context
> diff --git i/example.c w/example.c
> index d87b59b..346e2a7 100644
> --- i/example.c
> +++ w/example.c
> @@ -6,3 +6,3 @@ int other_routine() {
>  int main() {
> -
> +    puts("Hello, world!");
>  }

In your updated example, the line "int main() {" is the first line
of the hunk, and not a line before it.

If we said "int main() {" there, it would send a wrong signal that
there is another such line before the "int main() {" we see in the
hunk.
