Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40DEC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbiCWUId (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbiCWUIc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:08:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9349F85659
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:07:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9C81129E8B;
        Wed, 23 Mar 2022 16:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LJuDmQW7lg/T
        fWxX2tZO005S2nmPmBX3y5cqtajoBGs=; b=EDX9KptDZI/e1gaqjicMa8/lLxPk
        C/0Lmmn089U5fFrYIXvJdbJUO1vNYOICOTiy48MQp5OSeEpI8KnYxiHy8HBzXmrI
        gBgocSmf8GyN7KrnZiU2gb8YZEicWERXvm8rW2zgTERT5FYt08I+6f2pC+yY7Y+o
        xGtyZv2kXtDw6nU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1925129E8A;
        Wed, 23 Mar 2022 16:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40B61129E89;
        Wed, 23 Mar 2022 16:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v2 0/4] In PS1 prompt, make upstream state indicators
 consistent with other state indicators
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
        <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
        <220322.865yo6npg4.gmgdl@evledraar.gmail.com>
Date:   Wed, 23 Mar 2022 13:06:57 -0700
In-Reply-To: <220322.865yo6npg4.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 22 Mar 2022 13:25:35 +0100")
Message-ID: <xmqqa6dgsaam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB5D7C8C-AAE4-11EC-A29D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Feb 27 2022, Justin Donnelly via GitGitGadget wrote:
>
>> These patches are about the characters and words that can be configure=
d to
>> display in the PS1 prompt after the branch name. I've been unable to f=
ind a
>> consistent terminology. I refer to them as follows: [short | long] [ty=
pe]
>> state indicator where short is for characters (e.g. ?), long is for wo=
rds
>> (e.g. |SPARSE), and type is the type of indicator (e.g. sparse or upst=
ream).
>> I'd be happy to change the commit messages to a different terminology =
if
>> that's preferred.
>>
>> There are a few inconsistencies with the PS1 prompt upstream state ind=
icator
>> (GIT_PS1_SHOWUPSTREAM).
>>
>>  * With GIT_PS1_SHOWUPSTREAM=3D"auto", if there are no other short sta=
te
>>    indicators (e.g. + for staged changes, $ for stashed changes, etc.)=
, the
>>    upstream state indicator appears adjacent to the branch name (e.g.
>>    (main=3D)) instead of being separated by SP or GIT_PS1_STATESEPARAT=
OR (e.g.
>>    (main =3D)).
>>  * If there are long state indicators (e.g. |SPARSE), a short upstream=
 state
>>    indicator (i.e. GIT_PS1_SHOWUPSTREAM=3D"auto") is to the right of t=
he long
>>    state indicator (e.g. (main +|SPARSE=3D)) instead of with the other=
 short
>>    state indicators (e.g. (main +=3D|SPARSE)).
>>  * The long upstream state indicator (e.g. GIT_PS1_SHOWUPSTREAM=3D"ver=
bose")
>>    is separated from other (short or long) state indicators by a hard-=
coded
>>    SP. Other long state indicators are separated by a hard-coded pipe =
(|).
>>
>> These patches are to make the upstream state indicators more consisten=
t with
>> other state indicators.
>>
>> ----------------------------------------------------------------------=
------
>>
>> Changes since v1:
>>
>>  * Added __git_ps1 examples and before/after tables to commit messages=
 where
>>    applicable. This should make it clearer what the behavior is for ot=
her
>>    (not upstream) state indicators, and how the patches make the upstr=
eam
>>    state indicator more consistent.
>>  * Removed some extraneous information about long state indicators fro=
m
>>    patch 2 commit message. This wasn't really helpful, and was a
>>    distraction.
>
> Since this was all in reponse to my review: I've looked this over again
> and this all LGTM now:
>
> Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Thanks, both.
