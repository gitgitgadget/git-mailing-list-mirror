Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE607C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 04:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84297221E5
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 04:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkLdMmTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgIKEZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgIKEZE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 00:25:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6B3C061573
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 21:25:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id o68so6412152pfg.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 21:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=1bTbEqG7ULCnP6lGuV9xbLuLIB30/3kHlma4yrwZLtI=;
        b=tkLdMmTDlxCa53Mmhvum7uw0d+BRqnF9wT/qJquZb9Pv65S5kYKcTvhdVhg4wTfzSZ
         kC+mLSDTxd9lB+6Rpk9bxdJNSybcDgAlKzqe0VvoLbxmK3RXRxAHqt7hgI0PJPXY8TRX
         oi4fe2M4FIzNVhfAFIovcd86wh4GEmt4U9CSGNFB4GbTd+bYGSR1vjBAuNItbcHPqiVv
         ErK636RID5tvHL2gtqpyouTIMcPr9Up8On841oeKixcDKwtvw3cREUMCCiwKWCQTM1B9
         Cuf6lDF84dTVp1n0A4OHDmuTpR7krYtRIEluG15Kyq6nzBWljtUmG7v9Sj0ivf+3bkxs
         76QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=1bTbEqG7ULCnP6lGuV9xbLuLIB30/3kHlma4yrwZLtI=;
        b=rmccIzTBPCdR+nYF6nDExWjN6ePLAuOFIzXyBbtXHE+3+L98Y6NgCaWZdLLkRfkZa3
         LhprJ+q4afBWhWkBqk/0ZlcaO7JuCu+HOGnHyBUoC/98MfsiKebAZ5jXr94aGQ7tUgWl
         tA8WFEkBAL6m9sIiTDkhJieRhTFx3haBV6PPcLzWpJmZ1XD4e3fZ7Dg545C/E+kyfUC1
         dVuZ9/3q0ACcx88zdlo2DxT+tay8rYnarXf+6bn5G86MzYM68kKsCb7zLVxxSYLmt8gU
         7LwDsxaTg4eJySfWPj0pa54IP7Mm3hfDZKiUH9CKzoOSnPYQ6NdYmWLd1XSoeARqigdN
         Lspg==
X-Gm-Message-State: AOAM531dypFMk2U4E5yILrpydMx31/Cq1GQrX2ksdCt1Zmm1RS8/NJOo
        AxmlZk9aAbb4eutAeDeVR7FoVy8AZgXV6d3K
X-Google-Smtp-Source: ABdhPJyvwN/HJYgmWLdn+G/R77rG493PQXOA6ppvOmFp7nxJlfv6WeZHOGzmBxrXiP6kMrdj11Viqg==
X-Received: by 2002:a63:d04b:: with SMTP id s11mr320145pgi.241.1599798302821;
        Thu, 10 Sep 2020 21:25:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.70.3.170])
        by smtp.gmail.com with ESMTPSA id m13sm519262pjl.45.2020.09.10.21.25.01
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 21:25:02 -0700 (PDT)
From:   gmail <coolnavy2010@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Combine submodule and worktree with a center cache
Message-Id: <8FA765EA-D06C-4569-9921-DC333809E2F7@gmail.com>
Date:   Fri, 11 Sep 2020 12:24:59 +0800
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, It is possible to combine submodule and worktree with a center =
cache like `$HOME/.git-modules`=20
to speed up `git submodule update =E2=80=94init` and save disk space. =
Now I managed them manually. I suppose it will=20
be support by git automatically.

Best wishes.=
