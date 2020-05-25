Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F8C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BE720812
	for <git@archiver.kernel.org>; Mon, 25 May 2020 12:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv6OtnmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbgEYM1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390500AbgEYM1e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 08:27:34 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FCDC061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 05:27:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z1so1536289qtn.2
        for <git@vger.kernel.org>; Mon, 25 May 2020 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cqDAgxIgEiLdlsGfFDuESQfyBK7Ii6CrgGjFT7cdX2E=;
        b=Rv6OtnmOXjHrGSobPPPUvIeHrq/vKXJ6ddySPUTw8ydA+u+vsr+6we5nAr2fwVOypm
         nlojGC4xt8LJ2GCyNrjwsdKbkJN1mJhFumW6j3C1c0mA/du8nrqp0pwrxkUwxMTGVf5x
         cmMxhuZU67Uz9ilCcJkdokwTY+zLT1anhirEUKdhSMRtQUl2ivivTV2p7iuRfz9RKUZr
         n7ayXvrpFNmVFiFFPBKU3dtnLgLznAsfy6UPMgC/9T5CbSCKOebh57LQ2KihDjFKPHZv
         34Pp0zwWoTBVxl5KPp2wo2ZesxuRibBBY3rXJb+yCzS3LJmoONP4X5TiWYqg2FQqoGV+
         f0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cqDAgxIgEiLdlsGfFDuESQfyBK7Ii6CrgGjFT7cdX2E=;
        b=pptZHjMOg8tKSVm+LesLUQzLKBaBJm5BWJssziALaf9OvACWK9+xmpqrfatMDqWTDE
         ELVCOaiJ543TJUYP4pVeGeIYAle3gyAxV8Mw75KySMN900GlB2+TjwO3cLvN3ECo+IWu
         /wStsjusCcY7bieryhxXUOcGJrAm8zCyXWJriwvsL0X1sQDMJQlBwOxmrqVNhv7teDq0
         Gy4wISG3YU9xvCPF1cG3I+IXxlz/HAqBSjvdEMmIkYB6g+F/scDgcrr7DZr6QWQe5prk
         BHMVOTsu20RaRTf/PwSYFmHvS01epl0ytg+uGBQK5cFhqNBNjj+Mdc/U1ZXgcQHVeSCG
         QLhg==
X-Gm-Message-State: AOAM530T9FVD74pHnEs5lVNgncGsfeBZgNgUrUuY4JYDC+iiIWExyd1X
        5ZFav0+q6ou8gEIshiKUA99TLr6O
X-Google-Smtp-Source: ABdhPJw7eaQIUJUT5YVkxISdJAaWJ0YUjgWJeCXtewKPzVntMmhew4aWwM60KwI0e0fqKHKzaCNiow==
X-Received: by 2002:aed:2542:: with SMTP id w2mr28535977qtc.43.1590409652389;
        Mon, 25 May 2020 05:27:32 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id u27sm11101588qku.13.2020.05.25.05.27.31
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 25 May 2020 05:27:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Git error message "Server does not allow request for unadvertised object"
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <op.0ks2w7r1pvqxoc@rowan.vivaldi>
Date:   Mon, 25 May 2020 08:27:28 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3EE73235-F418-465D-9313-912F7B5AC8F9@gmail.com>
References: <op.0ks2w7r1pvqxoc@rowan.vivaldi>
To:     "Yngve N. Pettersen" <yngve@vivaldi.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Yngve,

> Le 18 mai 2020 =C3=A0 05:20, Yngve N. Pettersen <yngve@vivaldi.com> a =
=C3=A9crit :
>=20
> Hello all,
>=20
> A while back I reported an issue to the Windows Git project =
<https://github.com/git-for-windows/git/issues/2218> that I observed in =
Git for Windows 2.21.
>=20
> The error message "Server does not allow request for unadvertised =
object" is reported when a commit updating a submodule pointer points to =
a commit that does not exist in the repository for that submodule, even =
if later commits in the branch points to a commit that do exist in the =
submodule repo.
>=20
> This circumstance can easily occur if a developer (e.g)
>=20
> * interactively rebases a branch "foo" in the submodule (e.g to =
integrate commits from another branch before a larger rebase)
> * commits the resulting submodule pointer "A" in the branch to the =
parent repo
> * then do further rebasing in the submodule, e.g to move up on top of =
the "bar" branch
> * commits that pointer "B" to the parent repo
> * forgets to squash the history in the parent repo
> * pushes the updated submodule "foo" branch to the online repo. (NOTE: =
"B" is pushed, not "A")
> * pushes the parent module branch to its online repo
>=20
> When the parent repo is pulled by another developer, or an autobuild =
system, the fetch operation fails with the message "Server does not =
allow request for unadvertised object". A second fetch will complete =
successfully.
>=20
> IMO this kind of check should only happen if a commit with pointer to =
a missing submodule is actively checked out. At most the above message =
should be a warning, not a fatal error.

I think that's a good idea.=20

Another thing that I find confusing with this message is that it can be =
taken to mean that the server does not support fetching "unadvertised =
objects", i.e. `uploadpack.allow{Tip,Reachable,Any}SHA1InWant` is false, =
when in fact the object is simply inexistent...

Philippe.=
