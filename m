Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142D9C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 00:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhLMAaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 19:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhLMAaY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 19:30:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AED2C06173F
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 16:30:24 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z5so47677356edd.3
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 16:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bBX0ReSz1TFs/yHKuOp+fLsY3HV7tWyJ/fQGrDxV2nc=;
        b=AZn22qs+354cwE7O1o5x2+9YjH3USN1UShGYkxF3+Vl8noZNxWNbdJWTgQyRrbAND9
         CpokYyz9xJVFgB2Im/sNA9YJnqHp5i1sNMBusAOakauOf4RHqujoVxS00e+UWWjvLzbE
         cAgT/awxmWE+faKidIQnyGbzBjNjZAolL7xcaxulf6surDXPinnL6QL6NqbaxVMXB/3T
         Nf3zd0OGNjznrQqTGFyO/R4RXBALUgOLCSesV1LNmdNXKY/iw4TwnfBjlQRdnJ/IhtP8
         TQzKVEsfJvRGsUaQ4sv5tDO6bfAdGG343vvpsiSoS/F9i++TSLKiBNzvu3sDFo7h2GA3
         7hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bBX0ReSz1TFs/yHKuOp+fLsY3HV7tWyJ/fQGrDxV2nc=;
        b=Gdg2/OUQq/j2yKsKRnzaA4JM0vcTxROXX58pRs4Fbb2VB2pUO2PBx2CFcuu+sbnrt0
         9gi81ClHSeOM69FjRdVtCZZn4q1LojX7K5s6CtgvgTELjeGi6kFyQj0NEmYFj03o/IKd
         vTqCDacHDFi6QWbAovNnx8nUl5HxOUHChtDPLjsnKybD18q0ucyQT9qPM+xxqENMVKUI
         Ge+6fWUdMA4RpHylg0MufBOJIVhJcV5Onp3GcZvGnpelas4fpXI166pg92bEeGl0zx7Y
         nKNt2AEpaQH4YsCH4IvTBO+rxmiNkdKS7wh3A9Cz31RZKFsZhWgo+sz0hpX1oO3Oo8n0
         zqtA==
X-Gm-Message-State: AOAM5302X3ZdtKw1XP+cQYlNq601BzGu9alWacaiIRx0YrGSXId949mz
        eqbsyacOWylHHfdkPA+QVk9zmO5oLMxyvTRHBJN+SAeeUHk=
X-Google-Smtp-Source: ABdhPJyWSf2pqDsdPFdvBhWJnuwPDhRVVDR5+xV9oGQHZqPAUKdhjfdyw1FF1I7LhKw+MaN+aWeTklD9L2zxuv8z9Hg=
X-Received: by 2002:a17:907:3f96:: with SMTP id hr22mr39626061ejc.492.1639355421473;
 Sun, 12 Dec 2021 16:30:21 -0800 (PST)
MIME-Version: 1.0
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Sun, 12 Dec 2021 19:30:10 -0500
Message-ID: <CAKu1iLXJQxcjrk1Wny6ccMPPxKqJBpfxzTp+i+EZ90NvFkc-Yg@mail.gmail.com>
Subject: [PATCH v2 1/3] git-p4: remove support for Python 2
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Sun, Dec 12, 2021, 5:39 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com> wrote:
>
> This summary makes sense, i.e. if the original SCM doesn't have a
> declared or consistent encoding then having no "encoding" header etc. in
> git likewise makes sense, and we should be trying to handle it in our
> output layer.
>
> [Snipped from above]:
>
> > It's not clear to me how "attempt to detect the encoding somehow" would
> > work.  The first option therefore seems like the best choice.
>
> This really isn't possible to do in the general case, but you can get
> pretty far with heuristics.
>
> I already submitted a patch several months ago to introduce a "p4.fallbac=
kEncoding" option. It got merged to at least the lowest branch, but I think=
 it died at that point.

I did considerable research into the possible options at the time, and
I'm pretty sure the best approach would be:

Add an optional setting for the user to set the encoding.

When decoding, first try UTF-8. If that succeeds, then it's almost
certain that the encoding really is UTF-8. The nature of UTF-8 is that
non-UTF-8 text almost never just happens to be valid when decoded as
UTF-8.

If that fails, use the new setting if present.

This is what my patch does.

I think it would be better to go beyond that, and if it fails UTF-8,
and the new setting was not specified, then use some well- accepted
heuristic library to detect the encoding.

Frankly anything would be better than the current behavior, which is
to completely crash on the first non UTF-8 character encountered (at
least with Python 3).
