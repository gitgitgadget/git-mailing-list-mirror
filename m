Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EAA71F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfAWU7W (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46376 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfAWU7V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so4077068wrt.13
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYYfdfiAcoCJF4U6QUWjDSmv01tdT3OgSmavxE5+B4Y=;
        b=q93LzjZk7oRWKdv41iM6fjtCFfOPwgokYbwD6mSywH2ucaYS3kw+aNrA1J6ypJR+Hr
         sIiJ4rIl8phFG6XevgHhhwhLv8mekYZv4QdeIrhdlBnDCvkqQ45QnFRSd9yMyPpucYlu
         9M8eOToHx/VJDsmkcgp6yHLnuSqFDJImkNZo/lCUtAD9Awp3xSnrLE4JRwba/HVmBCdg
         unhzfPlXXarhORd+wJwmGd7UkPJMFigFCcgMmiv9X7v0aGzijllEs/dZEVf5EyB9v3ej
         eW2fCU5yMeFH0NSGwx3KPLMfXvBRGV/pu8Q3OY7p7zq+kdnqrUbgcP7GftoVK2H8MHza
         YYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYYfdfiAcoCJF4U6QUWjDSmv01tdT3OgSmavxE5+B4Y=;
        b=M3Yq0me3y/srBH/dgD+WHVi+/EwQYqA7r5RTN30Fa4M8/cFOPpGOIO3jnHKk1SALqy
         GrRG50BNYQxcKQzM+1g6o4okFYyO44V4Y1tly+JaxnjdxqYoWpaLyaOH1anXgkMinew3
         XOMgo0IVPW8UYshMd+lUsjphhn9vMi18Vnd7rPif4DiIl8OYo0utaeZMf+bB7wegVKgz
         sFvZEeUbK7NccC03XQ9DlmCxdiYreTlhOxC6qfwov4RWBc9JQtjxAelYkspxCE64plBC
         cJyQy0cYu44u7eHQNw6hScXevR6tbmddUZwIq+XXBW0cyTGZQStKl3to9QfAnKhIWHY2
         TeCQ==
X-Gm-Message-State: AJcUukfyR6rNpZa3J9ojLS8BoYOV1hZqir/zkch9vaBIHCkHQ3QTUF9D
        e1kW9LFRSHZfdoeGet0W1ut98Nl1
X-Google-Smtp-Source: ALg8bN7LovKSsqc7lEadXJKsWgGDuO4xxkuE/hS5uoDvegxec/BjEM6o/BUcdSy/2KNtgQ7H5kDj7A==
X-Received: by 2002:adf:91a3:: with SMTP id 32mr3928977wri.99.1548277159464;
        Wed, 23 Jan 2019 12:59:19 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:18 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 01/16] sequencer: changes in parse_insn_buffer()
Date:   Wed, 23 Jan 2019 21:58:06 +0100
Message-Id: <20190123205821.27459-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123205821.27459-1-alban.gruin@gmail.com>
References: <20181229160413.19333-1-alban.gruin@gmail.com>
 <20190123205821.27459-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This clears the number of items of a todo_list before parsing it to
allow to parse the same list multiple times without issues.  As its
items are not dynamically allocated, or don’t need to allocate memory,
no additionnal memory management is required here.

Furthermore, if a line is invalid, the type of the corresponding
command is set to a garbage value, and its argument is defined properly.
This will allow to recreate the text of a todo list from its commands,
even if one of them is incorrect.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Unchanged since v4.

 sequencer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d726f77e11..a7afaf6882 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2091,6 +2091,8 @@ static int parse_insn_buffer(struct repository *r, char *buf,
 	char *p = buf, *next_p;
 	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
 
+	todo_list->current = todo_list->nr = 0;
+
 	for (i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
 
@@ -2104,7 +2106,10 @@ static int parse_insn_buffer(struct repository *r, char *buf,
 		if (parse_insn_line(r, item, p, eol)) {
 			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
-			item->command = TODO_NOOP;
+			item->command = TODO_COMMENT + 1;
+			item->arg = p;
+			item->arg_len = (int)(eol - p);
+			item->commit = NULL;
 		}
 
 		if (fixup_okay)
-- 
2.20.1

