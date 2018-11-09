Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF1C1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeKIRr6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:47:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37994 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeKIRr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:47:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id f2-v6so1076555wme.3
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaRItsr0/AQnDuDwZ2VKpF1bK7lMEDMF6L9h5lxR2nI=;
        b=pz8BeTN1m5XVnk8BdqogvVdaAhNMa5lmwuRDFuunnVwpzY5AwumPIjX7T4RDxYw0VJ
         ga+/e139S53JxfVd8EfW0e/aU2Z0xcw1TYd2KRpDUbJBwx1/z7eVeigTxeGbqil5i0Cw
         GjJDLL+e1YIDoljvBrFrkP9U687i1FqvqNKUQKrRrwWWYS6o2pylVlsfQMhlEbfkKtHO
         QZn2Fhjp4RLwaSX5xBVR7JdyN8rHDbczooCwCAd906Tm0Qp+PP1SlWTN5Kb1K1knA80a
         USjEmuKLW3pr6xX+JA4IqXBLxN36jM1jEGTYdytFbZTbDaT4MmLrsuvuhkDNx41Zs6jL
         Z+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaRItsr0/AQnDuDwZ2VKpF1bK7lMEDMF6L9h5lxR2nI=;
        b=fG26iUZ87dLLXcTRtJBbGXkWz6WLlCGJuyWucB7gjQ4gsaCixHN11JSLsJsQQkiQ3Q
         +DeHDp7SRM0ATmR+Q1SAfX+HDODBmQpdArLqc86qyfXa3ZSLFDvCiGPvb+NlMUn1JHa/
         jYxIR68tnti1lZL8D1gk8gVCa1LxPtPCI5MRMey6Jm3efwrF1COl64lpAMRLSiZWix8v
         fpgpfQwHUYzkmWuIxBmclCPqr3CEDDbDbfcGF3tO/ELoxsQgEltipWbTraAYY87QhPke
         kTY+bRYI1IOiadKRLPff/nIvkftWQEvTFfGBEJCAZT/7Tajv/HN2HaeXxkHzeTAJwcuD
         FDDg==
X-Gm-Message-State: AGRZ1gLqaifg6szk1OOcXPxy+b/9hWvTYY+cXniEuChlBtyf4TVizJKm
        fjFv5ABx8zAQvlNbonB026AGVu2E
X-Google-Smtp-Source: AJdET5ddSmQEfATCqJ2Hee6OdulY0J9C02piqR1dlpe8ecPe4/Q8+CwuSHCdH7lEZVwF9TxoC0Y9WQ==
X-Received: by 2002:a1c:b513:: with SMTP id e19-v6mr3704008wmf.114.1541750911208;
        Fri, 09 Nov 2018 00:08:31 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:30 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 01/16] sequencer: changes in parse_insn_buffer()
Date:   Fri,  9 Nov 2018 09:07:50 +0100
Message-Id: <20181109080805.6350-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
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
No changes since v2.

 sequencer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 9e1ab3a2a7..07cc91d8db 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2066,6 +2066,8 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 	char *p = buf, *next_p;
 	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
 
+	todo_list->current = todo_list->nr = 0;
+
 	for (i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
 
@@ -2079,7 +2081,10 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 		if (parse_insn_line(item, p, eol)) {
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
2.19.1.872.ga867da739e

