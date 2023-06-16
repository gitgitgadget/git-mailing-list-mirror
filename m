Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64038EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 18:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjFPShx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 14:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFPShw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 14:37:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29FF35AD
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 11:37:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-987341238aeso6640666b.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686940669; x=1689532669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ll9jlK6a1WI/1nc955uHMNW6ZVIT+cZVRZ8aiBvurk=;
        b=kXrZ7cpSDbjqV0hJ4GaF1CCc5pk4oGR9v/W0daKrNu+wseUR4BbzPmuBGTeQrpbq5T
         xnYfsKW3bQ4hM9PSncEDtikBb+Q/SL8F14DIMaR/DFZvCrcpEJOpt//3Ww3N/UkuZ5+S
         hMasOIOC7HNdSPxc6/tsaxxpgKi4aJDGRuUDb7ir0vGJ3xTOY2IV5lufnzWbo48UJlci
         ajsRX/uWOI0Wth9gIWjmMb0heSOrVJZNR6Aq5CQd9zv/OMh7tW3mMyXi5tI0yiRSlYrC
         Is4W18n+UEweY6foOr1cXL0cMLjpsgXVtHmtuDagYlWoR0BH6ccWBsT8lBwIkYJM3azF
         49jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686940669; x=1689532669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ll9jlK6a1WI/1nc955uHMNW6ZVIT+cZVRZ8aiBvurk=;
        b=COIUL4zH+YmMDbONaDHot0KDnS4ThKbKtkNpMNVcUpm67SAvMnBKUQ/vwrrOxMMLUe
         QupRfA43S6Pz0s/FkTWVZIBHU7WaoFZSxx7PGCjZ8jhRuCyUBPvBGPL40mTBslJixw8q
         Vf9G2NtioVKoX744LjQi28Mf81Z0FZbrTMqVOFYAni6SicDifelg7wWU6olVVEyIo6tS
         6aRtT2qsCdHp/qygCayl3aACXgA2xlOmZX3NXob94BLeVzQcy4yTyu5Zbw3BERShQgWS
         iJjQEBQVdEYU3094yEkTj1JXDKlhTO+CpFE4/fQczWeuaXP12LYpOr6eOSqr/KhCLhpw
         515Q==
X-Gm-Message-State: AC+VfDzRmp/r5oQ33unKeeT1mk5Hgwc1UlWmWaylQS/hYEDt7nRIA9kb
        3CyrsJ7VlH1k8PuIX/pwY7/296XV0YcCXhfsyJk=
X-Google-Smtp-Source: ACHHUZ7WrTSEKUuV/1NIdkHJPVvQfQ1L917grzpJuwmtZXqap4r36ZrbfiaVijYV9kCxn067H+DV32qaSsKvzxDONZk=
X-Received: by 2002:a17:907:3e0a:b0:974:1ef1:81ad with SMTP id
 hp10-20020a1709073e0a00b009741ef181admr2896812ejc.4.1686940669080; Fri, 16
 Jun 2023 11:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
 <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com> <PH7PR07MB9467AD34C96AEE60D5A4369F8C58A@PH7PR07MB9467.namprd07.prod.outlook.com>
In-Reply-To: <PH7PR07MB9467AD34C96AEE60D5A4369F8C58A@PH7PR07MB9467.namprd07.prod.outlook.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Jun 2023 20:37:37 +0200
Message-ID: <CAP8UFD22tPfP37LU8tveHmZPzj7rwUnsEzctzRdqYripv2cyjg@mail.gmail.com>
Subject: Re: Possible bug regarding trailers
To:     "eric.frederich@siemens.com" <eric.frederich@siemens.com>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2023 at 6:04=E2=80=AFPM eric.frederich@siemens.com
<eric.frederich@siemens.com> wrote:
>
> Thanks for the reply and finding that code.
> I'm wondering a couple of things.
>
> A)
> Is it reasonable to expect that a trailer added during commit with `git c=
ommit --trailer some-key:some-value` always be able to be retrieved regardl=
ess of the contents of the commit message?

I think the following 3 conditions would be needed:

  - `git commit --trailer ...` should be fixed using a patch like the
one Peff proposed, and the trailer should be added using this fixed
command,
  -  a command that outputs only a commit message, or perhaps commits
headers and the commit message, like `git cat-file commit rev`, should
be used to retrieve the commit message that is passed to `git
interpret-trailers` for retrieving the trailer,
  - and `git interpret-trailers` should be used with both --parse and
--no-divider.

> I am migrating source code history from an older SCM to Git and would lik=
e to preserve the change messages.

Have you looked at existing tools to do that (like maybe reposurgeon)?

> B)
> Should anything that is retrieved via:
>     `git cat-file commit $SHA | git interpret-trailers --parse`
> also be displayed via:
>    `git log -1 --format=3D"%(trailers:key=3Dsome-key,valueonly,separator=
=3D%x2c) %H %T" $SHA`
>
> ... why is there a difference?  (Explicit call to interpret-trailers show=
s the trailer, but the log command does not).

I believe Peff explained that.

> With some minimal investigation (I added a printf at the top of find_patc=
h_start), I noticed that find_patch_start is called during call to `git int=
erpret-trailers` but it is NOT called during call to `git log`.
> This means the same code paths are not being followed in those two cases =
dealing w/ trailers.
> I would expect that it should use the same code paths in both cases.

The log command shows all the content of the commit message as is,
without any parsing. So yeah it doesn't use interpret-trailers' code
which is useful for modifying or parsing trailers contained in commit
messages.
