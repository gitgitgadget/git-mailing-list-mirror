Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A796C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABC864DEC
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBPOHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhBPOHs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:07:48 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5159EC061756
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 06:07:07 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 2so4701778qvd.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 06:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdzDbuAYLKOerJCUNPo1noYnH8NduUcVJ838/tHIJ28=;
        b=U0fWSS9KToKt8seO+xhCJC2yT+3Ky7kgP14po3PVakS9XgoGJ7afHqWMRpNeL6bPOX
         3TwZ+6XaePotSIecUQuRaFWzRwPojx1eNqlPBu5ZT3Xxy/haji+hbCkcULfMS06OCWE1
         2Nzzk+RzKkajEN25UJXw5RJgDvrIOtooG0ZkX47OKNsiz+Oyfw0+qkceMWKpnTpd+RiA
         DUeHsQIIwZGdRSIQtuW20EIfbmb8YZVPczulUXigpaMS0MN3VpIXeNCK4Q+OuHO6be0d
         UW3ZRuHzulKB5wjHotwNver8qGhR9DjaBhfTHwfxx1zPCElbAgK2T1U4yM6VvidNOhRd
         aK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdzDbuAYLKOerJCUNPo1noYnH8NduUcVJ838/tHIJ28=;
        b=LolUfxbzi37zaLp5EExwTSiaaQamArR0jkE7J9AD1IN3sNfDayyJpXA3s4vkBDCN+V
         zDTRrKN9JLjf3i2KLkVKh9M+loKvrBfnzBSm4RBswWMe2b2VciquijlOSMeLw8/pVvhg
         H6x7CKoGKYcZLV4Fx3TLthAkU3csYaX+oRDo+/f67PTRK2XktsZ5t9GMo5B9y2JqqGQs
         TuiluIgffYFDp8RWyP/Yo40eKZd1a91TuQt6KcqgC6AX/O+x+E9g2pCU4e/z477yqw2f
         v9OEbBPxwhevqNPS6aOpCRDpzhNJ4M6VQtZu7GyVV23mfdwMXqTqrqFm+d88g3tQFcIU
         eYlQ==
X-Gm-Message-State: AOAM530Ep16Tla5Lchxtq3tuFigvoZtutph6QZgBynUhLHSItk671QTL
        ypKVGeLC39mMxFqG324HsUmaZ8Fd+xwYdw==
X-Google-Smtp-Source: ABdhPJzlNVYkPe/roXuHuKj9xhZYJKSyBkZBlaD0H0y9MsP0x+4HRFtLH4ezCzGA16GNKTnlIMOOnw==
X-Received: by 2002:a0c:f0d2:: with SMTP id d18mr20056073qvl.58.1613484420671;
        Tue, 16 Feb 2021 06:07:00 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id x62sm14303049qkd.1.2021.02.16.06.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 06:06:59 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v3 1/2] write_entry(): fix misuses of `path` in error messages
Date:   Tue, 16 Feb 2021 11:06:51 -0300
Message-Id: <41c166d3806915b372b4b8dfd8c87a299cf6a9c9.1613483833.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613483833.git.matheus.bernardino@usp.br>
References: <cover.1613483833.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variables `path` and `ce->name`, at write_entry(), usually have the
same contents, but that's not the case when using a checkout prefix or
writing to a tempfile. (In fact, `path` will be either empty or dirty
when writing to a tempfile.) Therefore, these variables cannot be used
interchangeably. In this sense, fix wrong uses of `path` in error
messages where it should really be `ce->name`, and add some regression
tests. (Note: there doesn't seem to be any misuse in the other way
around.)

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c                         |  8 ++++----
 t/t2006-checkout-index-basic.sh | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index a0532f1f00..7b9f43716f 100644
--- a/entry.c
+++ b/entry.c
@@ -282,7 +282,7 @@ static int write_entry(struct cache_entry *ce,
 		new_blob = read_blob_entry(ce, &size);
 		if (!new_blob)
 			return error("unable to read sha1 file of %s (%s)",
-				     path, oid_to_hex(&ce->oid));
+				     ce->name, oid_to_hex(&ce->oid));
 
 		/*
 		 * We can't make a real symlink; write out a regular file entry
@@ -309,7 +309,7 @@ static int write_entry(struct cache_entry *ce,
 			new_blob = read_blob_entry(ce, &size);
 			if (!new_blob)
 				return error("unable to read sha1 file of %s (%s)",
-					     path, oid_to_hex(&ce->oid));
+					     ce->name, oid_to_hex(&ce->oid));
 		}
 
 		/*
@@ -354,7 +354,7 @@ static int write_entry(struct cache_entry *ce,
 
 	case S_IFGITLINK:
 		if (to_tempfile)
-			return error("cannot create temporary submodule %s", path);
+			return error("cannot create temporary submodule %s", ce->name);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
 		sub = submodule_from_ce(ce);
@@ -365,7 +365,7 @@ static int write_entry(struct cache_entry *ce,
 		break;
 
 	default:
-		return error("unknown file mode for %s in index", path);
+		return error("unknown file mode for %s in index", ce->name);
 	}
 
 finish:
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index 8e181dbf01..7ff3edab05 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -32,4 +32,27 @@ test_expect_success 'checkout-index reports errors (stdin)' '
 	test_i18ngrep not.in.the.cache stderr
 '
 
+test_expect_success 'checkout-index --temp correctly reports error on missing blobs' '
+	test_when_finished git reset --hard &&
+	missing_blob=$(echo "no such blob here" | git hash-object --stdin) &&
+	cat >objs <<-EOF &&
+	100644 $missing_blob	file
+	120000 $missing_blob	symlink
+	EOF
+	git update-index --index-info <objs &&
+
+	test_must_fail git checkout-index --temp symlink file 2>stderr &&
+	test_i18ngrep "unable to read sha1 file of file ($missing_blob)" stderr &&
+	test_i18ngrep "unable to read sha1 file of symlink ($missing_blob)" stderr
+'
+
+test_expect_success 'checkout-index --temp correctly reports error for submodules' '
+	git init sub &&
+	test_commit -C sub file &&
+	git submodule add ./sub &&
+	git commit -m sub &&
+	test_must_fail git checkout-index --temp sub 2>stderr &&
+	test_i18ngrep "cannot create temporary submodule sub" stderr
+'
+
 test_done
-- 
2.29.2

