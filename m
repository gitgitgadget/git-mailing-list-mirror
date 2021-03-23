Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FBCC433E1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0FE619AE
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhCWRpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:45:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60581 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhCWRpk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 13:45:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB4DFB5CBA;
        Tue, 23 Mar 2021 13:45:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yP8JAHHMuwGF
        DWiTQvyxWDQcO30=; b=SuH7XYHfFjeXxeG1s2SKv5ryYQx2g5jUYtTGR1LBJoW+
        7RbSsECVH7MMItVuc9mTGq1MSZgMzH4m1H0j3rUHQOS71/0Fep8+thDJ/rF5TGUt
        dMI8MloWxvWrgjjPLdcdxOknvCS1dDwDWi4HEwyIg7tMuiTH+sEzymFrKTmWq/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=R8oW9p
        bMVN9+zqIS9EY61S8fzLep/8RoWIPDUQu9Uz71QnVtPM1hSpvrKW68nT2iQcfRif
        ldzj2tgx+HQQxxFtC8RFeE8dY+SNWeP4dtYsdJutD+TSQSUbyNW4EsRl+upLXxyK
        uJDJ/dZsNBX3FuLDs8mk0q9fg1Jf7+z1pG5Bg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1EDFB5CB8;
        Tue, 23 Mar 2021 13:45:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D583B5CB7;
        Tue, 23 Mar 2021 13:45:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Madhu <enometh@meer.net>, git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
References: <xmqq7dlz94by.fsf@gitster.g>
        <20210322.143437.212295420302618690.enometh@meer.net>
        <xmqqr1k76p8d.fsf@gitster.g>
        <20210323.092748.1559327071188512317.enometh@meer.net>
        <xmqqr1k64bmk.fsf@gitster.g>
        <20210323165335.urvvccwnhahxmokt@tb-raspi4>
Date:   Tue, 23 Mar 2021 10:45:38 -0700
In-Reply-To: <20210323165335.urvvccwnhahxmokt@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 23 Mar 2021 17:53:35
 +0100")
Message-ID: <xmqqo8f93gsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94B4618C-8BFF-11EB-9AD0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> In the very long run, there may be room for improvements:
> While core.filemode works for a loal repo on a local disk,
> there are lots of cases where I whish a better handling.

But that is why we have multiple worktrees and per worktree
configuration, no?

Fundamentally, you cannot share a worktree from two systems and let
one work with filemode on while the other with filemode off, as you
summarized here:

> Exporting a git repo from e.g.
> Linux/ext4 to MacOs : Linux sees the execute-bit as is, MacOs has it al=
ways on
> Linux/ext4 to Windows : Linux sees the execute-bit as is, MacOs has it =
always off
>
> Visiting the same repo under Git-for-Windows and cygwin:
> cygwin supports the executable bit, Git-for-Windows does not.

The "new-workdirs" was a cute hack that was quite useful before the
multiple worktree support materialized, and it and (proper) worktree
share the quirk that by default the per-repo configuration file is
shared.

> And now we have the worktree (which may cross filesytem borders)
>
> Today there are many use cases, where a single config variable is not i=
deal.
>
> If there is a chance to have a "core.filemode=3Dauto", which does probe=
 the
> filemode for this very OS/filesytem/worktree combination:
> I would be happy to test/review/mentor such a code change.

I do not think we want to go there.  filemode is not the only thing
that would be shared.  What do you want to do with core.eol=3Dnative,
for example?  Paths touched while switching branches get the 'native'
line endings on the system that the user happened to be on when the
"switch" command was run, and working tree files end up with mixture?
