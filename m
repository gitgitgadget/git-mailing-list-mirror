Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69DC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344937AbiCUHfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344935AbiCUHfO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B94355BCC
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j13so2067635plj.8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDvZsShFMnXjG5lbO/nJWg+6l37lngugqc3el6D+dZk=;
        b=i16RvNSmrJGG3RnvkoQ0Jw4Uru38KKeoy5X/LePbAQECVID1W6FJYyhh3nuRar/sZo
         nm7IlGwWDKWzq7zMC+1U4aHCQvnr+sYltLIAsp8D3qrpvdaKXmBcBxHP8sWsmH1GuE44
         yDdM3zNu5DXRVr/LInO6BL2EreMNRugWu4GIg4OPIObmwi9L3tDT2sO2Z9b37ZA2JMRb
         Vf/jiVhVtbVN2IFeOnp99oNOipt0U/JapTF1BjtChmsSxzaCb1gNsiyRJh/XFTKsvmjj
         dO5ABNvT2/mzn3xn5TmbXdOgoYW+cWqKxCpZFmt/l8ofRO/iPzVoOJSADInNYKCx+xD0
         xeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDvZsShFMnXjG5lbO/nJWg+6l37lngugqc3el6D+dZk=;
        b=I+A4PO8kyBcBrIZHWFj2g44bpK3pH395Z9fDx6Jg1EJjik96QyKoMrOeBpWyQeU/fA
         42t79hI2gJr3I1p85w8OUvvXCe2FyDwmeBmfJXljpfKqKQLIkZ0UCzuPMEQJNw9YkCnF
         xhqQ5TlRFYPViuTgFAITbc/iPY7TdHTgu3M+Z3zyk4izL3/cUEt3ZIKRGj0bxmDx436A
         kTe8Sb+xC7E0Xs2BGNivJw+Sx/uvEm9tXcLzfp40FH24xI8tfcZ3ZHYzUVyWukW1I6d/
         PoLg+zqOEEzwfuDB8xTr1S96EeSfxDvgZ3TKRtg0NIsoz3wBz4iC8G+TpMIzricF8PUe
         rfXg==
X-Gm-Message-State: AOAM530AxmqVyeTM2jR2eitXlYGt5NGVyAjuE1cgBblRafuwfB2RXtge
        N5K4F0/zH05leGqbSlQ/01w=
X-Google-Smtp-Source: ABdhPJw0bKMHk1PXCpYxGi6Ba8bKXotNnOt/UU9Di2p2K0Q3CAaX6z2kj28fj0agkL9sy1CbGkAWew==
X-Received: by 2002:a17:90b:3a81:b0:1c6:834e:cd61 with SMTP id om1-20020a17090b3a8100b001c6834ecd61mr22651259pjb.149.1647848029095;
        Mon, 21 Mar 2022 00:33:49 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.33.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:33:48 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 04/16] ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
Date:   Mon, 21 Mar 2022 15:33:18 +0800
Message-Id: <2637464fd8f6b8bae6c681f20c10c9fc76dc6d6c.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The "struct strbuf"'s "len" member is a "size_t", not an "int", so
let's change our corresponding types accordingly. This also changes
the "len" and "speclen" variables, which are likewise used to store
the return value of strlen(), which returns "size_t", not "int".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3f0225b097..eecc7482d5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -31,7 +31,7 @@ static const  char * const ls_tree_usage[] = {
 	NULL
 };
 
-static int show_recursive(const char *base, int baselen, const char *pathname)
+static int show_recursive(const char *base, size_t baselen, const char *pathname)
 {
 	int i;
 
@@ -43,7 +43,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 
 	for (i = 0; i < pathspec.nr; i++) {
 		const char *spec = pathspec.items[i].match;
-		int len, speclen;
+		size_t len, speclen;
 
 		if (strncmp(base, spec, baselen))
 			continue;
@@ -65,7 +65,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
 	int retval = 0;
-	int baselen;
+	size_t baselen;
 	enum object_type type = OBJ_BLOB;
 
 	if (S_ISGITLINK(mode)) {
-- 
2.34.1.406.g2e0e55130e

