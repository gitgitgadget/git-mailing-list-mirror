Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326AA1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbeJ1GMb (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36881 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbeJ1GMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id g9-v6so4667650wrq.4
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkLQIlxbYOmzOXiqw2TYR990BYzjLe+X1gdiMoGGy0g=;
        b=BozxwVFsYugijPldUEyIP3aWIHqHUnNOqhWO/dIhdC09QLfiTzV6mrMfEQXVyCUrL2
         1aJ/p7GP5AQ/A4BIEz8BBC5TQZovs2+yYRPq7mP3Lyo6QFVppXUn9S/oajkZXJW6ykFu
         geujmE2/Z1UiW59BYA+6QR3YEre1tfkYn6hSuvO99qXZcOxefpFFMhwy7upPfVgqZAMZ
         KE4tmHi0QReiD0NAcH0vJMVKWTupOKJG05Mhjv8O8bWO3wt7QWMtcocgmCEsmDB1vhti
         QFhVEDwSiUM6RDEp836T0FH4hIfhtv2NG9TmIG3ZhV8l6tbCCc7BoFMqfP9Q7L4cZldZ
         VaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkLQIlxbYOmzOXiqw2TYR990BYzjLe+X1gdiMoGGy0g=;
        b=UD85BBdRlkC4BRmfq876be/vFJWgUVrK1P67T8yX+hIBu848x10HGLd2Zv8B8DFCWH
         Wn49+5ChlfimdLzsZS/lkZiv6IyDF+gV8rm2gI40y0E0+zFGJe1g8Vxk0shOQZABISfn
         1WiTVPFg9p1FAeUQcDg/mB/eglgPAk1OMwR1xTz13qkhTFZKElFCM5oQg2s3gpCKlPKa
         gb2ODuvgHcQg9UDLC1PF6zxHNNi9p3WSvtnAVG4oDk5ODGYyLtmFc3z19wJAC4ZHFruO
         sSlPWW3W5uLWQX68kGQbD0Vzdgw1tf40teyGfNmqkMt6/pNly2IH8CWOv6GzTWn5RYOf
         ZBrQ==
X-Gm-Message-State: AGRZ1gJR8Zekwii549eQ8hzDXqCBW2TQs8wiH50HL9NhCK1kenG5SCa9
        HMpwrrK1BVI5wPJlCLsPOAb9Xs6R
X-Google-Smtp-Source: AJdET5e3cePGK/mURbqrr/3N+CvC2NvMzIaceC7OOVYwp9sgkR7r1DybtqxLU7wqNbPMZ3QbXDhrPQ==
X-Received: by 2002:adf:db0f:: with SMTP id s15-v6mr9402591wri.129.1540675810062;
        Sat, 27 Oct 2018 14:30:10 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:30:09 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 14/16] sequencer: use edit_todo_list() in complete_action()
Date:   Sat, 27 Oct 2018 23:29:28 +0200
Message-Id: <20181027212930.9303-15-alban.gruin@gmail.com>
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

This changes complete_action() to use edit_todo_list(), now that it can
handle the initial edit of the todo list.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a03505f582..0763eeae25 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4457,7 +4457,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf;
 	struct object_id oid;
-	int command_count;
+	int command_count, res;
 
 	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
@@ -4484,24 +4484,16 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return error(_("nothing to do"));
 	}
 
-	if (todo_list_write_to_file(todo_list, todo_file,
-				    shortrevisions, shortonto, command_count,
-				    1, -1, flags | TODO_LIST_SHORTEN_IDS))
-		return error_errno(_("could not write '%s'"), todo_file);
-
-	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
-		return error(_("could not copy '%s' to '%s'."), todo_file,
-			     rebase_path_todo_backup());
-
-	if (launch_sequence_editor(todo_file, &new_todo.buf, NULL)) {
+	res = edit_todo_list(todo_list, &new_todo, flags,
+			     command_count, shortrevisions, shortonto);
+	if (res == -1)
+		return -1;
+	else if (res == -2) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
 
 		return -1;
-	}
-
-	strbuf_stripspace(&new_todo.buf, 1);
-	if (new_todo.buf.len == 0) {
+	} else if (res == -3) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
 		todo_list_release(&new_todo);
-- 
2.19.1

