Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD1AC43217
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiBHNOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350223AbiBHMOy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:14:54 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F11C03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:14:54 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y15-20020a17090a474f00b001b88562650aso1496386pjg.0
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptcAFncxGBKtBgWsUxBBg90Humwutx+K7Mif6gkRRN8=;
        b=F3QTs3R/m4TSOtEwD2FBDSWNoOw3uW80SWvouC5BkOrllRud/ZwmmtsTPyOTaK2A6t
         RT/8q8MiUJ/II3iw5JswgjYJFN4y3B7xOhNq1XKgm1uFHVnWHvFdIrtq9jSImUxbktYU
         Xj1V1gViWYa3HZ697qv6pdtw9bQXt3zx4lZOkcF9Z27dADsqEvcNvQTJClD/Dds9kYV/
         /PjQyNzhZjHedVQ3QdKsAAoQryQlTuqghe/AWgSF1zl0inJ4CZlh5tj8w3aBSaIOQQ07
         QwWK0EcuUC+mB1eKdMTPZJRYhSl5fD3wxXpU3EfmLIok0twoVcjI63um2WgshnmcsCbq
         Jktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptcAFncxGBKtBgWsUxBBg90Humwutx+K7Mif6gkRRN8=;
        b=rZaIDLsBKka38SO89+RY7bNZ6fOhfXkKQ6QvZSGfv2zKTUhocK15ekExGm9WZS2hCh
         iphMLicU6HzL7qS3KiD9ADRqNgbKo7LtHtczlI7EQp4WPSdiLADYNaarj4ErwiUozpdP
         895mXRX5B7zMGYy0YCYQAvGJoJ7mQn/rhs+NbMqy4nib4F3lue7t4J8cHweUJUu1xxwo
         VI/zbD0w1x7vKkuCdy9BVmpBLaK1cL08zWPiXaYCefZmJiawHR49HCPHUDErDn9K2ykl
         dW48PJS6dspuhqEx1THlPgVqsqLULwFyMCiGqHfJc9rZmjZVp9X7gvOA8vtVEiy+uPRH
         PDPg==
X-Gm-Message-State: AOAM533ij1WrzEQl1AgVbylz5QV//JINz1HOyMvRRN9Qoi5NIHRkQbyd
        kCP0Yo+P98NuJt6ukWo6uog=
X-Google-Smtp-Source: ABdhPJzcHRAQ892lWN0UhzXD1eNeeBpWD2BGsevZZ0ykKvn9zYrRJ+3AEvHpTbHwiWPManHczXynBg==
X-Received: by 2002:a17:902:7b89:: with SMTP id w9mr4270374pll.174.1644322493703;
        Tue, 08 Feb 2022 04:14:53 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:14:53 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v11 03/13] ls-tree: use "enum object_type", not {blob,tree,commit}_type
Date:   Tue,  8 Feb 2022 20:14:28 +0800
Message-Id: <208654b5e2aebbe988b5a8f478869253a0166e9b.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Change the ls-tree.c code to use type_name() on the enum instead of
using the string constants. This doesn't matter either way for
performance, but makes this a bit easier to read as we'll no longer
need a strcmp() here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 0a28f32ccb..3f0225b097 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -66,17 +66,17 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 {
 	int retval = 0;
 	int baselen;
-	const char *type = blob_type;
+	enum object_type type = OBJ_BLOB;
 
 	if (S_ISGITLINK(mode)) {
-		type = commit_type;
+		type = OBJ_COMMIT;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
 			retval = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
 				return retval;
 		}
-		type = tree_type;
+		type = OBJ_TREE;
 	}
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
@@ -84,7 +84,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
-			if (!strcmp(type, blob_type)) {
+			if (type == OBJ_BLOB) {
 				unsigned long size;
 				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
@@ -95,11 +95,11 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			} else {
 				xsnprintf(size_text, sizeof(size_text), "-");
 			}
-			printf("%06o %s %s %7s\t", mode, type,
+			printf("%06o %s %s %7s\t", mode, type_name(type),
 			       find_unique_abbrev(oid, abbrev),
 			       size_text);
 		} else {
-			printf("%06o %s %s\t", mode, type,
+			printf("%06o %s %s\t", mode, type_name(type),
 			       find_unique_abbrev(oid, abbrev));
 		}
 	}
-- 
2.34.1.403.gb35f2687cf.dirty

