Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEBBC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbiCWJPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbiCWJPG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D22F5D657
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n18so946226plg.5
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=flo5WnekFKg/jYhkQac5ddpxHfhUuvBa6zBhq+XDeZs=;
        b=X8PcjOQzoJ4h18YGIK0nGUndwvLQdAgPRExOeVZkYfktiR1Ikwa/MpQpSIqII6ypuk
         uLzx1IkG0Uc6UhpjWZq58Vvh11WBY7ffQva1/jA6kuQLTUZDH7CnvzDMjg4QPE4SF0mI
         7LvjW9hRvDTGc4IZmdSVGuAlFUXeQyP/WShBWxjZE83C5t9KXDrxYoY/SjFIxWjHOrn8
         qAuFmInnZLIPJ2/DdsKk6TYtK6ieE/78+UDUEJZksp/WMXfEHMnNFcSD8nBY106KjgKt
         Ql3F51lBkxTpZ6Br/5+McmYjHuIJVPlpWy3B/uQdr+oirpkHa/DIQwbM4IcEXHq5FKyA
         TAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=flo5WnekFKg/jYhkQac5ddpxHfhUuvBa6zBhq+XDeZs=;
        b=HiYIaDiC/UAWuXeTGSx5oUuqB2kNwSZzRYa7AE/pA3YutbtNIeIDvkAB5K8SLHpELC
         xigpl/lLiI5dPMoFpLWcK9l6RIhSlzXtKYemG5KWfxleDGN2aArhVO35JDL2A5hC7F+h
         xcwVm+i5mUbkccMav6sWV2L+RcQZpSoel1frajVlBNPDE4sKhoaKqvmfcoddH3I0EStF
         urE4rWGLLbNqoJx5XNrhNyhxX0MG1D4C8KsC4rBzyXjHtrTk/Rt5wyNQHyuRCIsBf7lK
         HHdPj/KN/i7Wvjp2X472DK3MeAU0KSK2mP7djAkBYwwY+zL05sn0OAyZho2tfac+WAVr
         rU0Q==
X-Gm-Message-State: AOAM533ptY6Y3DRvyZDqlRq8o9FKcXgPdBYZiO0Nt758bD3Z+BBRKLFE
        BJnFIl9NTnVKbyZdG0UN8gs=
X-Google-Smtp-Source: ABdhPJwT8jemUskZs9weLSC2Rv8wYP1nu1h5H7ICIrzWU98DeDLnH/si+8R2nXaKDVcc46jXZW/Vyg==
X-Received: by 2002:a17:903:1cc:b0:154:31c6:4e00 with SMTP id e12-20020a17090301cc00b0015431c64e00mr20575221plh.114.1648026815573;
        Wed, 23 Mar 2022 02:13:35 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:34 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 05/15] ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
Date:   Wed, 23 Mar 2022 17:13:05 +0800
Message-Id: <ca90461e031421763a600d509929a2c6f9960a03.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
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
2.34.1.404.g92931a4a2c.dirty

