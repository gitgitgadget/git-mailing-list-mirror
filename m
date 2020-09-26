Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F67C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D462388E
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 22:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dDZheX3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIZWcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 18:32:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51162 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgIZWcE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 18:32:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4ED10FCC0F;
        Sat, 26 Sep 2020 18:31:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=r0zO2Q5Iu/XN
        UoqEjLwd8Vf+1v0=; b=dDZheX3GCaTpFFRqyJCUw8jRF4OTuIghEYkuY/KVDN1C
        1j9VKy9sIr3UP2JOGFVmu4jBVC56BefnJysHWnUyB5hB/HCZ5b6j3IiI9VaKwqPa
        TgSbehU8eHtPeA/PM+SB62uhAEVGm7vfXzaExaHnbLWL6btFcUWrdLfN/5A3tow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AHoVZp
        qXzmfPXr4kqePiMGfja/3CYqrCYr5vqZNqCMF9n3lkF+44uiBtobWfQto4DkPOWP
        UrolQ052Bxgb8JLsYjpyk2fyqlwSG66ThfnTleWuXw1lUIfSsvwInvL5d7yxGq3h
        MICHS0MKpCx0mi8epkPasmuAB54PIEmqKWD90=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4687CFCC0E;
        Sat, 26 Sep 2020 18:31:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 91A70FCC0D;
        Sat, 26 Sep 2020 18:31:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?utf-8?Q?=C3=81kos?= Uzonyi <uzonyi.akos@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v2 1/2] completion: use "prev" variable instead of
 introducing "prevword"
References: <20200925211124.1673337-1-uzonyi.akos@gmail.com>
        <CA+P7+xrBcKpDgFfDyp8=f_AaqqcVzjo3MV38=6geJ6bavZSTDw@mail.gmail.com>
Date:   Sat, 26 Sep 2020 15:31:53 -0700
In-Reply-To: <CA+P7+xrBcKpDgFfDyp8=f_AaqqcVzjo3MV38=6geJ6bavZSTDw@mail.gmail.com>
        (Jacob Keller's message of "Fri, 25 Sep 2020 15:53:53 -0700")
Message-ID: <xmqqpn68i2zq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 15126A0C-0048-11EB-98D7-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Fri, Sep 25, 2020 at 3:00 PM =C3=81kos Uzonyi <uzonyi.akos@gmail.com=
> wrote:
>>
>> In both _git_checkout and _git_switch a new "prevword" variable were
>> introduced, however the "prev" variable already contains the last word=
.
>>
>> The "prevword" variable is replaced with "prev", and the case is moved
>> to the beginning of the function, like it's done in many other places
>> (e.g. _git_commit). Also the indentaion of the case is fixed.
>>
>
> Ahhh... didn't realize $prev existed.

Yup, makes a lot of sense.

Thanks, =C3=81kos.  Will queue.

>
>> Signed-off-by: =C3=81kos Uzonyi <uzonyi.akos@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 66 +++++++++++++------------=
-
>>  1 file changed, 32 insertions(+), 34 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completi=
on/git-completion.bash
>> index 8be4a0316e..3d02bd4de7 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1508,6 +1508,22 @@ _git_checkout ()
>>  {
>>         __git_has_doubledash && return
>>
>> +       local dwim_opt=3D"$(__git_checkout_default_dwim_mode)"
>> +
>> +       case "$prev" in
>> +       -b|-B|--orphan)
>> +               # Complete local branches (and DWIM branch
>> +               # remote branch names) for an option argument
>> +               # specifying a new branch name. This is for
>> +               # convenience, assuming new branches are
>> +               # possibly based on pre-existing branch names.
>> +               __git_complete_refs $dwim_opt --mode=3D"heads"
>> +               return
>> +               ;;
>> +       *)
>> +               ;;
>> +       esac
>> +
>>         case "$cur" in
>>         --conflict=3D*)
>>                 __gitcomp "diff3 merge" "" "${cur##--conflict=3D}"
>> @@ -1516,23 +1532,6 @@ _git_checkout ()
>>                 __gitcomp_builtin checkout
>>                 ;;
>>         *)
>> -               local dwim_opt=3D"$(__git_checkout_default_dwim_mode)"
>> -               local prevword prevword=3D"${words[cword-1]}"
>> -
>> -               case "$prevword" in
>> -                       -b|-B|--orphan)
>> -                               # Complete local branches (and DWIM br=
anch
>> -                               # remote branch names) for an option a=
rgument
>> -                               # specifying a new branch name. This i=
s for
>> -                               # convenience, assuming new branches a=
re
>> -                               # possibly based on pre-existing branc=
h names.
>> -                               __git_complete_refs $dwim_opt --mode=3D=
"heads"
>> -                               return
>> -                               ;;
>> -                       *)
>> -                               ;;
>> -               esac
>> -
>>                 # At this point, we've already handled special complet=
ion for
>>                 # the arguments to -b/-B, and --orphan. There are 3 ma=
in
>>                 # things left we can possibly complete:
>> @@ -2392,6 +2391,22 @@ _git_status ()
>>
>>  _git_switch ()
>>  {
>> +       local dwim_opt=3D"$(__git_checkout_default_dwim_mode)"
>> +
>> +       case "$prev" in
>> +       -c|-C|--orphan)
>> +               # Complete local branches (and DWIM branch
>> +               # remote branch names) for an option argument
>> +               # specifying a new branch name. This is for
>> +               # convenience, assuming new branches are
>> +               # possibly based on pre-existing branch names.
>> +               __git_complete_refs $dwim_opt --mode=3D"heads"
>> +               return
>> +               ;;
>> +       *)
>> +               ;;
>> +       esac
>> +
>>         case "$cur" in
>>         --conflict=3D*)
>>                 __gitcomp "diff3 merge" "" "${cur##--conflict=3D}"
>> @@ -2400,23 +2415,6 @@ _git_switch ()
>>                 __gitcomp_builtin switch
>>                 ;;
>>         *)
>> -               local dwim_opt=3D"$(__git_checkout_default_dwim_mode)"
>> -               local prevword prevword=3D"${words[cword-1]}"
>> -
>> -               case "$prevword" in
>> -                       -c|-C|--orphan)
>> -                               # Complete local branches (and DWIM br=
anch
>> -                               # remote branch names) for an option a=
rgument
>> -                               # specifying a new branch name. This i=
s for
>> -                               # convenience, assuming new branches a=
re
>> -                               # possibly based on pre-existing branc=
h names.
>> -                               __git_complete_refs $dwim_opt --mode=3D=
"heads"
>> -                               return
>> -                               ;;
>> -                       *)
>> -                               ;;
>> -               esac
>> -
>>                 # Unlike in git checkout, git switch --orphan does not=
 take
>>                 # a start point. Thus we really have nothing to comple=
te after
>>                 # the branch name.
>> --
>> 2.28.0
>>
