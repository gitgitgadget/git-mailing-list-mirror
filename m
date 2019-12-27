Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59C3C2D0DB
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702B520CC7
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlnD54+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfL0Nru (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:50 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:38752 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfL0Nrq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:46 -0500
Received: by mail-qv1-f53.google.com with SMTP id t6so10071059qvs.5
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hRHf+1abQ65c730N4vO7z7hEQYAWv5vbK/6rNYgALsQ=;
        b=hlnD54+iYhWcfcKBMTkXNDN2qSNwHR/76sYROoOYQJ7vP9UARwU2W4m8gi4MKHJu7H
         Q27z45TblENnqJO1lkiAv0F7EoIphosSxc5tk05n5+Qf2CHs6ALCSihu8C8gJJSDzfv3
         ld1TaBtCsnrBCvKJyI+YR8d8mq674RnwJgoIsVciM0f+pHSrKIWaN3HPgjKNPiaAoguf
         f8+d0TER7GURpWvxCmYUyhauvZiK6fJX09wbFxoEUFFc3ChkHk2RwwtQr0xr+KaPJcNK
         2Nxji8ebL2P2QEAWA1lHTft81PyaZcOUzVD3809u/lQqouOwdjYnsyKT+x1PO6hSsrJ0
         ndug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRHf+1abQ65c730N4vO7z7hEQYAWv5vbK/6rNYgALsQ=;
        b=fjqXWBzYMgfaO70MY8G0yeb7KCIN9g8nl3OAlzhXM34ObXpyUmyvqGJmnV0K0Ealmn
         flPLpPM2yFSTQeofz4emG5aglfz8ww7EtzJCxPa8I04Q9c+9fuz2wCZonrM1NYtr9FUC
         PhqCFcvMqdL1+dITZbMo2dCiY8xFQXZrCmEIilsg5J5xe+WnfrQ0YBgm58DAjf8Nihoa
         ph1oFzctUSTgabOypv0CVzkwBpXzFDO8X8IzUW3D2SoTyJtrTwronfW5ocLaD8hoI/ty
         Yd1xQE77BaHJXR/nisXrYVNlMkX/eQ2w8BTAc8htMN/hREcGy8VRUTN/Iht/qua4qhbj
         J/eQ==
X-Gm-Message-State: APjAAAUhwLS9ecpKgAWyJekoapExHct3O+a8Wzmn+/i3z97GNDvziuOw
        iZvw1quLu0v9soIDzSQ3YI3kecTl
X-Google-Smtp-Source: APXvYqy/FBvHLWP9QrUnlYxcGGdcvz3dmSpqXADDhCzRzgK7QXqbJRJTAGRTZr6D/6VqrLgbBVlDOw==
X-Received: by 2002:ad4:4d50:: with SMTP id m16mr39964312qvm.186.1577454464916;
        Fri, 27 Dec 2019 05:47:44 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:44 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 11/16] t3419: stop losing return code of git command
Date:   Fri, 27 Dec 2019 08:47:20 -0500
Message-Id: <a47c218392c0e91d8faf6def0bbf1197f686af3f.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had an instance of a git command in a non-assignment command
substitution. Its return code was lost so we would not be able to detect
if the command failed for some reason. Since we were testing to make
sure the output of the command was empty, rewrite it in a more canonical
way.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3419-rebase-patch-id.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 49f548cdb9..94552669ae 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -80,7 +80,8 @@ do_tests () {
 		git commit -q -m "change big file again" &&
 		git checkout -q other^{} &&
 		git rebase master &&
-		test_must_fail test -n "$(git rev-list master...HEAD~)"
+		git rev-list master...HEAD~ >revs &&
+		test_must_be_empty revs
 	'
 
 	test_expect_success $pr 'do not drop patch' '
-- 
2.24.1.810.g65a2f617f4

