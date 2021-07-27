Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DF4C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 02:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D8C60F6E
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 02:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhG0B2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 21:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhG0B2J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 21:28:09 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE81C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 19:08:36 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id db14so5413687qvb.10
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 19:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=ixnQdsDkXFqLtsqEsiZrcnGfuAevoQ/1SRa405P7jMg=;
        b=TCvob9MlbEOP130+tiiIfYHp7kI9f/dm5ncXh3O/S52bc22MMO/F7h5JWTbHV43+bl
         q1md+wUKMN+0R7L/aYNtNq+m251/xhRFmPuAI6IQhbg/GtRQ9D++YTsIDaVLVp9T0Oqw
         APohfaTEJzpHKX2iryrgFvNaItO+kiIIUrMRZ+Uh+PVStQCvZZvgWiwX/+uk2XCUCgoA
         MnqRVxOlOoyGSy6+1V2KFmyBUATSlv4wfYGbuPfWCZta5Elulvxl7VZPwUyfiH/5Y9EW
         Sl5r1Q/n37jF3mc2nkjpc7dnlLrQEjVhCRDm1lkG2WuMWP6zjv0PpuQDj/CNChlz2eGN
         I92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=ixnQdsDkXFqLtsqEsiZrcnGfuAevoQ/1SRa405P7jMg=;
        b=Tod3toYCfw1xBjPxfHJShUIGtBbhKIKf4GPYH8oNxHIHAWnNTCoP6Bja9rfl4Uylii
         kvck9Kk20cUGFGLfIR7roePZqX/UY++VB0V7/a6kjrPit7IpMr3aHMOcwtAkV1q0SC5g
         2i8/7J3kDSWz8zd5OKYMqDApQ7K7mF7MNjj3FHoIIcbYd1OdbfaBZiqhVOQ/qK+mmq9i
         n91V0sJTSpIXefldyDpIRMMlJdlYeLwiQFSscwhoQ2w7NexbI+BIu9k8HMmfMfF/nXod
         VXaIPJoyL66UTxc52rLy2JBNIJFR+K/jCnPukqWmDZOEeI07j6LagfdVl7SLryS/GkHq
         fjGA==
X-Gm-Message-State: AOAM531YaHYfKH4jUxx9u1x3m3+ZLLNGAQ2PP6xjAKZTOd2PCxo1EtNE
        p7xQOwhvl/m7iBQi0mvjSWEhAgjU2z9JkQ==
X-Google-Smtp-Source: ABdhPJyxtNJXbcILTs32U9suyAp6HI3v4h/ERco6DmJkE78lUdBhb3UK4/jsILzfJwHSKIe/8BDwAQ==
X-Received: by 2002:ad4:5965:: with SMTP id eq5mr12689439qvb.41.1627351714523;
        Mon, 26 Jul 2021 19:08:34 -0700 (PDT)
Received: from smtpclient.apple (host-68-169-160-88.MIDOLT1.epbfi.com. [68.169.160.88])
        by smtp.gmail.com with ESMTPSA id y9sm745962qtw.51.2021.07.26.19.08.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 19:08:34 -0700 (PDT)
From:   Evan Miller <emmiller@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: Exit code 255 after large clone (32-bit PowerPC)
Date:   Mon, 26 Jul 2021 22:08:33 -0400
References: <D3C1583B-8CC8-434B-8AF5-B9827A7FD037@gmail.com>
 <YP8ykvsZie4mPE5o@camp.crustytoothpaste.net>
 <874kcgsh94.fsf@evledraar.gmail.com>
To:     git@vger.kernel.org
In-Reply-To: <874kcgsh94.fsf@evledraar.gmail.com>
Message-Id: <89D261C9-A97C-4FD2-9FB5-ACCDA2E70CE0@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Jul 26, 2021, at 20:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
> Evan: Can you run this with some of GIT_TRACE=3D1 /
> GIT_TRACE_EVENT=3D/dev/stderr GIT_TRACE_PACKET=3D1 and see if some of =
those
> show what's happening in/around that 255 exit?

Running it again =E2=80=93 the "Connection closed" message appears while =
the Deltas are being computed. Until that message appears, the ssh =
process is still alive.

There are no trace messages immediately surrounding the closed =
connection. The 255 exit does not occur until after the deltas are =
computed and the updates are resolved. (Which makes the error confusing =
from a user perspective.)

I would think that the SSH connection could/should be closed immediately =
after all the objects have been received. I am still compiling a more =
recent SSH, and will report back tomorrow if that changes anything. As =
of this writing:

$ ssh -v
OpenSSH_5.1p1, OpenSSL 0.9.7l 28 Sep 2006

Evan=
