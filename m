Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A909FC352A2
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 15:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80429218AC
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 15:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="c7onANVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgBEPub (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:50:31 -0500
Received: from mout.web.de ([212.227.17.11]:60821 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgBEPub (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 10:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580917824;
        bh=a4vGZcxh5tpl8cwRpR+eYBIrrUL1fqZZCG7H7ZyYSJw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=c7onANVd5kym5U9eUi2pntFcAvVsY7OncVtu8ONOV9b87CDvlSisphGhHa11ARH4v
         90KVbQIaXAqKuERAhI6Pv608jQNSqndpKr2WkJq7exnMkMP0RWO7qqwnjwo002BNkl
         kp/WJCpNkPLyiN1oZUQDR4GL3drhB3NOoBLx34lE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lhvpu-1jKfLe1xmk-00nAQa; Wed, 05
 Feb 2020 16:50:24 +0100
Subject: Re: [PATCH 09/10] name-rev: generate name strings only if they are
 better
To:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <77d1d053-8680-5cbe-9182-b6aec9e9b446@web.de>
 <3a59d8b4-3c3d-3812-9b7e-ac7e331ccd1c@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1e9251b2-4bbf-48b8-b7f7-e0835fefeeb0@web.de>
Date:   Wed, 5 Feb 2020 16:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3a59d8b4-3c3d-3812-9b7e-ac7e331ccd1c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NZRYe5p7q7UGUHhVp+SX539vMPg+nBCX0iEqZPz6s8zZ9cIKcqh
 APoZJvcDqsUg3nf6j31j2qDYUEQ1jONaYWYV68O5KTkunK0PB35bAFDGta/GjSoqASDdeax
 1bNVtgBQUyrYdbq1iUyvOodVrcDvOw5naSXtmToPYykrtpFWXM4xiakoXSox5HvI9n30/Kn
 L2DcL2zeBSKjir2m9oQhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:68Ql37weSFo=:O0TMIomHPXVkpM1OcFKMuE
 mpn43DE81JXh1OTBvkH+MRiyy24N6x7rKiGufAaLaTpoyj7pJNaq1xz3hfLBOmXzxVo08dkRM
 zR6caHFNduQGA05CEKss7rNiXvu9dhSUO0hGqrLUFEo5GMty0NyjIMD6796LN7IN/0NrkMrXY
 wtoS5LzxfE+YPBL/Lcf+yAkJiEuA6KjTd3dMIwRIAkd3vEphSocxaEE1aL5GZQfkiIqpgtJ/u
 09snTlzA31qVN/70SUOKxCfbMMiSTRlvNxB1GlnhHw6UpncPyOz55cHRFGPidKBoEO2oXInN3
 SBBEqELQSc3HNiPjtU1ZkwpLwUAYyQlGhfPEgiquOhLnoaiDX5TrY7zS6Lmqcaf5wGTuzrf9Q
 f/o0KBokOmyL0y34IKS4xL8qeVaxniN4NNghpgyPviGNHGzX+jcCaPb6Ge7ik3paTn2OI/PVP
 BHj36stTJY7c5yZrNah1pHpFJbdSffqDOabTP0v1y6wld0tLAMvMfi6LpDDkMihqCWpkLVzAs
 8QlNDGsQwLd+7PHqNj/XtMn4refzVAUFEFtXmdfyIKTS84yOYguOpqd5CDKUouri/OqgQ0g24
 Of1OloT0sfvgJAQijyDu9g1CtyJvLyNCZEJIpAP5uPmPOMx7HNn04EZxwYbnBS+U47Cui1WIi
 iBp04dgUQEZtuAFZPa/3el34sQcH2xIhpTcJiErj0w6qX3ueryXLVrEeLWQsn3pAveUEpXMFy
 C5VdHo+uRC1WKe7YM53dewimZEJI8K6wyL/9K63/uLZb8R/l8s0fkngPHx/F1OT5KR8FMZECZ
 Q2NSbM88s2m6JMYZBlr469umo63UuZDV5lKDQdgDmJ50p2g68zYBHXvmGLxENrXTA6GFL+9Ws
 T8aV6sZQcFk3nx8cj3kF9HrgsBDtT3V7Jbo9OZPCviOfRNeZyL4FRH7BIaAOK/X7FkOSlVq3y
 RJp5a6S83b7A3s6d0VGu80CVddWGs7QLPe/a+gBbQcRr/sh2mIUMNPZh8yO/Id7pXdLF4cWSq
 QJvI4Xl9VlQlbRnVSIJiU+T2BC709/mOrBJROSuPH7S8s9VkX0Y+/YFpEkFd0xhS7OS02XTTd
 nhMJRzneEtDhtOUfBXCb4Jaxtz9m1+Woml3JmQidV1pgaobgNoBgDaKrxHQIxA5ljyDoDWWoV
 c8LmMEL0Z8A4tA3skz9VzawDtejCb1UVN/5OZ8IgByqto/zM5zTUZgOv4X+PJi/SwkpDwoA7u
 zeNkc1EpoH09tz668
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.02.20 um 16:11 schrieb Derrick Stolee:
> On 2/4/2020 4:25 PM, Ren=C3=A9 Scharfe wrote:
>> -			if (create_or_update_name(parent, new_name, taggerdate,
>> -						  generation, distance,
>> -						  from_tag)) {
>> +			parent_name =3D create_or_update_name(parent, taggerdate,
>> +							    generation,
>> +							    distance, from_tag);
>> +			if (parent_name) {
>
> As someone unfamiliar with the name-rev code, it took me a while to see =
why
> the algorithm isn't exponential in complexity. It technically _is_, but =
it
> is of the form 2^{N / MERGE_TRAVERSAL_WEIGHT} =3D 2^{N / 65535} and only=
 if
> we create a particularly nasty commit history that would never appear in=
 the wild.

As I understand it, name_rev() attaches a name (a tag or other reference) =
to a
commit, and then goes through all its ancestors, depth first, and attaches=
 a
name based on that to all of them as well.  It stops traversal if the name=
 is
not better than a previously attached name.  Each commit has at most one n=
ame.

If we have N commits and M tags then we could traverse N * M commits and s=
et
their names in the worst case, if the M tags are all for the very latest
commit and if the tags are ordered from worst to best.  Right?

Which implies that ordering names before attaching them one by one should
yield another speedup.  Older tags are preferred and should be tried first=
,
followed by younger tags and non-tags.  Hmm.. :)

> But, the critical section is the block above. The confusing part was tha=
t
> create_or_update_name() returns NULL if the name is updated, but non-NUL=
L if
> a better name is created. That makes it clear that this change is saving
> allocations.

create_or_update_name() returns NULL if the new name is not better than an
existing one, and the old name is left untouched.  It returns a pointer to
the name record if there either was no old name or if that name was worse.
In that case it updates the name.

After this patch it doesn't set the name string (tip_name) anymore, which
is left for the caller.  And the benefit is that the caller only needs to
prepare said name string if the new name is better.

Ren=C3=A9
