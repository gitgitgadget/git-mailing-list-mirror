Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A26C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 15:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhKWPNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhKWPNT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 10:13:19 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D51EC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 07:10:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c4so39482069wrd.9
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 07:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yeplaa-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=XhNoc8iZ/bFfMi62k19I1RbRWrgCHPfzGKbROCiyn0k=;
        b=y5bWezLS+NXvxQlxK9ocqhckcd8v2sdC2yDX5KIztXhvfUAGlvrW7OhEEHWEAaoO/A
         fGP5sHKkREPI2IuCbd3LqUjTJ8Ydegr0MPvjVO/0mb92VLtPhAEy9a2FtVF6FH3L9oL6
         BiC1msjvavdCkGsa4ZFxM1GytwsSmw8e6i5JxLnwHXVU97X/J9bkxAbCwpaviqat/CXF
         EFA+Kc2pDn8t91cVIWR+Aui8/4AsR5zsHPPeTihbBsF1mMFjMFHPYnYKp2kvo+QitCmH
         KbrhV15R5GhPJr111lyMV39hYnjHvTpLr4HN17xo4M3m2pSsXme3vQFak3liMNJfAU9X
         z+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=XhNoc8iZ/bFfMi62k19I1RbRWrgCHPfzGKbROCiyn0k=;
        b=Q+1vmJe9XwagLVDWjAZzpEWAmQ+zmSx06tRnMctZrBZGXHpHs/lVe2lZJeuwgH87ds
         hlcdKRnF9zUjF7VMEFfnx1KS4U8tKb/xrknOomw1C3+GpZzd0lCAch6lOoiQ2xCSVPvs
         YZZQPrzEZA+SJh8OhZowU/EhUtxmmzL9qBsOZFF4CyyXB8kJMNqWAYP67+b0qvsnX9LA
         pzrXtUTG3imQD0yU4B52GvXaKfIS9B3ZqF77JoX0Yqte3wFjgwRKtoBplH0yuNDGNP8H
         k6uZTYbpD38sU7pZlruxj80I7f3tbSY7g9xuck2zVSNQZQagC8jmoH01k+LAKyjtIKYR
         mulA==
X-Gm-Message-State: AOAM5335bTlFmZgeANsND3Z9mRZ1pUdED8u3iPiyUHlDBHGYhv5R2Ami
        kGorg0YsGCNw+kxCkuLWhLliKHsXicpuZ2j+
X-Google-Smtp-Source: ABdhPJzXd+xPxupAM97B6JqMEyBdE0jIPZ4gJlRVRbJI/Dbc2DUi4OdeDlxcwpLD/7yyQLVPfuM6ug==
X-Received: by 2002:a5d:4989:: with SMTP id r9mr8305315wrq.14.1637680208880;
        Tue, 23 Nov 2021 07:10:08 -0800 (PST)
Received: from smtpclient.apple (2a01cb0407624500dc792257eb7914bb.ipv6.abo.wanadoo.fr. [2a01:cb04:762:4500:dc79:2257:eb79:14bb])
        by smtp.gmail.com with ESMTPSA id z12sm12228721wrv.78.2021.11.23.07.10.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 07:10:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Loic Fouray <loic@yeplaa.net>
Mime-Version: 1.0 (1.0)
Date:   Tue, 23 Nov 2021 16:10:07 +0100
Subject: Git subtree command sustainability
Message-Id: <5D6F04AA-1CE6-423D-B097-58C0F429C9CA@yeplaa.net>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (19B81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I want use the git subtree split command on a new repo for splitting, extrac=
ting only a directory with its commits related from an upstream repo. It wor=
ks !
But I would like to know if the subtree split command is sustainable or if y=
ou advise to use other tools (as git-filter-repo for exemple)?=20

Thanks for your help
Lo=C3=AFc=
