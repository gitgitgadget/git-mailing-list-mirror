Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA701C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 22:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E212072E
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 22:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6PfNuRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389690AbgDBW6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:58:25 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:32986 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388630AbgDBW6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 18:58:25 -0400
Received: by mail-pj1-f67.google.com with SMTP id cp9so137360pjb.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxY7o2FYqS9xjtq9UsRFL+AJcu1mdPP5rHFHZWG3pfQ=;
        b=A6PfNuRN4myhOs5JENYPCnXvk0WMPovt4SaN9r0uB3w5ZkjHe/o+mIl+bqgzQkj+il
         SDgn3itmtgyhC9XQAzDlmnYpAq8rOhrN7xiVxP88gJj6cyLw72P/gTau5i8mohHXzjj+
         0zR+V7iwJJH3akEGkjNeEP2coiAzz/M6YqHuKRaBPWAyXzagM7AOswVP/Uk01CjsvhTr
         OgBTv+rQN2ncOjQO3IJsGSrWIzuU31GUgVtSPLwoLOPS6hmFNdb3XE892RK/9ZiZG3KB
         agm7eRPn2yMO27GmmF3oNj4VqKhNVRclD/AixoGVOAtiS3tIZiVykeDmI1gbKr7pUKLh
         OucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxY7o2FYqS9xjtq9UsRFL+AJcu1mdPP5rHFHZWG3pfQ=;
        b=PDGBGnfyhf4g66z3Bgkhbp/oKI/Zl1rM7MssCeuGyrG8nskQWIVxtA/PQMw1OsJ/1h
         b8F8KqclXU4dLPR14KGpQN6d6e4AFogX40751rQ1EHSjwtv90YGlj9pmZSwiOdZtUYMH
         I2Yo+mbLl+SmzVKXRnkmqiONCITURN3PC+N4Ujz8GxpWsN47JuF0iELLSRFvUpDCWkhh
         qSbFr7blD5ziFOoNxsZoWG5ti0i4sDOZhTIPIkT1JvmgTSvEdQdW6DOr/HJb0kNeux0N
         CfzjSjDWx4vUnAZG7rgex8eml/7M+gIZ+hb3wREC1aXwqCivinGR0oGUy4kdY3KACBYg
         irug==
X-Gm-Message-State: AGi0PuYBfwJzdagxMAZBKb4B7hp5U3LLRhPns7GjXkFklW32l4r8urzJ
        mz87rGEsa/0Gg6Sb/zrXRpgGmNAl4qd4RQ==
X-Google-Smtp-Source: APiQypIX5RWKrszw85e2bbzzbjWxUSB+e6a02LmAtbefy88gMcyoPnegRSwTT1D4PJrnXRBzcrOkcg==
X-Received: by 2002:a17:902:d712:: with SMTP id w18mr5299206ply.238.1585868303314;
        Thu, 02 Apr 2020 15:58:23 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id w16sm4536373pfj.79.2020.04.02.15.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 15:58:22 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 0/1] submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
Date:   Fri,  3 Apr 2020 04:28:06 +0530
Message-Id: <20200402225807.8603-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subcommands in 'submodule--helper.c' which give a callback to other functions
have structures and macros named in the format: 'subcommand_cb' and 'SUBCOMMAND_CB_INIT'
respectively.

The subcommand 'foreach' did not follow this convention and therefore had the naming of
the form: 'struct foreach_cb' and 'CB_FOREACH_INIT'. Rename these to: 'struct foreach_cb'
and 'FOREACH_CB_INIT' respectively.


Shourya Shukla (1):
  submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'

 builtin/submodule--helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.20.1

