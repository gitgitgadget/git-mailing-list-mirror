Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E260C25B06
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbiHITJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344647AbiHITJG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902F9E0CA
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z12so15290569wrs.9
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=o0CBaMAnbHqKIU6wgoZiwnGPgTaMvClGaDUwjI8nV8w=;
        b=Q2Ye4wY0yrE4Ac1oXHyHKBeNtDsibobk4hHW7u5PCvQ5PJW2QqF5lGo0hrnD46EtfB
         zoYxyp1cNcaoQQ54kDtk4uertOB1ta3qICMK7GFP1qKaBox7sd8HO2f1mjnxm5BvmILM
         uQDdeD5WXDuCPolS+6WVL4W976FfYBygncC5WIp5fnr6aGyL99eE8BcxEGngnZ51eXeo
         LDVOeI5ucXcegg3N3dhUacJ+7xXHvRF8k7ItxRH7ZKi13owJOwBHYuTZryWOF8mIrEQF
         4clgYToZdO2raEp8cggbi+d80miFWO5s9h121A186CRYjoUW+fnJtkRiNL1yWBNDS8RC
         lkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=o0CBaMAnbHqKIU6wgoZiwnGPgTaMvClGaDUwjI8nV8w=;
        b=y3x7uHJrtlE2LBYAE+hRTFiydFl7O35dmQB+OzBs8tzVt/6KNJT0q8zx8b5L+69PVf
         UqQRDKEL/5lFVASLcVgWaFbymz3mEF5C6J5csJu4FXWImFRxM7NRTTH/zyhUfLgapyMf
         TScR3NA+YISaRQpROLu11b09s9IZFjsO6pExYhytkBanHh2gEDfmYlTJYUWXhPo5Qtvc
         LS+X/0tXuan02oaNeFFlm4tKOcKvSyzXCiVCyVaw8tC2KMAWjFqkFqRle9E6INCreCIg
         Wk56hqYGl/6+fou7QaIt/rStGrKK9M4qfR8QY//k2GrFl5xrUptrmWvzSJ88lf5uOqUI
         yM6Q==
X-Gm-Message-State: ACgBeo3GTmyNY5vPfISVUTbM+DDuQfHlSmtjwX3DiHceXU60WANB4ky/
        2NOwDauZWKqb5fec8b5HKP/S3q6wA7c=
X-Google-Smtp-Source: AA6agR6DHxp1hhkQ6iuUyxHgWRRdVNytdFBapH/qpDkuaZ/bAY6f8jbiJdEfxoxoLEne3N2RCwsyYg==
X-Received: by 2002:adf:d1e2:0:b0:223:6167:fd00 with SMTP id g2-20020adfd1e2000000b002236167fd00mr4455479wrd.330.1660071326208;
        Tue, 09 Aug 2022 11:55:26 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:25 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 02/14] t6060: add tests for removed files
Date:   Tue,  9 Aug 2022 20:54:17 +0200
Message-Id: <20220809185429.20098-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Until now, t6060 did not not check git-merge-one-file's behaviour when a
file is deleted in a branch.  To avoid regressions on this during the
conversion from shell to C, this adds a new file, `file3', in the commit
tagged as `base', and deletes it in the commit tagged as `two'.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t6060-merge-index.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index d0d6dec0c8..bb4da4bbb2 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -6,12 +6,14 @@ test_description='basic git merge-index / git-merge-one-file tests'
 test_expect_success 'setup diverging branches' '
 	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
 	cp file file2 &&
-	git add file file2 &&
+	cp file file3 &&
+	git add file file2 file3 &&
 	git commit -m base &&
 	git tag base &&
 	sed s/2/two/ <file >tmp &&
 	mv tmp file &&
 	cp file file2 &&
+	git rm file3 &&
 	git commit -a -m two &&
 	git tag two &&
 	git checkout -b other HEAD^ &&
@@ -39,6 +41,7 @@ test_expect_success 'read-tree does not resolve content merge' '
 	cat >expect <<-\EOF &&
 	file
 	file2
+	file3
 	EOF
 	git read-tree -i -m base ten two &&
 	git diff-files --name-only --diff-filter=U >unmerged &&
-- 
2.37.1.412.gcfdce49ffd

