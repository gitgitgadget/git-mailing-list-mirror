Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A881C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjC1O3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjC1O3A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:29:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEDB61AF
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:28:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so15283910pjt.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680013739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qqtd0YNP5QvfdUZj5MmOWDNB1TDIyTNo19IV0ksBSlg=;
        b=DZrvnBAJ9BDWeF9VNOBgC/mffXQj4amnUzE/R+9GhFZ3rdSEaey62TlVQswtYYQ1iK
         p84OSZxk4Tax4/oBOrcJXs74uv11SlQn6LaHHBsFyWrIDa48BgEqXAvD/aY7UmtgVA5t
         /MjELUkFZjqzghE2R+tSXk6zfnk1yeXavna6H59e1/1SRyWgZPY7y7D7eCpB2iAIq33l
         vLicqLXoa4viVZlZcZ+eQ9WWehBW0QjUuT1THEdS2xWNGeGPfIOco6yuRnkUIB1CVt2+
         6Y5S1g1TqXAUYt1n8/b4GWyzlo6SuqX81Quy61v7RpxQ9V/4U0C44cQt+qsGacT01+TM
         pdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680013739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qqtd0YNP5QvfdUZj5MmOWDNB1TDIyTNo19IV0ksBSlg=;
        b=q7I88y9WbEhe/ACcov9Y1eN/nJfE0r+qjO+UAR2Q32jKtds68WHhE/8/hEWdCEG77y
         rgiUSF1Dx1W0Szzrm+jdVf072yr6QYRohBrAkBBzQ6zcAOdK78QNvu3RgucKD1GiqRKJ
         KAeoacVMWX4eAku0fXGvsorS0/5FmzIDiqnbeDu8SnsyPNi081fBNMnNQJY/saCBydyL
         sfm32ITtYPzSCumDwGJJ08YfsYkgaaEJn0lsjw/KkSqUcEPq5Pdkgeas7FRgyZkt6Q6x
         sa3RpMe2ttpmEZvaVyHSjimDZNMwg6oZBUcX410kXX9kz8cqxjA2fQWVob2rHx9MFIfI
         ObNA==
X-Gm-Message-State: AAQBX9fJcLmJd5a6fBwt8sWGVQcAzwYATgkupWb+nMEolBcjxPeKji5f
        2F3shObHIvH9h3QBhmpo3p4=
X-Google-Smtp-Source: AKy350YbcrGaKgUBCPcLxsaouTGRF+JyBrzN7HqbsftSjvmau/EJEz56Hxj+8FOSdUtzxqszYY8KFQ==
X-Received: by 2002:a17:903:22cb:b0:19d:1897:8192 with SMTP id y11-20020a17090322cb00b0019d18978192mr16767205plg.47.1680013739606;
        Tue, 28 Mar 2023 07:28:59 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.62])
        by smtp.gmail.com with ESMTPSA id bg9-20020a1709028e8900b0019cbabf127dsm21189275plb.182.2023.03.28.07.28.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:28:59 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v7 2/4] notes.c: cleanup for "designated init"
Date:   Tue, 28 Mar 2023 22:28:45 +0800
Message-Id: <9dc123c8f7a1cc2e7a146fb336939d6076369e2e.1680012650.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.rc2.4.gb9d12f0c
In-Reply-To: <cover.1680012650.git.dyroneteng@gmail.com>
References: <cover.1680012650.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

The "struct note_data d = { 0, 0, NULL, STRBUF_INIT };" style could be
replaced with designated init format.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 23cb6f0d..553ae2bd 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -401,7 +401,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object, new_note;
 	const struct object_id *note;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -567,7 +567,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const struct object_id *note;
 	char *logmsg;
 	const char * const *usage;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
-- 
2.40.0.rc2.4.gb9d12f0c

