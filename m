Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC9CC43331
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F292520787
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fte+Ytpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgDDBMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37215 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDDBMF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id z24so8180183qtu.4
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vJr4H9HQe+8dSCv9+aReBNKxwXXTrkp3NkLOLbdsidw=;
        b=Fte+YtpgkJ4scvpu/A0NAa8OIhfCj7INHCrhdwdbwm5bpvlzSG1Zwd/decAfvphCHu
         nNSnIOozJPGCQ7bS5xGu+AqxXCdOqbkVu7ooSTwNbstXoot9fBt6OSUjSfVyZVaFhQYW
         7i4VHC7jDzCZzwJeI5QEdMYIi/V4DKuFIG7GJfvmWhLBiya80lQEaFBdLNHTOdOA26ac
         aVbbwVL6PdLtCPxnxboh/uRCk4vSCBxX5M4nQspmgUG636cB1Wv0E7PzFesi53rY/iKd
         y8q7RXYd60knzQAd+Mqu7fj8dwvLrmMZI96FVe4HgX5IIqBr8Z9eA7NZs5hv/D+gAn6H
         E3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJr4H9HQe+8dSCv9+aReBNKxwXXTrkp3NkLOLbdsidw=;
        b=h7IWRhgLjrFVA6HhWWt50fo5U4IG6gi+5bZ6B0Wq9KzsKxCMviY+Ar9pok4TgBFJnt
         fwuXEQOMpfuXuOXRr1rddSXip8vxUfztmOTopgf7FCFDLNYT80vTAvSs9sIkxQdgth4A
         K7Kqg+3ho2tW8o6SIm6exBBonyczNKcZMmCeOxoe7XOJ2KDaK9A+t6USkWo6uC0B+/Lw
         XqJ0nb2UEFeqTm8jZ0NgY4mEmxvCsGdcFR0o3NbH2tIGwIaJfXoUOSC6Tc8hj1FLh+0Q
         BoHxZdM5J+CbDzhohcTcJ5D56IhmaUxnZD2VH9DlJlM+yHK55S9BhFcpc7OfvxVDP86D
         zdww==
X-Gm-Message-State: AGi0PubF+iZtH4tZZ2D1s7CzK1cz3Tdp9cR9IEM7Aq7O7w1stdnke85L
        yllMsFOxN85SoMDCK8aBHFbrp+9X
X-Google-Smtp-Source: APiQypLPvZ2403XO3B2b6RE5FsttTbZtZokzYdoZeBOie/IxwFNG/Oa1DQmrYKXGyLjU72+w3fAH6w==
X-Received: by 2002:aed:34a3:: with SMTP id x32mr11284527qtd.306.1585962724144;
        Fri, 03 Apr 2020 18:12:04 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:03 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 05/23] sequencer: make file exists check more efficient
Date:   Fri,  3 Apr 2020 21:11:18 -0400
Message-Id: <58da8e95558d5d345030db51200962dde71522f1.1585962672.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently check whether a file exists and return early before reading
the file. Instead of accessing the file twice, always read the file and
check `errno` to see if the file doesn't exist.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 09ca68f540..6e63224c41 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -431,13 +431,10 @@ static int write_message(const void *buf, size_t len, const char *filename,
 static int read_oneliner(struct strbuf *buf,
 	const char *path, int skip_if_empty)
 {
-
-	if (!file_exists(path))
-		return 0;
-
 	strbuf_reset(buf);
 	if (strbuf_read_file(buf, path, 0) < 0) {
-		warning_errno(_("could not read '%s'"), path);
+		if (errno != ENOENT && errno != ENOTDIR)
+			warning_errno(_("could not read '%s'"), path);
 		return 0;
 	}
 
-- 
2.26.0.159.g23e2136ad0

