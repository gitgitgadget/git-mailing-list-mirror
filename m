Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1652C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiCWJPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242497AbiCWJPH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A005D75622
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so1145086pjp.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zbGShpW8GYjRDhu/9DoIl/0h4lyz3H3tjcdUp1qvQUM=;
        b=WG4v4CuQQQYFEK7/8/JUSIF/FLDlupxteSJGeW8zars4wn25rP80oJhtWwDb3zaCjZ
         5RcgWZFiGX4WxDZ6OJQQPnH+9KmKLWZ3g0+a1hTJs8N2SjBb/Ct92m9qYqBRicIdMZCv
         hM8AP2rwJ2hYqwb0sHrBQm2cQM+21Y2odrAWtSkhvRT+uGmFaYh4Pzedc0mRgnEAxFRb
         iUIQoTKEyWIYOwuXW7JTwY6TfX2vrqzrD76QMJ7ilaOVpz0PbWRqKSu5oGECh2q7y5ni
         iBRpj/rBk+hkupYjtJVrxA5ISlQ8/2JRMmFa1kXqm9gT11ckQvwQB+MbNHUmDkbmhOdT
         CnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zbGShpW8GYjRDhu/9DoIl/0h4lyz3H3tjcdUp1qvQUM=;
        b=BERgCcIcuS7v0suz3BCKirMx5PobyraipSJi+vJwVii2YAMgp/xA0WtoiSuVYzuFPi
         rpsp3oIQU0chi40Yo6WTJKja4chczk4LEkgs9LWUZnIpl6CBraBBm4Lyu3/fzaJOhuUH
         imjlH3NBSzYC+lzN3ZX5vWVeyxLQr2c6TId8kwwLcEfBpLRvUVwvLatCxtGT+GHOIJ0n
         Vczcov+chrvE5ly7x5vC0bY+ushbtSyqS2lp08UB/pAep+dsKq2PgTS7j6e+Ar5Tmwoh
         2frsXw4c5p6pyqsNb/1Vqpa83OpWr3P7er+kzO9FoMLjBjfS3CkZU3FN3ChOZD4U50Rp
         BCZQ==
X-Gm-Message-State: AOAM5303nnvwVYx4Td6sj0cyApAHr3b46OAF1u3/dUbZjwR9qr+ZIIPC
        Fbd7XqrzzsXCS80m4OGA62E=
X-Google-Smtp-Source: ABdhPJyaHIf+uHYKG8PHEez7CjTTXUck4/bk+HW1fLBQF/tf6gx2tVThDf7RLehBvF5QmLKDmvjIKA==
X-Received: by 2002:a17:902:c105:b0:154:81e0:529d with SMTP id 5-20020a170902c10500b0015481e0529dmr8328953pli.1.1648026818135;
        Wed, 23 Mar 2022 02:13:38 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:37 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 06/15] ls-tree: rename "retval" to "recurse" in "show_tree()"
Date:   Wed, 23 Mar 2022 17:13:06 +0800
Message-Id: <f51d4fab0ac057ceb2974107244c74b2a0054870.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable which "show_tree()" return is named "retval", a name that's
a little hard to understand. The commit rename "retval" to "recurse"
which is a more meaningful name than before in the context. We do not
need to take a look at "read_tree_at()" in "tree.c" to make sure what
does "retval" mean.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index eecc7482d5..ef8c414f61 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -64,7 +64,7 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
-	int retval = 0;
+	int recurse = 0;
 	size_t baselen;
 	enum object_type type = OBJ_BLOB;
 
@@ -72,9 +72,9 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		type = OBJ_COMMIT;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
-			retval = READ_TREE_RECURSIVE;
+			recurse = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
-				return retval;
+				return recurse;
 		}
 		type = OBJ_TREE;
 	}
@@ -109,7 +109,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 				   chomp_prefix ? ls_tree_prefix : NULL,
 				   stdout, line_termination);
 	strbuf_setlen(base, baselen);
-	return retval;
+	return recurse;
 }
 
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
-- 
2.34.1.404.g92931a4a2c.dirty

