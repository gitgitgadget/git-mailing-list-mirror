Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30091F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeKIRsO (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43846 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeKIRsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id y3-v6so863897wrh.10
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ko+JIfODrwOH6Y3rguKFF557JlHaXRaiipOgQrkwZ2k=;
        b=XDnkvvnH7v73fKiWo0Or0B0U1ht2/oalBSaKIeDFZzb0zecS8BeRNXdzFpwUXQ1pQW
         6jW9iX0kEuBDZeUYOlt+mhtwHkOo1V5mSZ76GZqYhtajSatY72RfmQdI8R9SufXomn1e
         lZ6VdG8vxBhd7H2MkYLMQBx63c+VDZDDTLarQZKWaF8IfpRqRLosjgIb3N5S2/1ph7rP
         4zIBRoKF3F7JDieHfYpNsw/YdsusmgC/311s6ZV39WK0fSYfkT2wdU1tLXsACaHfOEOI
         OFVa4EiH4+w9P4taDYAGBOMKLXnsKeS7NKD/4MZ4F8MyZXGrRFDF/ME9nL8WRCCKfhua
         R07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ko+JIfODrwOH6Y3rguKFF557JlHaXRaiipOgQrkwZ2k=;
        b=VFMYo7nbyxoAnubT8WVz1vwtfIakochSoHmTzm/jchHwipocGt4wo2YbPGAR1Qla4H
         Hbyxt3Z1z2eeyXIIi2hYY/eRHlgxW9UWE902gEmXTZqO8U97WX5rpCAnbXkVRznpDuRu
         14pKfn0SHnrzdld/q65McAy4635dlXGlLvNZpYUCLsjBmjyCFx5HhYDqq5cv9esUzGUX
         tj/KpmXmoPbucDMTmPfz8yTr/loe4XlWFa4phC15lDAepQ7wvHrpz1q0nrK1h4owXTir
         d8ZVeqqVeTSoenRYcPnj/rm7DG3pqTr7pWaf/xWpfW0MN3q/yu29ESIeeIoQ9u8T6LyD
         U80w==
X-Gm-Message-State: AGRZ1gJ2mrAeDOVjMe1HN/XuUb4wOQ5AqiZIrb1hGzKeL6ouJ+qPk50e
        llkt3jNXUOG1R4m9wxqU7Eqyh2R+
X-Google-Smtp-Source: AJdET5fohzQ8U8oOiIGMZDQVtHt14HTESn+lpJbtMSGbRwwHlOutEN2lQiqzTzpLrBRmE1iFstEGtA==
X-Received: by 2002:a05:6000:151:: with SMTP id r17mr6639927wrx.53.1541750926804;
        Fri, 09 Nov 2018 00:08:46 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:46 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 14/16] sequencer: use edit_todo_list() in complete_action()
Date:   Fri,  9 Nov 2018 09:08:03 +0100
Message-Id: <20181109080805.6350-15-alban.gruin@gmail.com>
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

This changes complete_action() to use edit_todo_list(), now that it can
handle the initial edit of the todo list.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f04b002e37..02afd2f5cd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4654,6 +4654,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf;
 	struct object_id oid;
+	int res;
 
 	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
@@ -4679,24 +4680,15 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return error(_("nothing to do"));
 	}
 
-	if (todo_list_write_to_file(todo_list, todo_file,
-				    shortrevisions, shortonto, -1,
-				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
-		return error_errno(_("could not write '%s'"), todo_file);
-
-	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
-		return error(_("could not copy '%s' to '%s'."), todo_file,
-			     rebase_path_todo_backup());
-
-	if (launch_sequence_editor(todo_file, &new_todo.buf, NULL)) {
+	res = edit_todo_list(todo_list, &new_todo, shortrevisions, shortonto, flags);
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
2.19.1.872.ga867da739e

