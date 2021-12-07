Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9484FC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhLGLKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbhLGLKC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 06:10:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C974AC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 03:06:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o13so28601883wrs.12
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 03:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3iyMoNX3EnHm1RhYwf2uYE46OwyumDBnUt7PmaFZhnY=;
        b=UOK2pIXU8qAjep8K3rGToqBY1PDIAOoL/rydeU8nSD3DxuAtlhmbtPHNcDGWKGwBFi
         HG13zCjuktxGHoq/0n/mR24KwY3ajn0yyQRNKWj/7QHTlLO1l9AQ47UFWXuQwJNcFt6v
         Ibcn4wzug/BR1wYBpjMdfND59jO3nejE87ALc4k8ydfSbR+FIkRIBRvl217OGaY0PPvl
         eCfu3uRL3orD+N5ZcS45drT1rCWqoCYZU8Jb8KOmpdUEVLJVIXrzgfLD92TJez6+u2H9
         iqhsvFml/2JNUgxuw7gs/4AVj0vrq9Moglwi3paKisS7A3nPXdE8oCEIcJljYanj9YqD
         2+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3iyMoNX3EnHm1RhYwf2uYE46OwyumDBnUt7PmaFZhnY=;
        b=pbdgmVSo9uNyVfYKZqEZtvtQhAnIFS5cQeYLnrNMnG1vnrCqu/IsEqKjcyOYXIhVtF
         62UHh1xuJLegGoD+v17dAUXttOrM1h+XCEk1EYSJUTfjrIbA2wR7ejVoccl05OB2bwx+
         5yDpQWJI6U2gqjM+0byXbR3iI3JyhWB50D8nYGU7DkYWTsz2XFySo9v1jhIeM28MDh7z
         KOPIAMc2jD4k9MCaQ8HAKoj7d0tRRDWfz50CLpURwNJWeN9aJQDP1s+Bj6bV30nH4PPy
         j+Smcv5tC8XhQJYzniIGb3iSTNaHp7NkreWJ0H4DnRLMa0w7YFp+pIc/weu20yEacEjw
         QnJg==
X-Gm-Message-State: AOAM530TBJcOaqWI9dk395bo8ziM5C0WfZRhUTDSY0rD23Rias/9me/a
        EBBpjVdK2iGMEf0pmvIJxFC50fEX4YCKrg==
X-Google-Smtp-Source: ABdhPJzRitXY6Rdg7TPZYwje5xhGVbIxc53qKmtQpg14WZqjKOhODTl0NAnIF2tVj4rTTw0MS1EeRg==
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr51813453wrw.253.1638875190179;
        Tue, 07 Dec 2021 03:06:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm2629587wmq.11.2021.12.07.03.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 03:06:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] object.h: use BUG(...) no die("BUG: ...") in lookup_object_by_type()
Date:   Tue,  7 Dec 2021 12:05:54 +0100
Message-Id: <patch-v2-4.4-aaf952a9ede-20211207T110440Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-v2-0.4-00000000000-20211207T110440Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20211207T110440Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust code added in 7463064b280 (object.h: add
lookup_object_by_type() function, 2021-06-22) to use the BUG()
function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.c b/object.c
index 23a24e678a8..4be82c1e7bc 100644
--- a/object.c
+++ b/object.c
@@ -199,7 +199,7 @@ struct object *lookup_object_by_type(struct repository *r,
 	case OBJ_BLOB:
 		return (struct object *)lookup_blob(r, oid);
 	default:
-		die("BUG: unknown object type %d", type);
+		BUG("unknown object type %d", type);
 	}
 }
 
-- 
2.34.1.898.g5a552c2e5f0

