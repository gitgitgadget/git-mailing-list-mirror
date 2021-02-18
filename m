Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66929C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE9364EB8
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhBRSxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhBRSuo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 13:50:44 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F680C06178A
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 10:50:04 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q20so1896659pfu.8
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 10:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m9/LohLL3ug/CsFN27DuYrijxUG1hK5nfzys3st5jZQ=;
        b=p4qf6esyAPLIOcq/+THN2CY9ZKf+mjTLqwCb1KqUf7P9Hj34jNX1Q6EljxUVsQswoa
         cKw5oGJSv3PoKS9xd/11cXpt1Lj9HhIFFXb/mTGjkTi39YERtDB7b/MzCbdqSpo/iNxT
         RPAVz/Nf3PaPN6TuFQ2V2XctNZrBFN56RafWff/bas7VZHhMUIVtlK55T0T2iaZeXKJB
         nMCx6J7bB9DrE5SNG222GhHKDsqStaRprcKi59Hp/xOsQu3al6pruoimPm7ccQDYJuCL
         TXDH1xDYNNyyZcXmaJL1yEIJdOMXJD/O5l4z/VL9CWUQmHN51Bj5jiA3oqfHIrfuGFSp
         Yepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m9/LohLL3ug/CsFN27DuYrijxUG1hK5nfzys3st5jZQ=;
        b=LoapZ1llw30xHf4FZf+ylFKsDUcXY+K0XN39HevuXy6gfYQ+ga9Tyu1g4cyd3SNrig
         XhHkBapXGKcDzFQ1+TidBCey3zwGKqsKuZ+ZBgiO9+cGJXHLCwSj8HIPSiw2AZp4+Ybo
         sHDzPzT0BIag1YkS/zKhNehzoua0KORccSOSK67xH0rheVUpOXAoz3IC9z7DjiirHJBd
         MCmv62GfXghyZDZx2exGBcWwciEdEv2LukjNrE0bTPBrg7KBaH8VGDziLsJztApHj33/
         LX72+7wE8mBZzKq1/COgwCzWgTP/6xbbcZNMgKb+QHGXw2PdQLOwE8VcBD42SGyBg28Q
         pBjw==
X-Gm-Message-State: AOAM531x8/X6W3jqCeXsgyjeWHvjoo+qN5DAyzbfPWc+8x/XlodUby0Q
        XXLmbAk64njry6Ya1vCMcDMaDKUvEQE=
X-Google-Smtp-Source: ABdhPJy8LH77nC9MkS3yGf73C9Xtb68iueC0Q88m2UV1sS+zdrLaUfRMZohK25bscEFcLPkYzzbyXA==
X-Received: by 2002:a62:342:0:b029:1ed:b5f:d075 with SMTP id 63-20020a6203420000b02901ed0b5fd075mr4984154pfd.62.1613674202322;
        Thu, 18 Feb 2021 10:50:02 -0800 (PST)
Received: from localhost.localdomain ([122.176.159.190])
        by smtp.gmail.com with ESMTPSA id s22sm6790879pfe.133.2021.02.18.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 10:50:01 -0800 (PST)
From:   Shourya Shukla <periperidip@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        levraiphilippeblain@gmail.com,
        Shourya Shukla <periperidip@gmail.com>
Subject: [RFC][PATCH 0/2] rm: changes in the '.gitmodules' are staged after using '--cached'
Date:   Fri, 19 Feb 2021 00:19:29 +0530
Message-Id: <20210218184931.83613-1-periperidip@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

In the series of mail exchanges between me, Junio and Phillipe:
https://lore.kernel.org/git/20210207144144.GA42182@konoha/

The outcome of the BUG(?) reported by Javier Mora in the following mail:
https://lore.kernel.org/git/ea91c2ea29064079914f6a522db5115a@UUSALE0Z.utcmail.com/

Was not fully decided (i.e., whether it should be fixed or not) due to
the potential "pollution" of the 'git rm' command. Here is my patch
series attempting to fix the situation reported by Javier and make sure
that doing a 'git rm --cached <submodule>' deletes the entry of the
submodule in question from the '.gitmodules'. I have tried to keep the
changes as precise as possible without adding much extra stuff.
Reviews and comments are appreciated.

Thank you Phillipe, Junio and Christian for their comments on the patch.

Regards,
Shourya Shukla

Shourya Shukla (2):
  rm: changes in the '.gitmodules' are staged after using '--cached'
  t3600: amend test 46 to check for '.gitmodules' modification

 builtin/rm.c  | 48 +++++++++++++++++++++++++++---------------------
 t/t3600-rm.sh |  7 +++----
 2 files changed, 30 insertions(+), 25 deletions(-)

-- 
2.25.1

