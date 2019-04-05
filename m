Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5367D20248
	for <e@80x24.org>; Fri,  5 Apr 2019 03:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfDEDhv (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 23:37:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45422 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfDEDhu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 23:37:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so2239572plb.12
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 20:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eGWxjGhlNFg5TpJtevAfYnV2v0oecDO4SqpwhnHhpFE=;
        b=MtP0fknwN7OiSrvqs74ahIKPzyytAyFgqAP6n4pzEPCBqFiL8YN+v0ZPxdxjwGdG0S
         vkBTQ2Vbr+AvztFObOcjj6nwqB5Q9yi19H3vFeVkURldAeYiR82Y2cH26ZEhx1/QSirj
         8hnjRx43+ApOqNJSNt6lRG1PtrPgi+nJBEbGPjlK6CguflPm8ZmGSUS9ZJQtiAdwhHdO
         c3wGRf7t4NFwmQvpnfBJFjawMK+k6wuUPPXw3x212QKqSToBQ243rgPBy/69q2CZJTOn
         bQmqOPrkCebSxSA62ynPD2O9jm4FkupM/e6NDdI/J9nmRRQj4fpSD8g/mA/vFxKqXeUY
         00YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eGWxjGhlNFg5TpJtevAfYnV2v0oecDO4SqpwhnHhpFE=;
        b=s6SjuQT6F8dy4XdGOxC4U+0H/GBr1gqxm8POtLP+E0xPoRkeHs8oam7/fbPZwNaqTw
         yQESkjymWdCqqf4IOKBv0dO6iesYqrXI+l+EsNJhMBa0EBIuKQqKPpyH1k0yiRD4oMoP
         xD5BJsrfWYbX/mdr7bKdGoHjmtC6fjwvYST8v7Of7IZANfjoO0GLceTsaOFp33OdcLuy
         sF/l2mbxhuqx1v6PznotoXYhtUcRQUOGvwnjA4x8bnucnkbqIYylaWBTG5UYa0uXrV01
         srhNtLru0+MKFin+bU+9oTknvuQZXJ6Pd7whdDYJS1HhLNNIGP7k0E3GVqsZ4DqwoAi3
         rPnA==
X-Gm-Message-State: APjAAAVihwLvHfG3uwT5EHQXMG4dbU3YjekMbOC5MdPQvzQXaYSDKXtK
        QDy/TZh3L/z0vkx61qn0n0DcGr009+7crA==
X-Google-Smtp-Source: APXvYqwZuAmF6srajO1/Aws9aSPZ23goSgNiYllXJVxYFJTu0sWTtM5sl06ytKelQo3RwhPRjqVWZA==
X-Received: by 2002:a17:902:b484:: with SMTP id y4mr10358248plr.88.1554435469925;
        Thu, 04 Apr 2019 20:37:49 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:9900:4016:ceb4:1574])
        by smtp.gmail.com with ESMTPSA id o5sm68988463pfa.135.2019.04.04.20.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 20:37:49 -0700 (PDT)
Date:   Thu, 4 Apr 2019 20:37:48 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH 4/7] list-objects.c: handle unexpected non-tree entries
Message-ID: <6d59461830b89fab5eabae1c1b883888bd9d9fca.1554435033.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554435033.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply similar treatment as the previous commit for non-tree entries,
too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 list-objects.c                         | 5 +++++
 t/t6102-rev-list-unexpected-objects.sh | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index ea04bbdee6..bb7e61ef4b 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -125,6 +125,11 @@ static void process_tree_contents(struct traversal_context *ctx,
 
 		if (S_ISDIR(entry.mode)) {
 			struct tree *t = lookup_tree(ctx->revs->repo, &entry.oid);
+			if (!t) {
+				die(_("entry '%s' in tree %s has tree mode, "
+				      "but is not a tree"),
+				    entry.path, oid_to_hex(&tree->object.oid));
+			}
 			t->object.flags |= NOT_USER_GIVEN;
 			process_tree(ctx, t, base, entry.path);
 		}
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 76fe9be30f..30976385a8 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -33,8 +33,9 @@ test_expect_failure 'traverse unexpected non-tree entry (lone)' '
 	test_must_fail git rev-list --objects $broken_tree
 '
 
-test_expect_failure 'traverse unexpected non-tree entry (seen)' '
-	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1
+test_expect_success 'traverse unexpected non-tree entry (seen)' '
+	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1 &&
+	test_i18ngrep "is not a tree" output
 '
 
 test_expect_success 'setup unexpected non-commit parent' '
-- 
2.21.0.203.g358da99528

