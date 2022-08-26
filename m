Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ED3C0502C
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 21:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiHZVcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 17:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiHZVcH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 17:32:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA8491D05
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 14:32:04 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x26so2702467pfo.8
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=FNw1L/gC73W05YcUj50xnaw9Vb2ArJFNpfFuVl1Z+Wk=;
        b=U2u4bWhhbFjYUGLkiVCcNByvd0E6FjynRIw5PN5U0sUf464xGJ1Yh9K+dxVb4VlaLW
         dbEepjBdYGZgUyg7RRscK10WM1TH4yS3gV/vCcRKT7/455wsumtL0jsK+rEyQBVIgm/R
         iOkVgf10OXbExThHO56Sf8mnDTQXJTMniTMISVXSokq+1YCVqinJXJsLEHet7/TQO+K1
         cbjf/lpyxTdSH7F62ccrrWwXVa8wtoRZuYt5qMukesDKNgokxDRMczLt8y1ByBHACzUs
         hNlh08jRR+KcQK3jFBCpJHe/hDX+WsW+jS68Yuv8kIwYacjcHpHHH2RG9XHRIlTluQLk
         PGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=FNw1L/gC73W05YcUj50xnaw9Vb2ArJFNpfFuVl1Z+Wk=;
        b=hfFoD80cdKBSkU6FpD6N5FCwAGwGYrOqCqAFE7VRjt4h/j5I8pdXWbYRl7PGcDTjJq
         AMhyDVfeFhyTD8uN5mE8BiahPGKY4qOBU1+s02X8ZQ5MLrL1/3PwKVDHTmnX/HjVObIZ
         fgIb8bXR+QSBj/xY1jc/e3D/vipF0zJm0BsjN49okZ1VdKBqRcY+E93dQDgpbRPFYpTr
         7hfOyNih2KpoZXeG0Q0wSbRzaZgoFaAEUcmnXPqt25OLKK7VmqqPxHIO0UQsesLgXO4Y
         jL6DNd7eXwRYOl92LP+tmk1qRRhx6MBURJbzLHqltJgsW1lupuau6URZHKtAzkEEN390
         YU9A==
X-Gm-Message-State: ACgBeo06SwFXV8F3akbVrMPoibAoxS/m4wjF16qWkOagKbXBPSB08yDf
        YD5PH279nVc50jjqJ11Fob/PxnUAGcI=
X-Google-Smtp-Source: AA6agR7oaYluLtlTSOFuqLpMOf3O8g+64aQkHNCR814vvfaNtkZkqgE/Nnt4GVt31on4QG/fOYGUmg==
X-Received: by 2002:a65:6047:0:b0:42b:313e:d331 with SMTP id a7-20020a656047000000b0042b313ed331mr4824238pgp.179.1661549524128;
        Fri, 26 Aug 2022 14:32:04 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902e84400b0017336c3a585sm2073691plg.233.2022.08.26.14.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 14:32:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 0/2] format-patch --force-inbody-from
Date:   Fri, 26 Aug 2022 14:32:01 -0700
Message-Id: <20220826213203.3258022-1-gitster@pobox.com>
X-Mailer: git-send-email 2.37.2-587-g47adba97a9
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

The two-patch series may help such users.

 * The first one introduces a small helper to separate the logic
   that decides when in-body From: is used.

 * The second one adds a minimum support with a new test.

Junio C Hamano (2):
  pretty: separate out the logic to decide the use of in-body from
  format-patch: allow forcing the use of in-body From: header

 builtin/log.c           |  2 ++
 pretty.c                | 13 ++++++++++++-
 revision.h              |  1 +
 t/t4014-format-patch.sh | 13 +++++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.37.2-587-g47adba97a9

