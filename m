Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C09C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 06:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbjDZGl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 02:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbjDZGlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 02:41:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD9110DE
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 23:41:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2fddb442d47so6081281f8f.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 23:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682491282; x=1685083282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kj5ZfaLj5C9Xd/7ed1vBrp3wJGqZRO08IksONV4n5HY=;
        b=XtWtDNjH1SmOUhvRsPZuIldj8H/v6IonTbXmhNtUbMFbWU3Z410BdW1XEQV1uiBPIe
         FV/HcVXAuoHboNM8joFCd8VtS4vr7v/+HRxgnG8+TIQWXU4eVUrmB8JN7ZKRG3qwRUAe
         6oIER595UYAqnP5FLoxsc6yVxt1rV9g2NV8Ye1WLC7Hn71oVw9gw42ElBCJE7GV4FQ3Q
         K69Rb+Yyzwigc5jjUxUcaCqnCWK5j5dwDONbvutQzp6IwhXw47EKDAcOdThsscSharmF
         FDN7OAqZYLR4gNq+rk8ArwW/fpjYpuR+kbg+FM45vwFewxsUxKe3quCMgwg9HV+NR8Fy
         L+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682491282; x=1685083282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kj5ZfaLj5C9Xd/7ed1vBrp3wJGqZRO08IksONV4n5HY=;
        b=Jt1rikY7+CkcoZuDkmytafqrtzRoP8x48GoQZ1VYOoYuetqac/Ur2iAsdgqL3fRnY5
         7ZEBUCRZ3JsD1h10AjCe9/6bgzMha6gf8arhRP5Fa2+tBJCT8LbUty1MALeXYkOLMFI6
         Yev6Q6FhngLr32+1yk0HE4Vt9YFlDs+so2X1v2NOwIE6ETY8MVV1wtOCCLSUEIhkJVdu
         WVRU7T1mFBNJ7S/c5jDkSV81lQr6kCCIg4w3ivpgc5L6n3OHMeywAGZzOWiQKKbDRYz/
         11W6ext0QF9o1YZCq3JfxI9pQ8NL2ZTixe8oSvGdXuTjzC7KdVT6beqTF7eMIIR36TXu
         JXRg==
X-Gm-Message-State: AAQBX9eDu+1Z05UtrESnzkkZwLkuyD2vdUnamH+fvz1PMRvxNhEWAJfu
        0AJth+XZCxB56BebQpK0WAJpQzUntQIWuBegH9Q=
X-Google-Smtp-Source: AKy350brUbYwcpGq2Da1+be06AXdeoK1TSiXiQij5QpDHztzuRrLOqrZyzHtukCjL3SzpsoPcEmoSZ0/PJ35vUHeuP8=
X-Received: by 2002:a5d:4bcf:0:b0:2ef:eba4:e208 with SMTP id
 l15-20020a5d4bcf000000b002efeba4e208mr13901416wrt.45.1682491282039; Tue, 25
 Apr 2023 23:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230426013428.53206-1-carenas@gmail.com> <CAPig+cSN=DYXuCmO4-ewN20mibqH7o+zESDbwXG8c0QW0TVVrA@mail.gmail.com>
In-Reply-To: <CAPig+cSN=DYXuCmO4-ewN20mibqH7o+zESDbwXG8c0QW0TVVrA@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 25 Apr 2023 23:41:09 -0700
Message-ID: <CAPUEspgqGFHg-a2gZ+j6pRLQSZwVuVR9Sq3j3yvcK1LtAi1VHQ@mail.gmail.com>
Subject: Re: [PATCH] developer: remove gcc 12 workaround
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 8:45=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Tue, Apr 25, 2023 at 9:47=E2=80=AFPM Carlo Marcelo Arenas Bel=C3=B3n
> <carenas@gmail.com> wrote:
> > Since 846a29afb0 (config.mak.dev: workaround gcc 12 bug affecting
> > "pedantic" CI job, 2022-04-15), DEVELOPER mode has this workaround
> > for the version of gcc that was released with Fedora 36.
> >
> > That version of Fedora is about to be EOL and latest versions of
> > the compiler don't have that bug anymore, so remove the workaround.
> >
> > Tested not to trigger with latest gcc packages from the last 3
> > Fedora releases, including gcc 13 from Fedora 38.
>
> The commit message doesn't explain the benefit of removing this
> workaround. Is it because it's a maintenance burden? Or is it
> preventing some future planned improvement in this area?

The workaround was added for the benefit of the CI and to prevent
failures because the buggy warning will otherwise make it fail because
of -Werror when Fedora 36 was released and our CI started using it.

Our CI doesn't need it anymore to avoid that issue.

> What is the
> justification for penalizing users who might be stuck on Fedora 36 for
> some reason or another?

I certainly didn't intend on penalizing any users, but I frankly
suspect there aren't any, as the bug was fixed long ago, and it
wouldn't affect them unless no gcc updates were ever done on their
systems.

Carlo
