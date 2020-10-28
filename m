Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFBAC388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2EC2246CD
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK1L3J4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJ1Voc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgJ1Voa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:44:30 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC89BC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:44:29 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n15so518634otl.8
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZLHrZn3wqO8aKNK7DfXXL9LqsubEiDp+vV6x+I0qCU=;
        b=nK1L3J4Ldp8aU1JPrIiPMe8ihHIbgYjwrRMw6P0qqqg+3qy548AF1LpqPrcfXZxNZ2
         fwpLJJzOnxryHSnenTTL9G3THXuMz1GJTPdFq7haZLYqnocrKhjJaYHmCe2WiPGQfJ7+
         j3r1869XjaowN9jWTki1HmYRmO2MYVp/lvtNwfU0jregElBrVm5OFEkbVlEawMAWXJlT
         ALOxFRnCHM14GIUQHgWP3m/Abyqkl81XFBHVTiq4hYWNKg5Xa/Orb/9uHjZgVsrpHrqb
         GFkDxXtfFHMNhCOjx4ALB3wSyaIAuEzCpCWQPRBiqyApFWYy2tDnLuybRCj8KJPzoYmp
         lUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZLHrZn3wqO8aKNK7DfXXL9LqsubEiDp+vV6x+I0qCU=;
        b=KabsLrr1d4uC+W5BFtVxdh5MYBLiGb/bfUWndspTM5h4uxgzP0g21ajsVHPwqpY3L2
         CwTAEUckB+Zqbn7Dq9A0Lnw+rl+TUfhcS4zMrriVWhYzI694RTSUAm/xIVlo0Kl98/fa
         GBMNus358gCpbAS6OfnuNmsmmAm0E/J3o7OL1+EJiWOaeE7cS6wk6LxQMuCFLl+6Uapc
         q5Cgg1zBmB/Qxqq/2eTjvFYDipkx92+ErorzizuFDfxIaM2evdnwmgiz+kB+MFAMBPSI
         qDbDGvPpwio8pco+yDIhU7H0X8txBVBcLQnulAkuEMECTgXeOGTfZDbmgO2wPp6aClzE
         FIWQ==
X-Gm-Message-State: AOAM533ev/tmUNkX+oJC4kD9vd04i34Qq+bEFB7OeUp9CkiJ0SA7VGIG
        32Riqzxe+Kk3sA+vYv8C9mPU+pAgyZpviw==
X-Google-Smtp-Source: ABdhPJwqtKaL20WfPzOiHkL8F1rmj4TLqWAAYQbzjC/1BpgW8q+U2lTSAgOB/chti7sq+JeqS9MwKA==
X-Received: by 2002:a05:6830:2434:: with SMTP id k20mr3434075ots.205.1603850855683;
        Tue, 27 Oct 2020 19:07:35 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 81sm1840156oti.79.2020.10.27.19.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 13/29] completion: zsh: add missing direct_append
Date:   Tue, 27 Oct 2020 20:06:56 -0600
Message-Id: <20201028020712.442623-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 688077910b forgot to add the corresponding zsh function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index b894cb52db..c5b875993f 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -105,6 +105,11 @@ __gitcomp_direct ()
 	compadd -Q -- ${${=1}% } && _ret=0
 }
 
+__gitcomp_direct_append ()
+{
+	__gitcomp_direct "$@"
+}
+
 __gitcomp_nl ()
 {
 	emulate -L zsh
-- 
2.29.1

