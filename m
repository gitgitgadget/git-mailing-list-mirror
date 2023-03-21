Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BD6C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 08:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCUIEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 04:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCUIEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 04:04:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B4730193
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 01:04:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z19so4788178plo.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 01:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clumio.com; s=google; t=1679385860;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sauV0ctXYFbnyyY2aR+99S0/PrC3TbifR25iiCDjuoA=;
        b=Oj4KZC+yjCdMNgabKKu0+C3ANrFtupvrT0olROGJCEdNyLPqL01LZh1zlB6NGo0q0Z
         LgOlDiE/kOanO0Dm9YM9POfkAkygWLRLyZDb/u4iRM+xL96FfHS88dzGd9U2sAYJyzXu
         I4tVGpthr8vijQDYe7Rj0cQJT4vjIoqmLC7NdnvAiQC+S7A1yiPZsjyp2lgcawN3P3/g
         xcEh4HdaHHLxiwW7MXoK2iKry+ukx4ItMP3RzsGjBVI+01C0lfUDhicxgtcstLQPBByC
         kuu4KR+5onBNYhsrB48a9puxgqnQpC6HtcwFDl1lG6PJX2LHDrX8LkTrd0JswAQcyOYD
         C7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679385860;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sauV0ctXYFbnyyY2aR+99S0/PrC3TbifR25iiCDjuoA=;
        b=tjrEmlYHoAvQFkjNHFYlW5i26r+3OuRnmv5zjiXnQ7wDwMFa8hg2BxoRq6AVA1ZnDR
         v+TJBlTFo3BKoP0lt4glvtMEoABbQe9belIzKYZ8HdNtEpcC7QUAQz6kFQSG3XvT1hld
         AfvJTaA7Rz4CVO1FJRYi6DcvoUd91MsWQpVeMvE7RkK+rn6HJyIoILdANOa85WgRzdUc
         xFfJJ8ONMTw/kYWUQMNIeFruHBBbUtxRER8rOi6uDLRjNAEOfq9gg8U+L/bP3+4P3Npx
         4i1ZvlTTR2c2u2WbD40J1UKvZbjQtnpEwWoKA6M7Rl8awzK1UrjfRntnRvfDWL/glIqx
         wg0A==
X-Gm-Message-State: AO0yUKWeJoujrT6+l9utGXMWrm2M8dQGYBdJGBZiht2izuqHBghQfbKe
        S1lgHqQxDTBTYrmUyeE7n2YGy/7hW3HJycVTegQ=
X-Google-Smtp-Source: AK7set+nyChUra60u8OBkxuK8kKapO3PFbcqySnxxY93LmM3PyvyGzP6pdePCFE/0zvQSUUaBko9Yg==
X-Received: by 2002:a17:902:e48b:b0:1a1:b172:5428 with SMTP id i11-20020a170902e48b00b001a1b1725428mr1148543ple.18.1679385859839;
        Tue, 21 Mar 2023 01:04:19 -0700 (PDT)
Received: from smtpclient.apple (76-244-37-225.lightspeed.sntcca.sbcglobal.net. [76.244.37.225])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902748500b0019c91d3bdb4sm7960951pll.304.2023.03.21.01.04.19
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2023 01:04:19 -0700 (PDT)
From:   Stephane Odul <stephane@clumio.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Suspected git grep regression in git 2.40.0
Message-Id: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com>
Date:   Tue, 21 Mar 2023 01:04:08 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a CI pipeline on a private repository that started failing =
consistently while running `git grep -P` commands. The command fails =
with an exit code of -11 and is failing pretty consistently. With prior =
versions of git there is no issue whatsoever, but with 2.40.0 it always =
fails on the same call. Other git grep calls are fine, but that one is =
failing consistently.

I was not able to reproduce locally but my main machine is an M1 MacBook =
Pro, the CI pipeline runs under Kubernetes in AWS and the container is =
based on Ubuntu 20.04 with the git client installed via the PPA.

The error is for this pattern `git grep -cP '^\w+ =3D json.load'`.

As a  workaround we tried to download and install the microsoft-git =
v2.39.2 deb package since it allows us to downgrade, but then the git =
grep commands just got stuck.

Thank you,
Stephane Odul=
