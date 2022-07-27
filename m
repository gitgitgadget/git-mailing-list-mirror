Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71160C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 08:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiG0I4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 04:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiG0I41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 04:56:27 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B849C46DB9
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 01:56:24 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r70so13110364iod.10
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=y2WRFoLVC3G8f3t9w1sSXJbsURO24fa76/tnH4LxV4g=;
        b=ZQfuDXFI4REmKya4hy5rMM7QTUpWoKc+hfjqtP8JfBW3nRZU9V0VtujTBMV3ms/9zb
         SUGZtiLfCNAoKyjssYyeBHKg5BX4hs1RPwhO0GAN263CKGt/mx2RQTT0CGTgMU3BIbm5
         XHXWenY6YzFCFOtzbqt0TRMmx3ttXeBS66f5AuIeVUJi3uyNbAaHN8NjhG6YQj62pAh2
         j+QCYdf6zbTI/EhixIo+BL1jPo/s54yXkqH63Ytx03iRn7aMwDzjW6uoWBBjJIO/PVqP
         +iI6XjmJtyhz6R2NIqlq+Wcov/9rkf+2GIb7lv8JLA3Gyu3LREsTup2Z+boP9WHRG7ND
         LS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=y2WRFoLVC3G8f3t9w1sSXJbsURO24fa76/tnH4LxV4g=;
        b=KUwIbCQenBpOL5K+udloTSzdHC20vudDFFs5+6zY8V/K0b4bsKqGQ7EG31jRFVR0/c
         7F+UQ46+jF8lGMXlsITYSHzz4mNLiRYXZHQO85GnUFVr5vdY6QshCyKN7XnrgmwhpiD5
         UWELulbP848UMo6ailxcS/BYGRb1qALWFVsL7u+xF/xlNprBHyLOS5U9CS4Bq2Z/Zk0y
         U1IXu1cyZGfhT/4aylussFjNXBdfgJkK+2zoN8z3xVPE8e/TULNLPS9HSj70686jaOw5
         2Mv2y42fn2nG9Kx9F8ZHbLd8iapIg5AN/FRyIbXuETgneDVcizd5jVRySuJRqABriaaE
         R60Q==
X-Gm-Message-State: AJIora/xUOJDVGpIiWE7ssjfJDVID9UMLjqEMa4ePm0UM+ygrazk5wdm
        7SfhvWQHoKBbjJKBEA3ZHPMs4Ru5L24tq5xRa55VBtLEOJlieA==
X-Google-Smtp-Source: AGRyM1szlIfDXXWow0+nFdhN7Glhl4irO1/2IhwwRw1ZMxFZvf+S/oYO7rXxQ8+UCeU7t31ABDI5hk8YFFHCQ6iO1BI=
X-Received: by 2002:a05:6638:2596:b0:33f:8e0c:6af4 with SMTP id
 s22-20020a056638259600b0033f8e0c6af4mr8476724jat.128.1658912183941; Wed, 27
 Jul 2022 01:56:23 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 27 Jul 2022 16:56:12 +0800
Message-ID: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
Subject: Question: What's the best way to implement directory permission
 control in git?
To:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

if there is a monorepo such as
git@github.com:derrickstolee/sparse-checkout-example.git

There are many files and directories:

client/
    android/
    electron/
    iOS/
service/
    common/
    identity/
    list/
    photos/
web/
    browser/
    editor/
    friends/
boostrap.sh
LICENSE.md
README.md

Now we can use partial-clone + sparse-checkout to reduce
the network overhead, and reduce disk storage space size, that's good.

But I also need a ACL to control what directory or file people can fetch/push.
e.g. I don't want a client fetch the code in "service" or "web".

Now if the user client use "git log -p" or "git sparse-checkout add service"...
or other git command, git which will  download them by
"git fetch --filter=blob:none --stdin <oid>" automatically.

This means that the git client and server interact with git objects
(and don't care about path) we cannot simply ban someone download
a "path" on the server side.

What should I do? You may recommend me to use submodule,
but due to its complexity, I don't really want to use it :-(

ZheNing Hu
