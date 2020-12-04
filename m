Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E13C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3BA22512
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgLDCcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 21:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgLDCcF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 21:32:05 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF533C061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 18:31:18 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so3871080wrt.0
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 18:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YScv3l4E51kKT9CGpPEZVAwD+sbbiQR4f4QPpzG84O4=;
        b=rIixn3lSzD0QNUp0Jr4b+IdUHGHPJtaJggpnRmpAkqJAm0YCFGIa/ayUTsP4HmJB7l
         kZ2CiN2GGPUJs1szdZlMYZJkzMEJDjBL7pDNW8JdVOIkMdzHGd+3GhFmMVXmdtGLDXQE
         vkBxbUbIPstdZl23rH/+5t+KgQA76sfwrj87bqmEetnwWbTeRqtbP71/7P8JFyhKNzkM
         Z66lFC+mYEBGxECSt4GXQcP8TTKQEUERCXt18JSyQtbuXpSjp/Xy0EjlQWav2krpJWqp
         YQHoIQXlEG11dBXGrbscJFXpsWhgPHYqT1Iyt3VX0Unq08auTGtqEOYOHHJ3NfBwbrOM
         Giqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YScv3l4E51kKT9CGpPEZVAwD+sbbiQR4f4QPpzG84O4=;
        b=hiwTuzOIrnFoXSnR/bElMT2Ae2BcuL/Lsoz57yg8uI56XMJocpphnudY+Lj74ZINV7
         3JFCu4rYBs8ekzjM8k/WUkPv6LdZ978e3fVBEfmK9iRQPRidh0g/BG9TZu2Rxpylk7wn
         FchlMMjmdW5JrgPZUvyAwKIBywUcCUGH+0oddtIdxpPbRA8NEc77BixFvWWsVVqe0ryX
         wm1Hnu8e7l4o/pQRsXIjJXraA9HLtbt+Nv+M2/Z6unasrQUxRk57O/XX0t3aJIMGE6Ej
         uLkJq2OGI2g1rLbgeeqCnoZs7rA7S1wYEwoafczGqTjTJqoED2yyZuyT0LRWbpK8VbxS
         4ucQ==
X-Gm-Message-State: AOAM533jlAxdSQXnOf3lbu2FoJaEqA2C3OBSk5xIMmgPlBcfRw7FZdw1
        AFsJ0MwKvUEdi+HF6QzC6z3USzitbNh5g5jX3t3Pu+WPofCzKA==
X-Google-Smtp-Source: ABdhPJxb4wdqto8WiHUZx7hWgUTiZhspqb1cXFmnFX5qSZGOE1cCr0jYYii7NARZFHiPKNcYHRKFe28vfwf7F2Mtdmk=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr2150389wrr.319.1607049077715;
 Thu, 03 Dec 2020 18:31:17 -0800 (PST)
MIME-Version: 1.0
References: <a4ae4e1a-b457-4b35-878c-2714ebfc415f@www.fastmail.com>
In-Reply-To: <a4ae4e1a-b457-4b35-878c-2714ebfc415f@www.fastmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 3 Dec 2020 20:31:06 -0600
Message-ID: <CAMP44s2=3GrXf69jqVJ23U=N9QcmGb-dHP_OEqyb6MVTY2z7Jg@mail.gmail.com>
Subject: Re: Unexpected behavior with branch.*.{remote,pushremote,merge}
To:     Ben Denhartog <ben@sudoforge.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 7:29 PM Ben Denhartog <ben@sudoforge.com> wrote:
>
> I have a few repositories on my system that exist primarily as local copi=
es of remote repositories, in that I normally just want to track and follow=
 the upstream project (however, I periodically contribute back upstream so =
they are technically forks -- origin is my remote, upstream is theirs).

Otherwise known as a triangular workflow, for which in my opinion git
doesn't have good support.

I wrote about it in my blog [1], and I wrote the patches to properly
support that mode [2]. Unfortunately they were not merged.

Cheers.

[1] https://felipec.wordpress.com/2014/05/11/git-triangular-workflows/
[2] https://lore.kernel.org/git/1398023106-25958-1-git-send-email-felipe.co=
ntreras@gmail.com/

--=20
Felipe Contreras
