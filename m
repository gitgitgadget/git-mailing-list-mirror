Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6337BC2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 23:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333C32083E
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 23:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrHAN3FL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgDQXjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 19:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDQXjw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 19:39:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A060C061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 16:39:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k15so1799895pfh.6
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=wrRAXBNEVKe3+9PrTO3yNjXh3NCAAKFvX+N4zBc3T5o=;
        b=HrHAN3FLllvL8ZBF6gSvTlcuGrimoF4UqVD82BiVT5/78s/BFHcXC9v92glcpbPF5J
         HUqVF+VcZ74bRtSdZifLklEOGlXHK6TwDPDzsQQ/hTUWM5EW57DetiwttwoTlBdxec9j
         CDVnX7yCiFHvR0ssyuJ3AlK+o7jImYtdoVFfmIOyH1jfMJlTvM0KD1p6hcyYb6Tu0Vl1
         0daDMMn8e47RVMBvNYcEUDmgff0zHkm+u+Y9ebQd7O6i5OF8aovverLfoJ5OQdZ0uhLz
         +pP+MMvt5wFXeQOhsH8PxWaC+xDahw6TpyJpCzLLRjNEKvw6dL7xPb8zj3yR9WhV48WT
         /Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=wrRAXBNEVKe3+9PrTO3yNjXh3NCAAKFvX+N4zBc3T5o=;
        b=FGxQgUGa0iaRgvDyJ39nZyg4yo1nyslQMDqBI3AWtvv/nQImExi0F4ozQi17mvcgtY
         zPBjeUQxT5XmF0sbfYRU0KEHcuuvBP+jlDBD9yd8bvN7JEYOWgSI8L45A8ywrfddm4Rh
         5y3QZsJe7pZSnOakebnhiydzyfM5ZbxVhNoGmVoBRholJxHkyWz4bAMwXUK3KrTvepJo
         CbH0sZ5lh+YqvS0iYozW+TZbO/WKUK/2DZVBZpizkzCe/LY82zuGySu4nvk+qQpBfs+Y
         cDZJB81nPGkREM3KY9O9zr0SZKkzw8gMDB+k9PEd2VzOm0/asIk/nUYxOsESmlL/1p/f
         7ACA==
X-Gm-Message-State: AGi0PuaLU7isY1+Qlx1Kx9J0L579Joy06OJfiH+z8fS8zfqlxlQ2njuL
        lO81vZXZWsSbjUycjpTUd64U3MMW1ko=
X-Google-Smtp-Source: APiQypKGdHhuzTC3yQ83o21+N/GuA35YmQtp1U1M74Jw6wygylVdsuqUzX9plYfiaCnZZPRLpcomUQ==
X-Received: by 2002:a63:e44c:: with SMTP id i12mr5573825pgk.417.1587166791635;
        Fri, 17 Apr 2020 16:39:51 -0700 (PDT)
Received: from [192.168.20.26] (c-73-19-52-228.hsd1.wa.comcast.net. [73.19.52.228])
        by smtp.gmail.com with ESMTPSA id d8sm15333339pfd.159.2020.04.17.16.39.50
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 16:39:50 -0700 (PDT)
From:   Enji Cooper <yaneurabeya@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: blame --ignore-rev - repo-level ignore file
Date:   Fri, 17 Apr 2020 16:39:50 -0700
References: <B2997F0D-AEEE-4431-85B8-98831ACF85B6@gmail.com>
To:     git@vger.kernel.org
In-Reply-To: <B2997F0D-AEEE-4431-85B8-98831ACF85B6@gmail.com>
Message-Id: <388B3B98-4929-4B4A-9167-3076CFDD0B5B@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
	Given the increased number of C/C++ and python projects that =
both use git and a tool like black (python formatting tool), or =
clang-format (C/C++ tool, primarily), I would like to seriously consider =
revisiting the topic "blame --ignore-rev - repo-level ignore file=E2=80=9D=
 topic that was originally started by Terry Davis here [1] (quoted above =
for historical reference with the reply provided by Barret Rhoden).
	Having a default configuration that can be used with git instead =
of forcing end-users to set custom configs per repo clone would make it =
considerably easier for end-users: one could clone a repo, reformat code =
with an automated tool in a series of known commits, add ignored =
revisions to the file when using git blame, then make additional changes =
building off the automated reformatters' changes.
	I will be more than happy to submit patches to make this =
possible; I just need some guidance in terms of what=E2=80=99s required =
when contributing changes, etc.
Thank you,
-Enji=09

1. https://marc.info/?l=3Dgit&m=3D156864623817929&q=3Dmbox
