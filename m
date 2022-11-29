Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754F5C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 13:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiK2NPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiK2NP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 08:15:29 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697F561740
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:15:15 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a9so10205693pfr.0
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0+tbxnNG0fQvc6q7d+n21W6MAD2h2m2KF4VTi6IR+4=;
        b=Ry5wSpce+ko2PFJNdMj4nXvYBtwxQwtCDEzrxJiy/zW4dfgPaTOSjz+t7J0G9oPZtH
         KsB1GpqN8ccniAFI5N8G9S5S4tnfrzctjlMayYCpR4ZtB4ruom9oOP1WMB7nllMPMsy/
         BSEgoewfYO4DODP9yJGOoJ3Ll55X3H7mvRmWWxOUMD3d9r7z6Ae+tuvbmTOZxzRB6JSf
         E0IpbHLycEYEXC2YcyTgnUseSf/dUlgA1EY7fTtD0IS8jzUlKCwSsOgWwi2hcC0dm2E/
         9cgtOJqESyI8F4T8aVMX6ZfO1yOZ7qqZyRL/J96aMKW49z7HFu+NLOoCp2CSdmMheOCN
         yYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0+tbxnNG0fQvc6q7d+n21W6MAD2h2m2KF4VTi6IR+4=;
        b=WnOJDX1WlZW5yaZn29kbXm5QiyaYCqn8gsR41481zZkS8OC0EE2Jsodssk0PYO52E9
         wLSBmS+6VMW72HJImbUvB08GrG6YDksMakigLOBxhiVj7xc9w/wNcTMmXJVdRLjsj12F
         cIdOjTa39/Y429MOB5VkYfk1dj+K3DGCN2JaKoJb/Jf9u3TwJ+XjhGJ3mikJKh1w8KJa
         w71N0nbb3xFjGVZwuVavfxKbeTZjkjZ+FDrlbAM0Qoxxn2k9dBawGwXHzi3qxQkeXnHB
         jlbC6IcVVWT/TNRlcaFTWI5eD807JUlbdz3D3ZM592UX32HeCbP3fiVLKBXoBoCIxcz3
         65GA==
X-Gm-Message-State: ANoB5pk6/ZjxWfg9YTbwc7j76kxSwTdGPJy+UnmYAssaG4gl7iwAcs4G
        SkQkG3Fq1LO1QrIrAWQI4ru+6/F5p68=
X-Google-Smtp-Source: AA0mqf6Pa+xWV+O/sQV8YwBohKru0xeWAbNxltaRQtgB0Og0barc9E23QoYvrumASDWdX+w9WzkcBQ==
X-Received: by 2002:a63:1f63:0:b0:460:ec46:3645 with SMTP id q35-20020a631f63000000b00460ec463645mr51828442pgm.92.1669727714654;
        Tue, 29 Nov 2022 05:15:14 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b005745635c5b5sm9904524pfp.183.2022.11.29.05.15.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:15:13 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 0/3] t1301: various updates
Date:   Tue, 29 Nov 2022 21:15:08 +0800
Message-Id: <20221129131511.7173-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221128130323.8914-1-worldhello.net@gmail.com>
References: <20221128130323.8914-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Various updates for t1301:

  * t1301: fix wrong template dir for git-init
  * t1301: use test_when_finished for cleanup
  * t1301: do not change $CWD in "shared=all" test case

## range-diff v2...v3


1:  bc68ffb41c = 1:  7a66766a10 t1301: fix wrong template dir for git-init
2:  ae2b2f8afc = 2:  97eefb1e67 t1301: use test_when_finished for cleanup
3:  f1bf255e5a ! 3:  9575f2eb1c t1301: do not change $CWD in "shared=all" test case
    @@ Commit message
         So it is a safe change for us to run the test case "shared=all" in
         current repository instead of creating and changing to "sub".
     
    -    For the next test case, we no longer run it in the "sub" repository
    -    which is initialized from an empty template, we should not assume the
    -    path ".git/info" is missing. So add option "-p" to mkdir.
    +    For the next test case, the path ".git/info" is assumed to be missing,
    +    but we no longer run the test case in the "sub" repository which is
    +    initialized from an empty template. In order for the test case to run
    +    properly, we can set "TEST_CREATE_REPO_NO_TEMPLATE=1" to initialize the
    +    default repository without a template.
     
         Helped-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## t/t1301-shared-repo.sh ##
    +@@ t/t1301-shared-repo.sh: test_description='Test shared repository initialization'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_CREATE_REPO_NO_TEMPLATE=1
    + . ./test-lib.sh
    + 
    + # Remove a default ACL from the test dir if possible.
     @@ t/t1301-shared-repo.sh: do
      done
      
    @@ t/t1301-shared-repo.sh: do
      	git init --template= --shared=all &&
      	test 2 = $(git config core.sharedrepository)
      '
    -@@ t/t1301-shared-repo.sh: test_expect_success POSIXPERM 'update-server-info honors core.sharedRepository'
    - 	git add a1 &&
    - 	test_tick &&
    - 	git commit -m a1 &&
    --	mkdir .git/info &&
    -+	mkdir -p .git/info &&
    - 	umask 0277 &&
    - 	git update-server-info &&
    - 	actual="$(ls -l .git/info/refs)" &&

--

Jiang Xin (3):
  t1301: fix wrong template dir for git-init
  t1301: use test_when_finished for cleanup
  t1301: do not change $CWD in "shared=all" test case

 t/t1301-shared-repo.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.39.0.rc0

