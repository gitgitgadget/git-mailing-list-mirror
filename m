Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D74AC3F68F
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 19:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AFD2467A
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 19:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdq/+Kqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfLOToR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 14:44:17 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36757 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfLOToQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 14:44:16 -0500
Received: by mail-wr1-f43.google.com with SMTP id z3so4675577wru.3
        for <git@vger.kernel.org>; Sun, 15 Dec 2019 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8lZ+iV3HHC3oOGgxqbO/IpfvRogpJS9rILNP24mk+ZY=;
        b=vdq/+Kqxkw4ZZ0F+HUl1BlNSMtc0N0aSsbaNo7Ln1eYIt4QPlb6/4x4KO5MObCTUBd
         pAxHxkheUUKPG0nO4cBiQWrOnFd6hCW7r75NV8AVqQwojzOb3OJl4hIl09Tq30FlumKD
         7k5KSKdXDfaj3GW/VO6Qb/25J5tEk1F7WJBrWskXp4uPHbNDhvLZnfIgULP6sN/F+8i3
         lDj2Jrn58pHUGpWD1EdkuTePf1zARcnpQ4q0Cp5zcuyMN7aiaZqbcOHEBlnCuvGEiFZ7
         N4aiDw2rCEgU7zmC0BsxrRAo/Fa0E3AsYA/IvDGgzFs8Aa450nA2b7nbnrdND8GbOXh1
         P70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8lZ+iV3HHC3oOGgxqbO/IpfvRogpJS9rILNP24mk+ZY=;
        b=GHZcYAzuFvmVTVTONDqCRZgddyhdfDd8MKhs9ihaSVyY54Vz8pJgMaJMpUGwpwa/M+
         +rm4Pkn7nDpQV+cgh3GJSKqrAjTptiawpm3NxkRBbg1JlQRPeg0xFiilj/4v4rKhgNQd
         nY5LVq1gNqFGvEgVoxLEcVyJkQVOu5X3iqM42Js+wnPG+h2lDD/WIobxGQ9X9Q0ofK+E
         2oMd05lhzFqwN6JMKjb2r7S4thl7kxEHlL1aibtE4rb71ElMpyPz6Xwwz4FGVHh90Pcq
         rSMvS45IsAr9otOkzjQ1VBHg8KDdgNh+hEfLsU94fAz2ljDvo2pJtYYixRwSoOQtC4V8
         +R7A==
X-Gm-Message-State: APjAAAUv7i/01JjVT2GMhNBsfjYg85Z+qQBAfC8/4sqrApZbSMcH10c0
        776B501XomvifwRgjzP56vDCm3cH
X-Google-Smtp-Source: APXvYqxEk15gO5x3eVn0B1MRT23uKa6Rmc935wFzawCJe4DFrU14daDo+HSlxCnat6pxkGEioQ3GSQ==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr25537558wrp.292.1576439054827;
        Sun, 15 Dec 2019 11:44:14 -0800 (PST)
Received: from localhost (p200300DF4F2B29E5D9755E3431C6BEA2.dip0.t-ipconnect.de. [2003:df:4f2b:29e5:d975:5e34:31c6:bea2])
        by smtp.gmail.com with ESMTPSA id u14sm18975350wrm.51.2019.12.15.11.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2019 11:44:14 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: Reword generation numbers
Date:   Sun, 15 Dec 2019 20:44:12 +0100
Message-Id: <20191215194412.7549-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817
In-Reply-To: <2099929548.270607.1576431348524@ox.hosteurope.de>
References: <2099929548.270607.1576431348524@ox.hosteurope.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Braun <thomas.braun@virtuell-zuhause.de>

The english term generation is here not used in the sense of "to
generate" but in the sense of "generations of beings".

This corrects the initial translation from cf4c0c25 (l10n: update German
translation, 2018-12-06).

Fixed-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Thank you. The change looks good to me. I'll send a pull request
with this patch to the German translation repo at Github.

 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 066326a687..773e361f6f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1535,7 +1535,7 @@ msgstr "Lösche Commit-Markierungen in Commit-Graph"
 
 #: commit-graph.c:1104
 msgid "Computing commit graph generation numbers"
-msgstr "Commit-Graph Generierungsnummern berechnen"
+msgstr "Commit-Graph Generationsnummern berechnen"
 
 #: commit-graph.c:1179
 #, c-format
-- 
2.24.1.735.g03f4e72817

