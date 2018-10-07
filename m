Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143DE1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeJHDIt (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42494 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbeJHDIs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id g15-v6so15936611wru.9
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XvUG1Qp1UeDyWRLFMHRivt4EQ0EfCG3osOgL4zO3kUA=;
        b=DQJvAFacy45nT3www0jcxKrHMX03349p5WFGvo88F70Rev7rpqBnDKA2ijurDnKY1Q
         +YQev6oK4QSbJK+GYybJM5tJZHWL7hVzeb2FR1lcDt30iZJUv+jIkIGzDRgF+5r4lcSO
         MXjcs5I2a0ruOLytsWrQu3k9bX0xgnrPt/BvOxa5184thT6tuN1Ku4argEz347XwvdG7
         JcFZpp56Qntzl+CHC+7jNopK5j2QbiQpZjKhYmZlvyviZ6v+7CKjxX9r+8GaohSLXEa8
         1ZgrXsEJGJkN2ll67ozFCR8EhOt6qFys6YxExWyF09Qh39+XObh7euKjH/35o36C42fe
         3kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XvUG1Qp1UeDyWRLFMHRivt4EQ0EfCG3osOgL4zO3kUA=;
        b=S4c4gM/jq1T9U4OQWiUTrjKpmAhJ74nIlKQNFbParw7VWgeTqfT4UxOLUYiYdVePVY
         1gky5uhnrBfRHskyiBeafD8E5zCKsqN/7edazRj1v39d9SeSxnCOCsfHN35xUAm9HJi3
         u67F4J/7ca8pJOD8aoPb1u8gAuhi9F+y3AovKkVVOeVq25mHbmueu3gw386TvTqpwQS4
         Ty1k/KTnj+27Yju1j/ZVsll/kTevYbnIS1tcHgRQZmo0sjEJLgNQSqESojOgoMowRTMo
         P2AW4WdVisan0kNc9UaxBEzi+8BUuJfZfAcuredF8c4pH4/pk/DFcbc+G5ZEbdp2ETpk
         drOw==
X-Gm-Message-State: ABuFfohp3xDF+GHL9FYDJrp8Q+fFVpUxu9eVkmUHw8h6CM2mQqU+xzGr
        Cla8jAz/RWYMMzDFjsENhj13tKC8
X-Google-Smtp-Source: ACcGV62f8ENY+dWV5wBVOtCNOaLXwIsc3dVqobfbp3mTEwl42He0yJJoFDJfOyaZFBCHoGjs99cC9A==
X-Received: by 2002:adf:aa90:: with SMTP id h16-v6mr13572178wrc.216.1538942424045;
        Sun, 07 Oct 2018 13:00:24 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:23 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 14/15] sequencer: fix a call to error() in transform_todo_file()
Date:   Sun,  7 Oct 2018 21:54:17 +0200
Message-Id: <20181007195418.25752-15-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This replaces a call to error() by a call to error_errno() after writing
the content of the todo list to the disk in transform_todo_file().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 93b9b40f66..65bf251ba5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4421,7 +4421,7 @@ int sequencer_add_exec_commands(const char *commands)
 	int res;
 
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error(_("could not read '%s'."), todo_file);
+		return error_errno(_("could not read '%s'."), todo_file);
 
 	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
-- 
2.19.1

