Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9481C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbiEIR7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiEIR7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:59:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B23B2D86A8
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y21so17213012edo.2
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6gwX110jRW9ozhRny1SvhbGzf5KEA97RcwrbFuJpvM=;
        b=lZovO8TfRvFS9Gz0bCX9VAxteYtnAb1lOtl3ZWbINcWCqBRp+/0I2uqlEjj2x8ugx8
         SmzYMSxfGKAqIYm5n0J6UH8ofgxZ2RdhjGh+xEcyYm6uaH5R9YvFum5CJVtel1cjjSCM
         cX+qYmJyH8QdxRIaFdmoHRR1ICsXwXyeu6JU5fHLhHtDNP9sSV0R0Q5Pg5P1rJkJ9O7E
         1GFdBu6yWfKo5lEzwL4IpuamCm0etaNz2kBGT/7DLX4YIo2pYcqdonC44Zx/vOTglmXr
         vTK2KuxKGw1htamJqAiYeu39YYLXtmWlF1cSWfs2CQcRCti+8ycvjjbLzqgD5wiVdJ+5
         64nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6gwX110jRW9ozhRny1SvhbGzf5KEA97RcwrbFuJpvM=;
        b=Lq8skUs5T4HENFRKsjX2UUI3FMR8Y6LFyDkOqyEX/wY6FfU4Hgce/K57PQmtz2+w1C
         q71WJm8v9yJ6ms8cQiP1HgVNsPYuiPa4p7mjpBhJjw9BG7la699LRMZLlMW4Ccedu1a+
         bMZiefNfYgxPH96L9QJi2IHYTxex8d693UxsWIZj8FPPPG9p7UA+a+2A8EG31PnqB4Vp
         rfeXR7MxuDzW/PwwtQgqTZ+m4hLKtA++uTq+o/WYV9OR8/MQVs1HZDIId75y4QJSXmKY
         KOy6g9YIKGASEf0D4C72NZ6sU0wjddt02qkn2YULUKhkdp2MBU4EzZJgm44wQRbRdvvD
         U/SA==
X-Gm-Message-State: AOAM532CB9li3HkM0ufLorxajuGrulh49hqZsSia3y8N0z9CdamjXdIZ
        VJN6GQBy5wq+mVNE6z2lY6Kdp0yu12Q=
X-Google-Smtp-Source: ABdhPJzb0mpACwpWejFcZyPdfMy5EJvHQA9K6wVJUiHKWSMlJI/4d5E/bputVSy2xcoNSWdQcPFuNw==
X-Received: by 2002:a05:6402:3484:b0:428:1a5e:3d48 with SMTP id v4-20020a056402348400b004281a5e3d48mr18813096edc.401.1652118904082;
        Mon, 09 May 2022 10:55:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:55:03 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 06/15] test-dir-iterator: print errno name set by dir_iterator_advance
Date:   Mon,  9 May 2022 20:51:50 +0300
Message-Id: <20220509175159.2948802-7-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, test-dir-iterator does not check for errno error codes set by
an unsuccessful dir_iterator_advance() call. We do check for them,
however, in dir_iterator_begin(). Make it such that test-dir-iterator
does checks for them in dir_iterator_advance() as well.

This improves test coverage because it provides more detailed outputs
regarding errno error codes set by dir_iterator_advance(), which in turn
allows for the addition of more thorough tests over dir-iterator.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/helper/test-dir-iterator.c | 2 +-
 t/t0066-dir-iterator.sh      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index cdb9269ad5..55d8a58836 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -59,7 +59,7 @@ int cmd__dir_iterator(int argc, const char **argv)
 	}
 
 	if (iter_status != ITER_DONE) {
-		printf("dir_iterator_advance failure\n");
+		printf("dir_iterator_advance failure: %s\n", error_name(errno));
 		return EXIT_FAILURE;
 	}
 
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index b21c58ade3..61b02423d5 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -90,7 +90,7 @@ test_expect_success POSIXPERM,SANITY 'advance should not fail on errors by defau
 test_expect_success POSIXPERM,SANITY 'advance should fail on errors, w/ pedantic flag' '
 	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir3/a
-	dir_iterator_advance failure
+	dir_iterator_advance failure: EACCES
 	EOF
 
 	chmod 0 dir3/a &&
-- 
2.36.1

