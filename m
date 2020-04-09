Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC567C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 02:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5402084D
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 02:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht4PF6vA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDICEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 22:04:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36185 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgDICEP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 22:04:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id l23so8958793otf.3
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 19:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ypq9tqJeUj0kN1pCwzRVl8WKu4HB9U/uwe82bhZQMMQ=;
        b=Ht4PF6vAspbGwlDowhWJFNd7E1HRVME7ZkzH7lrfP06dxi5bUtQiyeNTh7aHPGwts6
         wYk3K8iUAn/ax+TiczTBJkemeBO9Yij+MoOV08VliH2NHrtJBqLrUNatAfneg/5ALgSk
         K1q1N3D8wcIwG84kamrmWGJ9z5mseBCXJE/d/lQV/sSWpeSaQSOAwkdV6JfkZxBEF1Eu
         pfhYlGaazZjV+JYA8rGVZu4sH+aosrBg2iksoquWHy+9p4HQ3QyaOPWBdN7HpvEuytsL
         JBjBrAljTwhwGpdsirTSYSDhI2ZESrHNPNc+1gtep8HXMeW+3Q2WsfI/P9av4oWlyuPW
         4/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ypq9tqJeUj0kN1pCwzRVl8WKu4HB9U/uwe82bhZQMMQ=;
        b=eBqOBGossyhfwN012qVqZC6q8u2DURD+ESqlSxhGZzg5a72s+moruZ9+7sUzCeCEXK
         dBobDlhwRUH9Owa2lPcTGqgXgdJAWzLgO3sBuEaENLOWiZkAZv4RjfEN/LIGjWXOr6XF
         VUDfqPiBmv7b0VDNBl9F4Pqvqf4xFMe1jgLnl5gakiDOm+KT/GsnZneKXCWf5XXHrINh
         xONYRY8ALcPW8ei31aRzidWldZlmuUtS1z1oC7n9e3+F/+hyPxlT3teEu8J1R5fQ4c0O
         +Fs24/mUxNBzXT5BIBLOtNG7Rvhhd+7lsZLNfxgnChTfT6ZeSymE/PRbPiY249mnUAiw
         dbNw==
X-Gm-Message-State: AGi0PuZtxJhl3qUmIt1CgDpvIv8NJpbUUexGPLYErV6vN4UFFMaH6v0k
        bkfHNkqbx69Aeqvj4YAbQbtqQdEgMpS8sPal1lSBKnaNtzs=
X-Google-Smtp-Source: APiQypJzb4fIJYK24hD9xuZxlo+/M/yNfy1NElpCLbFRyLSqG6kkaa8omIt/aIG+d+R3i2aD+1lNbu3BhaJ3m7DvDes=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr8427104otr.49.1586397854669;
 Wed, 08 Apr 2020 19:04:14 -0700 (PDT)
MIME-Version: 1.0
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Wed, 8 Apr 2020 19:04:02 -0700
Message-ID: <CAM+g_Nv4UqQNAuYyo5zsTsiomCe4ueoM6ZGU1aqAjLGV9+jQJg@mail.gmail.com>
Subject: [git 2.26] stat counts reported by commit and log are different
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just noticed that the numbers reported are different:

% git commit -m 'major code cleanup for SCIMPatchOperationUtil'
[nkiesel/nextrelease/SCIM_2 d4db6f6d83f] major code cleanup for
SCIMPatchOperationUtil
 1 file changed, 2106 insertions(+), 3367 deletions(-)
 rewrite utils/SCIMPatchOperationUtil.java (74%)
% git log --stat -1
commit d4db6f6d83f (HEAD -> nkiesel/nextrelease/SCIM_2)
Author: Norbert Kiesel <nkiesel@metricstream.com>
Date:   Wed Apr 8 18:49:27 2020 -0700

    major code cleanup for SCIMPatchOperationUtil

 utils/SCIMPatchOperationUtil.java | 3807
+++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------------------------------------
 1 file changed, 1273 insertions(+), 2534 deletions(-)
% wc -l utils/SCIMPatchOperationUtil.java
2106 utils/SCIMPatchOperationUtil.java

As you can see, the number of lines in the current file match the
number of insertions reported by commit.  I suspect some "automated
line ending conversion magic" is at fault here (the file has "\r\n"
for my Windows-impaired co-developers but I modified it on a Linux
system). `git config --get core.autocrlf` on my machine returns
`input`.  However, I think it would still be better to always report
the same numbers, no?
