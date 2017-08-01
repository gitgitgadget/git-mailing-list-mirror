Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19102047F
	for <e@80x24.org>; Tue,  1 Aug 2017 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbdHAP5o (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 11:57:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63714 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751815AbdHAP4F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 11:56:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC0A6A63CB;
        Tue,  1 Aug 2017 11:56:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=j/3e0oq0PvOj
        DjdEcFuzlgRIbzk=; b=TV3YpVLCfcXLMwcaqtiyOnVgft3jlX/M0upNAUOPBD/P
        RbnVvL5HanmqlMXnNZ5O9u9GqbSMVMXuf3OU2ceO5KaJYjpv1gqWudyb0TUAlIzU
        MZaxCVTh8ACXUbah8rzwhNBwORMjn0ZXaUoVvDuljriRsdX6DuREOCGf0X5RXZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QTfbeJ
        RJG5jZ0lYSgFbWShC+4KdLU8F9wOoxQMg1hjCyD8hN018ywlp2MhX4S6QSahIebk
        /iKsXsxPaR46Fl/Xvqa+IR/MQfLRVhCqTpeZ59dhN8SXtf8k9xk9jouVVgFaDlqw
        UlmR4Hf3IkwNxvx6jiyBWl1+78gW90YwI+jpQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3EB1A63CA;
        Tue,  1 Aug 2017 11:56:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29BB7A63C7;
        Tue,  1 Aug 2017 11:56:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andreas Stieger <astieger@suse.com>
Subject: Re: [PATCH] hash: Allow building with the external sha1dc library
References: <s5hh8y19hyg.wl-tiwai@suse.de>
        <CACBZZX5yv-NzL7H-CH1yMeM9dWkz=PUhx=2wek_jBGpsz1=EAA@mail.gmail.com>
        <s5h8tj37scz.wl-tiwai@suse.de>
Date:   Tue, 01 Aug 2017 08:56:00 -0700
In-Reply-To: <s5h8tj37scz.wl-tiwai@suse.de> (Takashi Iwai's message of "Tue,
        01 Aug 2017 07:46:20 +0200")
Message-ID: <xmqqbmnzgu3z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EB0E1D26-76D1-11E7-B8A4-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> On Fri, 28 Jul 2017 17:58:14 +0200,
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>  ...
>> * We now have much of the same header code copy/pasted between
>> sha1dc_git.h and sha1dc_git_ext.h, did you consider just always
>> including the former but making what it's doing conditional on
>> DC_SHA1_EXTERNAL? I don't know if it would be worth it from a cursory
>> glance, but again your commit message doesn't list that among options
>> considered & discarded.
>
> I don't mind either way, there is no perfect solution in this case.
> As you know, many people think the ifdef ugly no matter how.
>
> I leave the decision to maintainer.  Just let me know which option is
> preferred.

Yeah, I also found it somewhat confusing to have these two headers
that look quite similar to each other at the top-level of the tree.

What's the "conditional" part between the two headers?  Is it just
whether the header for underlying library is included?  I wonder if
it's just the matter of adjusting "hash.h" to read like this

    ...
    #if defined(DC_SHA1_EXTERNAL)
   -#include "sha1dc_git_ext.h"
   +#include <sha1dc/sha1.h>
   +#include "sha1dc_git.h"
    #elif  defined(DC_SHA1_SUBMODULE)
    ...

or are there heavier tweaks needed that won't be solved by continuing
along the same line?  As _ext.h variant is included only at this place,
if we can do with minimum tweaks around here without introducing it,
it may be ideal, I would think.

Thanks.

