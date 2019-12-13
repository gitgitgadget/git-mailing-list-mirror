Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E969AC4BA33
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B402475A
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4PRWcXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfLMQiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:38:09 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:45468 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLMQiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 11:38:09 -0500
Received: by mail-lj1-f176.google.com with SMTP id d20so3301046ljc.12
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=cA7aWWf1SK9PEIBCTIeWuLChCTFd9jSh2ZhgUKa8uQ4=;
        b=A4PRWcXokEfyo4QWxspMn0+S82JeVQ9SO2GsX710A5iAGPmO3Khp3BmEtohdbdvLcX
         COQx4bYx9NhwRcI9ShZc1/HP1AugQCJKUtu6Tp741sKs8pZwqh1NMnjsjsNm3AoLdJc0
         elvA7RBbEyqgHx/AKEkwqc0yt3zV0X6944NGG0GKMIMB5E/mZkgDQtKRgTBpxkyCdRw3
         je8bvVDx67yWQNXDVRJLfrrtkSSGLq9DGKP0nEW+3WjvEMVKkKkuff2bw6pCevuFQhHs
         RA5WlIuDHYXyFMpPnKfAg5eyXNle47kgzxyV74hgDyx4pe2u2afQHIgR+dcy6vcuNCxn
         hlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=cA7aWWf1SK9PEIBCTIeWuLChCTFd9jSh2ZhgUKa8uQ4=;
        b=OgCaMQnstjjU+L6n+t0Khm+lKKeqVDK4ETbpLMbp3JaIAtP9U7Tjk8dHSJs6SGbxmi
         cQKoTYIC3yPJG2i6+4me4r00Lz8sqoWXh7yezhac/XUs4cgx+hW7LsPbZ3VPH7SGmYbB
         AOFbQS2tpVDeikoud+0nBpEf0Z+vd0uDHNUXC06FZgUNSDhRlJFtxHp+i3dKn6wqIUtr
         7G9LIUnCFegN0G5aB1jyq261abyTVxFFvI4f8VLOppUySRzGq0nfG8MWuoHbcdZ4ASuZ
         TLMnIp21P3Ydaey3DWWDWEK7CSdnFi7nmblC1ZLkXKosSZIXFoNwd0JWqsmkp4zTWivq
         3iSw==
X-Gm-Message-State: APjAAAVauO1RUj6k2CMVJnXrwd0HxdhWv40GwihiBYHG5D1DpXrUP2/6
        kkqM2TA7e2PAIuwLHRWpDSrv2zDAQA==
X-Google-Smtp-Source: APXvYqzcijHb0T44mCO//cUebSGVFOemwqKAnROYSgWVx+OdgnnFktYTN08/y8bgHnuaQcCqZJJ3Sw==
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr9943452ljl.65.1576255086569;
        Fri, 13 Dec 2019 08:38:06 -0800 (PST)
Received: from ?IPv6:2a00:1370:8116:64e8:513f:cf98:3beb:1057? ([2a00:1370:8116:64e8:513f:cf98:3beb:1057])
        by smtp.gmail.com with ESMTPSA id e8sm5795862ljb.45.2019.12.13.08.38.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 08:38:06 -0800 (PST)
From:   Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: [BUG] Git bisect extends bisecting range on repeated good/bad data
Message-Id: <473FE927-FC11-46A0-8ABB-7A1FDC8C1A6C@linaro.org>
Date:   Fri, 13 Dec 2019 19:38:05 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git bisect may /extend/ bisection range on repeated good/bad data.  Is =
this expected?

E.g., try in gcc-mirror repository (tested with git:master and Ubuntu =
18.04 git 2.17.1):

git clone https://github.com/gcc-mirror/gcc.git
cd gcc
git bisect start
git bisect bad 81018e27c829e3f09bfe7ce331f14d9fdc995073
git bisect good ab9c3f0f3cabc7069ff0edc040206f1b82eef4ef
git bisect bad 6dc6f6c30298f89e725b0e9328775ed43e08e007

... says there are 0 revisions left to test after this (roughly 1 step).

But if we re-run:

git bisect bad 81018e27c829e3f09bfe7ce331f14d9fdc995073

... suddenly -- 15 revisions left to test after this (roughly 4 steps).

This is reduced from a real-world bisection between GCC's gcc-8-branch =
and gcc-9-branch:
=3D=3D=3D
git bisect start=20
git bisect good 2127e4096ab452a8f0d3e878cb3a4081b3402f1f
git bisect bad 81018e27c829e3f09bfe7ce331f14d9fdc995073
git bisect skip 941fafa56b52ee2328a8695c22e66301b8d30d5e
git bisect good 4c0c3d1029e79b6709b43fed8c5a5944f245516d
git bisect good d9c42406016fee5c0593b7e584135cf40342308d
git bisect good 6f9d77939fc5b55f4c50122b8dc06e6305480bd0
git bisect good 01b38cb1143f17e7ad5b4e863dd60ff42b64c9fd
git bisect good 28e329000fe8a36f059a9b30096a5d226231b4a5
git bisect good 44b2b4ce5d18e915e23f474a64a1a96490d48e82
git bisect good 22bf0cb640189880b683180d50b1e5b4b93e1fd9
git bisect good ab9c3f0f3cabc7069ff0edc040206f1b82eef4ef
git bisect bad 0f18417db316878818d997ae4e9d4e2f8520b2aa
git bisect bad 76c09fb0bcb5785830a24f1f0bec6a6d4f22949d
git bisect bad 6dc6f6c30298f89e725b0e9328775ed43e08e007

git bisect bad 81018e27c829e3f09bfe7ce331f14d9fdc995073
=3D=3D=3D

Regards,

--
Maxim Kuvyrkov
https://www.linaro.org




