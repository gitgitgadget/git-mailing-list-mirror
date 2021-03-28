Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFF5C433E6
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703856196E
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhC1NQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhC1NQB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EDCC061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so7506069wma.0
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02dmYg0pq3NYMuKuhJFrUENzF0SckD0GfxPVM6LCF0U=;
        b=U6dJ+jKeXiGHIp0NW6IhNuMOZJenrTpX/59aTDgwUXx8WC/aWEHnQxlCjzRsfYsWux
         R4HG8wFWHt9x1/ds48yfs6WWteZP+wXAuE0YDPM38QYeYS4AcVxp56jlyhqhhxdBJ7+H
         r2VGTyIpgesEdVWBMhm0bTUzzqhlTmLjq6ndsEaUx0cC6DOXn2w0CVZYVMF97I28LfP2
         zqPRfpNqyZmM9ZXd6AssL79vgd8rnjNP0TDTXTGc5kQv0BDB/kpj8Piuajt/1GjD1CTw
         0FrL7XHo7ZGYhpLIiovSmz2sLAo83yFiu9/uuwdi0wde9zaWmzPFCDRJmGyKxeE7keTQ
         9fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02dmYg0pq3NYMuKuhJFrUENzF0SckD0GfxPVM6LCF0U=;
        b=apYmuwlR4AgtBOClUnXT/X23hdYGQNpKKnGvww1C672JGRRvZL0MLkTaqDImOkT9di
         HTV36HfHOzOjiePoV2rbZeD5DfQ4yLowQ1XlcStO0s9HptJq/lDBbYHmOEsED43MNZmv
         bHOkV0WCf9FF1DcHJB48Yh2f9x9tfXrRzF59n1MwFzD+IcWdDjz0twtCQ8W6XgfwLMMt
         xl2zdwGBSe/at48S7Rwu1d2YAht8qnY6CTJn1rPoDsMmoijhFKUSoQtlbB2yXR232iKy
         j9uH6cR9Zv+8PkM13hUk8OT4BacYwBuHTQ40JrU5frSEhOrwCpoJKrBc6jLOtffKFmYX
         s0oA==
X-Gm-Message-State: AOAM533CmORljBit1ApepBlsvkd/0PHwlipyjvixNYIwnYaMUB6m1g/O
        GOcNMglFRQQxgfwiqfcih/yyBS63mdWRlg==
X-Google-Smtp-Source: ABdhPJwTR5bvhQSVJ72weobLM5KLIFukOi7dyq59HFg43jBRJOho8gsrwg4LCKYGx0d20dKknmdpGA==
X-Received: by 2002:a7b:c0c4:: with SMTP id s4mr21183498wmh.9.1616937360036;
        Sun, 28 Mar 2021 06:16:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:15:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 07/19] fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
Date:   Sun, 28 Mar 2021 15:15:39 +0200
Message-Id: <patch-07.20-948689ad5c8-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor "if options->msg_type" and other code added in
0282f4dced0 (fsck: offer a function to demote fsck errors to warnings,
2015-06-22) to reduce the scope of the "int msg_type" variable.

This is in preparation for changing its type in a subsequent commit,
only using it in the "!options->msg_type" scope makes that change

This also brings the code in line with the fsck_set_msg_type()
function (also added in 0282f4dced0), which does a similar check for
"!options->msg_type". Another minor benefit is getting rid of the
style violation of not having braces for the body of the "if".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fsck.c b/fsck.c
index a0463ea22cc..8614ee2c2a0 100644
--- a/fsck.c
+++ b/fsck.c
@@ -167,19 +167,17 @@ void list_config_fsck_msg_ids(struct string_list *list, const char *prefix)
 static int fsck_msg_type(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
-	int msg_type;
-
 	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
 
-	if (options->msg_type)
-		msg_type = options->msg_type[msg_id];
-	else {
-		msg_type = msg_id_info[msg_id].msg_type;
+	if (!options->msg_type) {
+		int msg_type = msg_id_info[msg_id].msg_type;
+
 		if (options->strict && msg_type == FSCK_WARN)
 			msg_type = FSCK_ERROR;
+		return msg_type;
 	}
 
-	return msg_type;
+	return options->msg_type[msg_id];
 }
 
 static int parse_msg_type(const char *str)
-- 
2.31.1.445.g087790d4945

