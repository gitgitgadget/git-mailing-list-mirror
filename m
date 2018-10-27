Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C992F1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeJ1GMc (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46552 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbeJ1GMb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id i4-v6so4622210wrr.13
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHGdcqnr9zOxdtn3J0UauDXk0QNZ8e1z6SbkxzukjKk=;
        b=kFGh2wYMz516j/orrmcfoJfEYk3MnOnOConiifZhI/A7iKg7Kd6mZTUoGAbNDbsSj9
         4MPGrlOmy1KF2rC9sjohKkrB9yjeteyi6pIC/u/w+RQMf2J13A4ZT8eFb1R7fIbD/DQL
         zfvMa5b0Ey8Bya0nwqxqtOuHLAjgSNhUG06uS2Jr2UmG5pEdWxGIXRFogng6/+RzBI+Y
         qlXxzSB5CsdWjqlgfcMFdOSxNyQtSj4KyZP+RcClCeJwQ3OND2aJNz6yx7S6ds7ya8y3
         jYp/HK1swHWgYQow0g1n6Qgy1Fk3vlQXhgKbMmCilZUyqn7Uf39Q0sN3vANfSex35ew2
         Jgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHGdcqnr9zOxdtn3J0UauDXk0QNZ8e1z6SbkxzukjKk=;
        b=HUQE4qt5ulDS3EFdbuvS6MeLYMfOdegsw13TbO+Ahd/LK7VPx/ynivKTYwNr+xXTK1
         R+3cAI/444gw7IvHjNVod5wyXTXtLVk/TrFrFd0Yy3FSO1wCgxn3/2+TSgZ81aEmqmC9
         QE6uY/N+Ya5dn4MtQTHkAtIUj4j6P7kBtQgzarw7qMvBRfTFhtjBZDmpMnowlW0nbyBt
         Vwu3bGNPM/VkqH/whgdOOmH4AQ4G2uD+7+tB05krH92+Ukvjgnm9v9oOYF8FyC12mjR1
         NcpfBS+YpyV8TTKyd34yL9J+i55F5Rql5J2NdDUFN71yB9nwYDleoRRjtLM+8x6VWzca
         xYfQ==
X-Gm-Message-State: AGRZ1gIqyLdAfrajNDVXj1peSGLy+8DT0HZIa5326ZSCSHMCkHurntpA
        DqJdBgowQGM2hJna5TeIhM81zidg
X-Google-Smtp-Source: AJdET5cuAukef9KPgdS8r8DwFiuetMZGbsZuLdOlywh9zr76mrHkB9uEf5KjsFyw0fbRkyZWqajelg==
X-Received: by 2002:a5d:6b0f:: with SMTP id v15-v6mr9228973wrw.53.1540675811179;
        Sat, 27 Oct 2018 14:30:11 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:30:10 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 15/16] sequencer: fix a call to error() in transform_todo_file()
Date:   Sat, 27 Oct 2018 23:29:29 +0200
Message-Id: <20181027212930.9303-16-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
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
No changes since v1, was commit 14/15.

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 0763eeae25..3069d4c6a2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4351,7 +4351,7 @@ int transform_todo_file(unsigned flags)
 	int res;
 
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error(_("could not read '%s'."), todo_file);
+		return error_errno(_("could not read '%s'."), todo_file);
 
 	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
-- 
2.19.1

