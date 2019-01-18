Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFBF71F453
	for <e@80x24.org>; Fri, 18 Jan 2019 18:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfARS4M (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 13:56:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43973 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbfARS4L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 13:56:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so16318275qtj.10
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 10:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnOea2GCCbkUz7wCu0KtTAXgqc31D8hbC7N7JNpZ3jY=;
        b=DwFzUkWinVL7GIj+Lubnxul5ebqC4GWHt/nscDxGekBFnX1e2g3JgzM2FaX4iuNnQf
         unPUmbcodYjX9xpT5QNeET21UvK2UnSj1+L+vY9hkksWv3/1sG4nzN4S+9njVpYP+bZT
         H62tNPqlEi7XclrYoUlppXQKCecIrl/hYZN61WDnnrqnDsn/NA2cR+A/GV+vyJuBHQns
         tVQiNEL8qtn555vxkYt9Vo1zqbvei6rjBRfc8ER/p56hC3EY3ngzVBmzPmOmgMpRzEpI
         I83jG0TTSVKnS9e9TcKO4xhEYoBfVhZ1QTBtg7uBDIkXXneSOOnI3ANjgWJ0b4ljjv/C
         9XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnOea2GCCbkUz7wCu0KtTAXgqc31D8hbC7N7JNpZ3jY=;
        b=MELpS77LWb7Iv035/wHVHZZ1TeaLhWAeYYSiABMiwFxlJXvbj6QfsfsI9N6l1sSpBz
         B0HHi7QsIzillh9HTtNSvlKjUGdi/ptC+RdXjxrK2SbU85KSAzOYHlzadtpi8IKeg0qv
         1/Q8XeJ6dvhDqVuZpq3Mvyeztj9b6UKXnQwo9umH9Tc7NeY7akIajOyLUJjz/1CQbe5M
         SxcJLHQ8CqXkjwXRli1XYuUnQBJenNufKGWKmBzrQuiO6rs2+FhEOkVBhZ/ybbctGuOk
         bAlhmrKsmt9nWz8qGJ5m1z/hqz4EqMQEW/19cFhcwMxVzVmHZWBLnWsqeEevtU40xM2y
         zgDg==
X-Gm-Message-State: AJcUukdEdfV0vLZkCsqEzF1SJ4X+BsPa56heW/HoRMjzH8XsrJ/7O6sw
        yNrqAj0E74qqkKEjUVpC584EdyFb0Nk=
X-Google-Smtp-Source: ALg8bN40zEXJRM+H6d3inCyal6JuZsdc/Sbu2iz4R2bl5jgQ+n1Y3mxTIVw547GffUCbmhrSSbiffw==
X-Received: by 2002:a0c:9d41:: with SMTP id n1mr13364994qvf.212.1547837769683;
        Fri, 18 Jan 2019 10:56:09 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id b20sm70228520qkb.17.2019.01.18.10.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 10:56:08 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, asottile@umich.edu, pclouds@gmail.com,
        gitster@pobox.com
Subject: [PATCH v1 2/2] checkout: fix regression in checkout -b on intitial checkout
Date:   Fri, 18 Jan 2019 13:55:58 -0500
Message-Id: <20190118185558.17688-3-peartben@gmail.com>
X-Mailer: git-send-email 2.19.1.gvfs.1.16.g9d1374d
In-Reply-To: <20190118185558.17688-1-peartben@gmail.com>
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
 <20190118185558.17688-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

When doing a 'checkout -b' do a full checkout including updating the working
tree when doing the initial checkout.  This fixes the regression in behavior
caused by fa655d8411 checkout: optimize "git checkout -b <new_branch>"

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/checkout.c         | 6 ++++++
 t/t2018-checkout-branch.sh | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6fadf412e8..af6b5c8336 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -517,6 +517,12 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
 	if (core_apply_sparse_checkout && !checkout_optimize_new_branch)
 		return 0;
 
+	/*
+	 * We must do the merge if this is the initial checkout
+	 */
+	if (is_cache_unborn())
+		return 0;
+
 	/*
 	 * We must do the merge if we are actually moving to a new commit.
 	 */
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 35999b3adb..c438889b0c 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -206,7 +206,7 @@ test_expect_success 'checkout -b after clone --no-checkout does a checkout of HE
 	rev="$(git -C src rev-parse HEAD)" &&
 	git clone --no-checkout src dest &&
 	git -C dest checkout "$rev" -b branch &&
-	test_must_fail test -f dest/a
+	test -f dest/a
 '
 
 test_done
-- 
2.19.1.gvfs.1.16.g9d1374d

