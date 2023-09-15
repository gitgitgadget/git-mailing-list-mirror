Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1433BEEAA7D
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 00:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjIOARr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 20:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjIOARq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 20:17:46 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3D42102
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 17:17:41 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-577f6205f42so1177596a12.1
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 17:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694737061; x=1695341861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bniS6bIOtx9XubkdqqGDcrtbBWVcAEU5fs/pE4zkpXM=;
        b=UdLIl1gsa/9h4qBQFGxKQzT8NqXYhpGFdumGS32cQOmrrv40rBxOLff1veHU+KcXGT
         AzSeQQvBb3ilehYqowRpDMIFXTf87hi3S+qOB2It2Gw69OSq2vUgEyF4356d95OF8k19
         mcGdFBxPm0ysNGTsS65+VhCndvuJW1YsVQ/fBKzP9CAaHeCpj6YN1yotRvDU6/6nTUL4
         dEv7q14K1ADqHENQEFPhFdc9Hpb8sCTrUhhJGyEGJerkJlESWlfmFYWp45jc+ab0wf5A
         +CgSIx2SROfTs+dLtG8GhPmni+ZVoIIGaeQqpwlmMtlO3B7HSCG2gAjeF6hjo8Cy27Uo
         gtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694737061; x=1695341861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bniS6bIOtx9XubkdqqGDcrtbBWVcAEU5fs/pE4zkpXM=;
        b=hZuZ0VwdeAY+rU+vXGeObGCVbbOaDp4a9403G3mjfseCQsGcSN3GOEhl/0mP6e0nlk
         JGMYcPwye7IYZfndNrK1VTA550xNeSkOWUz3fRSDegRGyMagMusSkfjQMFnb9+tKLJ3M
         uPqXwxrLWXVnLmBPLJZXzNrou0bcdfHaRe+PG5kKOnoO1Qg7orkL50c+Yv4KVLI4ZVBy
         UYI6KNRshKjqCz7jJZaxMbIA+O6kfTtXRtQ2reBESfbYtJkxHKQcXbGMDwuKEuo4DLiJ
         fr23NMcPE1izufKeWJpwbZNmBk6rSLiVfUQ6St/Qk2Ezo2Oh9eoOrRcipTsIARQfY4Vb
         61AQ==
X-Gm-Message-State: AOJu0YwhRU+F3KAROxjuleLNTp12czBWo0tU5QRz4UMAipxoroAwZZfu
        cK0zA96kFxwOAOJyRfZ2MYPS5U7FjJaViwSgc/FWOd2Mn/qGG5Kj9+k=
X-Google-Smtp-Source: AGHT+IHV+IEaLX5vtLsH7zK6ByNSQ3P9XCeOT3oIuiIiIXhcrIr+V+RwMNl9qB4SRzU+x58NLuqLTdJIJ0fJkmGS4tU=
X-Received: by 2002:a17:90a:670d:b0:271:9c57:1c9a with SMTP id
 n13-20020a17090a670d00b002719c571c9amr68298pjj.21.1694737061189; Thu, 14 Sep
 2023 17:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqcyykig1l.fsf@gitster.g> <xmqqr0n0h0tw.fsf@gitster.g>
In-Reply-To: <xmqqr0n0h0tw.fsf@gitster.g>
From:   Josip Sokcevic <sokcevic@google.com>
Date:   Thu, 14 Sep 2023 17:17:30 -0700
Message-ID: <CAJiyOigiBABJMgXXrExHd0Dd0E9RypVC3sWh15hrU0r+=+i7Qg@mail.gmail.com>
Subject: Re: [PATCH] cache: add fake_lstat()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2023 at 3:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> And your diff-lib change may look like this on top.  This one
> unfortunately is completely untested, as I do not use macOS.
>
> Reviewing, testing, and improving it is highly appreciated.

The patches look good to me, and all tests pass on macOS.

--=20
Josip Sokcevic
