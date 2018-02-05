Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4063B1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeBFAKU (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:10:20 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38571 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbeBFAKS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:10:18 -0500
Received: by mail-pg0-f44.google.com with SMTP id l18so142682pgc.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XiWFY2H86Ukrc0LyNjGCiIMz4+AF7LQQFiX8TGnIz6Y=;
        b=SNz+wHnuSYavaDZO/xZJ6ACrsJoH4OptafsfC1WX6/XTXsNt4912Vxb/EDgQDLaVUP
         3SfxKUhfUZjXOWbZyp6E+Qh56vz+Ad48gz+FG+QzYLegt/R6dqoxCy6Q16FlWOansdo4
         VKmKHHeZvZsN4my+YyWQweYcvu2tghQoplrrydUfttlM3TFrj5HB7iPnatsxWTamRx+a
         ZE/8qBLbuIXm8jhRB7lM3tw87egBR9inyfGbcXlDnbmWPCPnzL9iBtzOJgZcAhjpByZZ
         xvdlz9sgRwNkslGD4M6QWVUAzTINrx+t7sKyCJxjzqdNRjkEEaEx8tQcj8yttz8iSn/0
         sWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XiWFY2H86Ukrc0LyNjGCiIMz4+AF7LQQFiX8TGnIz6Y=;
        b=IKZqgZtm7Qlnnff3T5gnW4iTi10t4xIqkkj9YrFmZGEt4ZO6scED3qjSUpx7jBT4Nw
         yVL8ARVxnPZw8BPDknX7bjBWUk+1bY+ME/u3PoOAT1pJIdwlA2eo0RLLre+cuhzdIsDK
         1HZiYGr3zc/RGS9MNhjNGY0ndRsa9AY3KYHt9nLcPUnp1g2RUBjpb9d4sFeQsYjhX4Um
         GlX38yExrBfFzsA4h2Ze+cx40JwpOIfZ3n+IlS6dbB6WHvdPOXLYibzHe0ITLPRva6d9
         n7dQsyzSIopxokvE17kBx7/sZXzs6C7KnS60aAQvp7Pm8sX7Yh/eJ7u/z7Gp8z0Bk/eI
         mcUQ==
X-Gm-Message-State: APf1xPDo2wEZ8F9zROFhNs8BGBFq2hmRlnZlaqgLyxl9g5vLQC/8X4yP
        m0ZSoiMMgt0KA0F/n62XgEc0DJKryIo=
X-Google-Smtp-Source: AH8x227XB+E0ftMl5EV8TPPd+lCiRn0C3mDXqN/0Hhacrj+5UVwi+G4G/o05vtGoHcbKIk3t2eoWOw==
X-Received: by 10.98.83.71 with SMTP id h68mr524788pfb.198.1517875817192;
        Mon, 05 Feb 2018 16:10:17 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j25sm7634254pfk.38.2018.02.05.16.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:10:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 076/194] push: add test showing bad interaction of replace refs and submodules
Date:   Mon,  5 Feb 2018 15:55:37 -0800
Message-Id: <20180205235735.216710-56-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref subsystem has not been migrated yet to access the object store
via passed in repository objects. As a result replace when the object store
tries to access replace refs in a repository other than the_repository
it produces errors:

  error: refs/replace/3afabef75c627b894cccc3bcae86837abc7c32fe does not point to a valid object!

Add a test demonstrating this failure.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>

squash! push: add test showing bad interaction of replace refs and submodules

replace-objects: evaluate replacement refs without using the object store

Pass DO_FOR_EACH_INCLUDE_BROKEN when iterating over replacement refs
so that the iteration does not require opening the named objects from
the object store. This avoids a dependency cycle between object access
and replace ref iteration.

Moreover the ref subsystem has not been migrated yet to access the object
store via passed in repository objects.  As a result, without this patch
when the object store tries to access replace refs in a repository other
than the_repository it produces errors:

   error: refs/replace/3afabef75c627b894cccc3bcae86837abc7c32fe does not point to a valid object!

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5531-deep-submodule-push.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 39cb2c1c34..8b2aa5a0f4 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -308,6 +308,22 @@ test_expect_success 'submodule entry pointing at a tag is error' '
 	test_i18ngrep "is a tag, not a commit" err
 '
 
+test_expect_success 'replace ref does not interfere with submodule access' '
+	test_commit -C work/gar/bage one &&
+	test_commit -C work/gar/bage two &&
+	git -C work/gar/bage reset HEAD^^ &&
+	git -C work/gar/bage replace two one &&
+	test_when_finished "git -C work/gar/bage replace -d two" &&
+
+	test_commit -C work/gar/bage three &&
+	git -C work add gar/bage &&
+	git -C work commit -m "advance submodule" &&
+
+	git -C work push --recurse-submodules=on-demand ../pub.git master 2>err &&
+	! grep error err &&
+	! grep fatal err
+'
+
 test_expect_success 'push fails if recurse submodules option passed as yes' '
 	(
 		cd work/gar/bage &&
-- 
2.15.1.433.g936d1b9894.dirty

