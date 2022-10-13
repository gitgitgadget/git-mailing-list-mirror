Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DAEC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 05:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJMF52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 01:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiJMF5T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 01:57:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFFD1285C3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 22:57:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gf8so1023039pjb.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 22:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAtYRH17gfqCDE21k+jU5zZCSFCUfGNZgH5C6ICsoFg=;
        b=CIuz0+Lbo/deUISblrecq769kepUxBCWC3yxmnmgD6cyR/t6cBa/weHFElGfoZv544
         Cw9Hi8OoGOQRJAGYhXKIDtwfi71w9b4D6s4ZfLifFmmb2oxVKPMyxrdBz3uZ+L+DGaOr
         4Ajev6/648YICDMY3txdGSZuSVZmq96FABYjuzqx6ryUF29LRSc5ND7RrII5f/W/0Oh2
         oHybukpnioYFHH5vE7AsmWvE2NuD0EJV8UXXBBJBy+imoQQU5J/w+b2r/LYNuwuY5vVw
         cUC3UC3oZhmGGiyd21Tra1G5BfM5pMwksVWbHALELNbeszmHpd2moYJt6xad/rFlITb5
         Clkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAtYRH17gfqCDE21k+jU5zZCSFCUfGNZgH5C6ICsoFg=;
        b=Vk/7J5kEzEgdDm0/KPIRt/g/LY7DVwM/DS6UyPVRgzkldwT8ngkFxP4xgnyHlobMe8
         lRtL8pa1wdcUc3tlpPceTy9lKKrXQoNW88UchT2MVcupuAoCq7vmrMufqB+/Gv/DxPSD
         lVDsBZ8gbBlsKlm0A/ekvkxGKIpFjGxU68CAc9wuZU+G5H1Tn+T+eMQ3pnyoPWokTFV9
         eneeNwoL8PlVs8NZhh1HxSr1en7Qb+xK91dQ+JN44Ju6FMifB3yK9ctkRJyAZEFooEp+
         nFzR1q9mZwyvZsWssPE4UKOKyW6U7IUWEU28cXMIFIWeQhol5AJtnBbQd/YvhsgyYamF
         Rp2Q==
X-Gm-Message-State: ACrzQf3pBfgGY0nmTOFxG+sJe3hxsnJEocOpUmp/EW2KxgwmqexXyTqq
        NbuoSCsV7Rd5EXgZcb+kUvkbo5uifHyBTA==
X-Google-Smtp-Source: AMsMyM5VI+x990oLSYK2TnJ65SUhnF7anCZvRUl/pPCN6Q1RdGP4wGScXyMdGqEHHn7VOagIqn4KJw==
X-Received: by 2002:a17:902:d48d:b0:183:1d43:fd34 with SMTP id c13-20020a170902d48d00b001831d43fd34mr15974250plg.46.1665640634099;
        Wed, 12 Oct 2022 22:57:14 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.62])
        by smtp.gmail.com with ESMTPSA id l76-20020a633e4f000000b00460a5c6304dsm8008822pga.67.2022.10.12.22.57.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2022 22:57:13 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     --cc=avarab@gmail.com, tenglong.tl@alibaba-inc.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 2/2] notes.c: fixed tip when target and append note are both empty
Date:   Thu, 13 Oct 2022 13:56:54 +0800
Message-Id: <20221013055654.39628-3-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.0.rc2
In-Reply-To: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
References: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When "git notes append <object>" is executed, if there is no note in
the given object and the appended note is empty, the command line
prompt will be as follows:

     "Removing note for object <object>"

Actually, this tip is not that accurate, because there is no note in
the original <object>, and it also does no remove work on the notes
reference, so let's fix this and give the correct tip.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c  | 13 +++++++++++--
 t/t3301-notes.sh |  3 ++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 1ca0476a27..cc1e3aa2b6 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -567,9 +567,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object, new_note;
 	const struct object_id *note;
-	char *logmsg;
+	char *logmsg = NULL;
 	const char * const *usage;
 	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data cp = { 0, 0, NULL, STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -615,6 +616,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 
 	prepare_note_data(&object, &d, edit && note ? note : NULL);
 
+	strbuf_addbuf(&cp.buf, &d.buf);
+
 	if (note && !edit) {
 		/* Append buf to previous note contents */
 		unsigned long size;
@@ -634,16 +637,22 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
 			BUG("combine_notes_overwrite failed");
 		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
+		commit_notes(the_repository, t, logmsg);
+	} else if (!cp.buf.len) {
+		fprintf(stderr,
+			_("Both original and appended notes are empty in %s, do nothing\n"),
+			oid_to_hex(&object));
 	} else {
 		fprintf(stderr, _("Removing note for object %s\n"),
 			oid_to_hex(&object));
 		remove_note(t, object.hash);
 		logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
+		commit_notes(the_repository, t, logmsg);
 	}
-	commit_notes(the_repository, t, logmsg);
 
 	free(logmsg);
 	free_note_data(&d);
+	free_note_data(&cp);
 	free_notes(t);
 	return 0;
 }
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 43ac3feb78..967e6bfb67 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -574,7 +574,8 @@ test_expect_success 'git notes append == add when there is no existing note' '
 test_expect_success 'appending empty string to non-existing note does not create note' '
 	git notes remove HEAD &&
 	test_must_fail git notes list HEAD &&
-	git notes append -m "" &&
+	git notes append -m "" >output 2>&1 &&
+	grep "Both original and appended notes are empty" output &&
 	test_must_fail git notes list HEAD
 '
 
-- 
2.38.0.rc2

