Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6720D1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeKIRsP (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45344 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeKIRsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id k15-v6so856037wre.12
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ubnYXsEm/3EoussvQPLFrHRPodUXdckn5TZhTTJOqjY=;
        b=KOQYpjRneuPtpYOi3whjXu2jMr3Bym9M0qb987ksOOaQOdCLptuLFdxfm4pWgefeTQ
         cIyPcmeIuWKW4lMiTUn4C1Z2i4Pc/HzJj1kfgzF+HXfrWhSUmdUEjTnODM2mECm7FAYe
         i24T6/b8E39nL2fKWgC183kP0pjTybWIQcP7uK1/Mteawc6XHmAMSg2Bpvrsx/2bUmOf
         TlGy3i1dt8SqkDfTthpxuDAQ1zr6NBBXjmEIKBIdgnOR6Z7adH+0JPaq6tSB1NJlGwNH
         kdjUnp/NmnxNa6ZI9dBf38RxJTq8ktM2+ZQ2iNYKY1d+PtyNqokF9IenzWkQTJXPADhX
         BhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubnYXsEm/3EoussvQPLFrHRPodUXdckn5TZhTTJOqjY=;
        b=cM+39AiZvfYxpBezBuedqDiQuej7DkUezXDqQGr+9nejTaGnCnFoY/8QBog9+cSAfX
         HmgglSk22yY1OoHclrBhR1vK/FvS7qhApOMpCI8uD5ouaydi8xkmdG/pWZvQappjfytC
         0wcSpggQJjnz9OGwbfwItvb52gr6aHBiEuWLPNT4ZGOk7rriNjxEgJv1r9keB1Jj+KN4
         AKg7NorvOioru46rBN3AZUDPhkpzZvs9gAiuSjwX9bvwDhvJhtK3z7yx6iYvFOlVvSAC
         zdtapYwFGM62tPyMO3zbbn5GIS+iJYK+/PyVt9bWk/qDUt5N0ZB1r5YMVIR8BR4N0Jje
         NMRw==
X-Gm-Message-State: AGRZ1gKLLrLw/DDJ1maDXMu1WA3/AaSyYaXnGwUOD/4UyhZo1z3LwYhv
        XEVnpVuAnIdQUUR2X0j2V6NfJXGD
X-Google-Smtp-Source: AJdET5dhm2RkvvuK6E4AuIASq7y8anWc2ArlWGpiNpowAa/G43eURVfQyVQWcM6GtDEJVV4NSmCeog==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13-v6mr6901229wrt.298.1541750928069;
        Fri, 09 Nov 2018 00:08:48 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:47 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 15/16] sequencer: fix a call to error() in transform_todo_file()
Date:   Fri,  9 Nov 2018 09:08:04 +0100
Message-Id: <20181109080805.6350-16-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
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
No changes since v2.

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 02afd2f5cd..a55df3526f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4464,7 +4464,7 @@ int sequencer_add_exec_commands(struct string_list *commands)
 	int res;
 
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error(_("could not read '%s'."), todo_file);
+		return error_errno(_("could not read '%s'."), todo_file);
 
 	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
-- 
2.19.1.872.ga867da739e

