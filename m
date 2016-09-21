Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AF3D1F4F8
	for <e@80x24.org>; Wed, 21 Sep 2016 11:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757292AbcIULaF (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 07:30:05 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35618 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754206AbcIULaD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 07:30:03 -0400
Received: by mail-pf0-f196.google.com with SMTP id 6so2285626pfl.2
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHlIE7cZRK1rMppJ0Jv4SsQsAhXFikLfmPs40k+1H+c=;
        b=Rf2t6VH7RUuLxLaOAKZJ/ksroBinC/5p4BgV3ffpoE9VhuJfVlCbsow2NWW3BWMZHV
         fR+4Wv7fFADwmTFKMtbzjFX3EfiWg5yopoKWpAT6bMKGzlj+iFx+DydfGt37i9bh5KQJ
         4CIA9lDYRcBf6cYTprtbCnn7NTwwIOG3iM55rstFWrXp0EiEtAlQXiOPEHBTdYgIuxgD
         IkOWg8yoHm7OneLfBjt73jtaHsmu0IbWW4K2Vn+kaPPMimUJU30yg/WoEFIEyzhIjSRz
         LJ5ELyQvP5jwNkZRUITYRwXK6NuSfc+L3ejOinRnLyK5Ts+CR7El8DUcIJ+XM0u6w9w7
         Vm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHlIE7cZRK1rMppJ0Jv4SsQsAhXFikLfmPs40k+1H+c=;
        b=jAN7pqmQ9t+IMHvcokMnq8OUrqgEMOlyJC2bTx49tcxVFTQbTNXyGfefL4BkT0CPBv
         YYjoKryTqZNB6tmRHVD0VaYG8TpOy9fB3pWpXG6x1HGguUmcpifer9w/I0jnQsf4DvkA
         K1MS27poaNpDFbl7Pjpu/irRUvAXDKylliselhAxbtXPaDK2EKKr9aZLE6f5pQx3c/LD
         lWs72Ky+cQVYZLlwA9IViHkgCk+9Cm2XGxxV2ag3feu14BLYcklXADAs9ZiEYiThGXaY
         rRlZjDBa7h2XoyujvIdayOQFN9cDg8N0hTFbifIWUyJR3LfdJVi5q0Bu/3iulKzW1mKB
         viNg==
X-Gm-Message-State: AE9vXwOe3ks24RnRFxE/a6SzTi/s8K+05uqM4xDvfuA1GtwhgwmQvsUwyIyQ5ZO3gB01SQ==
X-Received: by 10.98.72.157 with SMTP id q29mr35686680pfi.44.1474457402691;
        Wed, 21 Sep 2016 04:30:02 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id q14sm66868610pfg.63.2016.09.21.04.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 04:30:01 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 21 Sep 2016 18:29:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
        max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 0/3] Fix git-init in linked worktrees
Date:   Wed, 21 Sep 2016 18:29:36 +0700
Message-Id: <20160921112939.3444-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160908134719.27955-1-pclouds@gmail.com>
References: <20160908134719.27955-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 requires jk/setup-sequence-update so I could kill my workaround
patch and avoid conflicts in t0001. And:

 - 1/3 has a few missing words back in its commit message
 - 2/3, which was 3/3 in v1, no longer has the ugly hacky
   get_first_git_dir()
 - 3/3 is a new tiny code improvement after the new 2/3

Nguyễn Thái Ngọc Duy (3):
  init: correct re-initialization from a linked worktree
  init: do not set core.worktree more often than necessary
  init: reuse original_git_dir in set_git_dir_init()

 builtin/init-db.c | 11 +++++++----
 t/t0001-init.sh   | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.8.2.524.g6ff3d78

