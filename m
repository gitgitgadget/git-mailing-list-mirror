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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68E8C2BA17
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962FC20731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6eFVTZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgDDBMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36209 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgDDBMH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id l25so2129762qkk.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjRx+g8u7bV1eyg1BYwny79VL+Mmg3/NJGUxTvQfil0=;
        b=t6eFVTZOPShxzIkqwcwHwTC3tspZe33j4YZOQwyAIEaLDqFjSVcFId+m/OdRttP6Z1
         HPazLIAv41VjWpoIxPACqcSxhHPzkHZvG4SqzW9GRG+rx3nHQuzGteUD6cTrOqhq3W37
         tbvDYvShIvEL58naz/EMoDnbh++je+6HB6pq5jh45sq/w5uwUJ+oQ7oDjV24h1SJRdf9
         1ujC9eJFnhZvkew8n1N5zr17BgDxQ7WW3wniek7/Kp9KI6RaE8D47QglsstHHK6RfQXP
         9YR6TqnjrEgLO1q2L23pFWX2UphFZzb5oXf5N91+ZrhquWsL0+hWNriPKsuS5U/M/Ekj
         rP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjRx+g8u7bV1eyg1BYwny79VL+Mmg3/NJGUxTvQfil0=;
        b=ftHqIRRw8vVVzf6GFGeMwIskDpY87v7lP6i/1GkOdoAybnZOSOUC8HFyUtpw/X+hS/
         1RzKjWPcQtaRdmVq7cBGzPcj8NF9SJqO3zMJxHDxSWbQY+PX4GPPLXsxLyotXtA4R1bT
         YpiN8/2+vTgbMbl7TF+lBENI57Mxtbs48dVMQRsVHIHnkNf83M/ZjKbecTiyBev7MZrM
         t5NcR9TtSf7Kd9m8d/Vg3iglqp3KE0ztYSGdKihr3RNqAVGM4mu6rrmS6CY+93g4xcKe
         J1bnuWWCo2nM+cBxYK4rh8tDWbBUwQz8O3mJfNXwnI/pSttRpdGIFzaiVCdMwBvnPN6Q
         VaDg==
X-Gm-Message-State: AGi0PuYJ3xS/xeFnO2eVSe91bWa1E0gGSR4HtOd49bWgN126/3RRq5mP
        eD+Z5JC3ToVgGgbxT6kkcdK4Jg8Q
X-Google-Smtp-Source: APiQypK11peOSMnjGkm1cudNh2Pr1Zq5fxnqnU8RsW7CjFoRY/GJmsDhLpqtMQSS67SD2Kwfn5jFAg==
X-Received: by 2002:a37:b95:: with SMTP id 143mr4165028qkl.412.1585962726220;
        Fri, 03 Apr 2020 18:12:06 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:05 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 07/23] sequencer: configurably warn on non-existent files
Date:   Fri,  3 Apr 2020 21:11:20 -0400
Message-Id: <2e7922b259851091b9014c761d340ff1a73a04e4.1585962672.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on externing read_oneliner(). Future users of
read_oneliner() will want the ability to output warnings in the event
that the `path` doesn't exist. Introduce the
`READ_ONELINER_WARN_MISSING` flag which, if active, would issue a
warning when a file doesn't exist by skipping the `!file_exists()` check
and letting `strbuf_read_file()` handle that case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 6c26d61670..b771e8f4ca 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -420,6 +420,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
 }
 
 #define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
+#define READ_ONELINER_WARN_MISSING (1 << 1)
 
 /*
  * Resets a strbuf then reads a file that was presumably written by a shell
@@ -435,7 +436,8 @@ static int read_oneliner(struct strbuf *buf,
 {
 	strbuf_reset(buf);
 	if (strbuf_read_file(buf, path, 0) < 0) {
-		if (errno != ENOENT && errno != ENOTDIR)
+		if ((flags & READ_ONELINER_WARN_MISSING) ||
+				(errno != ENOENT && errno != ENOTDIR))
 			warning_errno(_("could not read '%s'"), path);
 		return 0;
 	}
-- 
2.26.0.159.g23e2136ad0

