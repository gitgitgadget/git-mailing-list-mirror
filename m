Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89BCC5519F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D3720771
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRZafkNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgKSBDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 20:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgKSBDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 20:03:11 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF36C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:03:10 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id n129so4164058iod.5
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNo5e4nO8oc+7TQ+3J5Yv5O8r31c/563nlZnPs+M3mk=;
        b=tRZafkNiJPPha1UyaevYyDNRxDzNMV5VqfCHb1afbrdYp1I6k3Bs1zifxgjXdHxMOY
         8YyADUuHceVcW8cHE086L+8k7Qa/MtQ/ImgT9xPBIENk1+CI3MwNpCFi5PKBD3HlEu9Y
         TxWuVgTeaWso+CQfysuROaRJC0jQEL4u9kcYLo+nL1anSQ6GrKqJFVhjaRBJ0qWWqEa+
         /DP2/px6iQpMbDpUbSpk2/5auQsq+zT74e95BMeZoLgtcbl3OFM/EXZJmJY8/NHq4A+H
         RP5+ZmNxVxIbXQjSjbkgTmc956+fhWeJUNDye9KYia95yhdWXfJ3iqg3fYECud9ZkPUE
         qfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNo5e4nO8oc+7TQ+3J5Yv5O8r31c/563nlZnPs+M3mk=;
        b=bYrWu/NWOcYdqF68Swo5l9qKj8WPf1C3KKZUxkOFe2/6rlFHaRI8LQaguxNLXZZASf
         TTaTXVGykhzdWetMRSyYN6CTfNn65wnhWp3uc6mUnTidS1T1FiCJt27yxARC4xwuuADL
         l/ECsD2/xhhR6HaJQm1D0GApwj5I/CyfTLBWDuxL32lQ0EW23FBS29/JRLrsvanxwNrk
         jhlOzTfcCIQ82fv078fdlqMqNR8Z30Z/hIFeNAkv3qDKYD9yy6pplQJLTmAbt6ZKvJmR
         433zPG0o1UwRQrGwQXRsd/dyjZnkAZI1gNVVjUkCHm/En3qXWEnsxiWCCPZ3LE4k3CYi
         H3sw==
X-Gm-Message-State: AOAM5313rDjGvPcmroL97tctXt1kxkcGxpBUa1sQVgnK4oCoQR7gazcO
        1NN1h/Jeuz2kxCJR/ShMUwv0F52VnFeW4AJYrq4=
X-Google-Smtp-Source: ABdhPJxtw6jNsSQ/qMNPXpTpln/AbcZ4GNPSsE9Uwaw+pykpnG2fiDPqimmTCd0uSdPuX6HwfekjalQNf3Nm/9DC6mA=
X-Received: by 2002:a5e:8e01:: with SMTP id a1mr17868992ion.7.1605747790143;
 Wed, 18 Nov 2020 17:03:10 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu> <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu> <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
 <20201115034649.GC3985404@mit.edu>
In-Reply-To: <20201115034649.GC3985404@mit.edu>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 18 Nov 2020 17:02:59 -0800
Message-ID: <CA+sFfMfWrSMKAogg-5dsaO_beXUV-JCBLBPeLZ5g_0jGqsom8Q@mail.gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Lukasz Niemier <Lukasz.Niemier@kobil.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 14, 2020 at 8:23 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:

> This *really* is not hard; which is why I am starting to suspect
> people are really kvetching because their objections are really more
> about the woke/anti-woke aspect of the "master" -> "main" migration
> --- and they are using *think* the children^H^H^H^H^H^H^H users as a
> rhetorical device.

So we're changing the default branch name from "master" to "main"?

For what purpose?  What problem are we trying to solve?

Is the word "master" now going to become a taboo word that we're all
afraid to say?

Isn't this all a little silly? What's wrong with the term "master"?
It's a well understood and commonly used term that denotes
"authority", i.e. the master branch is the authoritative branch.
People sleep in master bedrooms. Universities have headmasters and
award master's degrees. Skilled people become master craftsmen and
give master classes (e.g. master plumber, master diver). Recording
artists master a track. Skilled chess players become chess masters
etc.

-Brandon
