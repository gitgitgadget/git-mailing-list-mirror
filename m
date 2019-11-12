Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9971F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKLANy (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:13:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41215 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfKLANx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:13:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id h4so10559731pgv.8
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oc+w6F49uszuUMDL1rkcq+uRpF+lV8Ej0xnwLvlGCOU=;
        b=B3OK0CpzgUDP3JXe6bacr2vHtC+SNBjnZ0hOdcOPuzacXPD/13QEbFbgcIzjy7wSiH
         xKP65rZbQb4ilz6RAf8PBcSIkPCRCD6gI551oWqM4r87+wuTTHIeRxy+yCJwxwfeVHF9
         cPidmiL60C1Mkj8CrNVNdRnPmhx78FU/lJd1iOq11qEI4DJv6pjGRM0OVMyBOPDyM97u
         i0YMndnfg2BTSfg3HCvQsKBD5LaFj3hE6ySMzL65d1ogSRuhzvDrdlAmtA+gdt/XK2eu
         +yTMFdv67qN9lTS105DwzXwgn+ysgO4H/B7J4UUL0ZhmqA/oXmE6gBYSM3dz/mB0ke4g
         fqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oc+w6F49uszuUMDL1rkcq+uRpF+lV8Ej0xnwLvlGCOU=;
        b=N6zzTpQx7kZmw40XVQ+2MSSHtRSmk9NseeQcRhgiza0vGUITSicFf1nTE9xD0Fvnn2
         ji5Znbr6NSz4S/USa+dBmf7Qnp5Mkf5ETh1/A2juy7Bqugu+rdSy3U4ve84Rhs3f6jn+
         UKoGcvyo/QYPB7/AIdbxZMpgSXqcWyZ6I6dAi9kGWSdtv9ZhACh9u5zJXUsQWvee/pM2
         X516kfWq5EL2wsMFteS1yNfWBwIT7n+u8Nvhc0pB1GJHWJSNp43QPxrptYoV/PooHz/5
         KYfYWXp+iliD7c39GKyU6uf5a9VQN70lwZnWu+p2+Z5I0SjtTq3QWpF7NoNhOYNu7McJ
         rvjw==
X-Gm-Message-State: APjAAAUDKyQX6x1opv3uyZC6LSywYadeKKa3yPT9fKvdzoOiuE98iBXi
        oopLoIA1eZl9491rdvLEemuSwbGe
X-Google-Smtp-Source: APXvYqxy4GMVO62498LFEF3xgUAM0vM3dD/Y11A7rCJkPU69AyaeEKRSuHSDqhMib64vx+n06JXavw==
X-Received: by 2002:a63:e90f:: with SMTP id i15mr8821642pgh.9.1573517632972;
        Mon, 11 Nov 2019 16:13:52 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id b21sm8345220pgs.35.2019.11.11.16.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:13:52 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:13:50 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 05/14] t5520: replace test -f with test-lib functions
Message-ID: <1d73546eb65fc32982a9a626d3410a45a84fabe4.1573517561.git.liu.denton@gmail.com>
References: <cover.1573152598.git.liu.denton@gmail.com>
 <cover.1573517561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573517561.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `test -f` has the same functionality as test_path_is_file(), in
the case where test_path_is_file() fails, we get much better debugging
information.

Replace `test -f` with test_path_is_file() so that future developers
will have a better experience debugging these test cases.

Also, in the case of `! test -f`, not only should that path not be a
file, it shouldn't exist at all so replace it with
test_path_is_missing().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 55560ce3cd..004d5884cd 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -39,8 +39,8 @@ test_expect_success 'pulling into void' '
 		cd cloned &&
 		git pull ..
 	) &&
-	test -f file &&
-	test -f cloned/file &&
+	test_path_is_file file &&
+	test_path_is_file cloned/file &&
 	test_cmp file cloned/file
 '
 
@@ -50,8 +50,8 @@ test_expect_success 'pulling into void using master:master' '
 		cd cloned-uho &&
 		git pull .. master:master
 	) &&
-	test -f file &&
-	test -f cloned-uho/file &&
+	test_path_is_file file &&
+	test_path_is_file cloned-uho/file &&
 	test_cmp file cloned-uho/file
 '
 
@@ -99,7 +99,7 @@ test_expect_success 'pulling into void must not create an octopus' '
 	(
 		cd cloned-octopus &&
 		test_must_fail git pull .. master master &&
-		! test -f file
+		test_path_is_missing file
 	)
 '
 
-- 
2.24.0.300.g722ba42680

