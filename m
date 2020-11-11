Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C05CC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBEA2072C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0Yflq99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgKKRf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgKKRf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 12:35:57 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F7CC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:35:56 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id m65so1828051qte.11
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3io3ms6WLg7nDhuLKHrrQa0cKDQcXklf+rUIOtreqD0=;
        b=m0Yflq99n89HUOSFjuiSUd3aWyiQNkFoSp7oUs/vyuHgZRsS6jNZd4q5Abb1AQxutV
         qz3+gMwLAuXrHSI75ac1T+kTk66i1p8StEdeMVY3R4j3qMI27ZDbtGiEsWW899sOtdw7
         Fw8Qbw/91QmHghk/2Tu2dgYpkfPxfegCCsx7XUV/RRpCOPQOOMblTOImJIIXWv0VdoK6
         73vtd6ElI4rhPgXUgX6S5kJbmEbiDVOkvHQz1mGfCqAGiaEM4iQUOIAXwm2u02M1HYRB
         IBlz7wZcsfz1y0G1ZXi7eDQFt/7t1mkXg6lGH3xX3PrLce8q4gT5wyqyc68hVThQbqVs
         +fmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3io3ms6WLg7nDhuLKHrrQa0cKDQcXklf+rUIOtreqD0=;
        b=Ux8ZKnLAl2O0aYpxFCXsmWFgCf/ACjfHR4TUgvJdmBye3/dvIz3yP+SjCHlpkXnzNe
         aS6d6qUO9t8zIBzXTYr29bCtuyWoKUIz89JAPcwMKwV4E+GEwiRVS3lKNtw0NFR59N7e
         6xk9Xm1WDbNzItIw9EyOh/xtHuqEd75wNM+F8vnOVBjEbjaSPxHAWOLHY5buCKC7wzYX
         kg8KA+qo/o6aV+geucq18bSjRe4UiTxnk9dtfaphd9yfQn1LO9QyyizbQwfS/92KJRn/
         WWimxgtOWI1/q/lQtq/f9MIOPO/lYjbrE4gM3R8dMmpsMj/wUxdJnee5eCmSxRReuWP9
         SJUw==
X-Gm-Message-State: AOAM53089IjKL7gmUHXfUspzkND0kYAoTgGnmGt9GrtHGj9skE5V+VUM
        E92z90JofDBJAC28dS+74N4=
X-Google-Smtp-Source: ABdhPJzhi8V6kWOkW+ijN92v4oeiIM0/jQA5LcwrMfXyrgrLOB4JQu5uvVD3/WiA+Sq5BpQ8uUGDnA==
X-Received: by 2002:aed:2726:: with SMTP id n35mr10057924qtd.254.1605116156168;
        Wed, 11 Nov 2020 09:35:56 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id a3sm2707701qtp.63.2020.11.11.09.35.55
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2020 09:35:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC 1/2] submodules: test for fetch of non-init subsub-repo
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqk0uuct94.fsf@gitster.c.googlers.com>
Date:   Wed, 11 Nov 2020 12:35:53 -0500
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <37DD13D4-FBE4-4DB7-85F5-824E850BA9AE@gmail.com>
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com> <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com> <1604910829-49109-2-git-send-email-peter.kaestle@nokia.com> <xmqqk0uuct94.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 9 nov. 2020 =C3=A0 12:52, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> Peter Kaestle <peter.kaestle@nokia.com> writes:
>=20
>> This test case triggers a regression, which was introduced by
>> a62387b3fc9f5aeeb04a2db278121d33a9caafa7 in following setup:
>=20
> Also, it probably is a better arrangement, after explaining how the
> current system does not work in the log message, to have the code
> fix in the same patch and add test to ensure the bug will stay
> fixed, in a single patch.  That way, you do not have to start with
> expect_failure and then flip the polarity to expect_success, which
> is a horrible style for reviewers to understand the code fix because
> the second "fix" step does not actually show the effect of what got
> fixed in the patch (the test change shows the flip of the polarity
> of the test plus only a few context lines and does not show what
> behaviour change the "fix" causes).

I had learned by browsing the list that this was the preferred way to
submit patches for bug fixes and regressions for this project, but I had
not yet read a good justification as to *why* it was preferred.=20

Thanks for spelling it out; I think a quick paragraph about this =
somewhere
in SubmittingPatches would be a good addition for new contributors.

Cheers,

Philippe.

