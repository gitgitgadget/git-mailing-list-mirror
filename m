Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95387C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 18:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345429AbiFIS3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 14:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345420AbiFIS3a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 14:29:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C1C22B12
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 11:29:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90156146F32;
        Thu,  9 Jun 2022 14:29:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2tFVFxqoQc49
        Zq0PXny314SmhiEZtZl07jQTRdIpfhk=; b=Mlvl/sn4exM1pkmNi2mLXAYKywC5
        ohxeT1ZQNx1CwwtMz2Jc6HXc34J7zQ8RdCcPMMm0wcKIf6WHBdaiffbtvLpWnCGJ
        wWVArkQY6RA5KIxZGINgOTwOoK9ly15PcLv02fMzrA8yOfR3brqqXTX9hNEUj8Il
        9ypE/FBmari+6VQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 886C4146F31;
        Thu,  9 Jun 2022 14:29:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0570146F30;
        Thu,  9 Jun 2022 14:29:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v7] git-prompt: make colourization consistent
References: <20220606175022.8410-1-joak-pet@online.no>
        <20220607115024.64724-1-joak-pet@online.no>
        <20220609090302.GA1738@szeder.dev>
        <736a5f12-2ab3-977c-8cba-45529e9ebee0@online.no>
Date:   Thu, 09 Jun 2022 11:29:25 -0700
In-Reply-To: <736a5f12-2ab3-977c-8cba-45529e9ebee0@online.no> (Joakim
        Petersen's message of "Thu, 9 Jun 2022 13:13:34 +0200")
Message-ID: <xmqq5yl9lmgq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 17F44286-E822-11EC-BE37-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joakim Petersen <joak-pet@online.no> writes:

> On 09/06/2022 11:03, SZEDER G=C3=A1bor wrote:
>> This patch seems to break colorization when __git_ps1() is invoked
>> from $PROMPT_COMMAND:
>>    ~/src/git (master)$ echo $PROMPT_COMMAND
>> __git_ps1 "\[\e]0;\w - Terminal\a\e[01;32m\]\h\[\e[01;34m\] \w" "\[\e[=
01;34m\]\$\[\e[00m\] " " \[\e[01;34m\](%s\[\e[01;34m\])"
>>    ~/src/git (master)$ git checkout 9470605a1b
>>    HEAD is now at 9470605a1b git-prompt: make colourization consistent
>>    ~/src/git ((9470605a1b...))$ source contrib/completion/git-prompt.s=
h
>>    ~/src/git (\[\e[31m\](9470605a1b...)\[\e[0m\])$ # uh-oh
>>    ~/src/git (\[\e[31m\](9470605a1b...)\[\e[0m\])$ git checkout 947060=
5a1b^
>>    Previous HEAD position was 9470605a1b git-prompt: make colourizatio=
n consistent
>>    HEAD is now at 2668e3608e Sixth batch
>>    ~/src/git (\[\e[31m\](2668e3608e...)\[\e[0m\])$ source contrib/comp=
letion/git-prompt.sh
>>    ~/src/git ((2668e3608e...))$ # Looks good.
>>=20
>
> While I did test this on my own prompt for v6 (which is identical to v7
> in terms of code) and not see any breakage, I have the same issue with
> v7. Maybe I forgot to re-source the changed git-prompt.sh. Either way,
> The issue stems from $b being wrapped in $__git_ps1_branch_name and the=
n
> back into itself after colouring. Moving this wrapping to before colour
> is applied fixes this. I will submit a v8 shortly.

As the topic is already in 'next' (and presumably that is how SZEDER
noticed the breakage), please make it an incremental fix-up.

Thanks.
