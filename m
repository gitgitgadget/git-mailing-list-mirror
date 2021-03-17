Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EDEC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743F764F2A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhCQUGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbhCQUGT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:06:19 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2384C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:06:18 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id h34so1160137uah.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2TepIEGFlAhW0zqW/ByZ7EYEaBpmPlesGu5dDPJH32A=;
        b=dyYyNyZiZc8aLSS0G/1H0CXxHRT2MSe3S39wkqdpAd8PaLZuMrKkHcLHfX4FQddpiT
         GCyFqFmti37hjcfmpuhoid97FjHgH+ohxx2vFc5OP5dVjP/QYUku1GNgQ3U8N4+QEMZY
         G5tpb3CsRU5+fzmkYrw9GBo6fdWnoGhniorYL7Ko/A4+TZqAZd5g8Pye7KpgWUqX8HtX
         vVln33yzMDC5br06xbBtahJSPLTopu6+FI1qXJbYa+KYncFHiBpiSHFsLZpbEjL/v/8I
         U3nWcGtPRDtKS5Vx1qNqNuMdpFI3vyhE0u2n2AUEEVEloY7q6nIufGeg/kQBNBimCW9T
         pTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2TepIEGFlAhW0zqW/ByZ7EYEaBpmPlesGu5dDPJH32A=;
        b=HV3F2tw6prWZeiXkFkG4XXBgc9GE80Lo/e54tj2qQ8gpcVq6jiBikZXm82CNQHMuGl
         sKi3+oCitO9nSNVR7O26CIa5udaxNezxAoXBPt36GNenG+3EtXPOIs5td2/GAk8wRvdg
         7qjjbYUYYM9iwNwhOuRMxLK/hSefhgeN60/Hg7A21A0eQ7pizFdS2glzHQ8Ot/PHF3qS
         KlV8boa4/HRn8mFNJMyy/RTfhkHdlCld+Unr/5NvCFYk5mLZzL5etuu666DxVnEhFG/T
         14bVac4aTiKvruwBDKf7y4bhEmOLIrwB6FccVdJOlPjAiet4ohgokYs0AXqAkAQic6MY
         eC8Q==
X-Gm-Message-State: AOAM533/zGs0mF0rj9jbrAn2vxrxtM6k1AWcbxbxjdcwaDOxySzgZNeL
        TABmgDfCRJG1dACFLQGnVD8KXI+iemFYKzATGhgw4b15zJs=
X-Google-Smtp-Source: ABdhPJzWGDpGqBcrl4oH/wxxnNWyY5kK5J7xO/yLu6Vn7BPYP/6cyqs6gZ90l5Cdt7U4Sphm4rdeQYa1bX0XvHWZnWA=
X-Received: by 2002:ab0:3579:: with SMTP id e25mr575444uaa.112.1616011577594;
 Wed, 17 Mar 2021 13:06:17 -0700 (PDT)
MIME-Version: 1.0
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 17 Mar 2021 21:06:06 +0100
Message-ID: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
Subject: Distinguishing FF vs non-FF updates in the reflog?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I'm working on some extensions to Gerrit for which it would be very
beneficial if we could tell from the reflog if an update is a
fast-forward or not: if we find a SHA1 in the reflog, and see there
were only FF updates since, we can be sure that the SHA1 is reachable
from the branch, without having to open packfiles and decode commits.

For the reftable format, I think we could store this easily by
introducing more record types. Today we have 0 =3D deletion, 1 =3D update,
and we could add 2 =3D FF update, 3 =3D non-FF update.

However, the textual reflog format doesn't easily allow for this.
However, we might add a convention, eg. have the message start with
'FF' or 'NFF' depending on the nature of the update.

Does this make sense, and if yes is it worth proposing a change?

thanks,
--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
