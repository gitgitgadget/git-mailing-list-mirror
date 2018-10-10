Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E012E1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 19:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJKC4X (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 22:56:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43488 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeJKC4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 22:56:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so7004550wrt.10
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3f/RceIOgWWDsTX8rbMDJZXRmeTjCbRrUztJf3Mw7FM=;
        b=ZGbf+5R1VmoRdiuZXuVUV8IE2oxcu7rv1FJO4CW09h0KnK00TpDZYuntzQ4o2VKphu
         sNhMkT177QEg8O/FSoKo7T6RW2xcVLFsaWaXpia9wD277SHyEXOBlRL5EP8khXFvytvx
         Cpl/w0+YAfLwgOUjaSyxAXxYewokNyVl+lSy4EzV4MgWV0bmLcx6Ft9DT72cH22Zcc0u
         8zIDcFJzsoYdaaXHilhO/fIFbc/5scAFrKhYN3TLYN7Co24kKdT8NIZL1oD+aydIzlCV
         A9OvDmbhct22FOi5KgzGuq73PNvg9+UeyZGMOXZeFWlCpZJRN0Z9w2PetjVlJdoQK53F
         OCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3f/RceIOgWWDsTX8rbMDJZXRmeTjCbRrUztJf3Mw7FM=;
        b=qp2XmrPBsCauLjJK4FK6kIpsb6irzwXrJ+UedFu9xJIre++KkYx9mxmElbgfOpjeDK
         4xRpf5tr5B7K3NSdJ9dZppXiA9lx+HkSvGP7RoONc/k+DJRVNaNzW22Hyxq+SnY28Pft
         56yGodrvO/CCCJBK5cZ01a5PRK4NdKFNeqlbB/jSKaCoqsZ+oZuYI/0qO4P0nWnLd9AZ
         ExuGquycKtafgpn2NiQKiy9Eq0CvsQ8BZrfZsE2M0kcsEiNS3+XwdRV+pHOBNlryIV8s
         Av13a1J/t2DVqn+Q0XIEiDC0MlyTruM/SFP7CQ3H0/Rtup/x5oe6ztkTQR3BD2xWZemP
         MwAA==
X-Gm-Message-State: ABuFfoiUJAbhcjAP8rN9fGWVp4E4Z1v+0kzkUjxWdSCXs5najkC10Pvt
        81Hiz42DYi0lhETSjJ2qP9c1qWSvdHo=
X-Google-Smtp-Source: ACcGV61g31wb4DYlGMXCGyIDv9ve1lLfL/owVp44TifkE0bHu7xqo2QG32dOQWL0kkOAtE0dJhWC3g==
X-Received: by 2002:a5d:5601:: with SMTP id l1-v6mr6177304wrv.209.1539199964600;
        Wed, 10 Oct 2018 12:32:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 74-v6sm18588567wmi.23.2018.10.10.12.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 12:32:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] gc: remove redundant check for gc_auto_threshold
Date:   Wed, 10 Oct 2018 19:32:35 +0000
Message-Id: <20181010193235.17359-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.390.gf3a00b506f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Checking gc_auto_threshold in too_many_loose_objects() was added in
17815501a8 ("git-gc --auto: run "repack -A -d -l" as necessary.",
2007-09-17) when need_to_gc() itself was also reliant on
gc_auto_pack_limit before its early return:

    gc_auto_threshold <= 0 && gc_auto_pack_limit <= 0

When that check was simplified to just checking "gc_auto_threshold <=
0" in b14d255ba8 ("builtin-gc.c: allow disabling all auto-gc'ing by
assigning 0 to gc.auto", 2008-03-19) this unreachable code should have
been removed. We only call too_many_loose_objects() from within
need_to_gc() itself, which will return if this condition holds, and in
cmd_gc() which will return before ever getting to "auto_gc &&
too_many_loose_objects()" if "auto_gc && !need_to_gc()" is true
earlier in the function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I had this in my tree as part of some general gc cleanups I was
working on, but since it's trivially considered as a stand-alone topic
and unlikely to conflict with anything I or anyone else has planned
I'm sending it as a one-off.

 builtin/gc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 2b592260e9..5f25a35dfc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -157,9 +157,6 @@ static int too_many_loose_objects(void)
 	int num_loose = 0;
 	int needed = 0;
 
-	if (gc_auto_threshold <= 0)
-		return 0;
-
 	dir = opendir(git_path("objects/17"));
 	if (!dir)
 		return 0;
-- 
2.19.1.390.gf3a00b506f

