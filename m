Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CB5C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiGURXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGURXP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:23:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A972F3B3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:23:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 80E631ACE29;
        Thu, 21 Jul 2022 13:23:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g0upF4luihro
        imaa6vJsDv/zkTJgvTRdYutY6Mu3O44=; b=VZszID9m0tN4ES6nrWfniWP2BbDD
        Hl4qc0zXdSbE4+Aj7e3lqKMoJ/SkbCl7ViHJqQO3ayGQmT1kfG+Jh925/uIkoTQS
        pSQILvvxAPeNDTlpZTZM3AqsaIzmip9zbAaJlBThzPpinZif19GlW7iVsfNpkFwZ
        R4zAvJJPuggixng=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 788B41ACE28;
        Thu, 21 Jul 2022 13:23:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2234D1ACE25;
        Thu, 21 Jul 2022 13:23:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gers?= =?utf-8?Q?hausen?= 
        <tboegi@web.de>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v8] ls-files: introduce "--format" option
References: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>
        <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com>
        <xmqqbktj3ct7.fsf@gitster.g>
        <220721.86ilnqtq8f.gmgdl@evledraar.gmail.com>
Date:   Thu, 21 Jul 2022 10:23:10 -0700
In-Reply-To: <220721.86ilnqtq8f.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Jul 2022 17:54:07 +0200")
Message-ID: <xmqqsfmuidmp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB82BF86-0919-11ED-B09C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>>       +test_expect_success 'git ls-files --format objectmode v.s. -s'=
 '
>>>      -+	git ls-files -s | awk "{print \$1}" >expect &&
>>>      ++	git ls-files -s >files &&
>>>      ++	cut -d" " -f1 files >expect &&
>>
>> Either "awk" or "cut" is fine and flipping between them is a bit
>> distracting.  Cutting the pipe into two is a good move.
>
> That "cut" suggestion saw mine, sorry about the churn...

As I said "cut" is perfectly fine.  Unless this part goes away,
(i.e. perhaps we may decide that it is a bad idea to check only the
pieces of lines), let's not flip back to awk ;-)

>> 	format=3D"%(objectmode) %(objectname) %(stage)	%(path)" &&
>> 	git ls-files -s >expect &&
>> 	git ls-files --format=3D"$format" >actual &&
>> 	test_cmp expect actual
>>
>> I do not know if the $format I wrote without looking at the doc is
>> correct, but you get the idea.
>
> Past rounds moved some tests towards that, maybe that's a good thing
> here too I didn't look deeply this time around...

OK, thanks for reviewing.
