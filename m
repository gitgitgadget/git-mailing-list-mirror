Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77252C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 17:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F009206C3
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 17:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5bLikzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCVR5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:57:33 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:44452 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgCVR5d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 13:57:33 -0400
Received: by mail-qk1-f178.google.com with SMTP id j4so12826752qkc.11
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=H4289ZsoWsqpNeFp2oWP93wRYm1rXPLJop2nKFHbxms=;
        b=Q5bLikzVTMAFe3xCqkGeWfq1qfN/IqFW1SMV+hWIrtl/4oercuZO+I7U5FFuwLVyfS
         YtSYbTACB0iF02SEQHjTzUEmQvVklDKq5q1vrirlfUXJM/+WegtP/k4KTbUsPBKkQGND
         7FNFDLU80NgYbCe52OAt4nODW/vSYjW75UAJEvlDAfsh6uFIgrHkAMr15CeZ4rmdc25m
         QEDbu6SuaefRvj+DYby2QNkxKMCRUkW/gi04iNVz6DhqIbFDoqgB2SIub9EoIw3jIRqU
         ZsnKlJ2Iq7TDOAiNd3xNgWVVr2XKT6Yvtm32uB6u2xekFqJiBEPh0XPOwEW6aLSLza+d
         lwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=H4289ZsoWsqpNeFp2oWP93wRYm1rXPLJop2nKFHbxms=;
        b=GJ7mAcGvPnjpMqZHE+52z9cUs7zeHbwS+UjSPKbcWGR/Dr8f086BTvYw4p9TS4LZJ4
         wYXDo783Akuhc8tIMGfcuBdijNndoT6kfny3fn8juUFUu42sHqoWLGhoKW90GErrtpJr
         YgCjSsZgMwzRZcGgkRPdtghzeqoWKmGGieaa+NyuDA0DGz7b3olluST6GIh7ivxG+zWm
         sgCS2bi0BDQ8rCImLff0RCNksUuETukFK3Kfx+Egm7ZsyZVXRuHVIkxpV9R9Izter0Ah
         /0q8EMy7yeByAQbyhwIaJhNIHEvHsCXGm3JmN3bEPnDmyAJf8lzeml/A2bcMd46Jp3EV
         bcMQ==
X-Gm-Message-State: ANhLgQ0uKtBW/hS9IzBYiO3TfiWy34inxyfRhhDPKx6FSI2qbgT6IUPg
        fUlRKRVmN9wwI7cj5oGT1R7OIZeF5nk=
X-Google-Smtp-Source: ADFU+vsSDCKHguaS/cHTKhYOHp6mw9dEf7gJzBqa+GtxJdzy9feh8927sj/G64RmuE/sDsczODs/VQ==
X-Received: by 2002:a37:844:: with SMTP id 65mr16462809qki.15.1584899850331;
        Sun, 22 Mar 2020 10:57:30 -0700 (PDT)
Received: from [192.168.1.2] (cpe-74-133-2-244.kya.res.rr.com. [74.133.2.244])
        by smtp.gmail.com with ESMTPSA id g201sm2855346qke.99.2020.03.22.10.57.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 10:57:29 -0700 (PDT)
From:   Jason Karns <jason.karns@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Confusion regarding subtree-push docs 
Message-Id: <29B972A3-277C-413F-A387-056AD80C169F@gmail.com>
Date:   Sun, 22 Mar 2020 13:57:28 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found some of git-subtree-push=E2=80=99s behavior confusing as it =
pertains to the docs. (Using git version 2.25.1)

The docs for subtree-push state: =
(https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt)

>  Does a 'split' (see below) using the <prefix> supplied and then does =
a 'git push' to push the result to the repository and ref.

As I understood this, I expected push to do a split =E2=80=9Cunder the =
covers=E2=80=9D. As such, I expected the relevant `split` options to be =
respected by push as well. In particular, I expected =E2=80=94annotate =
to modify the split+push commits with the corresponding prefix. =
Additionally, I expected subtree-push to also respect =E2=80=94rejoin =
and merge back into HEAD.

I think the docs as they are written are a bit misleading; or perhaps =
the docs are accurate and this is a bug with subtree-push? The former is =
more likely, so I assume the docs should be rephrased to make this =
clear. (Unless the docs are accurate and this is a bug with =
subtree-push.)

Regards,
Jason=
