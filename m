Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4E9C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A751206E6
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSexiwTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgIPMQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 08:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgIPKcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:32:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1205BC061354
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z9so2437446wmk.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cd6/zFkuzEN+RpX+5ogLFAjdj11/CmyNG1Rma0NhE6Q=;
        b=PSexiwThBLA3KDNQ3xN0xQ1B68bAKS44RIi0Tc3uIkpViCtwUppwHjgIYPMKyRyFHs
         5qVm6Jz0hXS5uEL15pgJTDKDnu2rraFapW6YuwKmUT0mf0DYIj3YxV7IqOsLNd6ULr/1
         JDDZtn5gTwFsbEmzNUJrzlD0wrEikv+JLOr49BB0DfXwGAu0+bJ8189feD3AVRof/l97
         iqZkZnLAx9D1DlvEsgng5RcDNLbCO290Nn0WSUkWK8HHGjyQ0h0wtbB6ijZH8Qdft+OU
         +/0HhzYzKiNTsrVyCV5WJBU2WC2psSxIas7vgGAY8GDRhRZE2t1JFWTY7zh+hqJ+tUN8
         PLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cd6/zFkuzEN+RpX+5ogLFAjdj11/CmyNG1Rma0NhE6Q=;
        b=VcmmsNopFALF95MQ3CnVd0sh7OyEpIMp3SV4fY6VxcCsMelHQ0JyrBr66u6IXeyPcb
         J6JAdALN5khoj071AEyC0GKaMjvcQwBXavjXvSsM2CxQ5ffPhCyPIk8tCfdR54y7B9Ac
         lMERSkSnA38gPd3dQsWzE0r9wunWgy3vaW+Y8A9rKUeIOxa5FNoZZHXwDkVZkIOhPde6
         RL/WQaiawbPbkWDkvCYoasnrSpRxZI51pXVAWUWbK3CITj57Q7bDS1REmJeTY4rz31RH
         BkPDVqfcZT8eeiKDO/wRHz/e+ikNsqs5DYvLLCpHIvU7w4Sa8hKbvMHVQxS1GbXEkqSp
         hyjQ==
X-Gm-Message-State: AOAM530GWo6RqItURPelVf21uiG3/1EurUuzCYUjd1AQ569Uio2FUsL9
        8sqQqeW8ZO8i7tsjFGy/IM3O+DRH1Zj52fFM
X-Google-Smtp-Source: ABdhPJxCRRUBRyTRMnCXQwYt5/WpkZBtUsaxNan2pQaWzK3c8MnZsLVlQNyTGqdpxzQaPDebCmJioA==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr4167025wmj.66.1600252206422;
        Wed, 16 Sep 2020 03:30:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/15] remote-mediawiki tests: guard test_cmp with test_path_is_file
Date:   Wed, 16 Sep 2020 12:29:10 +0200
Message-Id: <20200916102918.29805-8-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a test that used a plain test_cmp to first check the file(s)
using test_path_is_file. If some of these file(s) don't exist (as
happened to me during debugging), test_cmp will emit a way less useful
message about the failure.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
index 43580af3cf..d3de6c204a 100755
--- a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
+++ b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
@@ -52,9 +52,13 @@ test_expect_success 'git clone works on previously created wiki with media files
 	test_when_finished "rm -rf mw_dir mw_dir_clone" &&
 	git clone -c remote.origin.mediaimport=true \
 		mediawiki::'"$WIKI_URL"' mw_dir_clone &&
+	test_path_is_file mw_dir_clone/Foo.txt &&
+	test_path_is_file mw_dir/Foo.txt &&
 	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt &&
 	(cd mw_dir_clone && git checkout HEAD^) &&
 	(cd mw_dir && git checkout HEAD^) &&
+	test_path_is_file mw_dir_clone/Foo.txt &&
+	test_path_is_file mw_dir/Foo.txt &&
 	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt
 '
 
@@ -74,6 +78,8 @@ test_expect_success 'git clone works on previously created wiki with media files
 	test_when_finished "rm -rf mw_dir mw_dir_clone" &&
 	git clone -c remote.origin.mediaimport=true \
 		mediawiki::'"$WIKI_URL"' mw_dir_clone &&
+	test_path_is_file mw_dir_clone/Bar.txt &&
+	test_path_is_file mw_dir/Bar.txt &&
 	test_cmp mw_dir_clone/Bar.txt mw_dir/Bar.txt
 '
 
@@ -90,6 +96,7 @@ test_expect_success 'git push & pull work with locally renamed media files' '
 		git commit -m "Rename a file" &&
 		test_git_reimport &&
 		echo "A File" >expect &&
+		test_path_is_file Bar.txt &&
 		test_cmp expect Bar.txt &&
 		test_path_is_missing Foo.txt
 	)
-- 
2.28.0.297.g1956fa8f8d

