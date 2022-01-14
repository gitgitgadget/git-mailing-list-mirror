Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B18C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 03:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbiANDdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 22:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiANDdk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 22:33:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FCBC061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 19:33:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q185-20020a25d9c2000000b00611ae9c8773so11950589ybg.18
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 19:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to;
        bh=xqrkK3Ts702sys6jjEWWvN+/STzWu4CAqmk5MehVeaA=;
        b=Fp4DrC5A1ewPOJmvB38TDGcTLL1CK7MRQ3WZcXr8y31clxQI/1Qw9DusceHLi0bMDs
         C1nmcCXgyetGoyz88oKFaOJoYyHnuvPEF3DbTTSXxTGY5G/W5kE8FL+mHJPDHdp8AxR7
         Got5oz1Bi6acoaJ+B+Fawe+bOoIOpt+1jVvyZURna0wmq0U+9yO6DSHh76pdAFhM3C5R
         lBo3X8l3NUR8RCHOuDZtJzZgLWMmj0go5x6oZvCiRXhRzsOzsIJcEHspu39S++2tMa5+
         hOENsSsJL0/9Dh+yOFqV7Tv7a0Lurlx6YT1/nXbWHScP7PSmhQyjqxhR1lpbBaWwFtjc
         5HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=xqrkK3Ts702sys6jjEWWvN+/STzWu4CAqmk5MehVeaA=;
        b=klnXsvoeucSmoqLcBCI/CDOOO2RZ9EA2WviBdD+YQ3niXQNCSD2HOe/41MXTVyXbnu
         fb6mueBtk6F7T/gFPXWbCczoK/0XoaIbvJKJI9mnmwO7J/J0yxvONcjWQ2+Pqgl9upzb
         KmR4GwYf9/lMKaPtuzSO7aEUMTCONKrAHeLdUoY/n0Wdk8J5s/VF+dZXuLfpCZEP4eDe
         nZEO7bHvupGtf0bOHWPOHMYmuDYuQzvuq8CE3Ot70b5xZE/RpCkb/uwi4AUExK+6wTst
         2R3JZiGZ8AStuixU5HDP3kogwqWYczLBi3SGs7jb16QhuOClWxIsQFaC+hiaI1cpl9pf
         ttJA==
X-Gm-Message-State: AOAM530IiKU9sPCAEobBXRTFPrJRpYX99mefT+j0yn1MZ9N4oNolYxY/
        HOy+Zce8o7d3VZDVQSX+bRIeLz5dppcfP940O9YGTOdMJC0O+NSpjxwDBjitUylzlTZLPrhf3iG
        DnzidvxxX1ixft6EVoWsw48Mq5e3b1emF473Q59F+iLEOZhKH4ie5Lh12vg12I3Y=
X-Google-Smtp-Source: ABdhPJzcCUVeW6jUtFB7/CJgTRXmSns2+XVt69YHswRzQQ3+6egUBPnIGqucHH0QFG8am2fSABpXQDDSY4c4qw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:d145:5bc6:f3c2:cb74])
 (user=steadmon job=sendgmr) by 2002:a25:ba4c:: with SMTP id
 z12mr10823634ybj.136.1642131219119; Thu, 13 Jan 2022 19:33:39 -0800 (PST)
Date:   Thu, 13 Jan 2022 19:33:36 -0800
Message-Id: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] test-lib: unset trace2 parent envvars
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The trace2 subsystem can inherit certain information from parent
processes via environment variables; e.g., the parent command name and
session ID. This allows trace2 to note when a command is the child
process of another Git process, and to adjust various pieces of output
accordingly.

This behavior breaks certain tests that examine trace2 output when the
tests run as a child of another git process, such as in `git rebase -x
"make test"`.

While we could fix this by unsetting the relevant variables in the
affected tests (currently t0210, t0211, t0212, and t6421), this would
leave other tests vulnerable to similar breakage if new test cases are
added which inspect trace2 output. So fix this in general by unsetting
GIT_TRACE2_PARENT_NAME and GIT_TRACE2_PARENT_SID in test-lib.sh.

Reported-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/test-lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0f7a137c7d..e4716b0b86 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -449,6 +449,8 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 unset XDG_CACHE_HOME
 unset XDG_CONFIG_HOME
 unset GITPERLLIB
+unset GIT_TRACE2_PARENT_NAME
+unset GIT_TRACE2_PARENT_SID
 TEST_AUTHOR_LOCALNAME=author
 TEST_AUTHOR_DOMAIN=example.com
 GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}

base-commit: dcc0cd074f0c639a0df20461a301af6d45bd582e
-- 
2.34.1.703.g22d0c6ccf7-goog

