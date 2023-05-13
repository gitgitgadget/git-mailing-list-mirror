Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BBCC77B7D
	for <git@archiver.kernel.org>; Sat, 13 May 2023 09:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbjEMJLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 05:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEMJLo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 05:11:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601571BE3
        for <git@vger.kernel.org>; Sat, 13 May 2023 02:11:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso33816555e9.2
        for <git@vger.kernel.org>; Sat, 13 May 2023 02:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683969101; x=1686561101;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z6+k+4AlZERvSttC+IPZDXoDRqS8sz7vI29i+sYKKo8=;
        b=V9fZBX+Ir23qxLbHthFXRB3MJ06cL9ewX4ulw9DH2ujN3duSZQH44C/fU2J1hAto2Y
         MIehcUNwZiLcABvzxk/SJiwADCU/vnzxuieVxURPA9jUzgIUItlK0wJ9vn8E64JSb6Xh
         CeQDY9KfgWTVG+AmPdiVpqdWyb97nsR3kT8kt654OZ19UbGrPDQ31D8zsOuL3aXFaUDh
         p34PzCU5JLP39yIbFTz2nW5d16XkUGq0rUvd+g5EJTSPKa2fMRx2F8uQ2vs+5f68WhE/
         bP593jstBsQH9icNZ76uXfggXuy6tQI1OkJ1kxfHYSnrNVXYf5sYpo4kHbZBaAVOW2wj
         rRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683969101; x=1686561101;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6+k+4AlZERvSttC+IPZDXoDRqS8sz7vI29i+sYKKo8=;
        b=h/EojI2s5G3FlRi/DRDAMMcM0qGyWUwcnQ29f3CcHZCvK4zlcaw/3k49lih4/KIqdk
         cdRoOJsZVNrT98W6po1tFM0KQPKg5EzzunteKyU4G1oMdpva3GEDEv4g5iiDm7942vGP
         atvGXZF/Z/wzvoJdfI+bOmrS1nMh28DF4HZSPems2winU2Jy6GlMdCaPfPtz8jgSAz14
         +Mdka0UYoJKI7Acm7E0YfVUWQLO1Yvkj8CsMlv6Ou+2NGVD55q2sjk1gA+U6VATOsDay
         o063xW+Syb2lFi93qNLHVGzvMs3uUGlzWcTsloIFLa2cZIUzFI9hGTnkYb9vlCZ5XoDk
         Oj/g==
X-Gm-Message-State: AC+VfDwx6yxjLhGguUhlxPV7DS1z0+U2L1N45wgvjb1hAzB+azTdyRU2
        eHGutRYqQusmaRy4LweSi/C26AuH2Vo=
X-Google-Smtp-Source: ACHHUZ5zB0ASYTaqMzV4gtESY294fMceWk4NoDQvl8ryVlZ5W+ee6K2QnT8dfrT28Dk9hy2G5SXvOA==
X-Received: by 2002:a7b:ce04:0:b0:3eb:42fc:fb30 with SMTP id m4-20020a7bce04000000b003eb42fcfb30mr18588506wmc.32.1683969101330;
        Sat, 13 May 2023 02:11:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6-20020a1c7706000000b003f42cc7aac4sm12586243wmi.37.2023.05.13.02.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 02:11:41 -0700 (PDT)
Message-Id: <pull.1533.git.1683969100.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 May 2023 09:11:37 +0000
Subject: [PATCH 0/2] ls-files: align format atoms with git ls-tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Martin Monperrus <martin.monperrus@gnieh.org>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users sometimes want all format atoms of git ls-files --format to be
compatible with the format atoms of git ls-tree --format [1]. However, git
ls-files --format lacks the %(objecttype) and %(objectsize),
%(objectsize:padded) atoms compared to git ls-tree --format, causing
incompatibility. Therefore, these atoms are added to the --format of git
ls-files to resolve the issue of incompatibility.

%(objecttype): get the object type of the file which is recorded in the
index. %(objectsize): get the object size of the file which is recorded in
the index, ("-" if the object is a commit or tree). %(objectsize:padded):
same as %(objectsize), but with a padded format.

v1: add %(objecttype) and %(objectsize) atos to git ls-files --format.

[1]:
https://lore.kernel.org/git/21183ea9-84e2-fd89-eb9b-419556680c07@gnieh.org/T/#u

ZheNing Hu (2):
  ls-files: add %(objecttype) atom to format option
  ls-files: add %(objectsize) atom to format option

 Documentation/git-ls-files.txt |  6 ++++++
 builtin/ls-files.c             | 27 ++++++++++++++++++++++++++
 t/t3013-ls-files-format.sh     | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)


base-commit: 5bc069e383539824fd3a0d897100d44bbe1f8a24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1533%2Fadlternative%2Fzh%2Fls-files-formats-expand-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1533/adlternative/zh/ls-files-formats-expand-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1533
-- 
gitgitgadget
