Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C501A1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbeGBAY7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:24:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51490 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeGBAYy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:24:54 -0400
Received: by mail-it0-f67.google.com with SMTP id o5-v6so8852578itc.1
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Krk4fe2M7+bhRGb+rGh8Hmd6EQpptojOwuGZSs0SJDg=;
        b=TfK2BhLb5co2afBTTmk0BmElhdtbh/9JAkUfwisGc2ou1oqsPGd3aScDFONOazpN1E
         N7CtZaVKn0fCu027aY0yiNdJ59exgb1e4FpwWGVQrX6zzmqbr+i6iRc0bNTmaQLn75RT
         IxIs6QgbhW/8yVeIziPnEkrwQNeHL9kgHv9Pwsti7AucycSUl8+iv9Uh+SHf/wbuCU/5
         cregnRC9b71aVD6z0kZkU81EnV4M3KYrlTv6DEiL7XgmoJuu6XMUDAky3kc2rlHRXcjJ
         ax8SSZEcKOJmndPQJQAwUS5y3hF0nRbtfvg34pL0ELL1p8iFSPYkamtVWe6g5D93itqo
         hing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Krk4fe2M7+bhRGb+rGh8Hmd6EQpptojOwuGZSs0SJDg=;
        b=NFbsIMBb/4qWAjZIuIZ31JUgfW1pWzJ9YUqTktnHg0LiFTaMENOQNh/pwJTN7pp2Y3
         cTmk7Ypxw8GLUVxWwJnyT3QSX0XDCXFTRL49t96YT55vHnIOhhLwQKnFwzEDwgSbA8DH
         X9oTMVXanZhb6WbotD6jTvyfbafNgTZ48Da4mprHVigjfwG/Pyw68TASIzicIp4Ey17H
         WrH1Mih7FgT0McPYUPXWh9lrRoujUVDsvRLc2aWejC5Vaf0wPthZBvWKc719CIVwlpHU
         s/G2DsImVwDZQDrfzVX6ZIF+G3GYvaVHZ8fUGhjFpag2KuMbn6Ni6IGOUknkQg/jhyJI
         E3DQ==
X-Gm-Message-State: APt69E0rmLEXsL6kcvPr0UtJdhfg/8IYPVdn+C/EC7DFUm+BfBGy4pDa
        /IKMPTyp5dcA4CLL6BRol0CUSQ==
X-Google-Smtp-Source: AAOMgpcQbqxwiiyMBZU6X03pXQAlcZ9OfGs1nGfzhwgtd6hf7pfOzw83QZndBp/VCBrtykZF3gEDnw==
X-Received: by 2002:a02:4dda:: with SMTP id t87-v6mr4798858jad.51.1530491093725;
        Sun, 01 Jul 2018 17:24:53 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:53 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 05/25] t/lib-submodule-update: fix "absorbing" test
Date:   Sun,  1 Jul 2018 20:23:45 -0400
Message-Id: <20180702002405.3042-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test has been dysfunctional since it was added by 259f3ee296
(lib-submodule-update.sh: define tests for recursing into submodules,
2017-03-14), however, the problem went unnoticed due to a broken
&&-chain.

The test wants to verify that replacing a submodule containing a .git
directory will absorb the .git directory into the .git/modules/ of the
superproject, and then replace the working tree content appropriate to
the superproject. It is, therefore, incorrect to check if the
submodule content still exists since the submodule will have been
replaced by the content of the superproject.

Fix this by removing the submodule content check, which also happens
to be the line that broke the &&-chain.

While at it, fix broken &&-chains in a couple neighboring tests.

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/lib-submodule-update.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 1f38a85371..e90ec79087 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -755,7 +755,7 @@ test_submodule_recursing_with_args_common() {
 			: >sub1/untrackedfile &&
 			test_must_fail $command replace_sub1_with_file &&
 			test_superproject_content origin/add_sub1 &&
-			test_submodule_content sub1 origin/add_sub1
+			test_submodule_content sub1 origin/add_sub1 &&
 			test -f sub1/untracked_file
 		)
 	'
@@ -842,7 +842,7 @@ test_submodule_switch_recursing_with_args () {
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			: >sub1 &&
-			echo sub1 >.git/info/exclude
+			echo sub1 >.git/info/exclude &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -969,7 +969,6 @@ test_submodule_forced_switch_recursing_with_args () {
 			rm -rf .git/modules/sub1 &&
 			$command replace_sub1_with_directory &&
 			test_superproject_content origin/replace_sub1_with_directory &&
-			test_submodule_content sub1 origin/modify_sub1
 			test_git_directory_exists sub1
 		)
 	'
-- 
2.18.0.203.gfac676dfb9

