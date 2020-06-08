Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C14C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 10:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC61206C3
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 10:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="W03FPFDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgFHKWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:22:50 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:11141 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgFHKWs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 06:22:48 -0400
Date:   Mon, 08 Jun 2020 10:22:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1591611763;
        bh=OQIhI7WM/BuByNjyp52szRnggoAA7CDBlIl8b1Or2Tg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=W03FPFDdzvz6vCTyqB+G79Z+PXzaRJ9smInRtx+6N9tAOv8Sz7E2c1ACQlo9bP6q+
         ziAdhRPVI0WM/p65KEQYFN29AgQOq8OPPVlNStPnozJRuWxlImO1s8N6NcB3OLhB2i
         n5ynjxhccL8ZiToIO3ROWr1Cm2ctO2oUdpJJ+Pdo=
To:     Junio C Hamano <gitster@pobox.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "me@ttaylorr.com" <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2] grep: add configuration variables for --heading
Message-ID: <2lg0C_0k4SnWqhB0oW3wGE6eixtc_ZT5GgZJFzH8XC6g5dJXmSGGnrV9uZVT4QIOG9Sjc7yuLOR_v5kwGIV1hnMSojXinNG16G3tOOMg-Fc=@emersion.fr>
In-Reply-To: <xmqqeer5mina.fsf@gitster.c.googlers.com>
References: <4WK2xPaKLXPbLE0jjY0rBR9M_BVt69rzJKBN17M0ily4VPYuMNC_a2kXsIKWR8y6lc7j58WpBmaIqdbJ1whnjonrfEWz7YE-WpdQqCu_lN0=@emersion.fr>
 <C5PlGbi78_QpceNrgFm_-Wt6BooqbntaL8OdH7XjxjXCtyIfsisyeOQMslLOwNY68Dg7iUxGIvzLPAvUEWyMIC0GdpTgeWwgwD5sWlsyrSM=@emersion.fr>
 <xmqqeer5mina.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, May 27, 2020 6:45 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:

> Naturally it follows that a command-line option
>
> $ git config grep.heading yes
> $ git grep --no-heading -e pattern
>
> is a way to countermand the configured default per invocation
> basis.

Is see where you're getting at, but this is missing for a handful of
options, like grep.lineNumber and grep.column. I'd rather not create an
inconsistency here.

> When writing new tests, we often get too excited and stop at showing
> off how well the shiny new feature works, but we should make sure
> that we test the "negative" case, too, i.e. that the "feature" can
> be disabled when the user does not want to trigger it, and that the
> "feature" notices incorrect invocations and fails appropriately.
>
> E.g.
>
> git -c grep.heading=3Dyes grep --no-heading ...
>
> should not leave the opt->heading true, and
>
> git -c grep.heading=3Dnonsense grep ...
>
> should fail, saying "grep.heading must be a bool" (or something
> along that line).

Note, these new tests are only required if --no-heading is added to the
patch.
