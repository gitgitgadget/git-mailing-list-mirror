Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0683BC352A1
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 14:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiK0Ovz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 09:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK0Ovx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 09:51:53 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30299FAE3
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 06:51:52 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b4so8198676pfb.9
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 06:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI4pjxpZ/4gX93Rdfsz03nhtqdNKssBQBmITP88Y+Fs=;
        b=qcfCQtlp44Q6K5A7Rbfoa/xnz7fv33hHWIckH+K5Mj0AH7ywGgCymZdsRjmOWzvdeh
         aIdHGuvEcgINkh3gUCWLhI2JtNepkuXfMb5fFhW+Pp+ElErEr/1LlNIVvEUkH7779OcT
         putcGKHJbrx+WLI2mjmhibTzBPBggatdwN9iBYhAC4kbJ/BCWJXXMfXkyy+ezib6DNEw
         bGPjmHoBQU8p9JjlF2Qi+cMYLzdSLXCH/3cijWVgBIaM99q4z/fa4M8xsvlUDBUiTrQe
         wTw1H27Bw/LlmR6gnt7+v71x3JF95eYeVknl2Pgi2LOai97Q9UF9SFEvgoUHVJP7R0YT
         vW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PI4pjxpZ/4gX93Rdfsz03nhtqdNKssBQBmITP88Y+Fs=;
        b=QC8y5TH/vV0lSUvKCbYAwacZC55673wfwmIIY8ynKnQLH94IAqCvrucAG7HnHAKv2k
         cCSXBA83J82n8ecNouAxUoieRU7kwknQ9ritw4SHMiJUUuX0zG2nsNBRotImBcbkDL6J
         M4C/50zELdV+BpXaVH2dwPT643Luvp0Rzh2MMcDecMS5Rxn14zEv1F+wlJljXpkfXD95
         VfoJ5riAO5gMWOLDHruUuWGFSGOqnmISiFyjv6sUB4pX82P3KngK5eybVJJlU+rvBd9b
         IxCUV4or32Q7ppWFliKCwutgnaesHrOuAy5aP9aB3NI9djoWHADlC+IJqozqaikLYoyA
         YVlQ==
X-Gm-Message-State: ANoB5pn51aLR6gANbrmASkktRVGyDO28as8ScnngKFM2vna1OoxBthk0
        pQFWO+/XFZFp6Qry5ddV4gBKB2be8Gs=
X-Google-Smtp-Source: AA0mqf7UKMPnh4DOgoxqsCg4mxjN/Sq1esRADHH0dYfPivXgWU4oWWNa1N7LJtrTczqZJzgsbeDiCg==
X-Received: by 2002:aa7:9882:0:b0:574:7931:98a3 with SMTP id r2-20020aa79882000000b00574793198a3mr18561546pfl.17.1669560711493;
        Sun, 27 Nov 2022 06:51:51 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a058800b002137d3da760sm7915050pji.39.2022.11.27.06.51.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Nov 2022 06:51:51 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v1 4/4] t1301: do not change $CWD in "shared=all" test case
Date:   Sun, 27 Nov 2022 22:51:30 +0800
Message-Id: <20221127145130.16155-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221127145130.16155-1-worldhello.net@gmail.com>
References: <20221127145130.16155-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

In test case "shared=all", the working directory is permanently changed
to the "sub" directory. This leads to a strange behavior that the
temporary repositories created by subsequent test cases are all in this
"sub" directory, such as "sub/new", "sub/child.git". If we bypass this
test case, all subsequent test cases will have different working
directory.

Since the test case "shared=all" and all subsequent will work properly
in the default test repository, we don't need to create and change to
the "sub" directory in the test case "shared=all".

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t1301-shared-repo.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 3ca91bf504..c4f2f72f6b 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -46,8 +46,6 @@ do
 done
 
 test_expect_success 'shared=all' '
-	mkdir sub &&
-	cd sub &&
 	git init --template= --shared=all &&
 	test 2 = $(git config core.sharedrepository)
 '
-- 
2.39.0.rc0

