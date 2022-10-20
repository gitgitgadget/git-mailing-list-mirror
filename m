Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CF0C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 02:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJTCju (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 22:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiJTCjs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 22:39:48 -0400
Received: from box.elsiehupp.com (box.elsiehupp.com [104.131.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8BD5051B
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 19:39:46 -0700 (PDT)
Received: from authenticated-user (box.elsiehupp.com [104.131.30.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by box.elsiehupp.com (Postfix) with ESMTPSA id E0C26FC431;
        Wed, 19 Oct 2022 22:39:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elsiehupp.com;
        s=mail; t=1666233586;
        bh=YHEzpDzK1QO8KqekKRQbnt2GaiWr+i5Qsy/BCtHQ4JA=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=pEvqyalws1qZFada7BH7cDleY2k/a/JLoSKAx5x+IX33wTATks7Cj4sj++mRVnuRE
         Ur6f1RvHZIGFi4Awqc+Mf//YKBtS1Axbs8Tae7x/JuOgkYkxUsMRC7DZIdwwda1jf0
         kxmACMwwZkz+3gI5gqTrS4qE+4hcRPEcpaeVVFdM0OJwDjee8BaFgvumfzrNW+l5MD
         sKXqYGIrVsjOy7kRpuqha2pUBedRJMWuApF7KMrLtAOpo6qgu5l8jQAtS/c7QzmdQo
         grX9Itn4kpm6cvxdg7UTcJkRwVSgpu6JHmZy7wkhksbRSc9h/TwqbPUQw/eIJOrtP+
         OuOWz/eS+ZYlw==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0
Subject: Re: Multiple --global config workspaces?
From:   Elsie Hupp <git@elsiehupp.com>
In-Reply-To: <90F9456A-6ABC-4555-8127-FF2DB0449EF1@elsiehupp.com>
Date:   Wed, 19 Oct 2022 22:39:45 -0400
Cc:     Junio C Hamano <gitster@pobox.com>, reto@labrat.space,
        philipoakley@iee.email, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A64CF44-0AE5-497D-85C7-F625B51EA28F@elsiehupp.com>
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
 <xmqqwn96x61t.fsf@gitster.g> <Y0Vr/4IeA236nxzF@coredump.intra.peff.net>
 <03B277AB-DE33-443D-AC9C-FAB7A2F93AB3@elsiehupp.com>
 <Y0m64fHWIjZoXoTQ@coredump.intra.peff.net>
 <ACFF4036-3DD1-4647-90BB-77F029326715@elsiehupp.com>
 <Y08SRgwIvDcsWF0Z@coredump.intra.peff.net>
 <90F9456A-6ABC-4555-8127-FF2DB0449EF1@elsiehupp.com>
To:     Jeff King <peff@peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I might also mention recursive globbing =C3=A0 la bash globstar, as =
described here:

https://unix.stackexchange.com/questions/49913/recursive-glob

=E2=80=A6but that=E2=80=99s getting quite a bit into the weeds (not to =
mention exceeding my personal knowledge of bash).

> On Oct 19, 2022, at 10:29 PM, Elsie Hupp <git@elsiehupp.com> wrote:
>=20
>> The expansion of the glob is done by the shell. But it is "cat" which =
is
>> happy to receive multiple files as input. But many other commands are
>> not, and include.path is not.
>>=20
>> None of which is to say you're wrong to think of it this way. It's a
>> perfectly valid mental model. It just happens not to be the mental =
model
>> we used when implementing it.
>=20
> The only reason I thought of trying it in the first place is that =
while reading the git-config documentation, I saw that [include]:gitdir =
uses implicit globbing:
>=20
> =
https://git-scm.com/docs/git-config#Documentation/git-config.txt-codegitdi=
rcode
>=20
>> =E2=80=A2 If the pattern does not start with either ~/, ./ or /, **/ =
will be automatically prepended. For example, the pattern foo/bar =
becomes **/foo/bar and would match /any/path/to/foo/bar.
>> =E2=80=A2 If the pattern ends with /, ** will be automatically added. =
For example, the pattern foo/ becomes foo/**. In other words, it matches =
"foo" and everything inside, recursively.
>=20
> Like literally I did not think to try the wildcard characters with =
[include] until the mentions of [include]:gitdir, [include]:onbranch, =
and [include]:hasconfig:remote.*.url suggested it to me.
>=20
> Admittedly, the examples here are for *implicit* glowing, rather than =
*explicit* globbing, but this support in one way or another does create =
a stronger proximate case for consistency than cat does.
>=20
>> 1. I'd be more convinced by a concrete use case. It sounds like
>>    conditional includes were the real sticking point for yours. Maybe
>>    somebody wants to do include.path on ".gitconfig.d/*" or =
something?
>>    I dunno.
>=20
> Basically what I would like as a concrete example is the ability to =
specify the path, e.g., ~/Repositories/github/.gitconfig without having =
to specify the name =E2=80=9CRepositories=E2=80=9D, as other users might =
prefer, e.g., ~/Projects/github/.gitconfig instead.
>=20
>>> I don=E2=80=99t know off the top of my head what happens when a =
single
>>> variable is defined multiple times. I do get the following output,
>>> though:
>>=20
>> It depends on the variable. Most single-value options in Git are =
"last
>> one wins", but some are lists (e.g., remote.*.fetch). We also hold
>> config values for other porcelain scripts whose semantics we may not
>> even know ourselves. There are options to "git config" for specifying
>> how to handle these (e.g., --get-all).
>=20
> I mean this is where the desired behavior would have to be defined. =
=46rom my somewhat ignorant position, =E2=80=9Clast one wins=E2=80=9D =
does seem reasonable in the case of, say, user.email.
>=20
>> if somebody wants to go to the trouble to implement
>=20
> Yeah this somebody is almost certainly not going to be me, considering =
my complete and utter unfamiliarity with the codebase, among other =
things. =F0=9F=98=AC
>=20
> As for proceeding, I think what I can do personally is submit a draft =
pull request to the Git Book repository with instructions for how to =
accomplish my own use case as well as, say, the personal/school/work use =
case with the functionality that already exists, and then based on how =
that goes things could go from there=E2=80=A6?
>=20
> Best,
> Elsie
>=20

