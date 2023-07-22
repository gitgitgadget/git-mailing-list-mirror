Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B931DC001DC
	for <git@archiver.kernel.org>; Sat, 22 Jul 2023 21:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjGVV3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jul 2023 17:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGVV3N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2023 17:29:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E110D9
        for <git@vger.kernel.org>; Sat, 22 Jul 2023 14:29:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6689430d803so1848027b3a.0
        for <git@vger.kernel.org>; Sat, 22 Jul 2023 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690061352; x=1690666152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98zH7dMkI9Q+24mjorRXD83QnZC5AB71KgfogyqOgXQ=;
        b=JEkzHY3pUbQoouJb9AVNCvQsrxLn/Xacx4Y0W4/VgFEARfVUMOUY4c/K43v1+3SI/3
         OLNQLJWnKk0JGbsvtu4KfzrWs3MP7r8QThkIFfOQ3nSWjwD61hwTW9+H2C610XQfZfZU
         NzMhaCdsB2IXlwh/NDY7Hxz2oucu6zcoBBvRXMlfPgrUcQDGMOQOq/MYWsKjrYwiGuXa
         JQ747SgUW9vQEcBKzGHZvoyewhPChgelfXQMhW83rXEr/EP2GGS2H2oYQQ7Q9JsGSMpG
         PfxIUCYuitm7bXGxxUbtwazTP82crpHvDS9y0zLa7idtaGWPgifYmykmziIznDT+EHU4
         kqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690061352; x=1690666152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98zH7dMkI9Q+24mjorRXD83QnZC5AB71KgfogyqOgXQ=;
        b=cJvH4Kg6d5n+R08dXQx43m/+NqCvoplOWO1GipYtXO6A5Tp7/gdTXT5u+Ba8sdIZqp
         gAnhLSA1DZmdxPgAdbi+szQoJv0nM4kqWp6gL93t31QSrBhpbCW+MUm66RFFZRhlhfwI
         7YkYPOaYvV4aYF1C76sh84EKLaRIeS+PqujrHhYNlB+EVkPHfOoV1eRg4I4/EDu/BOg2
         PV1kEoQAmo0TpZQPKGvqJPj6sfm8kH2jabOoAsRu1CMJysCzTBfV66VVs1/ZR7qsoo1U
         EhG7gDD+qELDUqpMqorVBP61S0lRsWL0gg7/8NKxkaNd3m9eKmTwiZH9d3K+zui0+CWb
         PSGw==
X-Gm-Message-State: ABy/qLYlLBgHOLmnZp3m0fXiWC082wgqai9gYuR04PgkO1WCuEKLE8YS
        me96kKmdoLX0w5O+gxXSb67tHpWO+gk=
X-Google-Smtp-Source: APBJJlGxOEQESsJbu6mPQKql2hzWxyELEem3Wd8SmBPbVNmM4zCqYp4/r1l61+6pkHQpVh0Omu7IEQ==
X-Received: by 2002:a05:6a00:1397:b0:67e:bf65:ae68 with SMTP id t23-20020a056a00139700b0067ebf65ae68mr4782262pfg.3.1690061352163;
        Sat, 22 Jul 2023 14:29:12 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7810c000000b006833b73c749sm5055224pfi.22.2023.07.22.14.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 14:29:11 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5 1/1] sequencer: finish parsing the todo list despite an invalid first line
Date:   Sat, 22 Jul 2023 15:28:25 -0600
Message-ID: <20230722212830.132135-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230722212830.132135-1-alexhenrie24@gmail.com>
References: <20230721060848.35641-1-alexhenrie24@gmail.com>
 <20230722212830.132135-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before the todo list is edited it is rewritten to shorten the OIDs of
the commits being picked and to append advice about editing the list.
The exact advice depends on whether the todo list is being edited for
the first time or not. After the todo list has been edited it is
rewritten to lengthen the OIDs of the commits being picked and to remove
the advice. If the edited list cannot be parsed then this last step is
skipped.

Prior to db81e50724 (rebase-interactive: use todo_list_write_to_file()
in edit_todo_list(), 2019-03-05) if the existing todo list could not be
parsed then the initial rewrite was skipped as well. This had the
unfortunate consequence that if the list could not be parsed after the
initial edit the advice given to the user was wrong when they re-edited
the list. This change relied on todo_list_parse_insn_buffer() returning
the whole todo list even when it cannot be parsed. Unfortunately if the
list starts with a "fixup" command then it will be truncated and the
remaining lines are lost. Fix this by continuing to parse after an
initial "fixup" commit as we do when we see any other invalid line.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 sequencer.c                   |  2 +-
 t/t3404-rebase-interactive.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index cc9821ece2..adc9cfb4df 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2702,7 +2702,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 		if (fixup_okay)
 			; /* do nothing */
 		else if (is_fixup(item->command))
-			return error(_("cannot '%s' without a previous commit"),
+			res = error(_("cannot '%s' without a previous commit"),
 				command_to_string(item->command));
 		else if (!is_noop(item->command))
 			fixup_okay = 1;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff0afad63e..c734983da0 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1596,6 +1596,33 @@ test_expect_success 'static check of bad command' '
 	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'the first command cannot be a fixup' '
+	rebase_setup_and_clean fixup-first &&
+	(
+		cat >orig <<-EOF &&
+		fixup $(git log -1 --format="%h %s" B)
+		pick $(git log -1 --format="%h %s" C)
+		EOF
+
+		(
+			set_replace_editor orig &&
+			test_must_fail git rebase -i A 2>actual
+		) &&
+		grep "cannot .fixup. without a previous commit" actual &&
+		grep "You can fix this with .git rebase --edit-todo.." actual &&
+		# verify that the todo list has not been truncated
+		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
+		test_cmp orig actual &&
+
+		test_must_fail git rebase --edit-todo 2>actual &&
+		grep "cannot .fixup. without a previous commit" actual &&
+		grep "You can fix this with .git rebase --edit-todo.." actual &&
+		# verify that the todo list has not been truncated
+		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
+		test_cmp orig actual
+	)
+'
+
 test_expect_success 'tabs and spaces are accepted in the todolist' '
 	rebase_setup_and_clean indented-comment &&
 	write_script add-indent.sh <<-\EOF &&
-- 
2.41.0

