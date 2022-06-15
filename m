Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350F9C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 13:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbiFONqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiFONp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 09:45:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598432CCB4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:45:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso1151634wmc.4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=HsY3yAAERQuCvptjjA5gQczyiFdpYxYU05D0DcWdDCA=;
        b=LsHkvEaBTA2xoj5cafRHgQ0lumJGb6akAUEo7BVpcdsPua9ZWcYxQ/DlJe8v2iN+Gp
         6PKt02QmqXfBqV4GipGeunDZb0urpeXhAgbacvvCs0QUAGMF2IWOyRylzJkaEzqRPLIJ
         CmHYA+sWHpqMzDaX0WHKcroEWG3gq6C7HZpKH0ldx1Eo/yJFmV7UIMTbmabl/72PNDbc
         2Bm5TEJFswVUQa9PbJsebw5tH1HCcyUCaeNkt2cCQq7a9q362AvOywMUiVtOikXZ7Rqc
         qM3/31JkCqrsXPbjsF7/qswOTChKYc+XiKhTTEjmqhxHK818uw3JibjuZ3pLEXVXv3Mw
         45mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HsY3yAAERQuCvptjjA5gQczyiFdpYxYU05D0DcWdDCA=;
        b=yYGfjCahV2cKuzHjGQ0Ig3eiZpcAvQN5QTM7O0GkTcVb6wOetdGh+W44t7hu40bxhG
         1ZWXm84w8vBJvKEYeUiPvza0xC3XVhX3HV6vCVBEk39i/T2by6yOK5NJ3iAsbvZZRtzA
         ibElM4HjEp+JVPnKNmo7zEFB2g3HTf7B1wbWhPCBNwNVXsUMQDQRpqaEwmAn4hJId29l
         FoS33qGl3tsCiQxRD2Rmv3aYDr+8nT6K0dlU1/EUm0C0olar+l03Y/tLcw4AcNTNWBuk
         Z3NaEyBafOneBOqvtX3GKLgNbNgTijYvo7eai61Y46bEnp7TKCUE+3QHVuJEU1H6h9j8
         AKQA==
X-Gm-Message-State: AOAM530rht02uIGEVOLO9OL/X99MxYWmFGFk9NHVTmImZp1ybqfusYEB
        uciZWzI1TTD6UY34uriIcl2+zddsI1N0Tg==
X-Google-Smtp-Source: ABdhPJx18ZS8etDG1JmcT/4akFwvkl9hBA9QQ71FUjB/wEha5eLoVw/4Zu00r7McTUDA5a45Otn/zg==
X-Received: by 2002:a7b:c389:0:b0:39c:49fe:25d3 with SMTP id s9-20020a7bc389000000b0039c49fe25d3mr10219316wmj.83.1655300754547;
        Wed, 15 Jun 2022 06:45:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15-20020adfe38f000000b0020fd392df33sm14576746wrm.29.2022.06.15.06.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 06:45:53 -0700 (PDT)
Message-Id: <pull.1262.git.1655300752.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 13:45:50 +0000
Subject: [PATCH 0/2] ls-files: introduce "--format" and "--object-only" options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometime we may need to extract some custom informations from git index
entries. Add a new option "--format" to "git ls-files" which can do such
thing, and add a new option "--object-only" which alias to
"--format=%(objectname)".

The origin discussion is here:
https://lore.kernel.org/git/pull.1250.v2.git.1654778272871.gitgitgadget@gmail.com/

ZheNing Hu (2):
  ls-files: introduce "--format" option
  ls-files: introduce "--object-only" option

 Documentation/git-ls-files.txt |  59 ++++++++++-
 builtin/ls-files.c             | 160 +++++++++++++++++++++++++++++-
 t/t3013-ls-files-format.sh     | 176 +++++++++++++++++++++++++++++++++
 3 files changed, 390 insertions(+), 5 deletions(-)
 create mode 100755 t/t3013-ls-files-format.sh


base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1262%2Fadlternative%2Fzh%2Fls-file-format-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1262/adlternative/zh/ls-file-format-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1262
-- 
gitgitgadget
