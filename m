Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8F2ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 21:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiH2Vir (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiH2Vik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 17:38:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CCE8277D
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 14:38:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f24so6488555plr.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 14:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=NE1iouwmnieVtKk4dgIX5N+hM7BUsTrmYk1zCX/SOrs=;
        b=WsL9m1fxAD/oJ3OX8Qq8U8m32kqh/XTaUDABCwZaC6wv4XehATrRfKaJuKPdQn/Eix
         IE171JZl99JGgxfWPunld3lybujbRkPofz/mDI5BirxywOA5dplOerlbd3qN5pxUycGl
         /wRdWBBEztFWZCxX0yPxjD7Jvq8psE188+UEZl+E2G9IhATTnzYYIRs5CI4RJ9AdkFLL
         srl9zKXAdc3TcBH3GtebS/M5vWX25D5vKux0lvildUttRgbtJbSHK0covyVkQBYxupkR
         QnUzhL9j3tMyTe08jOV7FAFYehvEUzBa3yRv2AAM6I9UXjnJRwcxhE131TDixdlbZLTc
         IrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=NE1iouwmnieVtKk4dgIX5N+hM7BUsTrmYk1zCX/SOrs=;
        b=wmbz/7bF5RXWrsP7ZAb1HMevZxM/5VqGzU8xqu9i4CgoWjEWiF903f8MG+TfdKfqC7
         tgK/R43kJam73kkqOrrHpdl5Xq0vexTdtv/1QlXmP+6KwDb4pzokCAPh3e8Jetfi2Imi
         3eTWSzDoh23eajP2inS2RbPs4PhFkcDi39H58muDE5HyEXCIXhT6uDyFiYdffdcSZbeP
         mWIXZT8GkBFJZWLoDFHT7SO345shiRxbsoMp0QgIYSL8ZFAWq927j5j46vIpLnHb0L/D
         hCXRqlTgxVraa/xTYP0xIxyaXmD0wK504IJdQ9RHyYMq1u126Ix38dxqBg2EDs2ZFlfL
         QwPA==
X-Gm-Message-State: ACgBeo2a3shSh+EzHWRBS5c3wthNLy+zGBgICD3GR8DcAPB3+HZHxTh8
        E5Mx7G6U61BeeroFszDtkoff7WlvlRc=
X-Google-Smtp-Source: AA6agR7adkaxBu631YqzGiiocOlb3Nadj8lEF5A9JYPeOv6CKFs5E19dp2pu3NDl4I+/oqsvRS+7Qg==
X-Received: by 2002:a17:902:7204:b0:172:663f:80b7 with SMTP id ba4-20020a170902720400b00172663f80b7mr18562921plb.115.1661809117990;
        Mon, 29 Aug 2022 14:38:37 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g16-20020aa79f10000000b0052d2cd99490sm7660753pfr.5.2022.08.29.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 14:38:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/3] format-patch --force-in-body-from
Date:   Mon, 29 Aug 2022 14:38:34 -0700
Message-Id: <20220829213837.13849-1-gitster@pobox.com>
X-Mailer: git-send-email 2.37.2-621-gd3a800faf0
In-Reply-To: <20220826213203.3258022-1-gitster@pobox.com>
References: <20220826213203.3258022-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users may be authoring and committing their commits under the same
e-mail address they use to send their patches from, in which case
they shouldn't need to use the in-body From: line in their outgoing
e-mails.  At the receiving end, "git am" will use the address on the
"From:" header of the incoming e-mail and all should be well.

Some mailing lists, however, mangle the From: address from what the
original sender had; in such an unfortunate situation, the user may
want to add the in-body "From:" header even for their own patch.

A new option `--force-in-body-from` from the command line of `git
format-patch`, and a new configuration variable `format.forceInBodyFrom`
that can be set per repository, are added to address this.

Changes since the original submission are

 * The configuration variable support is new.

 * comes with documentation updates.

 * "in-body" is spelled as such, not "inbody".

 * the order of config and option parsing plus initializing the
   rev_info structure dictates a separate variable to be used for
   the former two and then copied to rev_info later.

Junio C Hamano (3):
  pretty: separate out the logic to decide the use of in-body from
  format-patch: allow forcing the use of in-body From: header
  format-patch: learn format.forceInBodyFrom configuration variable

 Documentation/config/format.txt    |  4 ++++
 Documentation/git-format-patch.txt | 11 +++++++++
 builtin/log.c                      |  9 ++++++++
 pretty.c                           | 12 +++++++++-
 revision.h                         |  1 +
 t/t4014-format-patch.sh            | 37 ++++++++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 1 deletion(-)

-- 
2.37.2-621-gd3a800faf0
