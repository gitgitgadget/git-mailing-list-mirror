Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACAAC56201
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5C320878
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ahRTIkaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbgJ1WmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:42:00 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:30405 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388954AbgJ1Wl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:41:58 -0400
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 3229F2000F7D
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 02:45:14 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ahRTIkaG"
Date:   Wed, 28 Oct 2020 02:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603853109;
        bh=vTUwEEOlBOXF+WUs2HLZvDnd7XW3IF3rTl1QnYGehYg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ahRTIkaGPCpJwRvyS3XAArnSTzfqUbFKUoJWAD7fE+H1CO3IpYtgtNjrYzptHDRKb
         mLAZ1N/LuhimBn39rJkVtL+9oBDlCgVligBsdIc8YgCuqmP8+oY3mOmrbgKpvfARma
         DmyTuF9TzYSW+HCd00LriWAv9lkBWZfzvEEDbZ/g=
To:     Jonathan Nieder <jrnieder@gmail.com>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in test script
Message-ID: <4q38uC7_84GKAeX0QAsYSjHB0zcWtp3othTmTuALUWus0ENKxQJMaMxf2jbtz9CpqXKgjbybPelAJ1z8PVTZXAcpvKsLroqbksLvLqbTGbw=@protonmail.com>
In-Reply-To: <20201028001905.GA1500644@google.com>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com> <20201026205028.GC2645313@google.com> <xmqqwnzcd6jf.fsf@gitster.c.googlers.com> <Bgt8H4Cev0hu-OKtYHazhsRRIFO_6bAoBqdc4tep09T98tL426R9WXIAMjm7aO4b0uPrZGldPhZ1mV3f9pbS3PDN4bOlb9JkUvvXKtnUFHA=@protonmail.com> <20201026220228.GD2645313@google.com> <AwF-WVCPGK9qyy3lWQ-aYXuvw7HTPjjGuvT4rbPjgoWZE0czToIU-aACj2oyRnkOevGWLQbDgtndt9dkMSGF-SFkNanPgao9yLuVYU1VURI=@protonmail.com> <XDwhHkxbkjL46BTp1WCJ5gJ3UbrMxRGwR2VgeRxehZh0-G07JlxCHrBGCpruqk-OegVspO6LJ0Y3yW9izl97pufYDwOhGaS885_xaVK63vs=@protonmail.com> <20201027001427.GG2645313@google.com> <bixxjcjnQYoZ6CIUQUXdBTaGE7vawm33kqmy3csw7hsPqGQpQNyEhUqBYkvoDgHb8sb3vjLr1KOR3I71-4a4wDKQqTrFocv-eVtGlyE8S84=@protonmail.com> <20201028001905.GA1500644@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> A subtlety: one advantage of helpers such as test_path_is_missing is
> that they print a diagnostic if and only if the condition fails, which
> can make the output from a failing test easier to read. Unfortunately,
> some helpers in this test communicate whether a configured pager is
> expected to run using a shell constract that doesn't have that property:
>
> my_generic_helper () {
> ...
> ${if_local_config}test -e core.pager_used
> }
>
> ...
> if_local_config=3D'! '
> my_generic_helper
>
> Rewriting this to "${if_local_config}test_path_is_file core.pager_used"
> would print a diagnostic when the file is absent, which is the opposite
> of what we want. Make the logic more explicit instead, using "test" to
> check a variable core_pager_wanted that is nonempty when core.pager is
> expected to be used.

Thank you for this explanation, much appreciated.

> That said, it looks like js/t7006-cleanup is in "next", indicating
> that it has finished being reviewed and is now safe to build on (see
> https://git-scm.com/docs/SubmittingPatches for more on this subject),
> so it would be even better to make this a patch on top of the existing
> v2 patch after all.

A proposed commit msg for patch v1 in the branch js/t7006-cleanup that expl=
ains "what was wrong in the previous patches and how the problem was correc=
ted" would be;
The previous patch introduces `test_path_is_file` and helper functions
for instances that include checking if a configured pager is expected
to run using a shell construct. This prints a diagnostic message even
when the file is absent, as opposed to only when the file exists and
has been checked.
Use "test" to first check if a pager is wanted when `core.pager` is
expected to be used, then diagnose `core.pager_used` and print a
diagnostic message as appropriate.

Should I include an explicit mention to the removal of `${if_local_config}`=
?

Should I start a new email thread with "[PATCH v1]" on further discussion?

Thank you,
Joey
