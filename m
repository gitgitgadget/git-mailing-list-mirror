Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402FBC636CA
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 11:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1989261040
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 11:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhGRMCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 08:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhGRMCY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 08:02:24 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F6C061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 04:59:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d12so15752227pgd.9
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=DxyqOiYsHo1SrSq2e1jVNyAWb/w9am0e1MLYP62+NTs=;
        b=dF1EAedrS//OUQibuX4CZEtbhZ0dSyfSYXbGXHfsgxNjQZKf6D37o2kEq4m8azTb+y
         gO9UnNlHXwWGbMS/Lw5VPcDgThDopGkED+P3f7SS1FYgrIBXB6zV/svokYtrzXz++GSS
         tKtNxTopK9A5ww6pPat4x0W/hNJ0Zb0/Olhd5ULAcMkGYWpeucp3X55T2k5H+riBDM5c
         lYgTOIXre8Z7fl/DvEwqfFymaSs9+EHQ0Fa/htCoqk6y7Ym3tk3YpzTAM7CPoTXncLa3
         Y4RPgYUCzbzRdA1TN34mkb02v4wIAs1QfmGJ/fTXXzMv7kBJe3jBby5AQvNBOQC1f+GA
         xpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=DxyqOiYsHo1SrSq2e1jVNyAWb/w9am0e1MLYP62+NTs=;
        b=Sf/ZX+hMm6Q5BZqFLoGwrp2ClgAP8nIR7JtNwzndygJP42577CwFvXNHlocTha7lUJ
         CLthXRqHp+4u5lcekTErqBTpSFq3e9lixJ9D4p58dkB78A8coMuOxOPutWL02lnbodyP
         UKeqNVvdqLoOBUO0rW6dxFuy1LOnuYZg0JKL5xuVnqIaUEivrU/cKDYiFYwSs0NZ3rSF
         NGt+WRpPacm4npn6Auxo3oWJK+8C2UKQGrDrFW6rZ5NZ/sIQq9xghbJvyJGgU0rOMOKu
         cbwjToY/ZnWo/nofP1IxFL8WNzmeG6/qbPySSiIiYCRq6ib4RB4Ck4GF9yYiFHBpoTIS
         gUog==
X-Gm-Message-State: AOAM532QujONoDRd+fGUZpQMFx4cIBp+3ffXu4WgKKKmHNUN1URGZEAL
        vK2YlSavvoOrIuTwDRUX/J2F5OwCQUt82A==
X-Google-Smtp-Source: ABdhPJz1q18RkY105uRgpJYr7TKE4Cr2rkwwWnOoog/INczxqb70tFDfsjEkjt2VMbZLr5z7nqzQFw==
X-Received: by 2002:a05:6a00:bd3:b029:329:3e4f:eadb with SMTP id x19-20020a056a000bd3b02903293e4feadbmr20374398pfu.44.1626609566241;
        Sun, 18 Jul 2021 04:59:26 -0700 (PDT)
Received: from smtpclient.apple ([1.39.187.248])
        by smtp.gmail.com with ESMTPSA id n22sm15870861pfo.125.2021.07.18.04.59.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jul 2021 04:59:25 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: My Git Dev Blog - Week 9
Message-Id: <ED260A04-153A-46D5-8A84-CF517085DEC9@gmail.com>
Date:   Sun, 18 Jul 2021 17:29:22 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's my latest blog post:
https://atharvaraykar.me/gitnotes/week9

A part that may be interesting to list readers:

- In one section of the blog, I describe the problem of the git
  submodule configuration not updating properly, when I launch
  a subprocess that first initialises the submodule. I will
  appreciate it if someone has a possible explanation for the
  issue I faced at:
  =
https://atharvaraykar.me/gitnotes/week9#launching-the-init-part-as-a-subpr=
ocess

The rest of the post talks about my project progress so far, and how I
avoided the above problem entirely for now by taking a different =
approach.

Have a great day!

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

