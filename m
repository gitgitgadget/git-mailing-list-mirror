Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EE1C388F9
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 01:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E507C20720
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 01:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="tB23PfSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgJ1Bic (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 21:38:32 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:52233 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833053AbgJ0XqA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 19:46:00 -0400
Date:   Tue, 27 Oct 2020 23:45:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603842356;
        bh=zOA7GZzYzdgafX7216BNlWl6/XpvW+HcgP6Ndi9M/es=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=tB23PfSwGqR/J6/XuAzJ9vGwv28FUPdWZYZKgfHGN6p5XIKTyy3Jq1QutsMcMo2OG
         D4UZ342e2kKVGA7XKRf4ENdfCjcyMOWJ8mg7+fkbZjT2+EkTSxxglLa9RiMIYaF7u5
         pfO41sh6jkp4ga/OZRorYXB6uVhWpmyAEMlbFJEU=
To:     Jonathan Nieder <jrnieder@gmail.com>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in test script
Message-ID: <bixxjcjnQYoZ6CIUQUXdBTaGE7vawm33kqmy3csw7hsPqGQpQNyEhUqBYkvoDgHb8sb3vjLr1KOR3I71-4a4wDKQqTrFocv-eVtGlyE8S84=@protonmail.com>
In-Reply-To: <20201027001427.GG2645313@google.com>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com> <20201026205028.GC2645313@google.com> <xmqqwnzcd6jf.fsf@gitster.c.googlers.com> <Bgt8H4Cev0hu-OKtYHazhsRRIFO_6bAoBqdc4tep09T98tL426R9WXIAMjm7aO4b0uPrZGldPhZ1mV3f9pbS3PDN4bOlb9JkUvvXKtnUFHA=@protonmail.com> <20201026220228.GD2645313@google.com> <AwF-WVCPGK9qyy3lWQ-aYXuvw7HTPjjGuvT4rbPjgoWZE0czToIU-aACj2oyRnkOevGWLQbDgtndt9dkMSGF-SFkNanPgao9yLuVYU1VURI=@protonmail.com> <XDwhHkxbkjL46BTp1WCJ5gJ3UbrMxRGwR2VgeRxehZh0-G07JlxCHrBGCpruqk-OegVspO6LJ0Y3yW9izl97pufYDwOhGaS885_xaVK63vs=@protonmail.com> <20201027001427.GG2645313@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> > If `if test -n '$pager_wanted'` is checking if pager_wanted=3Dtrue
> > before diagnosing core.pager_used, then would;
> > For other instances when '$pager_wanted' is not empty then `test_path_i=
s_file`
> > will diagnose the directory and print a message.
> > be more accurate?
>
> Yes, but because it restates what the patch says instead of describing
> the "why", it's at the wrong level of abstraction.
> I think what would make sense is to add a second paragraph describing
> why the existing code uses ${if_local_config} and why what the new
> code is doing is better.

I see, thank you. I'm now thinking of a paragraph like this (thank you Emil=
y Shaffer for your guidance in the IRC channel);
Messages from checks to `${if_local_config}` are also printed when the
result is false, which can be confusing. Improve readability by
removing `${if_local_config}` checks and print messages only when a
pager is wanted.

> Thanks,
> Jonathan

Thank you for your patient input and feedback.
